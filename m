Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZquHV5g1wTTNOBz5hutZAFpAiYlbuXGE93rPzQDAb3eTI7yzAn4M6Yfj8Zm7dkuT28EPzjs
ARC-Seal: i=1; a=rsa-sha256; t=1525146786; cv=none;
        d=google.com; s=arc-20160816;
        b=QuX9rfj/6bLr27i25aFmT+thGt+lFulMqvZmjjTWHEI3Pq8R+YdBM1dcd31EzpZm6p
         MzqgYucfWYvqKHDWYxGMp7y5brqHHxb5cTDlKTCmx/FvG2/xJQjSrGw59B+SZ41ML8Ot
         MOhwSuwxBm+vt7346j2713E1eL94pLkZQuqBiKjc7RcJnCMesFvO5i0wI0dFC/g1BPYO
         MJvId2SgqE8VStLVgT33Dkj5MZLuE2U1nf9qTU3QaI7oKPKJ6FLQeX6NVoShLeyrJ/7i
         E8ny/gtR3i/dI4J/P8jJ0ZFgfrJ2UWjH9G7XcLeMRZZ/RRpyOdqln/WzC+k0NoEMsxY3
         5Dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=beEO4xl03KFMSLO5fr+YCYumaifnzFwPy68fnXHNlSM=;
        b=oQSZGedgIm+7imtDUaYZgy6s92weZOgFNcPfOao8nLa0vrTxmvKe5Rnol0mRpC4POT
         GbawLM3cURamEC1g6oZ8a2cuP97FOkXFBzKvRWV4xbBbXkRnjPPm+oMr5scmMompXG+R
         ptJMbl/05UAK5XIx6VHnjSnyLnPWstiRfrLvV1zGrvZvT2r/Z65l3SDWc4b6To6ovRdO
         ah9roE8Ide3f6tlkLrwXIGWbsYhPRUWE/HUZq4Pu43YdtTOxLzdu7COLSamWDCewsCS0
         h3Cf5Bxb9NHBNMY9EkZK0/p6VW64/R5d0hKKLhJw+LRE99X772poeTclVDqT4FI2w90n
         O1Yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Tue, 01 May 2018 13:52:38 +1000
Subject: [PATCH 01/10] staging: lustre: ldlm: store name directly in
 namespace.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152514675876.17843.12443354625160742215.stgit@noble>
In-Reply-To: <152514658325.17843.11455067361317157487.stgit@noble>
References: <152514658325.17843.11455067361317157487.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232316691358736?=
X-GMAIL-MSGID: =?utf-8?q?1599232316691358736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rather than storing the name of a namespace in the
hash table, store it directly in the namespace.
This will allow the hashtable to be changed to use
rhashtable.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
Reviewed-by: Andreas Dilger <andreas.dilger@dilger.ca>
---
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    5 ++++-
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |    5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
index d668d86423a4..b3532adac31c 100644
--- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
+++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
@@ -362,6 +362,9 @@ struct ldlm_namespace {
 	/** Flag indicating if namespace is on client instead of server */
 	enum ldlm_side		ns_client;
 
+	/** name of this namespace */
+	char			*ns_name;
+
 	/** Resource hash table for namespace. */
 	struct cfs_hash		*ns_rs_hash;
 
@@ -878,7 +881,7 @@ static inline bool ldlm_has_layout(struct ldlm_lock *lock)
 static inline char *
 ldlm_ns_name(struct ldlm_namespace *ns)
 {
-	return ns->ns_rs_hash->hs_name;
+	return ns->ns_name;
 }
 
 static inline struct ldlm_namespace *
diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
index 6c615b6e9bdc..43bbc5fd94cc 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
@@ -688,6 +688,9 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 	ns->ns_obd      = obd;
 	ns->ns_appetite = apt;
 	ns->ns_client   = client;
+	ns->ns_name     = kstrdup(name, GFP_KERNEL);
+	if (!ns->ns_name)
+		goto out_hash;
 
 	INIT_LIST_HEAD(&ns->ns_list_chain);
 	INIT_LIST_HEAD(&ns->ns_unused_list);
@@ -730,6 +733,7 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 	ldlm_namespace_sysfs_unregister(ns);
 	ldlm_namespace_cleanup(ns, 0);
 out_hash:
+	kfree(ns->ns_name);
 	cfs_hash_putref(ns->ns_rs_hash);
 out_ns:
 	kfree(ns);
@@ -993,6 +997,7 @@ void ldlm_namespace_free_post(struct ldlm_namespace *ns)
 	ldlm_namespace_debugfs_unregister(ns);
 	ldlm_namespace_sysfs_unregister(ns);
 	cfs_hash_putref(ns->ns_rs_hash);
+	kfree(ns->ns_name);
 	/* Namespace \a ns should be not on list at this time, otherwise
 	 * this will cause issues related to using freed \a ns in poold
 	 * thread.
