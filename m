Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/qpjWp+A+hC0wsr8IOrhcMUACA741hrw/HwX1riWRzYtHEet6m5xxU/n7nD0kGGV/ufO5h
ARC-Seal: i=1; a=rsa-sha256; t=1523483760; cv=none;
        d=google.com; s=arc-20160816;
        b=VkL30guAJ3Ls2QbXryBKGtdsegRVlPJGL5BDxbp7rftB62MRwHiHmrU+Y8Fa96HQOu
         a35TtS9GKwV7XDH6h0yKEB6kOwwGkSSgQ+dDbo0zVabocvInir2qFM6N2gEJU1sLKNph
         bSGUYLZOeqRG8hTf1tNmiYDLUoXbU8Kcb94szzLlrzRUE6VM37P7ZDifpOpHMQbsLCRx
         vTJPusCK+OdT7JvKhxysWmbcJcOcBztg/CLZLOMcir0U15bEOCd8byOIMU7+9AEpJVrS
         hseQqZ31FCbYlDXuhYIfzi6s3MRWwUVblZzo3DjHgBYWOQjLHJPcd/CWzYhdNZTupr5y
         VKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=PAg+NIKRlUGBcqhQ936cYdfqNDNWCMq5Hgqv4/+ARX8=;
        b=J132ftPds7oTPM1XurPtOUlOiV2kjNUxflztFxjz7aKY+5oLodXUKHk0P41xTgZ0vQ
         JLViP/YgemndIlW4BhNUnYBKax6RX9tCCUjBimEWEji5W5ukcUD8CfmwT1ubb6f/qHXH
         fXklRmqYjJWwhvnYsuAua/t8IdpBKSjOPf68ZJ6FfZwmT7DB3po1nouM0bImKwehLflp
         7VlsgMnv3esngnA+OgA1oORl+QKalLhoKvG6KCSCQEQP/3eeJbSjewYccypwWtYAKonY
         f1yHcMNCklc80PKeNYE5fG6FB8XxWJQQKhqXX90deoIiCE1BFV2lcZUvsu/rPkYvPw1F
         JOwQ==
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
Subject: [PATCH 06/20] staging: lustre: ldlm: add a counter to the
 per-namespace data
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152348368872.12394.16831797606945626384.stgit@noble>
In-Reply-To: <152348312863.12394.11915752362061083241.stgit@noble>
References: <152348312863.12394.11915752362061083241.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488507401957606?=
X-GMAIL-MSGID: =?utf-8?q?1597488507401957606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When we change the resource hash to rhashtable we won't have
a per-bucket counter.  We could use the nelems global counter,
but ldlm_resource goes to some trouble to avoid having any
table-wide atomics, and hopefully rhashtable will grow the
ability to disable the global counter in the near future.
Having a counter we control makes it easier to manage the
back-reference to the namespace when there is anything in the
hash table.

So add a counter to the ldlm_ns_bucket.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    2 ++
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
index 395d50160dcc..ab90abe1c2d8 100644
--- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
+++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
@@ -309,6 +309,8 @@ struct ldlm_ns_bucket {
 	 * fact the network or overall system load is at fault
 	 */
 	struct adaptive_timeout     nsb_at_estimate;
+	/* counter of entries in this bucket */
+	atomic_t		nsb_count;
 };
 
 enum {
diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
index 927544f01adc..669556420bdf 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
@@ -181,12 +181,11 @@ static ssize_t resource_count_show(struct kobject *kobj, struct attribute *attr,
 	struct ldlm_namespace *ns = container_of(kobj, struct ldlm_namespace,
 						 ns_kobj);
 	__u64		  res = 0;
-	struct cfs_hash_bd	  bd;
 	int		    i;
 
 	/* result is not strictly consistent */
-	cfs_hash_for_each_bucket(ns->ns_rs_hash, &bd, i)
-		res += cfs_hash_bd_count_get(&bd);
+	for (i = 0; i < (1 << ns->ns_bucket_bits); i++)
+		res += atomic_read(&ns->ns_rs_buckets[i].nsb_count);
 	return sprintf(buf, "%lld\n", res);
 }
 LUSTRE_RO_ATTR(resource_count);
@@ -668,6 +667,7 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 		struct ldlm_ns_bucket *nsb = &ns->ns_rs_buckets[idx];
 		at_init(&nsb->nsb_at_estimate, ldlm_enqueue_min, 0);
 		nsb->nsb_namespace = ns;
+		atomic_set(&nsb->nsb_count, 0);
 	}
 
 	ns->ns_obd      = obd;
@@ -1144,7 +1144,7 @@ ldlm_resource_get(struct ldlm_namespace *ns, struct ldlm_resource *parent,
 	}
 	/* We won! Let's add the resource. */
 	cfs_hash_bd_add_locked(ns->ns_rs_hash, &bd, &res->lr_hash);
-	if (cfs_hash_bd_count_get(&bd) == 1)
+	if (atomic_inc_return(&res->lr_ns_bucket->nsb_count) == 1)
 		ns_refcount = ldlm_namespace_get_return(ns);
 
 	cfs_hash_bd_unlock(ns->ns_rs_hash, &bd, 1);
@@ -1202,7 +1202,7 @@ static void __ldlm_resource_putref_final(struct cfs_hash_bd *bd,
 	cfs_hash_bd_unlock(ns->ns_rs_hash, bd, 1);
 	if (ns->ns_lvbo && ns->ns_lvbo->lvbo_free)
 		ns->ns_lvbo->lvbo_free(res);
-	if (cfs_hash_bd_count_get(bd) == 0)
+	if (atomic_dec_and_test(&nsb->nsb_count))
 		ldlm_namespace_put(ns);
 	kmem_cache_free(ldlm_resource_slab, res);
 }
