Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbeCHV2g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:28:36 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:49461 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeCHV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:28:34 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu,  8 Mar 2018 15:24:27 -0600
Message-Id: <20180308212430.7053-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87ina6ntx0.fsf_-_@xmission.com>
References: <87ina6ntx0.fsf_-_@xmission.com>
X-XM-SPF: eid=1eu35G-00018P-9m;;;mid=<20180308212430.7053-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/2VqdNp0d82Hg0vn4H20vfxeF6XSNwbs4=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=270]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=270 
X-Spam-Combo: *;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15020 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.0%), b_tie_ro: 1.71 (0.0%), parse: 0.73 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 1.37 (0.0%),
        tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.18 (0.0%), tests_pri_-900:
        1.01 (0.0%), tests_pri_-400: 32 (0.2%), check_bayes: 30 (0.2%), b_tokenize:
        11 (0.1%), b_tok_get_all: 8 (0.0%), b_comp_prob: 3.2 (0.0%), b_tok_touch_all:
        6 (0.0%), b_finish: 1.52 (0.0%), tests_pri_0: 199 (1.3%),
        check_dkim_signature: 0.66 (0.0%), check_dkim_adsp: 3.3 (0.0%),
        tests_pri_500: 14769 (98.3%), poll_dns_idle: 14761 (98.3%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH v9 1/4] fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the point of fuse_dev_do_read the user space process that initiated the
action on the fuse filesystem may no longer exist.  The process have been
killed or may have fired an asynchronous request and exited.

If the initial process has exited the code "pid_vnr(find_pid_ns(in->h.pid,
fc->pid_ns)" will either return a pid of 0, or in the unlikely event that
the pid has been reallocated it can return practically any pid.  Any pid is
possible as the pid allocator allocates pid numbers in different pid
namespaces independently.

The only way to make translation in fuse_dev_do_read reliable is to call
get_pid in fuse_req_init_context, and pid_vnr followed by put_pid in
fuse_dev_do_read.  That reference counting in other contexts has been shown
to bounce cache lines between processors and in general be slow.  So that is
not desirable.

The only known user of running the fuse server in a different pid namespace
from the filesystem does not care what the pids are in the fuse messages
so removing this code should not matter.

Getting the translation to a server running outside of the pid namespace
of a container can still be achieved by playing setns games at mount time.
It is also possible to add an option to pass a pid namespace into the fuse
filesystem at mount time.

Fixes: 5d6d3a301c4e ("fuse: allow server to run in different pid_ns")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fuse/dev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5d06384c2cae..0fb58f364fa6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1260,12 +1260,6 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	in = &req->in;
 	reqsize = in->h.len;
 
-	if (task_active_pid_ns(current) != fc->pid_ns) {
-		rcu_read_lock();
-		in->h.pid = pid_vnr(find_pid_ns(in->h.pid, fc->pid_ns));
-		rcu_read_unlock();
-	}
-
 	/* If request is too large, reply with an error and restart the read */
 	if (nbytes < reqsize) {
 		req->out.h.error = -EIO;
-- 
2.14.1
