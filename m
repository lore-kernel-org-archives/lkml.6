Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeFEJ04 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:26:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45240 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeFEJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:26:54 -0400
X-Google-Smtp-Source: ADUXVKJ4GVD3oPDhitYG5Y9TtH8KFxTtsFqyAj3Uccig6zqeovsuxJSdpQZV/rcu7NsGO0vjLPB3Qg==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: torvalds@linux-foundation.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>, axboe@kernel.dk,
        snitzer@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dm: Use kzalloc for all structs with embedded biosets/mempools
Date: Tue,  5 Jun 2018 05:26:33 -0400
Message-Id: <20180605092633.29583-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempool_init()/bioset_init() require that the mempools/biosets be zeroed
first; they probably should not _require_ this, but not allocating those
structs with kzalloc is a fairly nonsensical thing to do (calling
mempool_exit()/bioset_exit() on an uninitialized mempool/bioset is legal
and safe, but only works if said memory was zeroed.)

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---

Linus,

I fucked up majorly on the bioset/mempool conversion - I forgot to check that
everything biosets/mempools were being embedded in was actually being zeroed on
allocation. Device mapper currently explodes, you'll probably want to apply this
patch post haste.

I have now done that auditing, for every single conversion - this patch fixes
everything I found. There do not seem to be any incorrect ones outside of device
mapper...

We'll probably want a second patch that either a) changes
bioset_init()/mempool_init() to zero the passed in bioset/mempool first, or b)
my preference, WARN() or BUG() if they're passed memory that isn't zeroed.

 drivers/md/dm-bio-prison-v1.c | 2 +-
 drivers/md/dm-bio-prison-v2.c | 2 +-
 drivers/md/dm-io.c            | 2 +-
 drivers/md/dm-kcopyd.c        | 2 +-
 drivers/md/dm-region-hash.c   | 2 +-
 drivers/md/dm-snap.c          | 2 +-
 drivers/md/dm-thin.c          | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-bio-prison-v1.c b/drivers/md/dm-bio-prison-v1.c
index 8e33a38083..e794e3662f 100644
--- a/drivers/md/dm-bio-prison-v1.c
+++ b/drivers/md/dm-bio-prison-v1.c
@@ -33,7 +33,7 @@ static struct kmem_cache *_cell_cache;
  */
 struct dm_bio_prison *dm_bio_prison_create(void)
 {
-	struct dm_bio_prison *prison = kmalloc(sizeof(*prison), GFP_KERNEL);
+	struct dm_bio_prison *prison = kzalloc(sizeof(*prison), GFP_KERNEL);
 	int ret;
 
 	if (!prison)
diff --git a/drivers/md/dm-bio-prison-v2.c b/drivers/md/dm-bio-prison-v2.c
index 601b156920..f866bc97b0 100644
--- a/drivers/md/dm-bio-prison-v2.c
+++ b/drivers/md/dm-bio-prison-v2.c
@@ -35,7 +35,7 @@ static struct kmem_cache *_cell_cache;
  */
 struct dm_bio_prison_v2 *dm_bio_prison_create_v2(struct workqueue_struct *wq)
 {
-	struct dm_bio_prison_v2 *prison = kmalloc(sizeof(*prison), GFP_KERNEL);
+	struct dm_bio_prison_v2 *prison = kzalloc(sizeof(*prison), GFP_KERNEL);
 	int ret;
 
 	if (!prison)
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 53c6ed0eaa..81ffc59d05 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -51,7 +51,7 @@ struct dm_io_client *dm_io_client_create(void)
 	unsigned min_ios = dm_get_reserved_bio_based_ios();
 	int ret;
 
-	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index c89a675a2a..ce7efc7434 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -882,7 +882,7 @@ struct dm_kcopyd_client *dm_kcopyd_client_create(struct dm_kcopyd_throttle *thro
 	int r;
 	struct dm_kcopyd_client *kc;
 
-	kc = kmalloc(sizeof(*kc), GFP_KERNEL);
+	kc = kzalloc(sizeof(*kc), GFP_KERNEL);
 	if (!kc)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
index 43149eb493..abf3521b80 100644
--- a/drivers/md/dm-region-hash.c
+++ b/drivers/md/dm-region-hash.c
@@ -180,7 +180,7 @@ struct dm_region_hash *dm_region_hash_create(
 		;
 	nr_buckets >>= 1;
 
-	rh = kmalloc(sizeof(*rh), GFP_KERNEL);
+	rh = kzalloc(sizeof(*rh), GFP_KERNEL);
 	if (!rh) {
 		DMERR("unable to allocate region hash memory");
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index b11ddc55f2..f745404da7 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1120,7 +1120,7 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		origin_mode = FMODE_WRITE;
 	}
 
-	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
 	if (!s) {
 		ti->error = "Cannot allocate private snapshot structure";
 		r = -ENOMEM;
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 6c923824ec..5772756c63 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2861,7 +2861,7 @@ static struct pool *pool_create(struct mapped_device *pool_md,
 		return (struct pool *)pmd;
 	}
 
-	pool = kmalloc(sizeof(*pool), GFP_KERNEL);
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 	if (!pool) {
 		*error = "Error allocating memory for pool";
 		err_p = ERR_PTR(-ENOMEM);
-- 
2.17.1
