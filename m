Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx48onHjoGMq1j+C9d7beqB7GayVGU98gUOL/ZWQ/wpBPBY+iyCIsXp2xvHkFBQY2lOUkzSj4
ARC-Seal: i=1; a=rsa-sha256; t=1523483768; cv=none;
        d=google.com; s=arc-20160816;
        b=wxPYxP8FiWcKS5RFhr2oFKiHjuNe7u/GtE0RR5BBH1XILiNuAbOIicMnxPKP92sWG9
         BSVUKPTWXI+7MHJukJTc5QXK6+tfNHcmYsXyp+kErDXkJI+9JR1/PYGtXrXOFhkB3UuB
         y4qEUzB+s5HUxeS0B4oOCHq6ZmTOS16E376n+yMO+zd/wpLOhEyHyAFWy1Im2NT0ZqMD
         /MfCfc+dl4YDkF8xYhEsA1wUzG3n0r9cxHptR2Q8ADvlO9W2SgkN+xBfxbErCOO1BJth
         CUIT/cKU5DkiJ22GY9A9+j0uJSWBCzI/9VkskG0woxRgfQF9V54PXrKJaZoDgTJdt61A
         A5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=6d9qGSk7/25kRq3H7bRkQED9XJWvUMFCJOZBO9okigM=;
        b=HkjwV/DToaYMBmmFPe9p1M54aTABspO1V+7p12/TkUqpYU60ErZrVco1VzYGI1W4ns
         xnLR2Qj9AOVNfXKWFbHgq1GGvs+U8k04650AKOOBwuGlZGw0VVhrIJOUtVhTkKe2zgf0
         ssygxgaoHfrVg0RlCRRXdfdgyIt4eVZWNdcucsetrbhfU6Mlzk98ND5g3a1JR0WAiRtu
         GRIvQWI0FACFW3wUqV79tpY41vj26Ao5pzmdNom8UjqBqdl3rBuEKeJGu/K12eU1AW0V
         i+u+anJzPIGT5u0r17QN2JUAkXzizOynQdBWeHxtrgDC0oYON8iyZOI+yHJOJmrrO7F1
         CuxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 12 Apr 2018 07:54:48 +1000
Subject: [PATCH 07/20] staging: lustre: ldlm: store name directly in
 namespace.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152348368875.12394.18428069846372860341.stgit@noble>
In-Reply-To: <152348312863.12394.11915752362061083241.stgit@noble>
References: <152348312863.12394.11915752362061083241.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488515669735132?=
X-GMAIL-MSGID: =?utf-8?q?1597488515669735132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rather than storing the name of a namespace in the
hash table, store it directly in the namespace.
This will allow the hashtable to be changed to use
rhashtable.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    5 ++++-
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |    5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
index ab90abe1c2d8..500dda854564 100644
--- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
+++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
@@ -364,6 +364,9 @@ struct ldlm_namespace {
 	/** Flag indicating if namespace is on client instead of server */
 	enum ldlm_side		ns_client;
 
+	/** name of this namespace */
+	char			*ns_name;
+
 	/** Resource hash table for namespace. */
 	struct cfs_hash		*ns_rs_hash;
 	struct ldlm_ns_bucket	*ns_rs_buckets;
@@ -882,7 +885,7 @@ static inline bool ldlm_has_layout(struct ldlm_lock *lock)
 static inline char *
 ldlm_ns_name(struct ldlm_namespace *ns)
 {
-	return ns->ns_rs_hash->hs_name;
+	return ns->ns_name;
 }
 
 static inline struct ldlm_namespace *
diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
index 669556420bdf..a14cc12303ab 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
@@ -673,6 +673,9 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 	ns->ns_obd      = obd;
 	ns->ns_appetite = apt;
 	ns->ns_client   = client;
+	ns->ns_name     = kstrdup(name, GFP_KERNEL);
+	if (!ns->ns_name)
+		goto out_hash;
 
 	INIT_LIST_HEAD(&ns->ns_list_chain);
 	INIT_LIST_HEAD(&ns->ns_unused_list);
@@ -715,6 +718,7 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 	ldlm_namespace_sysfs_unregister(ns);
 	ldlm_namespace_cleanup(ns, 0);
 out_hash:
+	kfree(ns->ns_name);
 	kvfree(ns->ns_rs_buckets);
 	cfs_hash_putref(ns->ns_rs_hash);
 out_ns:
@@ -980,6 +984,7 @@ void ldlm_namespace_free_post(struct ldlm_namespace *ns)
 	ldlm_namespace_sysfs_unregister(ns);
 	cfs_hash_putref(ns->ns_rs_hash);
 	kvfree(ns->ns_rs_buckets);
+	kfree(ns->ns_name);
 	/* Namespace \a ns should be not on list at this time, otherwise
 	 * this will cause issues related to using freed \a ns in poold
 	 * thread.
