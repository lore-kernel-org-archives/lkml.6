Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932726AbeCBWAm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:00:42 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54879 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932428AbeCBWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:00:39 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri,  2 Mar 2018 15:59:17 -0600
Message-Id: <20180302215919.27207-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87r2p287i8.fsf_-_@xmission.com>
References: <87r2p287i8.fsf_-_@xmission.com>
X-XM-SPF: eid=1ersjF-0000ts-4w;;;mid=<20180302215919.27207-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ErfgL8Aop+U3yErFB2ZXRGDl6ER3/kiQ=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=67]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=67 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1241 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.6 (0.4%), b_tie_ro: 3.8 (0.3%), parse: 0.72 (0.1%),
        extract_message_metadata: 10 (0.8%), get_uri_detail_list: 1.52 (0.1%),
        tests_pri_-1000: 5 (0.4%), tests_pri_-950: 1.13 (0.1%), tests_pri_-900: 0.94
        (0.1%), tests_pri_-400: 24 (2.0%), check_bayes: 23 (1.9%), b_tokenize: 7
        (0.6%), b_tok_get_all: 9 (0.7%), b_comp_prob: 1.86 (0.1%), b_tok_touch_all:
        3.5 (0.3%), b_finish: 0.66 (0.1%), tests_pri_0: 1187 (95.6%),
        check_dkim_signature: 0.47 (0.0%), check_dkim_adsp: 2.4 (0.2%),
        tests_pri_500: 5 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v8 4/6] fuse: Fail all requests with invalid uids or gids
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon a cursory examinination the uid and gid of a fuse request are
necessary for correct operation.  Failing a fuse request where those
values are not reliable seems a straight forward and reliable means of
ensuring that fuse requests with bad data are not sent or processed.

In most cases the vfs will avoid actions it suspects will cause
an inode write back of an inode with an invalid uid or gid.  But that does
not map precisely to what fuse is doing, so test for this and solve
this at the fuse level as well.

Performing this work in fuse_req_init_context is cheap as the code is
already performing the translation here and only needs to check the
result of the translation to see if things are not representable in
a form the fuse server can handle.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/fuse/dev.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0fb58f364fa6..2886a56d5f61 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -112,11 +112,20 @@ static void __fuse_put_request(struct fuse_req *req)
 	refcount_dec(&req->count);
 }
 
-static void fuse_req_init_context(struct fuse_conn *fc, struct fuse_req *req)
+static bool fuse_req_init_context(struct fuse_conn *fc, struct fuse_req *req)
 {
-	req->in.h.uid = from_kuid_munged(&init_user_ns, current_fsuid());
-	req->in.h.gid = from_kgid_munged(&init_user_ns, current_fsgid());
+	req->in.h.uid = from_kuid(&init_user_ns, current_fsuid());
+	req->in.h.gid = from_kgid(&init_user_ns, current_fsgid());
 	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
+
+	return (req->in.h.uid != ((uid_t)-1)) && (req->in.h.gid != ((gid_t)-1));
+}
+
+static void fuse_req_init_context_nofail(struct fuse_req *req)
+{
+	req->in.h.uid = 0;
+	req->in.h.gid = 0;
+	req->in.h.pid = 0;
 }
 
 void fuse_set_initialized(struct fuse_conn *fc)
@@ -162,12 +171,13 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
 			wake_up(&fc->blocked_waitq);
 		goto out;
 	}
-
-	fuse_req_init_context(fc, req);
 	__set_bit(FR_WAITING, &req->flags);
 	if (for_background)
 		__set_bit(FR_BACKGROUND, &req->flags);
-
+	if (unlikely(!fuse_req_init_context(fc, req))) {
+		fuse_put_request(fc, req);
+		return ERR_PTR(-EOVERFLOW);
+	}
 	return req;
 
  out:
@@ -256,7 +266,7 @@ struct fuse_req *fuse_get_req_nofail_nopages(struct fuse_conn *fc,
 	if (!req)
 		req = get_reserved_req(fc, file);
 
-	fuse_req_init_context(fc, req);
+	fuse_req_init_context_nofail(req);
 	__set_bit(FR_WAITING, &req->flags);
 	__clear_bit(FR_BACKGROUND, &req->flags);
 	return req;
-- 
2.14.1
