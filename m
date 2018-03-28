Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeC1SsU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:48:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53841 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeC1SsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:48:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: linux-kernel@vger.kernel.org
Cc: LKP <lkp@01.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        wfg@linux.intel.com, kernel test robot <fengguang.wu@intel.com>
References: <5abb446e.XtEK088UbWSHCPaF%fengguang.wu@intel.com>
Date: Wed, 28 Mar 2018 13:47:03 -0500
In-Reply-To: <5abb446e.XtEK088UbWSHCPaF%fengguang.wu@intel.com> (kernel test
        robot's message of "Wed, 28 Mar 2018 15:29:50 +0800")
Message-ID: <877epwavh4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f1G7A-0005oB-3v;;;mid=<877epwavh4.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/dLsrYZ35VLiS4igX5jGt7MRTERcLUxz0=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  1.0 XM_Doc_Oz_Body BODY: Dr. Oz body dropper
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 2054 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.9 (0.1%), b_tie_ro: 2.0 (0.1%), parse: 0.79 (0.0%),
        extract_message_metadata: 12 (0.6%), get_uri_detail_list: 1.65 (0.1%),
        tests_pri_-1000: 6 (0.3%), tests_pri_-950: 1.11 (0.1%), tests_pri_-900: 0.91
        (0.0%), tests_pri_-400: 23 (1.1%), check_bayes: 23 (1.1%), b_tokenize: 7
        (0.3%), b_tok_get_all: 7 (0.4%), b_comp_prob: 2.3 (0.1%), b_tok_touch_all:
        4.2 (0.2%), b_finish: 0.54 (0.0%), tests_pri_0: 174 (8.5%),
        check_dkim_signature: 0.50 (0.0%), check_dkim_adsp: 2.6 (0.1%),
        tests_pri_500: 1829 (89.0%), poll_dns_idle: 1818 (88.5%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH] ipc/shm: Fix pid freeing.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The 0day kernel test build report reported an oops:
>
>  IP: put_pid+0x22/0x5c
>  PGD 19efa067 P4D 19efa067 PUD 0
>  Oops: 0000 [#1]
>  CPU: 0 PID: 727 Comm: trinity Not tainted 4.16.0-rc2-00010-g98f929b #1
>  RIP: 0010:put_pid+0x22/0x5c
>  RSP: 0018:ffff986719f73e48 EFLAGS: 00010202
>  RAX: 00000006d765f710 RBX: ffff98671a4fa4d0 RCX: ffff986719f73d40
>  RDX: 000000006f6e6125 RSI: 0000000000000000 RDI: ffffffffa01e6d21
>  RBP: ffffffffa0955fe0 R08: 0000000000000020 R09: 0000000000000000
>  R10: 0000000000000078 R11: ffff986719f73e76 R12: 0000000000001000
>  R13: 00000000ffffffea R14: 0000000054000fb0 R15: 0000000000000000
>  FS:  00000000028c2880(0000) GS:ffffffffa06ad000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000677846439 CR3: 0000000019fc1005 CR4: 00000000000606b0
>  Call Trace:
>   ? ipc_update_pid+0x36/0x3e
>   ? newseg+0x34c/0x3a6
>   ? ipcget+0x5d/0x528
>   ? entry_SYSCALL_64_after_hwframe+0x52/0xb7
>   ? SyS_shmget+0x5a/0x84
>   ? do_syscall_64+0x194/0x1b3
>   ? entry_SYSCALL_64_after_hwframe+0x42/0xb7
>  Code: ff 05 e7 20 9b 03 58 c9 c3 48 ff 05 85 21 9b 03 48 85 ff 74 4f 8b 47 04 8b 17 48 ff 05 7c 21 9b 03 48 83 c0 03 48 c1 e0 04 ff ca <48> 8b 44 07 08 74 1f 48 ff 05 6c 21 9b 03 ff 0f 0f 94 c2 48 ff
>  RIP: put_pid+0x22/0x5c RSP: ffff986719f73e48
>  CR2: 0000000677846439
>  ---[ end trace ab8c5cb4389d37c5 ]---
>  Kernel panic - not syncing: Fatal exception

In newseg when changing shm_cprid and shm_lprid from pid_t to struct
pid* I misread the kvmalloc as kvzalloc and thought shp was
initialized to 0.  As that is not the case it is not safe to for the
error handling to address shm_cprid and shm_lprid before they are
initialized.

Therefore move the cleanup of shm_cprid and shm_lprid from the no_file
error cleanup path to the no_id error cleanup path.  Ensuring that an
early error exit won't cause the oops above.

Reported-by:  kernel test robot <fengguang.wu@intel.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 ipc/shm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 018db3d0e70e..35bdfe76d11b 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -646,12 +646,12 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	return error;
 
 no_id:
+	ipc_update_pid(&shp->shm_cprid, NULL);
+	ipc_update_pid(&shp->shm_lprid, NULL);
 	if (is_file_hugepages(file) && shp->mlock_user)
 		user_shm_unlock(size, shp->mlock_user);
 	fput(file);
 no_file:
-	ipc_update_pid(&shp->shm_cprid, NULL);
-	ipc_update_pid(&shp->shm_lprid, NULL);
 	call_rcu(&shp->shm_perm.rcu, shm_rcu_free);
 	return error;
 }
-- 
2.14.1
