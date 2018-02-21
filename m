Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeBUUay (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:30:54 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47047 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeBUUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:30:52 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 21 Feb 2018 14:29:05 -0600
Message-Id: <20180221202908.17258-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878tbmf5vl.fsf@xmission.com>
References: <878tbmf5vl.fsf@xmission.com>
X-XM-SPF: eid=1eob2C-0004Av-E8;;;mid=<20180221202908.17258-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+edoXUsW77mNjLXj6+hEkef83bAmncRGY=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15020 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (0.0%), b_tie_ro: 1.80 (0.0%), parse: 0.73 (0.0%),
        extract_message_metadata: 9 (0.1%), get_uri_detail_list: 1.48 (0.0%),
        tests_pri_-1000: 2.6 (0.0%), tests_pri_-950: 1.12 (0.0%), tests_pri_-900:
        0.92 (0.0%), tests_pri_-400: 20 (0.1%), check_bayes: 19 (0.1%), b_tokenize: 7
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.65 (0.0%), b_tok_touch_all:
        2.7 (0.0%), b_finish: 0.53 (0.0%), tests_pri_0: 175 (1.2%),
        check_dkim_signature: 0.41 (0.0%), check_dkim_adsp: 3.1 (0.0%),
        tests_pri_500: 14804 (98.6%), poll_dns_idle: 14796 (98.5%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH v6 2/5] fuse: Fail all requests with invalid uids or gids
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
 fs/fuse/dev.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0fb58f364fa6..216db3f51a31 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -112,11 +112,13 @@ static void __fuse_put_request(struct fuse_req *req)
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
 }
 
 void fuse_set_initialized(struct fuse_conn *fc)
@@ -162,12 +164,13 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
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
@@ -256,9 +259,12 @@ struct fuse_req *fuse_get_req_nofail_nopages(struct fuse_conn *fc,
 	if (!req)
 		req = get_reserved_req(fc, file);
 
-	fuse_req_init_context(fc, req);
 	__set_bit(FR_WAITING, &req->flags);
 	__clear_bit(FR_BACKGROUND, &req->flags);
+	if (unlikely(!fuse_req_init_context(fc, req))) {
+		fuse_put_request(fc, req);
+		return ERR_PTR(-EOVERFLOW);
+	}
 	return req;
 }
 
-- 
2.14.1
