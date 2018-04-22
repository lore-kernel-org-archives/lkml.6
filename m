Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754737AbeDVPBV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 11:01:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35086 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbeDVPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 11:01:13 -0400
Subject: Re: [PATCH] nvme: unquiesce the queue before cleaup it
To: Max Gurtovoy <maxg@mellanox.com>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1524126553-16290-1-git-send-email-jianchao.w.wang@oracle.com>
 <df008d75-1f5c-ba00-ac61-e537a608901e@oracle.com>
 <1d51898e-cb3b-1178-c0b6-0716acbb9564@mellanox.com>
 <4ef5f9f2-b61d-89a0-f619-d15c40587f03@oracle.com>
 <09a72ec6-117c-e31f-5aa6-546e74c3c20b@mellanox.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <74ea389f-499f-5162-b9c0-14d02e273455@oracle.com>
Date: Sun, 22 Apr 2018 23:00:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <09a72ec6-117c-e31f-5aa6-546e74c3c20b@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8871 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804220169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max

That's really appreciated!
Here is my test script.

loop_reset_controller.sh
#!/bin/bash 
while true
do
	echo 1 > /sys/block/nvme0n1/device/reset_controller 
	sleep 1
done

loop_unbind_driver.sh 
#!/bin/bash 
while true
do
	echo "0000:02:00.0" > /sys/bus/pci/drivers/nvme/unbind 
	sleep 2
	echo "0000:02:00.0" > /sys/bus/pci/drivers/nvme/bind
	sleep 2
done

loop_io.sh 
#!/bin/bash 

file="/dev/nvme0n1"
echo $file
while true;
do
	if [ -e $file ];then
		fio fio_job_rand_read.ini
	else
		echo "Not found"
		sleep 1
	fi
done

The fio jobs is as below:
size=512m
rw=randread
bs=4k
ioengine=libaio
iodepth=64
direct=1
numjobs=16
filename=/dev/nvme0n1
group_reporting

I started in sequence, loop_io.sh, loop_reset_controller.sh, loop_unbind_driver.sh.
And if lucky, I will get io hang in 3 minutes. ;)
Such as:

[  142.858074] nvme nvme0: pci function 0000:02:00.0
[  144.972256] nvme nvme0: failed to mark controller state 1
[  144.972289] nvme nvme0: Removing after probe failure status: 0
[  185.312344] INFO: task bash:1673 blocked for more than 30 seconds.
[  185.312889]       Not tainted 4.17.0-rc1+ #6
[  185.312950] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  185.313049] bash            D    0  1673   1629 0x00000080
[  185.313061] Call Trace:
[  185.313083]  ? __schedule+0x3de/0xac0
[  185.313103]  schedule+0x3c/0x90
[  185.313111]  blk_mq_freeze_queue_wait+0x44/0x90
[  185.313123]  ? wait_woken+0x90/0x90
[  185.313133]  blk_cleanup_queue+0xe1/0x280
[  185.313145]  nvme_ns_remove+0x1c8/0x260
[  185.313159]  nvme_remove_namespaces+0x7f/0xa0
[  185.313170]  nvme_remove+0x6c/0x130
[  185.313181]  pci_device_remove+0x36/0xb0
[  185.313193]  device_release_driver_internal+0x160/0x230
[  185.313205]  unbind_store+0xfe/0x150
[  185.313219]  kernfs_fop_write+0x114/0x190
[  185.313234]  __vfs_write+0x23/0x150
[  185.313246]  ? rcu_read_lock_sched_held+0x3f/0x70
[  185.313252]  ? preempt_count_sub+0x92/0xd0
[  185.313259]  ? __sb_start_write+0xf8/0x200
[  185.313271]  vfs_write+0xc5/0x1c0
[  185.313284]  ksys_write+0x45/0xa0
[  185.313298]  do_syscall_64+0x5a/0x1a0
[  185.313308]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

And get following information in block debugfs:
root@will-ThinkCentre-M910s:/sys/kernel/debug/block/nvme0n1# cat hctx6/cpu6/rq_list 
000000001192d19b {.op=READ, .cmd_flags=, .rq_flags=IO_STAT, .state=idle, .tag=69, .internal_tag=-1}
00000000c33c8a5b {.op=READ, .cmd_flags=, .rq_flags=IO_STAT, .state=idle, .tag=78, .internal_tag=-1}
root@will-ThinkCentre-M910s:/sys/kernel/debug/block/nvme0n1# cat state
DYING|BYPASS|NOMERGES|SAME_COMP|NONROT|IO_STAT|DISCARD|NOXMERGES|INIT_DONE|NO_SG_MERGE|POLL|WC|FUA|STATS|QUIESCED

We can see there were reqs on ctx rq_list and the request_queue is QUIESCED. 

Thanks again !!
Jianchao

On 04/22/2018 10:48 PM, Max Gurtovoy wrote:
> 
> 
> On 4/22/2018 5:25 PM, jianchao.wang wrote:
>> Hi Max
>>
>> No, I only tested it on PCIe one.
>> And sorry for that I didn't state that.
> 
> Please send your exact test steps and we'll run it using RDMA transport.
> I also want to run a mini regression on this one since it may effect other flows.
> 
>>
>> Thanks
>> Jianchao
>>
>> On 04/22/2018 10:18 PM, Max Gurtovoy wrote:
>>> Hi Jianchao,
>>> Since this patch is in the core, have you tested it using some fabrics drives too ? RDMA/FC ?
>>>
>>> thanks,
>>> Max.
>>>
>>> On 4/22/2018 4:32 PM, jianchao.wang wrote:
>>>> Hi keith
>>>>
>>>> Would you please take a look at this patch.
>>>>
>>>> This issue could be reproduced easily with a driver bind/unbind loop,
>>>> a reset loop and a IO loop at the same time.
>>>>
>>>> Thanks
>>>> Jianchao
>>>>
>>>> On 04/19/2018 04:29 PM, Jianchao Wang wrote:
>>>>> There is race between nvme_remove and nvme_reset_work that can
>>>>> lead to io hang.
>>>>>
>>>>> nvme_remove                    nvme_reset_work
>>>>> -> change state to DELETING
>>>>>                                  -> fail to change state to LIVE
>>>>>                                  -> nvme_remove_dead_ctrl
>>>>>                                    -> nvme_dev_disable
>>>>>                                      -> quiesce request_queue
>>>>>                                    -> queue remove_work
>>>>> -> cancel_work_sync reset_work
>>>>> -> nvme_remove_namespaces
>>>>>     -> splice ctrl->namespaces
>>>>>                                  nvme_remove_dead_ctrl_work
>>>>>                                  -> nvme_kill_queues
>>>>>     -> nvme_ns_remove               do nothing
>>>>>       -> blk_cleanup_queue
>>>>>         -> blk_freeze_queue
>>>>> Finally, the request_queue is quiesced state when wait freeze,
>>>>> we will get io hang here.
>>>>>
>>>>> To fix it, unquiesce the request_queue directly before nvme_ns_remove.
>>>>> We have spliced the ctrl->namespaces, so nobody could access them
>>>>> and quiesce the queue any more.
>>>>>
>>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>>> ---
>>>>>    drivers/nvme/host/core.c | 9 ++++++++-
>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index 9df4f71..0e95082 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -3249,8 +3249,15 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>>>>        list_splice_init(&ctrl->namespaces, &ns_list);
>>>>>        up_write(&ctrl->namespaces_rwsem);
>>>>>    -    list_for_each_entry_safe(ns, next, &ns_list, list)
>>>>> +    /*
>>>>> +     * After splice the namespaces list from the ctrl->namespaces,
>>>>> +     * nobody could get them anymore, let's unquiesce the request_queue
>>>>> +     * forcibly to avoid io hang.
>>>>> +     */
>>>>> +    list_for_each_entry_safe(ns, next, &ns_list, list) {
>>>>> +        blk_mq_unquiesce_queue(ns->queue);
>>>>>            nvme_ns_remove(ns);
>>>>> +    }
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>>>>>   
>>>>
>>>> _______________________________________________
>>>> Linux-nvme mailing list
>>>> Linux-nvme@lists.infradead.org
>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=eQ9q70WFDS-d0s-KndBw8MOJvcBM6wuuKUNklqTC3h8&s=oBasfz9JoJw4yQF4EaWcNfKChZ1HMCkfHVZqyjvYVHQ&e=
>>>>
>>>
>>> _______________________________________________
>>> Linux-nvme mailing list
>>> Linux-nvme@lists.infradead.org
>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=eQ9q70WFDS-d0s-KndBw8MOJvcBM6wuuKUNklqTC3h8&s=oBasfz9JoJw4yQF4EaWcNfKChZ1HMCkfHVZqyjvYVHQ&e=
>>>
