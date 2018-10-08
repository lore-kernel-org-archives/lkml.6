Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145BCC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C988F21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyMzOWLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C988F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeJICGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbeJICGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B38D204FD;
        Mon,  8 Oct 2018 18:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024793;
        bh=2PRRWKqD93nto6N2HRIpBvTazSvuUJsboEHXb3NKU7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HyMzOWLQfDxxSRDhnMz36i5tIp1hHo35xsWlcDTzVH9Zs1TaRjvW4/FraK3OvlJjR
         J3kNorYCmYrRb5pNPHkkpzmyl9fcATaUs+APBd9RrR/z7u5rfRlIugkZ23nHD6X6Fx
         /p6c6vnMJ+M275hOZhH/QMOYzpteQlaCtEAO3X+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.18 156/168] iommu/amd: Clear memory encryption mask from physical address
Date:   Mon,  8 Oct 2018 20:32:16 +0200
Message-Id: <20181008175625.978463772@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Singh, Brijesh <brijesh.singh@amd.com>

commit b3e9b515b08e407ab3a026dc2e4d935c48d05f69 upstream.

Boris Ostrovsky reported a memory leak with device passthrough when SME
is active.

The VFIO driver uses iommu_iova_to_phys() to get the physical address for
an iova. This physical address is later passed into vfio_unmap_unpin() to
unpin the memory. The vfio_unmap_unpin() uses pfn_valid() before unpinning
the memory. The pfn_valid() check was failing because encryption mask was
part of the physical address returned. This resulted in the memory not
being unpinned and therefore leaked after the guest terminates.

The memory encryption mask must be cleared from the physical address in
iommu_iova_to_phys().

Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with memory encryption")
Reported-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: <iommu@lists.linux-foundation.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/amd_iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3073,7 +3073,7 @@ static phys_addr_t amd_iommu_iova_to_phy
 		return 0;
 
 	offset_mask = pte_pgsize - 1;
-	__pte	    = *pte & PM_ADDR_MASK;
+	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
 
 	return (__pte & ~offset_mask) | (iova & offset_mask);
 }


