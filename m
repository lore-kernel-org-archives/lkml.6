Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeCBWA3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:00:29 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50180 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932428AbeCBWA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:00:28 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri,  2 Mar 2018 15:59:14 -0600
Message-Id: <20180302215919.27207-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87r2p287i8.fsf_-_@xmission.com>
References: <87r2p287i8.fsf_-_@xmission.com>
X-XM-SPF: eid=1ersj3-0000ts-AL;;;mid=<20180302215919.27207-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+AZqtuwQ7WX6FylUTdSlEvkIyd1PcjxQY=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1379 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.2%), b_tie_ro: 2.1 (0.2%), parse: 1.38 (0.1%),
        extract_message_metadata: 18 (1.3%), get_uri_detail_list: 3.8 (0.3%),
        tests_pri_-1000: 9 (0.6%), tests_pri_-950: 1.71 (0.1%), tests_pri_-900: 1.45
        (0.1%), tests_pri_-400: 33 (2.4%), check_bayes: 32 (2.3%), b_tokenize: 16
        (1.2%), b_tok_get_all: 8 (0.5%), b_comp_prob: 3.2 (0.2%), b_tok_touch_all:
        2.2 (0.2%), b_finish: 0.61 (0.0%), tests_pri_0: 1303 (94.5%),
        check_dkim_signature: 0.75 (0.1%), check_dkim_adsp: 3.1 (0.2%),
        tests_pri_500: 4.5 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v8 1/6] fs/posix_acl: Update the comments and support lightweight cache skipping
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code has been missing a way for a ->get_acl method to not cache
a return value without risking invalidating a cached value
that was set while get_acl() was returning.

Add that support by implementing to_uncachable_acl, to_cachable_acl,
is_uncacheable_acl, and dealing with uncachable acls in get_acl().

Update the comments so that they are a little clearer about
what is going on in get_acl()

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/posix_acl.c            | 50 ++++++++++++++++++++++++++++++++---------------
 include/linux/posix_acl.h | 17 ++++++++++++++++
 2 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 2fd0fde16fe1..00281bc30854 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -96,12 +96,16 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 {
 	void *sentinel;
 	struct posix_acl **p;
-	struct posix_acl *acl;
+	struct posix_acl *acl, *to_cache;
 
 	/*
 	 * The sentinel is used to detect when another operation like
 	 * set_cached_acl() or forget_cached_acl() races with get_acl().
 	 * It is guaranteed that is_uncached_acl(sentinel) is true.
+	 *
+	 * This is sufficient to prevent races between ->set_acl
+	 * calling set_cached_acl (outside of filesystem specific
+	 * locking) and get_acl() caching the returned acl.
 	 */
 
 	acl = get_cached_acl(inode, type);
@@ -126,12 +130,18 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 		/* fall through */ ;
 
 	/*
-	 * Normally, the ACL returned by ->get_acl will be cached.
-	 * A filesystem can prevent that by calling
-	 * forget_cached_acl(inode, type) in ->get_acl.
+	 * Normally, the ACL returned by ->get_acl() will be cached.
+	 *
+	 * A filesystem can prevent the acl returned by ->get_acl()
+	 * from being cached by wrapping it with to_uncachable_acl().
 	 *
-	 * If the filesystem doesn't have a get_acl() function at all, we'll
-	 * just create the negative cache entry.
+	 * A filesystem can at anytime effect the cache directly and
+	 * cause in process calls of get_acl() not to update the cache
+	 * by calling forget_cache_acl(inode, type) or
+	 * set_cached_acl(inode, type, acl).
+	 *
+	 * If the filesystem doesn't have a ->get_acl() function at
+	 * all, we'll just create the negative cache entry.
 	 */
 	if (!inode->i_op->get_acl) {
 		set_cached_acl(inode, type, NULL);
@@ -140,20 +150,28 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 	acl = inode->i_op->get_acl(inode, type);
 
 	if (IS_ERR(acl)) {
-		/*
-		 * Remove our sentinel so that we don't block future attempts
-		 * to cache the ACL.
-		 */
-		cmpxchg(p, sentinel, ACL_NOT_CACHED);
-		return acl;
+		/* Don't cache an acl just return an error. */
+		to_cache = ACL_NOT_CACHED;
+	}
+	else if (is_uncacheable_acl(acl)) {
+		/* Don't cache an acl, but return one. */
+		to_cache = ACL_NOT_CACHED;
+		acl = to_cacheable_acl(acl);
+	}
+	else {
+		/* Cache and return the acl. */
+		to_cache = posix_acl_dup(acl);
 	}
 
 	/*
-	 * Cache the result, but only if our sentinel is still in place.
+	 * Remove the sentinel and replace it with the value to
+	 * cache, but only if the sentinel is still in place.
 	 */
-	posix_acl_dup(acl);
-	if (unlikely(cmpxchg(p, sentinel, acl) != sentinel))
-		posix_acl_release(acl);
+	if (unlikely(cmpxchg(p, sentinel, to_cache) != sentinel)) {
+		if (!is_uncached_acl(to_cache))
+			posix_acl_release(to_cache);
+	}
+
 	return acl;
 }
 EXPORT_SYMBOL(get_acl);
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 540595a321a7..3be8929b9f48 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -56,6 +56,23 @@ posix_acl_release(struct posix_acl *acl)
 		kfree_rcu(acl, a_rcu);
 }
 
+/*
+ * Allow for acls returned from ->get_acl() to not be cached.
+ */
+static inline bool is_uncacheable_acl(struct posix_acl *acl)
+{
+	return ((unsigned long)acl) & 1UL;
+}
+
+static inline struct posix_acl *to_uncacheable_acl(struct posix_acl *acl)
+{
+	return (struct posix_acl *)(((unsigned long)acl) | 1UL);
+}
+
+static inline struct posix_acl *to_cacheable_acl(struct posix_acl *acl)
+{
+	return (struct posix_acl *)(((unsigned long)acl) & ~1UL);
+}
 
 /* posix_acl.c */
 
-- 
2.14.1
