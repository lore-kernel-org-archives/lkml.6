Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68870ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115D5208E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EIZr/01/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115D5208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeGMFJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:09:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46856 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeGMFJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:09:23 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so10630174qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 21:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GZ7pbph9RA5T64mYEULW8PTxgiFXpzZJDFXv+4YEJTs=;
        b=EIZr/01/kxIkfl+OywpLODL4nibHyCtSMf6F2V0J716AEXd5GVSdwyfscdZVDEQLs6
         CDqEia1MxlM43hunCTy4iOSwOi1qnVpyLMDhPZI3djYAUbwHrH7/CZl+E86wtUzoZ5yw
         kMnfy1gfOUrCXCMkxSciqp+ah+whMSaHLcoQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GZ7pbph9RA5T64mYEULW8PTxgiFXpzZJDFXv+4YEJTs=;
        b=Dp2uk4BzsfJhgMbbdqgPTbFSAzyzEtfARZsZmtW0yNHi+aeJMiECK2ledlnrqrmH69
         oJDlCC4GAltBFOVMuwt43OVE0C+6CZMQsm1QPA63s4ilBrewrbavtMV74ZrHSZRrpgRA
         U+H2uUaZ7CnMEVzyDD2ABVrILBaY5Yl2wQBPIOIoL6Hocg/NY+vqLbJGpSJKQrININ5J
         GkZ5tRnTR+tUCUrpFdWcbUIHyeFpiNGYiJ6691p65vhStyObh/9RUktdh3IdI8RnPrIX
         j8m/+Xl6ORoUVBsCbuzfLHiGWdm6EiSnsPtUn7WEAHTF3yqSzCLU2+gWkzXWuDYYSKfZ
         tp6w==
X-Gm-Message-State: AOUpUlG3SX0NJfG6R+15JY0uJRb9WdTgyR3JuUpOafRpUpsYeO9j+t3A
        4OVOkGbkSjoxLO+oyZIHFZIwDg==
X-Google-Smtp-Source: AAOMgpfEk9rhWEtf9VriMs9bP5Jp4V6LdvwkmWS4mu6jWj9cZ4MH5X70IDxd94/SdmL5ukvkNiZ7Og==
X-Received: by 2002:aed:2a33:: with SMTP id c48-v6mr4484932qtd.147.1531457791261;
        Thu, 12 Jul 2018 21:56:31 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w43-v6sm15830537qth.58.2018.07.12.21.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 21:56:30 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     ray.jui@broadcom.com, vikram.prakash@broadcom.com,
        scott.branden@broadcom.com, kvm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH] vfio/pci: map prefetchble bars as writecombine
Date:   Fri, 13 Jul 2018 10:26:17 +0530
Message-Id: <1531457777-11825-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default all BARs map with VMA access permissions
as pgprot_noncached.

In ARM64 pgprot_noncached is MT_DEVICE_nGnRnE which
is strongly ordered and allows aligned access.
This type of mapping works for NON-PREFETCHABLE bars
containing EP controller registers.
But it restricts PREFETCHABLE bars from doing
unaligned access.

In CMB NVMe drives PREFETCHABLE bars are required to
map as MT_NORMAL_NC to do unaligned access.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/vfio/pci/vfio_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a30..eff6b65 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1142,7 +1142,10 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	}
 
 	vma->vm_private_data = vdev;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	if (pci_resource_flags(pdev, index) & IORESOURCE_PREFETCH)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
 
 	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-- 
2.7.4

