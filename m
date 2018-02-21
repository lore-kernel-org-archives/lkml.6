Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBUUbN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:31:13 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:51773 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeBUUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:31:00 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 21 Feb 2018 14:29:08 -0600
Message-Id: <20180221202908.17258-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878tbmf5vl.fsf@xmission.com>
References: <878tbmf5vl.fsf@xmission.com>
X-XM-SPF: eid=1eob2Y-0004Av-UT;;;mid=<20180221202908.17258-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19mzDCCaskvtQtga3PZFjdPcHZ77wZGT+A=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5015]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 244 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.3 (1.0%), b_tie_ro: 1.62 (0.7%), parse: 0.75 (0.3%),
        extract_message_metadata: 18 (7.4%), get_uri_detail_list: 2.0 (0.8%),
        tests_pri_-1000: 12 (4.8%), tests_pri_-950: 1.17 (0.5%), tests_pri_-900: 1.00
        (0.4%), tests_pri_-400: 21 (8.6%), check_bayes: 20 (8.2%), b_tokenize: 7
        (2.9%), b_tok_get_all: 7 (2.7%), b_comp_prob: 1.77 (0.7%), b_tok_touch_all:
        2.7 (1.1%), b_finish: 0.58 (0.2%), tests_pri_0: 171 (70.1%),
        check_dkim_signature: 0.44 (0.2%), check_dkim_adsp: 2.5 (1.0%),
        tests_pri_500: 14 (5.8%), poll_dns_idle: 6 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v6 5/5] fuse: Restrict allow_other to the superblock's namespace or a descendant
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seth Forshee <seth.forshee@canonical.com>

Unprivileged users are normally restricted from mounting with the
allow_other option by system policy, but this could be bypassed
for a mount done with user namespace root permissions. In such
cases allow_other should not allow users outside the userns
to access the mount as doing so would give the unprivileged user
the ability to manipulate processes it would otherwise be unable
to manipulate. Restrict allow_other to apply to users in the same
userns used at mount or a descendant of that namespace. Also
export current_in_userns() for use by fuse when built as a
module.

Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/fuse/dir.c           | 2 +-
 kernel/user_namespace.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ad1cfac1942f..d41559a0aa6b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1030,7 +1030,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
 	const struct cred *cred;
 
 	if (fc->allow_other)
-		return 1;
+		return current_in_userns(fc->user_ns);
 
 	cred = current_cred();
 	if (uid_eq(cred->euid, fc->user_id) &&
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 246d4d4ce5c7..492c255e6c5a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1235,6 +1235,7 @@ bool current_in_userns(const struct user_namespace *target_ns)
 {
 	return in_userns(target_ns, current_user_ns());
 }
+EXPORT_SYMBOL(current_in_userns);
 
 static inline struct user_namespace *to_user_ns(struct ns_common *ns)
 {
-- 
2.14.1
