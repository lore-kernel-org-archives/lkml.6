Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26739C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA06321104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA06321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeK1In3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:43:29 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35400 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbeK1In2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:43:28 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gRl99-0000NN-Jc; Tue, 27 Nov 2018 14:43:56 -0700
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     stable@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6875ca04-a36a-89ae-825b-f629ab011d47@deltatee.com>
Date:   Tue, 27 Nov 2018 14:43:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, bhelgaas@google.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, hch@lst.de, jglisse@redhat.com, stable@vger.kernel.org, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v8 3/7] mm, devm_memremap_pages: Fix shutdown handling
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dan,

On 2018-11-20 4:13 p.m., Dan Williams wrote:
> The last step before devm_memremap_pages() returns success is to
> allocate a release action, devm_memremap_pages_release(), to tear the
> entire setup down. However, the result from devm_add_action() is not
> checked.
> 
> Checking the error from devm_add_action() is not enough. The api
> currently relies on the fact that the percpu_ref it is using is killed
> by the time the devm_memremap_pages_release() is run. Rather than
> continue this awkward situation, offload the responsibility of killing
> the percpu_ref to devm_memremap_pages_release() directly. This allows
> devm_memremap_pages() to do the right thing  relative to init failures
> and shutdown.
> 
> Without this change we could fail to register the teardown of
> devm_memremap_pages(). The likelihood of hitting this failure is tiny as
> small memory allocations almost always succeed. However, the impact of
> the failure is large given any future reconfiguration, or
> disable/enable, of an nvdimm namespace will fail forever as subsequent
> calls to devm_memremap_pages() will fail to setup the pgmap_radix since
> there will be stale entries for the physical address range.
> 
> An argument could be made to require that the ->kill() operation be set
> in the @pgmap arg rather than passed in separately. However, it helps
> code readability, tracking the lifetime of a given instance, to be able
> to grep the kill routine directly at the devm_memremap_pages() call
> site.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...")
> Reviewed-by: "Jérôme Glisse" <jglisse@redhat.com>
> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I recently realized this patch, which was recently added to the mm tree,
will break p2pdma. This is largely because the patch was written and
reviewed before p2pdma was merged (in 4.20). Originally, I think we both
expected this patch would be merged before p2pdma but that's not what
happened.

Also, while testing this, I found the teardown is still not quite
correct. In p2pdma, the struct pages will be removed before all of the
percpu references have released and if the device is unbound while pages
are in use, there will be a kernel panic. This is because we wait on the
completion that indicates all references have been free'd after
devm_memremap_pages_release() is called and the pages are removed. This
is fairly easily fixed by waiting for the completion in the kill
function and moving the call after the last put_page(). I suspect device
DAX also has this problem but I'm not entirely certain if something else
might be preventing us from hitting this bug.

Ideally, as part of this patch we need to update the p2pdma call site
for devm_memremap_pages() and fix the completion issue. The diff for all
this is below, but if you'd like I can send a proper patch.

Thanks,

Logan

--


diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index ae3c5b25dcc7..1df7bdb45eab 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -82,9 +82,10 @@ static void pci_p2pdma_percpu_release(struct
percpu_ref *ref)
        complete_all(&p2p->devmap_ref_done);
 }

-static void pci_p2pdma_percpu_kill(void *data)
+static void pci_p2pdma_percpu_kill(struct percpu_ref *ref)
 {
-       struct percpu_ref *ref = data;
+       struct pci_p2pdma *p2p =
+               container_of(ref, struct pci_p2pdma, devmap_ref);

        /*
         * pci_p2pdma_add_resource() may be called multiple times
@@ -96,6 +97,7 @@ static void pci_p2pdma_percpu_kill(void *data)
                return;

        percpu_ref_kill(ref);
+       wait_for_completion(&p2p->devmap_ref_done);
 }

 static void pci_p2pdma_release(void *data)
@@ -105,7 +107,6 @@ static void pci_p2pdma_release(void *data)
        if (!pdev->p2pdma)
                return;

-       wait_for_completion(&pdev->p2pdma->devmap_ref_done);
        percpu_ref_exit(&pdev->p2pdma->devmap_ref);

        gen_pool_destroy(pdev->p2pdma->pool);
@@ -198,6 +199,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev,
int bar, size_t size,
        pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
        pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
                pci_resource_start(pdev, bar);
+       pgmap->kill = pci_p2pdma_percpu_kill;

        addr = devm_memremap_pages(&pdev->dev, pgmap);
        if (IS_ERR(addr)) {
@@ -211,11 +213,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev,
int bar, size_t size,
        if (error)
                goto pgmap_free;

-       error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_percpu_kill,
-                                         &pdev->p2pdma->devmap_ref);
-       if (error)
-               goto pgmap_free;
-
        pci_info(pdev, "added peer-to-peer DMA memory %pR\n",
                 &pgmap->res);

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 5e45f0c327a5..dd9a953e796a 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -88,9 +88,9 @@ static void devm_memremap_pages_release(void *data)
        resource_size_t align_start, align_size;
        unsigned long pfn;

-       pgmap->kill(pgmap->ref);
        for_each_device_pfn(pfn, pgmap)
                put_page(pfn_to_page(pfn));
+       pgmap->kill(pgmap->ref);

        /* pages are dead and unused, undo the arch mapping */
        align_start = res->start & ~(SECTION_SIZE - 1);







