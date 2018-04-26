Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeDZI3D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:29:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48946 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeDZI2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:28:53 -0400
Subject: Re: [PATCH] nvme: unquiesce the queue before cleaup it
To: Max Gurtovoy <maxg@mellanox.com>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1524126553-16290-1-git-send-email-jianchao.w.wang@oracle.com>
 <df008d75-1f5c-ba00-ac61-e537a608901e@oracle.com>
 <1d51898e-cb3b-1178-c0b6-0716acbb9564@mellanox.com>
 <4ef5f9f2-b61d-89a0-f619-d15c40587f03@oracle.com>
 <09a72ec6-117c-e31f-5aa6-546e74c3c20b@mellanox.com>
 <74ea389f-499f-5162-b9c0-14d02e273455@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <7bc27059-578e-0694-654f-c1390b47cb70@oracle.com>
Date: Thu, 26 Apr 2018 16:27:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <74ea389f-499f-5162-b9c0-14d02e273455@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260082
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max

I did a similar test on nvme-rdma, the underlying fabric is soft-RoCE.
A io loop, reset controller loop  and a delete/create controller loop.
And found io hang below:

[  230.884590] WARNING: CPU: 0 PID: 150 at /home/will/u04/source_code/linux-stable/drivers/nvme/host/rdma.c:1755 nvme_rdma_reset_ctrl_work+0x3d/0xb0 [nvme_rdma]
[  230.884689] CPU: 0 PID: 150 Comm: kworker/u16:3 Not tainted 4.17.0-rc1+ #16
[  230.884690] Hardware name: LENOVO 10MLS0E339/3106, BIOS M1AKT22A 06/27/2017
[  230.884693] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
[  230.884696] RIP: 0010:nvme_rdma_reset_ctrl_work+0x3d/0xb0 [nvme_rdma]
[  230.884697] RSP: 0018:ffffa9e30255be40 EFLAGS: 00010246
[  230.884699] RAX: 0000000000000000 RBX: ffff9633b64c2000 RCX: 0000000000000000
[  230.884700] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff9ac05516
[  230.884701] RBP: ffff9633b64c23b8 R08: 0000000000000001 R09: 0000000000000000
[  230.884702] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9633b64c2970
[  230.884703] R13: 0000000000000000 R14: 0ffff96340ffcc80 R15: ffff9634102af9c0
[  230.884705] FS:  0000000000000000(0000) GS:ffff963422c00000(0000) knlGS:0000000000000000
[  230.884706] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  230.884707] CR2: 0000000001ce9ca4 CR3: 000000038040f005 CR4: 00000000003606f0
[  230.884708] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  230.884709] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  230.884710] Call Trace:
[  230.884717]  process_one_work+0x1c0/0x680
[  230.884722]  worker_thread+0x22b/0x430
[  230.884728]  kthread+0x100/0x140
[  230.884730]  ? rescuer_thread+0x370/0x370
[  230.884731]  ? kthread_delayed_work_timer_fn+0x80/0x80
[  230.884736]  ret_from_fork+0x24/0x30
[  230.884744] Code: ff 48 8d ab b8 03 00 00 48 89 ef e8 1e 25 d7 d9 31 f6 48 89 df e8 44 f9 ff ff be 04 00 00 00 48 89 ef e8 b7 13 d7 d9 84 c0 75 07 <0f> 0b 5b 5d 41 5c c3 31 f6 48 89 df e8 b2 fa ff ff 85 c0 75 39 
[  230.884799] irq event stamp: 88150
[  230.884802] hardirqs last  enabled at (88149): [<ffffffff9ac05529>] _raw_spin_unlock_irqrestore+0x59/0x70
[  230.884803] hardirqs last disabled at (88150): [<ffffffff9ae0116c>] error_entry+0x6c/0xc0
[  230.884805] softirqs last  enabled at (87998): [<ffffffff9aa603a0>] sk_common_release+0x60/0xd0
[  230.884807] softirqs last disabled at (87996): [<ffffffff9aa60375>] sk_common_release+0x35/0xd0
[  230.884808] ---[ end trace c03fac253b80d77d ]---
[  277.472094] INFO: task kworker/u16:0:6 blocked for more than 30 seconds.
[  277.473482]       Tainted: G        W         4.17.0-rc1+ #16
[  277.474825] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  277.476293] kworker/u16:0   D    0     6      2 0x80000000
[  277.476317] Workqueue: nvme-delete-wq nvme_delete_ctrl_work
[  277.476335] Call Trace:
[  277.476365]  ? __schedule+0x3de/0xac0
[  277.476393]  schedule+0x3c/0x90
[  277.476405]  blk_mq_freeze_queue_wait+0x44/0x90
[  277.476419]  ? wait_woken+0x90/0x90
[  277.476437]  blk_cleanup_queue+0xe1/0x280
[  277.476453]  nvme_ns_remove+0x1c8/0x260
[  277.476475]  nvme_remove_namespaces+0x7f/0xa0
[  277.476495]  nvme_delete_ctrl_work+0x4b/0x80
[  277.476508]  process_one_work+0x1c0/0x680
[  277.476535]  worker_thread+0x22b/0x430
[  277.476562]  kthread+0x100/0x140
[  277.476572]  ? rescuer_thread+0x370/0x370
[  277.476579]  ? kthread_delayed_work_timer_fn+0x80/0x80
[  277.476598]  ret_from_fork+0x24/0x30

00000000ea33345b {.op=READ, .cmd_flags=23, .rq_flags=MQ_INFLIGHT|IO_STAT, .state=idle, .tag=19, .internal_tag=-1}
0000000071218c5a {.op=READ, .cmd_flags=23, .rq_flags=MQ_INFLIGHT|IO_STAT, .state=idle, .tag=45, .internal_tag=-1}
root@will-ThinkCentre-M910s:/sys/kernel/debug/block/nvme1c1n1# cat state
DYING|BYPASS|NOMERGES|SAME_COMP|NONROT|IO_STAT|DISCARD|NOXMERGES|INIT_DONE|NO_SG_MERGE|POLL|WC|FUA|STATS|QUIESCED

This is due to a race following:

nvme_delete_ctrl                    nvme_rdma_reset_ctrl_work
  -> change state to DELETING
  -> queue delete_work
                                      -> nvme_rdma_shutdown_ctrl
                                        -> nvme_stop_queues
                                          -> blk_mq_quiesce_queue
                
                                      -> change to LIVE state fails
                                        -> return
nvme_delete_ctrl_work
  -> nvme_remove_namespaces
    -> nvme_ns_remove
      -> blk_cleanup_queue
        -> blk_freeze_queue

This patch could also fix this issue.

Thanks
Jianchao

On 04/22/2018 11:00 PM, jianchao.wang wrote:
> Hi Max
> 
> That's really appreciated!
> Here is my test script.
> 
> loop_reset_controller.sh
> #!/bin/bash 
> while true
> do
> 	echo 1 > /sys/block/nvme0n1/device/reset_controller 
> 	sleep 1
> done
> 
> loop_unbind_driver.sh 
> #!/bin/bash 
> while true
> do
> 	echo "0000:02:00.0" > /sys/bus/pci/drivers/nvme/unbind 
> 	sleep 2
> 	echo "0000:02:00.0" > /sys/bus/pci/drivers/nvme/bind
> 	sleep 2
> done
> 
> loop_io.sh 
> #!/bin/bash 
> 
> file="/dev/nvme0n1"
> echo $file
> while true;
> do
> 	if [ -e $file ];then
> 		fio fio_job_rand_read.ini
> 	else
> 		echo "Not found"
> 		sleep 1
> 	fi
> done
> 
> The fio jobs is as below:
> size=512m
> rw=randread
> bs=4k
> ioengine=libaio
> iodepth=64
> direct=1
> numjobs=16
> filename=/dev/nvme0n1
> group_reporting
> 
> I started in sequence, loop_io.sh, loop_reset_controller.sh, loop_unbind_driver.sh.
> And if lucky, I will get io hang in 3 minutes. ;)
> Such as:
> 
> [  142.858074] nvme nvme0: pci function 0000:02:00.0
> [  144.972256] nvme nvme0: failed to mark controller state 1
> [  144.972289] nvme nvme0: Removing after probe failure status: 0
> [  185.312344] INFO: task bash:1673 blocked for more than 30 seconds.
> [  185.312889]       Not tainted 4.17.0-rc1+ #6
> [  185.312950] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  185.313049] bash            D    0  1673   1629 0x00000080
> [  185.313061] Call Trace:
> [  185.313083]  ? __schedule+0x3de/0xac0
> [  185.313103]  schedule+0x3c/0x90
> [  185.313111]  blk_mq_freeze_queue_wait+0x44/0x90
> [  185.313123]  ? wait_woken+0x90/0x90
> [  185.313133]  blk_cleanup_queue+0xe1/0x280
> [  185.313145]  nvme_ns_remove+0x1c8/0x260
> [  185.313159]  nvme_remove_namespaces+0x7f/0xa0
> [  185.313170]  nvme_remove+0x6c/0x130
> [  185.313181]  pci_device_remove+0x36/0xb0
> [  185.313193]  device_release_driver_internal+0x160/0x230
> [  185.313205]  unbind_store+0xfe/0x150
> [  185.313219]  kernfs_fop_write+0x114/0x190
> [  185.313234]  __vfs_write+0x23/0x150
> [  185.313246]  ? rcu_read_lock_sched_held+0x3f/0x70
> [  185.313252]  ? preempt_count_sub+0x92/0xd0
> [  185.313259]  ? __sb_start_write+0xf8/0x200
> [  185.313271]  vfs_write+0xc5/0x1c0
> [  185.313284]  ksys_write+0x45/0xa0
> [  185.313298]  do_syscall_64+0x5a/0x1a0
> [  185.313308]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> And get following information in block debugfs:
> root@will-ThinkCentre-M910s:/sys/kernel/debug/block/nvme0n1# cat hctx6/cpu6/rq_list 
> 000000001192d19b {.op=READ, .cmd_flags=, .rq_flags=IO_STAT, .state=idle, .tag=69, .internal_tag=-1}
> 00000000c33c8a5b {.op=READ, .cmd_flags=, .rq_flags=IO_STAT, .state=idle, .tag=78, .internal_tag=-1}
> root@will-ThinkCentre-M910s:/sys/kernel/debug/block/nvme0n1# cat state
> DYING|BYPASS|NOMERGES|SAME_COMP|NONROT|IO_STAT|DISCARD|NOXMERGES|INIT_DONE|NO_SG_MERGE|POLL|WC|FUA|STATS|QUIESCED
> 
> We can see there were reqs on ctx rq_list and the request_queue is QUIESCED. 
> 
> Thanks again !!
> Jianchao
> 
> On 04/22/2018 10:48 PM, Max Gurtovoy wrote:
>>
>>
>> On 4/22/2018 5:25 PM, jianchao.wang wrote:
>>> Hi Max
>>>
>>> No, I only tested it on PCIe one.
>>> And sorry for that I didn't state that.
>>
>> Please send your exact test steps and we'll run it using RDMA transport.
>> I also want to run a mini regression on this one since it may effect other flows.
>>
>>>
>>> Thanks
>>> Jianchao
>>>
>>> On 04/22/2018 10:18 PM, Max Gurtovoy wrote:
>>>> Hi Jianchao,
>>>> Since this patch is in the core, have you tested it using some fabrics drives too ? RDMA/FC ?
>>>>
>>>> thanks,
>>>> Max.
>>>>
>>>> On 4/22/2018 4:32 PM, jianchao.wang wrote:
>>>>> Hi keith
>>>>>
>>>>> Would you please take a look at this patch.
>>>>>
>>>>> This issue could be reproduced easily with a driver bind/unbind loop,
>>>>> a reset loop and a IO loop at the same time.
>>>>>
>>>>> Thanks
>>>>> Jianchao
>>>>>
>>>>> On 04/19/2018 04:29 PM, Jianchao Wang wrote:
>>>>>> There is race between nvme_remove and nvme_reset_work that can
>>>>>> lead to io hang.
>>>>>>
>>>>>> nvme_remove                    nvme_reset_work
>>>>>> -> change state to DELETING
>>>>>>                                  -> fail to change state to LIVE
>>>>>>                                  -> nvme_remove_dead_ctrl
>>>>>>                                    -> nvme_dev_disable
>>>>>>                                      -> quiesce request_queue
>>>>>>                                    -> queue remove_work
>>>>>> -> cancel_work_sync reset_work
>>>>>> -> nvme_remove_namespaces
>>>>>>     -> splice ctrl->namespaces
>>>>>>                                  nvme_remove_dead_ctrl_work
>>>>>>                                  -> nvme_kill_queues
>>>>>>     -> nvme_ns_remove               do nothing
>>>>>>       -> blk_cleanup_queue
>>>>>>         -> blk_freeze_queue
>>>>>> Finally, the request_queue is quiesced state when wait freeze,
>>>>>> we will get io hang here.
>>>>>>
>>>>>> To fix it, unquiesce the request_queue directly before nvme_ns_remove.
>>>>>> We have spliced the ctrl->namespaces, so nobody could access them
>>>>>> and quiesce the queue any more.
>>>>>>
>>>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>>>> ---
>>>>>>    drivers/nvme/host/core.c | 9 ++++++++-
>>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>> index 9df4f71..0e95082 100644
>>>>>> --- a/drivers/nvme/host/core.c
>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>> @@ -3249,8 +3249,15 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>>>>>        list_splice_init(&ctrl->namespaces, &ns_list);
>>>>>>        up_write(&ctrl->namespaces_rwsem);
>>>>>>    -    list_for_each_entry_safe(ns, next, &ns_list, list)
>>>>>> +    /*
>>>>>> +     * After splice the namespaces list from the ctrl->namespaces,
>>>>>> +     * nobody could get them anymore, let's unquiesce the request_queue
>>>>>> +     * forcibly to avoid io hang.
>>>>>> +     */
>>>>>> +    list_for_each_entry_safe(ns, next, &ns_list, list) {
>>>>>> +        blk_mq_unquiesce_queue(ns->queue);
>>>>>>            nvme_ns_remove(ns);
>>>>>> +    }
>>>>>>    }
>>>>>>    EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>>>>>>   
>>>>>
>>>>> _______________________________________________
>>>>> Linux-nvme mailing list
>>>>> Linux-nvme@lists.infradead.org
>>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=eQ9q70WFDS-d0s-KndBw8MOJvcBM6wuuKUNklqTC3h8&s=oBasfz9JoJw4yQF4EaWcNfKChZ1HMCkfHVZqyjvYVHQ&e=
>>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-nvme mailing list
>>>> Linux-nvme@lists.infradead.org
>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=eQ9q70WFDS-d0s-KndBw8MOJvcBM6wuuKUNklqTC3h8&s=oBasfz9JoJw4yQF4EaWcNfKChZ1HMCkfHVZqyjvYVHQ&e=
>>>>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwIGaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=ivKrSi6co_9l91-czj52P2ABAPyKOwv9GrD3UeCbhio&s=2U00IBVk4CVt0Q-jiZX3sEWEEA2IleOjPU_PD38Fgvg&e=
> 
