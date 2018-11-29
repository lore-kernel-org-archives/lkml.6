Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C00C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3B620863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="anRe2fKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3B620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeK3ETc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40473 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeK3ETK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:19:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so2674623wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zf26VLC73KBeOMRN+TciYckaN/0BTjlAJnyTuYhXxyU=;
        b=anRe2fKfurgWjUShMpRaDkx3BLJlCKBVQ1II1d9aRyRnpxxlaZrmNwEvXXKWN8qFKR
         iEnqvs3yVLKmUanB444pieAbiBOvgRAszRNoulw96X2WVA8ghoeyTnNpUIAw5u+8LwTH
         +ULYQrOvH4vX2YYWHnLcoW3ddR8/2hwnWbmBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zf26VLC73KBeOMRN+TciYckaN/0BTjlAJnyTuYhXxyU=;
        b=Vop0UNB+CvDKk0hWuSFzBUvSGYnbDAfXFCGNlcK4jN9GeM+GJX8AJkCjSzAPMO21t8
         h282Fd4Zp2dPGISDQIu4oDPMrm8C34H7KLKWZKiyq31PVyB4FARuWx/x3AkZoYIThrA+
         mSwf0z8ggNjvnm9QwxInW9/XAQgXtI1pzg33IFazNo6kqZdO6i/+TnVvn263/2FfI/Lu
         +bz2zwvqVFgtcuIPEEuGILO2hXTIdJBX2bFkVxtpMpfdR/ENhBygPcb90hVM0toA6wwD
         /lgO36AddsS0jM5QShggFSfHT/PB3UZXx5upnCB3s3C5xBQVWHzZ0865Lhqmc0IbZP0e
         JLBA==
X-Gm-Message-State: AA+aEWbs591ZIia8a+dOJQYPcJAG8iaRDz3Fx3+lrSP+XFfrjpd6C3BY
        hW395rv+XOfND00kdfkdUldIvg==
X-Google-Smtp-Source: AFSGD/XNJQdfHlb8ec4+AOXwjCHnF1swnuaPJz4B7594ro7ibK+Nir0V6sc3RryQ1PypTTLeQe1BVg==
X-Received: by 2002:adf:9361:: with SMTP id 88mr2080952wro.204.1543511584259;
        Thu, 29 Nov 2018 09:13:04 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:13:03 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH 10/11] efi: reduce the amount of memblock reservations for persistent allocations
Date:   Thu, 29 Nov 2018 18:12:29 +0100
Message-Id: <20181129171230.18699-11-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of efi_mem_reserve_persistent() is rather
naive, in the sense that for each invocation, it creates a separate
linked list entry to describe the reservation. Since the linked list
entries themselves need to persist across subsequent kexec reboots,
every reservation created this way results in two memblock_reserve()
calls at the next boot.

On arm64 systems with 100s of CPUs, this may result in a excessive
number of memblock reservations, and needless fragmentation.

So instead, make use of the newly updated struct linux_efi_memreserve
layout to put multiple reservations into a single linked list entry.
This should get rid of the numerous tiny memblock reservations, and
effectively cut the total number of reservations in half on arm64
systems with many CPUs.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 20 +++++++++++++++++---
 include/linux/efi.h        |  3 +++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 80b11521627a..e90bc32c2670 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -998,7 +998,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
 	struct linux_efi_memreserve *rsv;
 	int rsvsize = EFI_MEMRESERVE_SIZE(1);
-	int rc;
+	unsigned long prsv;
+	int rc, index;
 
 	if (efi_memreserve_root == (void *)ULONG_MAX)
 		return -ENODEV;
@@ -1009,11 +1010,24 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			return rc;
 	}
 
-	rsv = kmalloc(rsvsize, GFP_ATOMIC);
+	/* first try to find a slot in an existing linked list entry */
+	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
+		rsv = __va(prsv);
+		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
+		if (index < rsv->size) {
+			rsv->entry[index].base = addr;
+			rsv->entry[index].size = size;
+
+			return 0;
+		}
+	}
+
+	/* no slot found - allocate a new linked list entry */
+	rsv = (struct linux_efi_memreserve *)__get_free_page(GFP_ATOMIC);
 	if (!rsv)
 		return -ENOMEM;
 
-	rsv->size = 1;
+	rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
 	atomic_set(&rsv->count, 1);
 	rsv->entry[0].base = addr;
 	rsv->entry[0].size = size;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4f27640fdcdc..becd5d76a207 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1724,4 +1724,7 @@ struct linux_efi_memreserve {
 #define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
 	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
 
+#define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
+	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
+
 #endif /* _LINUX_EFI_H */
-- 
2.19.1

