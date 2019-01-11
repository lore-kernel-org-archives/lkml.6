Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3883C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8276E21848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217777;
	bh=n3Wg0exKWeHjLI9VlCGMIwSyw9bhqGn1K7kkmK9Me+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YxPn5chK8gZHFghEpfth6QqOzhM8lSUKNnzRw5uKRHtSerMf9pbCMoobDuGkTFAPn
	 pWRlx1nsCKGHyi82pmlX7EJTBVzFQElCmOkMQzjWq7YGoSgrLux96BlM2rpZzc8daM
	 de+xloS750/TL/mmBLtHmJWyS6Em0XX3wc1Gb7KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404272AbfAKOm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404247AbfAKOmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 802E32063F;
        Fri, 11 Jan 2019 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217771;
        bh=n3Wg0exKWeHjLI9VlCGMIwSyw9bhqGn1K7kkmK9Me+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLWEPg6OxVHNAnJ8qQ8CVOcjU6/dVncEcpBUXCNEvXaNqYJOTli7B9P9PXvgprfHc
         CP2757K3qx6eGpX5Rk+2LmqQK91AFvOtPmHTwLzzTcQRWpkEc6AK1/t6QesRoO5H/p
         3HUMkYhEfxknPjhkV+/wLzccy3tEv5mgi6R2dCZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 06/65] mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
Date:   Fri, 11 Jan 2019 15:14:52 +0100
Message-Id: <20190111131057.030483512@linuxfoundation.org>
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

commit 808153e1187fa77ac7d7dad261ff476888dcf398 upstream.

devm_memremap_pages() is a facility that can create struct page entries
for any arbitrary range and give drivers the ability to subvert core
aspects of page management.

Specifically the facility is tightly integrated with the kernel's memory
hotplug functionality.  It injects an altmap argument deep into the
architecture specific vmemmap implementation to allow allocating from
specific reserved pages, and it has Linux specific assumptions about page
structure reference counting relative to get_user_pages() and
get_user_pages_fast().  It was an oversight and a mistake that this was
not marked EXPORT_SYMBOL_GPL from the outset.

Again, devm_memremap_pagex() exposes and relies upon core kernel internal
assumptions and will continue to evolve along with 'struct page', memory
hotplug, and support for new memory types / topologies.  Only an in-kernel
GPL-only driver is expected to keep up with this ongoing evolution.  This
interface, and functionality derived from this interface, is not suitable
for kernel-external drivers.

Link: http://lkml.kernel.org/r/154275557457.76910.16923571232582744134.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/memremap.c                 |    2 +-
 tools/testing/nvdimm/test/iomap.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -233,7 +233,7 @@ void *devm_memremap_pages(struct device
  err_array:
 	return ERR_PTR(error);
 }
-EXPORT_SYMBOL(devm_memremap_pages);
+EXPORT_SYMBOL_GPL(devm_memremap_pages);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
 {
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -113,7 +113,7 @@ void *__wrap_devm_memremap_pages(struct
 		return nfit_res->buf + offset - nfit_res->res.start;
 	return devm_memremap_pages(dev, pgmap);
 }
-EXPORT_SYMBOL(__wrap_devm_memremap_pages);
+EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
 pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
 {


