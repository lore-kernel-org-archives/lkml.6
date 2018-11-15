Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02EEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBF92245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBF92245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbeKOUCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:02:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbeKOUCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:02:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FC2980F83;
        Thu, 15 Nov 2018 09:55:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-127.pek2.redhat.com [10.72.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4E9119C65;
        Thu, 15 Nov 2018 09:55:41 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org,
        dyoung@redhat.com, bhe@redhat.com
Subject: [PATCH 1/2 v7] resource: add the new I/O resource descriptor 'IORES_DESC_RESERVED'
Date:   Thu, 15 Nov 2018 17:55:28 +0800
Message-Id: <20181115095529.21220-2-lijiang@redhat.com>
In-Reply-To: <20181115095529.21220-1-lijiang@redhat.com>
References: <20181115095529.21220-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 15 Nov 2018 09:55:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upstream kernel can not accurately add the e820 reserved type to
kdump krenel e820 table.

Kdump uses walk_iomem_res_desc() to iterate io resources, then adds
the matched resource ranges to the e820 table for kdump kernel. But,
when convert the e820 type into the iores descriptor, several e820
types are converted to 'IORES_DESC_NONE' in this function e820_type
_to_iores_desc(). So the walk_iomem_res_desc() will get unnecessary
types(such as E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_KERN) when
walk through io resources by the descriptor 'IORES_DESC_NONE'.

This patch adds the new I/O resource descriptor 'IORES_DESC_RESERVED'
for the iomem resources search interfaces. It is helpful to exactly
match the reserved resource ranges when walking through iomem resources.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
Changes since v5:
1. Improve the patch log

Changes since v6:
1. Modify this patch, and add the new I/O resource descriptor
   'IORES_DESC_RESERVED' for the iomem resources search interfaces.
2. Improve patch log.

 arch/x86/kernel/e820.c | 2 +-
 include/linux/ioport.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 50895c2f937d..57fafdafb860 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1048,10 +1048,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
 	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
+	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
 	case E820_TYPE_UNUSABLE:	/* Fall-through: */
-	case E820_TYPE_RESERVED:	/* Fall-through: */
 	default:			return IORES_DESC_NONE;
 	}
 }
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..6ed59de48bd5 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -133,6 +133,7 @@ enum {
 	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
+	IORES_DESC_RESERVED			= 8,
 };
 
 /* helpers to define resources */
-- 
2.17.1

