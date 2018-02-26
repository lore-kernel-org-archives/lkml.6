Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeBZXym (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:54:42 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:59845 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeBZXy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:54:26 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 26 Feb 2018 17:52:59 -0600
Message-Id: <20180226235302.12708-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87po4rz4ui.fsf_-_@xmission.com>
References: <87po4rz4ui.fsf_-_@xmission.com>
X-XM-SPF: eid=1eqSbB-0005iL-DO;;;mid=<20180226235302.12708-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//9JS+0CbA0AiBz6rUKt//SmBQIKZtfB4=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 171 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.9 (1.7%), b_tie_ro: 2.1 (1.2%), parse: 0.93 (0.5%),
        extract_message_metadata: 10 (5.7%), get_uri_detail_list: 0.85 (0.5%),
        tests_pri_-1000: 6 (3.2%), tests_pri_-950: 1.14 (0.7%), tests_pri_-900: 0.95
        (0.6%), tests_pri_-400: 16 (9.5%), check_bayes: 15 (8.9%), b_tokenize: 4.7
        (2.7%), b_tok_get_all: 5 (3.0%), b_comp_prob: 1.41 (0.8%), b_tok_touch_all:
        2.3 (1.4%), b_finish: 0.62 (0.4%), tests_pri_0: 126 (73.5%),
        check_dkim_signature: 0.59 (0.3%), check_dkim_adsp: 2.4 (1.4%),
        tests_pri_500: 5 (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v7 4/7] fuse: Cache a NULL acl when FUSE_GETXATTR returns -ENOSYS
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When FUSE_GETXATTR will never return anything call cache_no_acl to
cache that state in the vfs as well in fuse with fc->no_getxattr.

The only code path this affects are the code paths that call
fuse_get_acl and caching a NULL or returning it immediately
is exactly the same effect so this should not effect anything.

This keeps the vfs from waisting it's time calling down into fuse
when fuse isn't going to do anything, and it makes it clear
when a NULL should be cached for optimal performance.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fuse/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 3caac46b08b0..0520a4f47226 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -82,6 +82,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 		ret = min_t(ssize_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
 		fc->no_getxattr = 1;
+		cache_no_acl(inode);
 		ret = -EOPNOTSUPP;
 	}
 	return ret;
-- 
2.14.1
