Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B08C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4095621848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217781;
	bh=ANcQIX8HsQFA+PuTZ+SQprEVjQqjQAQDYlmN5BHxWV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M35Vs/34lPCez5AZIclv8+4N6WYcAPvyBidL+GgJ7Zlgp1Nmy0YlMNu2bGSptV8Nc
	 7UHoCipUb8J82lmTFHV/wWlCtxYZ2aYBtSxYj5sq2BJqMCHmoEvLhfttcj3M6py7Yg
	 aXwI5t/52gg84VLV9rRwBqGd+6sZBtIx1klNafmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbfAKOnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404270AbfAKOm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EDEB20872;
        Fri, 11 Jan 2019 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217776;
        bh=ANcQIX8HsQFA+PuTZ+SQprEVjQqjQAQDYlmN5BHxWV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQdN6oXadhn5/hBwgNNdpnepDu7lSIr0TJ/6ABK0GwEIvbt4lyCfiOI9S2FPT33I6
         iMWW6q0/ELfd31lDxDZ3/2o+L0asnlmu7rcFqekkOXhUjalMng4q5zXT5GJY+rY/9j
         rn1onB46cckNd8/wYR9sALXTAlGJCPMqnjog9tzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 08/65] mm, devm_memremap_pages: fix shutdown handling
Date:   Fri, 11 Jan 2019 15:14:54 +0100
Message-Id: <20190111131057.397661129@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit a95c90f1e2c253b280385ecf3d4ebfe476926b28 upstream.

The last step before devm_memremap_pages() returns success is to allocate
a release action, devm_memremap_pages_release(), to tear the entire setup
down.  However, the result from devm_add_action() is not checked.

Checking the error from devm_add_action() is not enough.  The api
currently relies on the fact that the percpu_ref it is using is killed by
the time the devm_memremap_pages_release() is run.  Rather than continue
this awkward situation, offload the responsibility of killing the
percpu_ref to devm_memremap_pages_release() directly.  This allows
devm_memremap_pages() to do the right thing relative to init failures and
shutdown.

Without this change we could fail to register the teardown of
devm_memremap_pages().  The likelihood of hitting this failure is tiny as
small memory allocations almost always succeed.  However, the impact of
the failure is large given any future reconfiguration, or disable/enable,
of an nvdimm namespace will fail forever as subsequent calls to
devm_memremap_pages() will fail to setup the pgmap_radix since there will
be stale entries for the physical address range.

An argument could be made to require that the ->kill() operation be set in
the @pgmap arg rather than passed in separately.  However, it helps code
readability, tracking the lifetime of a given instance, to be able to grep
the kill routine directly at the devm_memremap_pages() call site.

Link: http://lkml.kernel.org/r/154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...")
Reviewed-by: "Jérôme Glisse" <jglisse@redhat.com>
Reported-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dax/pmem.c                |   14 +++-----------
 drivers/nvdimm/pmem.c             |   13 +++++--------
 include/linux/memremap.h          |    2 ++
 kernel/memremap.c                 |   30 ++++++++++++++----------------
 tools/testing/nvdimm/test/iomap.c |   15 ++++++++++++++-
 5 files changed, 38 insertions(+), 36 deletions(-)

--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -48,9 +48,8 @@ static void dax_pmem_percpu_exit(void *d
 	percpu_ref_exit(ref);
 }
 
-static void dax_pmem_percpu_kill(void *data)
+static void dax_pmem_percpu_kill(struct percpu_ref *ref)
 {
-	struct percpu_ref *ref = data;
 	struct dax_pmem *dax_pmem = to_dax_pmem(ref);
 
 	dev_dbg(dax_pmem->dev, "trace\n");
@@ -112,17 +111,10 @@ static int dax_pmem_probe(struct device
 	}
 
 	dax_pmem->pgmap.ref = &dax_pmem->ref;
+	dax_pmem->pgmap.kill = dax_pmem_percpu_kill;
 	addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
-	if (IS_ERR(addr)) {
-		devm_remove_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
-		percpu_ref_exit(&dax_pmem->ref);
+	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-	}
-
-	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_kill,
-							&dax_pmem->ref);
-	if (rc)
-		return rc;
 
 	/* adjust the dax_region resource to the start of data */
 	memcpy(&res, &dax_pmem->pgmap.res, sizeof(res));
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -309,8 +309,11 @@ static void pmem_release_queue(void *q)
 	blk_cleanup_queue(q);
 }
 
-static void pmem_freeze_queue(void *q)
+static void pmem_freeze_queue(struct percpu_ref *ref)
 {
+	struct request_queue *q;
+
+	q = container_of(ref, typeof(*q), q_usage_counter);
 	blk_freeze_queue_start(q);
 }
 
@@ -402,6 +405,7 @@ static int pmem_attach_disk(struct devic
 
 	pmem->pfn_flags = PFN_DEV;
 	pmem->pgmap.ref = &q->q_usage_counter;
+	pmem->pgmap.kill = pmem_freeze_queue;
 	if (is_nd_pfn(dev)) {
 		if (setup_pagemap_fsdax(dev, &pmem->pgmap))
 			return -ENOMEM;
@@ -427,13 +431,6 @@ static int pmem_attach_disk(struct devic
 		memcpy(&bb_res, &nsio->res, sizeof(bb_res));
 	}
 
-	/*
-	 * At release time the queue must be frozen before
-	 * devm_memremap_pages is unwound
-	 */
-	if (devm_add_action_or_reset(dev, pmem_freeze_queue, q))
-		return -ENOMEM;
-
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 	pmem->virt_addr = addr;
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -111,6 +111,7 @@ typedef void (*dev_page_free_t)(struct p
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @res: physical address range covered by @ref
  * @ref: reference count that pins the devm_memremap_pages() mapping
+ * @kill: callback to transition @ref to the dead state
  * @dev: host device of the mapping for debug
  * @data: private data pointer for page_free()
  * @type: memory type: see MEMORY_* in memory_hotplug.h
@@ -122,6 +123,7 @@ struct dev_pagemap {
 	bool altmap_valid;
 	struct resource res;
 	struct percpu_ref *ref;
+	void (*kill)(struct percpu_ref *ref);
 	struct device *dev;
 	void *data;
 	enum memory_type type;
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -88,14 +88,10 @@ static void devm_memremap_pages_release(
 	resource_size_t align_start, align_size;
 	unsigned long pfn;
 
+	pgmap->kill(pgmap->ref);
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
 
-	if (percpu_ref_tryget_live(pgmap->ref)) {
-		dev_WARN(dev, "%s: page mapping is still live!\n", __func__);
-		percpu_ref_put(pgmap->ref);
-	}
-
 	/* pages are dead and unused, undo the arch mapping */
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
@@ -116,7 +112,7 @@ static void devm_memremap_pages_release(
 /**
  * devm_memremap_pages - remap and provide memmap backing for the given resource
  * @dev: hosting device for @res
- * @pgmap: pointer to a struct dev_pgmap
+ * @pgmap: pointer to a struct dev_pagemap
  *
  * Notes:
  * 1/ At a minimum the res, ref and type members of @pgmap must be initialized
@@ -125,11 +121,8 @@ static void devm_memremap_pages_release(
  * 2/ The altmap field may optionally be initialized, in which case altmap_valid
  *    must be set to true
  *
- * 3/ pgmap.ref must be 'live' on entry and 'dead' before devm_memunmap_pages()
- *    time (or devm release event). The expected order of events is that ref has
- *    been through percpu_ref_kill() before devm_memremap_pages_release(). The
- *    wait for the completion of all references being dropped and
- *    percpu_ref_exit() must occur after devm_memremap_pages_release().
+ * 3/ pgmap->ref must be 'live' on entry and will be killed at
+ *    devm_memremap_pages_release() time, or if this routine fails.
  *
  * 4/ res is expected to be a host memory range that could feasibly be
  *    treated as a "System RAM" range, i.e. not a device mmio range, but
@@ -145,6 +138,9 @@ void *devm_memremap_pages(struct device
 	pgprot_t pgprot = PAGE_KERNEL;
 	int error, nid, is_ram;
 
+	if (!pgmap->ref || !pgmap->kill)
+		return ERR_PTR(-EINVAL);
+
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
 		- align_start;
@@ -170,12 +166,10 @@ void *devm_memremap_pages(struct device
 	if (is_ram != REGION_DISJOINT) {
 		WARN_ONCE(1, "%s attempted on %s region %pr\n", __func__,
 				is_ram == REGION_MIXED ? "mixed" : "ram", res);
-		return ERR_PTR(-ENXIO);
+		error = -ENXIO;
+		goto err_array;
 	}
 
-	if (!pgmap->ref)
-		return ERR_PTR(-EINVAL);
-
 	pgmap->dev = dev;
 
 	error = xa_err(xa_store_range(&pgmap_array, PHYS_PFN(res->start),
@@ -217,7 +211,10 @@ void *devm_memremap_pages(struct device
 				align_size >> PAGE_SHIFT, pgmap);
 	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap) - pfn_first(pgmap));
 
-	devm_add_action(dev, devm_memremap_pages_release, pgmap);
+	error = devm_add_action_or_reset(dev, devm_memremap_pages_release,
+			pgmap);
+	if (error)
+		return ERR_PTR(error);
 
 	return __va(res->start);
 
@@ -228,6 +225,7 @@ void *devm_memremap_pages(struct device
  err_pfn_remap:
 	pgmap_array_delete(res);
  err_array:
+	pgmap->kill(pgmap->ref);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -104,13 +104,26 @@ void *__wrap_devm_memremap(struct device
 }
 EXPORT_SYMBOL(__wrap_devm_memremap);
 
+static void nfit_test_kill(void *_pgmap)
+{
+	struct dev_pagemap *pgmap = _pgmap;
+
+	pgmap->kill(pgmap->ref);
+}
+
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 {
 	resource_size_t offset = pgmap->res.start;
 	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
 
-	if (nfit_res)
+	if (nfit_res) {
+		int rc;
+
+		rc = devm_add_action_or_reset(dev, nfit_test_kill, pgmap);
+		if (rc)
+			return ERR_PTR(rc);
 		return nfit_res->buf + offset - nfit_res->res.start;
+	}
 	return devm_memremap_pages(dev, pgmap);
 }
 EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);


