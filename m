Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeBZXy1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:54:27 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:37273 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeBZXyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:54:24 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 26 Feb 2018 17:52:58 -0600
Message-Id: <20180226235302.12708-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87po4rz4ui.fsf_-_@xmission.com>
References: <87po4rz4ui.fsf_-_@xmission.com>
X-XM-SPF: eid=1eqSb9-0005iL-7C;;;mid=<20180226235302.12708-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+sVgvknIFd9LBW190FBDC1RLnbry6ijxc=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 209 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (1.4%), b_tie_ro: 2.0 (1.0%), parse: 0.99 (0.5%),
        extract_message_metadata: 13 (6.1%), get_uri_detail_list: 1.71 (0.8%),
        tests_pri_-1000: 6 (2.8%), tests_pri_-950: 1.19 (0.6%), tests_pri_-900: 1.02
        (0.5%), tests_pri_-400: 18 (8.5%), check_bayes: 17 (8.0%), b_tokenize: 5
        (2.6%), b_tok_get_all: 5 (2.6%), b_comp_prob: 1.94 (0.9%), b_tok_touch_all:
        2.2 (1.1%), b_finish: 0.60 (0.3%), tests_pri_0: 159 (76.2%),
        check_dkim_signature: 0.61 (0.3%), check_dkim_adsp: 2.8 (1.3%),
        tests_pri_500: 4.6 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v7 3/7] fs/posix_acl: Document that get_acl respects ACL_DONT_CACHE
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuse is about to join overlayfs in relying on get_acl respecting
ACL_DONT_CACHE so update the documentation in get_acl to reflect that
fact.  The comment and this change description should give people a
clue that respecting ACL_DONT_CACHE in get_acl is important, and they
should audit the filesystems before removing that support.

Additionaly update the comment above the call to get_acl itself and
remove the wrong information that an implementation of get_acl can
prevent caching by calling forget_cached_acl.  Replace that with the
correct information that to prevent caching all that is necessary is
to set inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE when the
inode is initialized.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/posix_acl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 2fd0fde16fe1..3c24fc263401 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -121,14 +121,17 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 	 * could wait for that other task to complete its job, but it's easier
 	 * to just call ->get_acl to fetch the ACL ourself.  (This is going to
 	 * be an unlikely race.)
+	 *
+	 * ACL_DONT_CACHE is treated as another task updating the acl and
+	 * remains set.
 	 */
 	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
 		/* fall through */ ;
 
 	/*
 	 * Normally, the ACL returned by ->get_acl will be cached.
-	 * A filesystem can prevent that by calling
-	 * forget_cached_acl(inode, type) in ->get_acl.
+	 * A filesystem can prevent that by calling setting
+	 * inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE.
 	 *
 	 * If the filesystem doesn't have a get_acl() function at all, we'll
 	 * just create the negative cache entry.
-- 
2.14.1
