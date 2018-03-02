Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeCBTyZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:54:25 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:38724 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932387AbeCBTyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:54:23 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <87po4rz4ui.fsf_-_@xmission.com>
        <20180226235302.12708-3-ebiederm@xmission.com>
        <CA+55aFySgJyR6JLcS9HLC9wEpWU1isdyTkchHxZHbJWsh7HFpg@mail.gmail.com>
        <87r2p7rvn5.fsf@xmission.com> <87tvu3qg2b.fsf@xmission.com>
        <CA+55aFwPo7Pbq+3Oup-oo8MUFHeEpFXp7qr6z2PrzKp7S0ON+A@mail.gmail.com>
Date: Fri, 02 Mar 2018 13:53:45 -0600
In-Reply-To: <CA+55aFwPo7Pbq+3Oup-oo8MUFHeEpFXp7qr6z2PrzKp7S0ON+A@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 26 Feb 2018 19:41:21 -0800")
Message-ID: <87r2p2b6eu.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1erql3-0005vv-3M;;;mid=<87r2p2b6eu.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/4t4hSeajxuYNMhrp57GHLiqpesI6YFTw=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 353 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.7 (0.8%), b_tie_ro: 1.83 (0.5%), parse: 0.95 (0.3%),
        extract_message_metadata: 11 (3.2%), get_uri_detail_list: 2.7 (0.8%),
        tests_pri_-1000: 6 (1.6%), tests_pri_-950: 1.15 (0.3%), tests_pri_-900: 0.93
        (0.3%), tests_pri_-400: 31 (8.8%), check_bayes: 30 (8.5%), b_tokenize: 10
        (3.0%), b_tok_get_all: 11 (3.1%), b_comp_prob: 2.5 (0.7%), b_tok_touch_all:
        3.0 (0.9%), b_finish: 0.59 (0.2%), tests_pri_0: 290 (82.1%),
        check_dkim_signature: 0.57 (0.2%), check_dkim_adsp: 2.6 (0.7%),
        tests_pri_500: 6 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] fs/posix_acl: Update the comments and support lightweight cache skipping
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

Linus my issue with the forget_cached_acl case was really that it was
too big of a hammer.  If you care about caching acls only somtimes
forget_cached_acl called from ->get_acl can stomp that acl you
explicitly cached with set_cached_acl.

With this change I can unify the legacy horrible fuse posix acl case
that requires not caching acls with a single if statement in the get_acl
method. AKA:

+	if (!IS_ERR(acl) && !fc->posix_acl)
+		acl = to_uncacheable_acl(acl);
 	return acl;

That code I know is locally correct even if later fuse decides to cache
negative acls when the underlying filesystem does not support xattrs.

 fs/posix_acl.c            | 56 ++++++++++++++++++++++++++++++++++-------------
 include/linux/posix_acl.h | 17 ++++++++++++++
 2 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 2fd0fde16fe1..e58a68e18603 100644
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
+	 *
+	 * A filesystem can at anytime effect the cache directly and
+	 * cause in process calls of get_acl() not to update the cache
+	 * by calling forget_cache_acl(inode, type) or
+	 * set_cached_acl(inode, type, acl).
 	 *
-	 * If the filesystem doesn't have a get_acl() function at all, we'll
-	 * just create the negative cache entry.
+	 * If the filesystem doesn't have a ->get_acl() function at
+	 * all, we'll just create the negative cache entry.
 	 */
 	if (!inode->i_op->get_acl) {
 		set_cached_acl(inode, type, NULL);
@@ -139,21 +149,37 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 	}
 	acl = inode->i_op->get_acl(inode, type);
 
+
+	/* To keep the logic simple default to not caching an acl when
+	 * the sentinel is cleared.
+	 */
+	to_cache = ACL_NOT_CACHED;
 	if (IS_ERR(acl)) {
-		/*
-		 * Remove our sentinel so that we don't block future attempts
-		 * to cache the ACL.
+		/* Clears the sentinel so that we don't block future
+		 * attempts to cache the ACL, and return an error.
 		 */
-		cmpxchg(p, sentinel, ACL_NOT_CACHED);
-		return acl;
+	}
+	else if (is_uncacheable_acl(acl)) {
+		/* Clears the sentinel so that we don't block future
+		 * attempts to cache the ACL, and return a valid ACL.
+		 */
+		acl = to_cacheable_acl(acl);
+	}
+	else {
+		to_cache = acl;
+		posix_acl_dup(to_cache);
 	}
 
 	/*
-	 * Cache the result, but only if our sentinel is still in place.
+	 * Remove the sentinel and replace it with the value that
+	 * needs to be cached, but only if the sentinel is still in
+	 * place.
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
