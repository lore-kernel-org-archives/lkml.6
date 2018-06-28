Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E85C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB092522D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB092522D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeF1I6u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:58:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933153AbeF1I6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:58:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2D62C12A0;
        Thu, 28 Jun 2018 08:58:43 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1C482026D6A;
        Thu, 28 Jun 2018 08:58:37 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: [PATCH 4/5 V4] Adjust some permanent mappings in unencrypted ways for kdump when SME is enabled.
Date:   Thu, 28 Jun 2018 16:58:05 +0800
Message-Id: <20180628085806.9280-5-lijiang@redhat.com>
In-Reply-To: <20180628085806.9280-1-lijiang@redhat.com>
References: <20180628085806.9280-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 08:58:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 08:58:43 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kdump, the acpi table and dmi table will need to be remapped in
unencrypted ways during early init, they have just a simple wrapper
around early_memremap(), but the early_memremap() remaps the memory
in encrypted ways by default when SME is enabled, so we put some logic
into the early_memremap_pgprot_adjust(), which will have an opportunity
to adjust it.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/mm/ioremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index e01e6c6..3c1c8c4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -689,8 +689,17 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 	encrypted_prot = true;
 
 	if (sme_active()) {
+		/*
+		 * In kdump mode, the acpi table and dmi table will need to
+		 * be remapped in unencrypted ways during early init when
+		 * SME is enabled. They have just a simple wrapper around
+		 * early_memremap(), but the early_memremap() remaps the
+		 * memory in encrypted ways by default when SME is enabled,
+		 * so we must adjust it.
+		 */
 		if (early_memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		    memremap_is_efi_data(phys_addr, size) ||
+		    is_kdump_kernel())
 			encrypted_prot = false;
 	}
 
-- 
2.9.5

