Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF398C41536
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8513A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2eS3OBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8513A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeK3ETK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbeK3ETJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:19:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so2682424wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vz5y5QfDkngla5yyvKovxaI5hAxDbbXuYQKEXtGsLK0=;
        b=A2eS3OBsFIVDm3SbMQ7DUpIRVJaS4Tf4DsriQrtmhjV/xWOrFJrAGLsgYBTc5/fFlA
         OpVuFxOZ/rcVN87UaesapdcPSRxKvEXGo3RvgB8nKzD/b1pspyeh3U+iCODuXeRt3xk5
         MZCuXvCIBlyLxDmtKe+GunAIP/SJBTBSiVHpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vz5y5QfDkngla5yyvKovxaI5hAxDbbXuYQKEXtGsLK0=;
        b=NZ4L9Wsw1zzJ/S6hOftba8aBSrL9z8hTy1B5EkUxLwjpO6Dt0Ggq2YgknS8fMUaMG7
         uK5XOH7fuI+oOKAJlUxzpBsIf6nXni5pKuMbTSOcZGgIXyQEGn1UjMrNL285b/GcESt2
         Iqe/fdj2W8s0ydEHBbQaqSBQlsYjeA71OoxMwBKzJcU012ZJBaV6U4gzxqzV5UCzzs/e
         Gr4/h5OLJhM4RDRgwNinicNrBHm408iLWfy4mJA9BniDE1t44WKtq4T80zpIq9meeCue
         qbasTHSx/9NP22Myw4ukHVsx0iXigO3yOKJlAoXPKAtPGkPyUl+kYAY2+fuUM4lfGuAP
         1TvA==
X-Gm-Message-State: AA+aEWaULf2RzkrE2pyKvkDOJyd8XEqLhZUCyovv/Qi1RujmYrfDWTFm
        mSlua7ooIjpizRo5o8hcs8OtRg==
X-Google-Smtp-Source: AFSGD/XPSjHYNRHfSzMVvI8TnB0UjDzpOaOvtnSjewY8kr1XwC9JyKnC4C/aEITO5Gp32KPaM3KgTQ==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr2115260wrt.63.1543511582682;
        Thu, 29 Nov 2018 09:13:02 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:13:01 -0800 (PST)
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
Subject: [PATCH 09/11] efi: permit multiple entries in persistent memreserve data structure
Date:   Thu, 29 Nov 2018 18:12:28 +0100
Message-Id: <20181129171230.18699-10-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of updating efi_mem_reserve_persistent() to cause less
fragmentation when dealing with many persistent reservations, update
the struct definition and the code that handles it currently so it
can describe an arbitrary number of reservations using a single linked
list entry. The actual optimization will be implemented in a subsequent
patch.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c              | 39 +++++++++++++++++--------
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 include/linux/efi.h                     | 13 +++++++--
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 415849bab233..80b11521627a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -602,21 +602,33 @@ int __init efi_apply_persistent_mem_reservations(void)
 
 		while (prsv) {
 			struct linux_efi_memreserve *rsv;
-
-			/* reserve the entry itself */
-			memblock_reserve(prsv, sizeof(*rsv));
-
-			rsv = early_memremap(prsv, sizeof(*rsv));
-			if (rsv == NULL) {
+			u8 *p;
+			int i;
+
+			/*
+			 * Just map a full page: that is what we will get
+			 * anyway, and it permits us to map the entire entry
+			 * before knowing its size.
+			 */
+			p = early_memremap(ALIGN_DOWN(prsv, PAGE_SIZE),
+					   PAGE_SIZE);
+			if (p == NULL) {
 				pr_err("Could not map UEFI memreserve entry!\n");
 				return -ENOMEM;
 			}
 
-			if (rsv->size)
-				memblock_reserve(rsv->base, rsv->size);
+			rsv = (void *)(p + prsv % PAGE_SIZE);
+
+			/* reserve the entry itself */
+			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
+
+			for (i = 0; i < atomic_read(&rsv->count); i++) {
+				memblock_reserve(rsv->entry[i].base,
+						 rsv->entry[i].size);
+			}
 
 			prsv = rsv->next;
-			early_memunmap(rsv, sizeof(*rsv));
+			early_memunmap(p, PAGE_SIZE);
 		}
 	}
 
@@ -985,6 +997,7 @@ static int __init efi_memreserve_map_root(void)
 int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
 	struct linux_efi_memreserve *rsv;
+	int rsvsize = EFI_MEMRESERVE_SIZE(1);
 	int rc;
 
 	if (efi_memreserve_root == (void *)ULONG_MAX)
@@ -996,12 +1009,14 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			return rc;
 	}
 
-	rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
+	rsv = kmalloc(rsvsize, GFP_ATOMIC);
 	if (!rsv)
 		return -ENOMEM;
 
-	rsv->base = addr;
-	rsv->size = size;
+	rsv->size = 1;
+	atomic_set(&rsv->count, 1);
+	rsv->entry[0].base = addr;
+	rsv->entry[0].size = size;
 
 	spin_lock(&efi_mem_reserve_persistent_lock);
 	rsv->next = efi_memreserve_root->next;
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 3d36142cf812..9e20159ea5f5 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -86,8 +86,8 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	}
 
 	rsv->next = 0;
-	rsv->base = 0;
 	rsv->size = 0;
+	atomic_set(&rsv->count, 0);
 
 	status = efi_call_early(install_configuration_table,
 				&memreserve_table_guid,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2b3b33c83b05..4f27640fdcdc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1712,9 +1712,16 @@ extern struct efi_runtime_work efi_rts_work;
 extern struct workqueue_struct *efi_rts_wq;
 
 struct linux_efi_memreserve {
-	phys_addr_t	next;
-	phys_addr_t	base;
-	phys_addr_t	size;
+	int		size;			// allocated size of the array
+	atomic_t	count;			// number of entries used
+	phys_addr_t	next;			// pa of next struct instance
+	struct {
+		phys_addr_t	base;
+		phys_addr_t	size;
+	} entry[0];
 };
 
+#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
+	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
+
 #endif /* _LINUX_EFI_H */
-- 
2.19.1

