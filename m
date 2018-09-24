Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B12C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D9B206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D9B206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeIXSma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:42:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbeIXSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:42:29 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3714109A;
        Mon, 24 Sep 2018 12:40:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 159/235] KVM: PPC: Book3S: Fix matching of hardware and emulated TCE tables
Date:   Mon, 24 Sep 2018 13:52:25 +0200
Message-Id: <20180924113121.095540331@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit 76346cd93a5eca33700f82685d56172dd65d4c0a ]

When attaching a hardware table to LIOBN in KVM, we match table parameters
such as page size, table offset and table size. However the tables are
created via very different paths - VFIO and KVM - and the VFIO path goes
through the platform code which has minimum TCE page size requirement
(which is 4K but since we allocate memory by pages and cannot avoid
alignment anyway, we align to 64k pages for powernv_defconfig).

So when we match the tables, one might be bigger that the other which
means the hardware table cannot get attached to LIOBN and DMA mapping
fails.

This removes the table size alignment from the guest visible table.
This does not affect the memory allocation which is still aligned -
kvmppc_tce_pages() takes care of this.

This relaxes the check we do when attaching tables to allow the hardware
table be bigger than the guest visible table.

Ideally we want the KVM table to cover the same space as the hardware
table does but since the hardware table may use multiple levels, and
all levels must use the same table size (IODA2 design), the area it can
actually cover might get very different from the window size which
the guest requested, even though the guest won't map it all.

Fixes: ca1fc489cf "KVM: PPC: Book3S: Allow backing bigger guest IOMMU pages with smaller physical pages"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_64_vio.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -180,7 +180,7 @@ extern long kvm_spapr_tce_attach_iommu_g
 		if ((tbltmp->it_page_shift <= stt->page_shift) &&
 				(tbltmp->it_offset << tbltmp->it_page_shift ==
 				 stt->offset << stt->page_shift) &&
-				(tbltmp->it_size << tbltmp->it_page_shift ==
+				(tbltmp->it_size << tbltmp->it_page_shift >=
 				 stt->size << stt->page_shift)) {
 			/*
 			 * Reference the table to avoid races with
@@ -296,7 +296,7 @@ long kvm_vm_ioctl_create_spapr_tce(struc
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
 	struct kvmppc_spapr_tce_table *siter;
-	unsigned long npages, size;
+	unsigned long npages, size = args->size;
 	int ret = -ENOMEM;
 	int i;
 
@@ -304,7 +304,6 @@ long kvm_vm_ioctl_create_spapr_tce(struc
 		(args->offset + args->size > (ULLONG_MAX >> args->page_shift)))
 		return -EINVAL;
 
-	size = _ALIGN_UP(args->size, PAGE_SIZE >> 3);
 	npages = kvmppc_tce_pages(size);
 	ret = kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
 	if (ret)


