Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeC1UBz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:01:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36910 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeC1UBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:01:54 -0400
Subject: Re: [PATCH] ipc/shm: Fix pid freeing.
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc: LKP <lkp@01.org>, wfg@linux.intel.com,
        kernel test robot <fengguang.wu@intel.com>
References: <5abb446e.XtEK088UbWSHCPaF%fengguang.wu@intel.com>
 <877epwavh4.fsf@xmission.com>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <01161396-25cb-2da4-344b-4ea4ca27b373@oracle.com>
Date: Wed, 28 Mar 2018 12:57:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <877epwavh4.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/28/2018 11:47 AM, ebiederm@xmission.com wrote:
> The 0day kernel test build report reported an oops:
>>   IP: put_pid+0x22/0x5c
>>   PGD 19efa067 P4D 19efa067 PUD 0
>>   Oops: 0000 [#1]
>>   CPU: 0 PID: 727 Comm: trinity Not tainted 4.16.0-rc2-00010-g98f929b #1
>>   RIP: 0010:put_pid+0x22/0x5c
>>   RSP: 0018:ffff986719f73e48 EFLAGS: 00010202
>>   RAX: 00000006d765f710 RBX: ffff98671a4fa4d0 RCX: ffff986719f73d40
>>   RDX: 000000006f6e6125 RSI: 0000000000000000 RDI: ffffffffa01e6d21
>>   RBP: ffffffffa0955fe0 R08: 0000000000000020 R09: 0000000000000000
>>   R10: 0000000000000078 R11: ffff986719f73e76 R12: 0000000000001000
>>   R13: 00000000ffffffea R14: 0000000054000fb0 R15: 0000000000000000
>>   FS:  00000000028c2880(0000) GS:ffffffffa06ad000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 0000000677846439 CR3: 0000000019fc1005 CR4: 00000000000606b0
>>   Call Trace:
>>    ? ipc_update_pid+0x36/0x3e
>>    ? newseg+0x34c/0x3a6
>>    ? ipcget+0x5d/0x528
>>    ? entry_SYSCALL_64_after_hwframe+0x52/0xb7
>>    ? SyS_shmget+0x5a/0x84
>>    ? do_syscall_64+0x194/0x1b3
>>    ? entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>   Code: ff 05 e7 20 9b 03 58 c9 c3 48 ff 05 85 21 9b 03 48 85 ff 74 4f 8b 47 04 8b 17 48 ff 05 7c 21 9b 03 48 83 c0 03 48 c1 e0 04 ff ca <48> 8b 44 07 08 74 1f 48 ff 05 6c 21 9b 03 ff 0f 0f 94 c2 48 ff
>>   RIP: put_pid+0x22/0x5c RSP: ffff986719f73e48
>>   CR2: 0000000677846439
>>   ---[ end trace ab8c5cb4389d37c5 ]---
>>   Kernel panic - not syncing: Fatal exception
> In newseg when changing shm_cprid and shm_lprid from pid_t to struct
> pid* I misread the kvmalloc as kvzalloc and thought shp was
> initialized to 0.  As that is not the case it is not safe to for the
> error handling to address shm_cprid and shm_lprid before they are
> initialized.
>
> Therefore move the cleanup of shm_cprid and shm_lprid from the no_file
> error cleanup path to the no_id error cleanup path.  Ensuring that an
> early error exit won't cause the oops above.
>
> Reported-by:  kernel test robot <fengguang.wu@intel.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Thanks!

Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
> ---
>   ipc/shm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 018db3d0e70e..35bdfe76d11b 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -646,12 +646,12 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>   	return error;
>   
>   no_id:
> +	ipc_update_pid(&shp->shm_cprid, NULL);
> +	ipc_update_pid(&shp->shm_lprid, NULL);
>   	if (is_file_hugepages(file) && shp->mlock_user)
>   		user_shm_unlock(size, shp->mlock_user);
>   	fput(file);
>   no_file:
> -	ipc_update_pid(&shp->shm_cprid, NULL);
> -	ipc_update_pid(&shp->shm_lprid, NULL);
>   	call_rcu(&shp->shm_perm.rcu, shm_rcu_free);
>   	return error;
>   }
