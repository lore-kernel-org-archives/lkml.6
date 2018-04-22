Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757907AbeDVOZ5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 10:25:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46406 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757853AbeDVOZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 10:25:55 -0400
Subject: Re: [PATCH] nvme: unquiesce the queue before cleaup it
To: Max Gurtovoy <maxg@mellanox.com>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1524126553-16290-1-git-send-email-jianchao.w.wang@oracle.com>
 <df008d75-1f5c-ba00-ac61-e537a608901e@oracle.com>
 <1d51898e-cb3b-1178-c0b6-0716acbb9564@mellanox.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <4ef5f9f2-b61d-89a0-f619-d15c40587f03@oracle.com>
Date: Sun, 22 Apr 2018 22:25:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1d51898e-cb3b-1178-c0b6-0716acbb9564@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8871 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804220162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max

No, I only tested it on PCIe one.
And sorry for that I didn't state that.

Thanks
Jianchao

On 04/22/2018 10:18 PM, Max Gurtovoy wrote:
> Hi Jianchao,
> Since this patch is in the core, have you tested it using some fabrics drives too ? RDMA/FC ?
> 
> thanks,
> Max.
> 
> On 4/22/2018 4:32 PM, jianchao.wang wrote:
>> Hi keith
>>
>> Would you please take a look at this patch.
>>
>> This issue could be reproduced easily with a driver bind/unbind loop,
>> a reset loop and a IO loop at the same time.
>>
>> Thanks
>> Jianchao
>>
>> On 04/19/2018 04:29 PM, Jianchao Wang wrote:
>>> There is race between nvme_remove and nvme_reset_work that can
>>> lead to io hang.
>>>
>>> nvme_remove                    nvme_reset_work
>>> -> change state to DELETING
>>>                                 -> fail to change state to LIVE
>>>                                 -> nvme_remove_dead_ctrl
>>>                                   -> nvme_dev_disable
>>>                                     -> quiesce request_queue
>>>                                   -> queue remove_work
>>> -> cancel_work_sync reset_work
>>> -> nvme_remove_namespaces
>>>    -> splice ctrl->namespaces
>>>                                 nvme_remove_dead_ctrl_work
>>>                                 -> nvme_kill_queues
>>>    -> nvme_ns_remove               do nothing
>>>      -> blk_cleanup_queue
>>>        -> blk_freeze_queue
>>> Finally, the request_queue is quiesced state when wait freeze,
>>> we will get io hang here.
>>>
>>> To fix it, unquiesce the request_queue directly before nvme_ns_remove.
>>> We have spliced the ctrl->namespaces, so nobody could access them
>>> and quiesce the queue any more.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>> ---
>>>   drivers/nvme/host/core.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 9df4f71..0e95082 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3249,8 +3249,15 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>>       list_splice_init(&ctrl->namespaces, &ns_list);
>>>       up_write(&ctrl->namespaces_rwsem);
>>>   -    list_for_each_entry_safe(ns, next, &ns_list, list)
>>> +    /*
>>> +     * After splice the namespaces list from the ctrl->namespaces,
>>> +     * nobody could get them anymore, let's unquiesce the request_queue
>>> +     * forcibly to avoid io hang.
>>> +     */
>>> +    list_for_each_entry_safe(ns, next, &ns_list, list) {
>>> +        blk_mq_unquiesce_queue(ns->queue);
>>>           nvme_ns_remove(ns);
>>> +    }
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>>>  
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=eQ9q70WFDS-d0s-KndBw8MOJvcBM6wuuKUNklqTC3h8&s=oBasfz9JoJw4yQF4EaWcNfKChZ1HMCkfHVZqyjvYVHQ&e=
>>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=eQ9q70WFDS-d0s-KndBw8MOJvcBM6wuuKUNklqTC3h8&s=oBasfz9JoJw4yQF4EaWcNfKChZ1HMCkfHVZqyjvYVHQ&e=
> 
