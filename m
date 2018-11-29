Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1888C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B629120863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7gRNaTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B629120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbeK3ETD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbeK3ETC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:19:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so3066032wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otiyS0qoWsuunniYKJ1BwM1dERK1qmd7Q4dc5cs0rtA=;
        b=j7gRNaTRiQ5ED0EKIyqB5OZVqFlopVcjKBcwU7WVTKKDNPA+l+hh3yBjmBd0+ZXCNM
         rrR87AZhWnRlTg+jbZzCsdue9gXmLeHFBz40pmpno3bSdRjQOP9NLqdYERHBNX+HXkOf
         MIllGYKc+Lfp3mnThSgb2dqkpQADtQc7ybq/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otiyS0qoWsuunniYKJ1BwM1dERK1qmd7Q4dc5cs0rtA=;
        b=mJv/13dWVSKnArL7bClPWzGs4ZQBAyBIklvLD0gnn/Hxaf702l9g7p4mCKaMeEyfKE
         PWCNyWFCavJ9ci8bP1grqDFRNUXApA4d0M7v6Z+vmqf/UXgTrp8qy+bpHrZa1smraN0A
         TqPVVkZgxFCIqCzQ0tlHY4+C+bIkb7Dp4y0wkWKgsO+7SSqPY5Dfu9h2XEYpoaUdpMUP
         FKAG5hMDkZ+6qac9CgdQe6dxMxhuXVoP5P4Kggg4KKvQsufId+f4S1zTPqZNvMcfXY+k
         pBen166m5VssZPWMnySfuSikqMrOnVSWjWvrqd+C8I5hhQoBDI+Ekf33dZom/EHHNQ+0
         LnrQ==
X-Gm-Message-State: AA+aEWa6l26ZZMq2RjThiCnCoJmsfXONmQY44943iNsC5Y+TgIq4k3YL
        keCm6F1qFfR3HHWevuOvHqC9sw==
X-Google-Smtp-Source: AFSGD/X9sZ+l7hRJl8EcXE4hw/so3sLUTXZ7G/IkKMEe20rFr3fp2Xd+HIW2CP+mFbINTlfLyxFJsQ==
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr2608832wmc.17.1543511576404;
        Thu, 29 Nov 2018 09:12:56 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:12:55 -0800 (PST)
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
Subject: [PATCH 05/11] x86/efi: Unmap EFI boot services code/data regions from efi_pgd
Date:   Thu, 29 Nov 2018 18:12:24 +0100
Message-Id: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

efi_free_boot_services(), as the name suggests, frees EFI boot services
code/data regions but forgets to unmap these regions from efi_pgd. This
means that any code that's running in efi_pgd address space (e.g:
any EFI runtime service) would still be able to access these regions but
the contents of these regions would have long been over written by
someone else. So, it's important to unmap these regions. Hence,
introduce efi_unmap_pages() to unmap these regions from efi_pgd.

After unmapping EFI boot services code/data regions, any illegal access
by buggy firmware to these regions would result in page fault which will
be handled by EFI specific fault handler.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 95e77a667ba5..09e811b9da26 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -369,6 +369,24 @@ void __init efi_reserve_boot_services(void)
 	}
 }
 
+/*
+ * Apart from having VA mappings for EFI boot services code/data regions,
+ * (duplicate) 1:1 mappings were also created as a quirk for buggy firmware. So,
+ * unmap both 1:1 and VA mappings.
+ */
+static void __init efi_unmap_pages(efi_memory_desc_t *md)
+{
+	pgd_t *pgd = efi_mm.pgd;
+	u64 pa = md->phys_addr;
+	u64 va = md->virt_addr;
+
+	if (kernel_unmap_pages_in_pgd(pgd, pa, md->num_pages))
+		pr_err("Failed to unmap 1:1 mapping for 0x%llx\n", pa);
+
+	if (kernel_unmap_pages_in_pgd(pgd, va, md->num_pages))
+		pr_err("Failed to unmap VA mapping for 0x%llx\n", va);
+}
+
 void __init efi_free_boot_services(void)
 {
 	phys_addr_t new_phys, new_size;
@@ -393,6 +411,13 @@ void __init efi_free_boot_services(void)
 			continue;
 		}
 
+		/*
+		 * Before calling set_virtual_address_map(), EFI boot services
+		 * code/data regions were mapped as a quirk for buggy firmware.
+		 * Unmap them from efi_pgd before freeing them up.
+		 */
+		efi_unmap_pages(md);
+
 		/*
 		 * Nasty quirk: if all sub-1MB memory is used for boot
 		 * services, we can get here without having allocated the
-- 
2.19.1

