Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C7EC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ABA224E3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ztghxqOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ABA224E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390801AbeKLIWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390740AbeKLIWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:36 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02F122443;
        Sun, 11 Nov 2018 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975558;
        bh=J6n5/AJjTX3FW39fn/fdNcuZ498ivOZKzgtqdukDYZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztghxqOAINDqLip0u+mZcO2mkIx1YgI0EHM8OCE1ARNCqSSG/ZKd+Jpk/dP8F6iWq
         iu5N33HqeVqDIB9zzR4yw2EQ1ZSyJQ9HYAdAB3lEXNgUME8kkUd8hEU/TeSxEDTiQ/
         bPXQitwqw/tonQpyLZ2yWrn5aoQTa5ashTmL9mi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christoph Helwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>
Subject: [PATCH 4.14 116/222] xen-swiotlb: use actually allocated size on check physical continuous
Date:   Sun, 11 Nov 2018 14:23:33 -0800
Message-Id: <20181111221658.135131620@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Jin <joe.jin@oracle.com>

commit 7250f422da0480d8512b756640f131b9b893ccda upstream.

xen_swiotlb_{alloc,free}_coherent() allocate/free memory based on the
order of the pages and not size argument (bytes). This is inconsistent with
range_straddles_page_boundary and memset which use the 'size' value,
which may lead to not exchanging memory with Xen (range_straddles_page_boundary()
returned true). And then the call to xen_swiotlb_free_coherent() would
actually try to exchange the memory with Xen, leading to the kernel
hitting an BUG (as the hypercall returned an error).

This patch fixes it by making the 'size' variable be of the same size
as the amount of memory allocated.

CC: stable@vger.kernel.org
Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Christoph Helwig <hch@lst.de>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: John Sobecki <john.sobecki@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/swiotlb-xen.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -317,6 +317,9 @@ xen_swiotlb_alloc_coherent(struct device
 	*/
 	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
+	/* Convert the size to actually allocated. */
+	size = 1UL << (order + XEN_PAGE_SHIFT);
+
 	/* On ARM this function returns an ioremap'ped virtual address for
 	 * which virt_to_phys doesn't return the corresponding physical
 	 * address. In fact on ARM virt_to_phys only works for kernel direct
@@ -365,6 +368,9 @@ xen_swiotlb_free_coherent(struct device
 	 * physical address */
 	phys = xen_bus_to_phys(dev_addr);
 
+	/* Convert the size to actually allocated. */
+	size = 1UL << (order + XEN_PAGE_SHIFT);
+
 	if (((dev_addr + size - 1 <= dma_mask)) ||
 	    range_straddles_page_boundary(phys, size))
 		xen_destroy_contiguous_region(phys, order);


