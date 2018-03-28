Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeC1R2J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:28:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42612 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeC1R2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:28:07 -0400
Subject: Re: 98f929b1bd ("ipc/shm: Fix shmctl(..., IPC_STAT, ...) between
 .."): Oops: 0000 [#1]
To: kernel test robot <fengguang.wu@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org, wfg@linux.intel.com
References: <5abb446e.XtEK088UbWSHCPaF%fengguang.wu@intel.com>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <f249d351-240a-8c0e-ef50-f9155b696e86@oracle.com>
Date: Wed, 28 Mar 2018 10:22:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5abb446e.XtEK088UbWSHCPaF%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

     From 
https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/tree/ipc/shm.c?h=for-next

It looks like if the following condition in Line 616 succeeds

error = PTR_ERR(file);
if (IS_ERR(file))
     goto no_file;

we get to no_file with garbage value in shm_cprid. An attempt to put_pid 
on this garbage value might be causing panic.

We could initialize shm_cprid to NULL as soon as it was created.

Thanks,

Nagarathnam.


On 03/28/2018 12:29 AM, kernel test robot wrote:
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-next
>
> commit 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454
> Author:     Eric W. Biederman <ebiederm@xmission.com>
> AuthorDate: Fri Mar 23 00:29:57 2018 -0500
> Commit:     Eric W. Biederman <ebiederm@xmission.com>
> CommitDate: Tue Mar 27 15:53:09 2018 -0500
>
>      ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
>      
>      Today shm_cpid and shm_lpid are remembered in the pid namespace of the
>      creator and the processes that last touched a sysvipc shared memory
>      segment.   If you have processes in multiple pid namespaces that
>      is just wrong, and I don't know how this has been over-looked for
>      so long.
>      
>      As only creation and shared memory attach and shared memory detach
>      update the pids I do not expect there to be a repeat of the issues
>      when struct pid was attached to each af_unix skb, which in some
>      notable cases cut the performance in half.  The problem was threads of
>      the same process updating same struct pid from different cpus causing
>      the cache line to be highly contended and bounce between cpus.
>      
>      As creation, attach, and detach are expected to be rare operations for
>      sysvipc shared memory segments I do not expect that kind of cache line
>      ping pong to cause probems.  In addition because the pid is at a fixed
>      location in the structure instead of being dynamic on a skb, the
>      reference count of the pid does not need to be updated on each
>      operation if the pid is the same.  This ability to simply skip the pid
>      reference count changes if the pid is unchanging further reduces the
>      likelihood of the a cache line holding a pid reference count
>      ping-ponging between cpus.
>      
>      Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
>      Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
>      Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> 03f1fc0918  ipc/util: Helpers for making the sysvipc operations pid namespace aware
> 98f929b1bd  ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
> 0d79cbf83b  ipc/smack: Tidy up from the change in type of the ipc security hooks
> +------------------------------------------+------------+------------+------------+
> |                                          | 03f1fc0918 | 98f929b1bd | 0d79cbf83b |
> +------------------------------------------+------------+------------+------------+
> | boot_successes                           | 33         | 4          | 2          |
> | boot_failures                            | 0          | 11         | 19         |
> | Oops:#[##]                               | 0          | 10         | 12         |
> | RIP:put_pid                              | 0          | 11         | 15         |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 11         | 15         |
> | BUG:unable_to_handle_kernel              | 0          | 2          | 4          |
> | BUG:kernel_in_stage                      | 0          | 0          | 4          |
> | general_protection_fault:#[##]           | 0          | 0          | 3          |
> +------------------------------------------+------------+------------+------------+
>
> [    8.040360] gfs2: path_lookup on rootfs returned error -2
> [    8.044048] mount (541) used greatest stack depth: 13352 bytes left
> Kernel tests: Boot OK!
> [   18.532190] IP: put_pid+0x22/0x5c
> [   18.532552] PGD 19efa067 P4D 19efa067 PUD 0
> [   18.533006] Oops: 0000 [#1]
> [   18.533318] CPU: 0 PID: 727 Comm: trinity Not tainted 4.16.0-rc2-00010-g98f929b #1
> [   18.534144] RIP: 0010:put_pid+0x22/0x5c
> [   18.534586] RSP: 0018:ffff986719f73e48 EFLAGS: 00010202
> [   18.535129] RAX: 00000006d765f710 RBX: ffff98671a4fa4d0 RCX: ffff986719f73d40
> [   18.535871] RDX: 000000006f6e6125 RSI: 0000000000000000 RDI: ffffffffa01e6d21
> [   18.536616] RBP: ffffffffa0955fe0 R08: 0000000000000020 R09: 0000000000000000
> [   18.537386] R10: 0000000000000078 R11: ffff986719f73e76 R12: 0000000000001000
> [   18.538120] R13: 00000000ffffffea R14: 0000000054000fb0 R15: 0000000000000000
> [   18.538892] FS:  00000000028c2880(0000) GS:ffffffffa06ad000(0000) knlGS:0000000000000000
> [   18.539736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.540360] CR2: 0000000677846439 CR3: 0000000019fc1005 CR4: 00000000000606b0
> [   18.541115] Call Trace:
> [   18.541385]  ? ipc_update_pid+0x36/0x3e
> [   18.541792]  ? newseg+0x34c/0x3a6
> [   18.542146]  ? ipcget+0x5d/0x528
> [   18.542523]  ? entry_SYSCALL_64_after_hwframe+0x52/0xb7
> [   18.543068]  ? SyS_shmget+0x5a/0x84
> [   18.543444]  ? do_syscall_64+0x194/0x1b3
> [   18.543884]  ? entry_SYSCALL_64_after_hwframe+0x42/0xb7
> [   18.544434] Code: ff 05 e7 20 9b 03 58 c9 c3 48 ff 05 85 21 9b 03 48 85 ff 74 4f 8b 47 04 8b 17 48 ff 05 7c 21 9b 03 48 83 c0 03 48 c1 e0 04 ff ca <48> 8b 44 07 08 74 1f 48 ff 05 6c 21 9b 03 ff 0f 0f 94 c2 48 ff
> [   18.546443] RIP: put_pid+0x22/0x5c RSP: ffff986719f73e48
> [   18.547026] CR2: 0000000677846439
> [   18.547395] ---[ end trace ab8c5cb4389d37c5 ]---
> [   18.547888] Kernel panic - not syncing: Fatal exception
>
>                                                            # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start 77a1df249bf89af82d6a2a6fe5f57c3da270f8d9 3eb2ce825ea1ad89d20f7a3b5780df850e4be274 --
> git bisect  bad dd5963ef89e4dbe5abfea40df18549a440570cdf  # 11:17  B      0    11   24   0  Merge 'tj-libata/for-next' into devel-spot-201803280843
> git bisect  bad 3fb00b899e5e53dd42cc3ef865c017e34f52563d  # 11:39  B      0     2   15   0  Merge 'linux-review/NeilBrown/rhashtable-assorted-fixes-and-enhancements/20180328-024648' into devel-spot-201803280843
> git bisect good 0d5dbbbdbdf1b6dc50c40fe936e3b0eaf278ab32  # 11:59  G     11     0    4   4  Merge 'masahiroy/for-next' into devel-spot-201803280843
> git bisect good 44cf2417eb69f79e9ed9c4023907a286c7a48501  # 12:23  G     11     0    0   0  Merge 'userns/userns-next' into devel-spot-201803280843
> git bisect  bad a299bee013ccdda737d11cbafeb024e5a8ebcc56  # 12:40  B      0    11   24   0  Merge 'linux-review/Li-RongQing/mm-list_lru-replace-spinlock-with-RCU-in-__list_lru_count_one/20180328-042620' into devel-spot-201803280843
> git bisect  bad 919db40dc9754fa11973ffcbfbb95f7cf87db991  # 13:00  B      0    11   26   2  Merge 'linux-review/Pablo-Neira-Ayuso/netfilter-ipt_CLUSTERIP-Allow-configuring-local-node-0-again/20180328-044503' into devel-spot-201803280843
> git bisect  bad a878805a8837c1bfde9745c505d3c37b1f0f73e0  # 13:14  B      0     2   15   0  Merge 'userns/userns-test' into devel-spot-201803280843
> git bisect good 34b56df922b10ac2876f268c522951785bf333fd  # 13:31  G     11     0    0   0  msg: Move struct msg_queue into ipc/msg.c
> git bisect good 03f1fc09180b345582889a344b012d069b3a6dbe  # 13:52  G     11     0    0   0  ipc/util: Helpers for making the sysvipc operations pid namespace aware
> git bisect  bad 39a4940eaa185910bb802ca9829c12268fd2c855  # 14:10  B      0    11   24   0  ipc/msg: Fix msgctl(..., IPC_STAT, ...) between pid namespaces
> git bisect  bad 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454  # 14:20  B      0    11   25   0  ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
> # first bad commit: [98f929b1bd4d0b7c7a77d0d9776d1b924db2e454] ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
> git bisect good 03f1fc09180b345582889a344b012d069b3a6dbe  # 14:23  G     31     0    2   2  ipc/util: Helpers for making the sysvipc operations pid namespace aware
> # extra tests with debug options
> git bisect  bad 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454  # 14:35  B      0    11   25   0  ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
> # extra tests on HEAD of linux-devel/devel-spot-201803280843
> git bisect  bad 77a1df249bf89af82d6a2a6fe5f57c3da270f8d9  # 14:35  B      0    18   42   7  0day head guard for 'devel-spot-201803280843'
> # extra tests on tree/branch userns/for-next
> git bisect  bad 0d79cbf83be07bb38a1224f47fd0e2b163310442  # 15:06  B      0     4   17   0  ipc/smack: Tidy up from the change in type of the ipc security hooks
> # extra tests with first bad commit reverted
> git bisect good 96c582dca4d93f55c7dbcb67e4dcaa28b00bc2b1  # 15:29  G     11     0    1   1  Revert "ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces."
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation
