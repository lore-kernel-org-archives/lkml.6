Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZoP9tNe/jpjTBygrFKmBnnaJ/QeQYtxAL7g6a+GSUbhcI1HJJgwjP2JQ6Cyzfzh4OSceo3s
ARC-Seal: i=1; a=rsa-sha256; t=1525654528; cv=none;
        d=google.com; s=arc-20160816;
        b=VU3bREcihBoID6cyWSN5vRdowABwgyL29r6l28CoR0AShdql9Fqsc6N9pDC84TOwYC
         XwcdEKKn6yRbYw7ahhWxAd63SPQfUKArAe3Kc/T4puGo3AvazN6COaazfr4Mh6edUw5P
         C/svmTmaP1kijDzStz5CExba0mOaOsurfjoLofTSeObYd2PEhmxD0pffKdNIF06PQrfz
         f3PmZa7FB+/J0djokaKy9WVrvTBefCzmqVQnZpJ8WqaNTrmPgsm8eNSoz5lafpBqhsIR
         baWnL/70fg607hMAA8a6aidN88mjCOY6se8A3dwEriz1rXZnA74ZpVOtFxT+htWK37gK
         zULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=5lHZyDgDOiz70s93LiUkECgz/YFWGbtePvkLGjBWWbU=;
        b=Xf+ZRBiQqCUccvx6COk1KxaATvHKWywfC2hFViQ5BTfC4LljBuz701PHEBw8FZ26HJ
         xYlW2D2DYg4vMwUA+C+X0UdqpECTurbzEoYyMkRWWI6OJhOPE01Gk2hHjo20ygj+Ysu6
         59khzlySsGunz/PZv/XIzwu0x6tsJgB64tmIfkeUIY6v/moU+hgont5ZrUkDsaLft0Wi
         lP3pU4NdujRGYB7tbvrVa53feUdtE9hu5NFQeozb+Ks7fv0zKIZdroLHUPCQ8zMhndR9
         ycNgIXwAGnvqhLOvJtfBF+NPDe/7cB1tx7lUVuot2zLxPTVdOFJ8or/2iTLEv8aaa/AI
         q1cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 07 May 2018 10:54:48 +1000
Subject: [PATCH 01/10] staging: lustre: ldlm: store name directly in
 namespace.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152565448797.30131.661528421769812256.stgit@noble>
In-Reply-To: <152565436690.30131.2229703651041382739.stgit@noble>
References: <152565436690.30131.2229703651041382739.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599764722583930483?=
X-GMAIL-MSGID: =?utf-8?q?1599764722583930483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rather than storing the name of a namespace in the
hash table, store it directly in the namespace.
This will allow the hashtable to be changed to use
rhashtable.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
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
