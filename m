Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeBKDPB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:15:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeBKDPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:15:00 -0500
Subject: Re: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and
 nvme_dev_disable
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, hch@lst.de, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
 <073ce416-fd26-b41a-187d-1db9210c48b0@grimberg.me>
 <20180208175606.GD5039@localhost.localdomain>
 <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>
 <20180209171231.GB6970@localhost.localdomain>
 <de6fd2ac-fc69-1b3b-c206-7abfce24ac70@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <1872576f-8b5c-0f7f-3d7a-c769543ace87@oracle.com>
Date: Sun, 11 Feb 2018 11:06:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <de6fd2ac-fc69-1b3b-c206-7abfce24ac70@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8801 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802110041
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/2018 10:32 AM, jianchao.wang wrote:
> Hi Keith
> 
> Thanks for your kindly response here.
> That's really appreciated.
> 
> On 02/10/2018 01:12 AM, Keith Busch wrote:
>> On Fri, Feb 09, 2018 at 09:50:58AM +0800, jianchao.wang wrote:
>>>
>>> if we set NVME_REQ_CANCELLED and return BLK_EH_HANDLED as the RESETTING case,
>>> nvme_reset_work will hang forever, because no one could complete the entered requests.
>>
>> Except it's no longer in the "RESETTING" case since you added the
>> "CONNECTING" state, so that's already broken for other reasons...
>>
> 
> Yes, but as your patch, we have to fail the IOs and even kill the controller.
> In fact, up to nvme_wait_freeze in nvme_reset_work, the RECONNECTING state has been completed.
> We even could say it is in LIVE state. Maybe we should recover the controller again instead
> of fail the IOs and kill the controller.
> 
> On the other hand, can you share with me why we cannot use blk_set_preempt_only to replace
> blk_freeze_queue ? we just want to gate the new bios out of generic_make_request and we 
> needn't use the preempt requests.

Looks like blk_freeze_queue in blk_mq_update_nr_hw_queues cannot be worked around.
Still face IOs in nvme_reset_work. T_T

> 
> Looking forward your advice and directive.
> 
> Thanks
> Jianchao
> 
> 
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=UqKQMB3A2ppfm2sN7PyisX0xTtXKsHlTBwjsS18qVx8&s=A2VMSm9IjQQXxM7foB6VUiRHLs-nIREF2_kMstwxlgw&e=
>>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=cstI6JeNHGVX4OV1UdHdoemUr75aCUAjUrPe23Dhv8U&s=MYTmBPYS5tW4vC23iMEKINprtCxnRHe5AXrbST91XpY&e=
> 
