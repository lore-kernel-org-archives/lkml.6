Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FBE21570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9rl4lXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FBE21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeI0PIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46675 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeI0PIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id z3-v6so1624871wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G7faJzsD3RoI+9ZciyV9NwH0zlHSWtEgk++NwoeQKTU=;
        b=g9rl4lXwZQBPXY7Wwn06ohS0x+uep6V+L1wUn0QOetpxa+xO/dHJQE2UgMzsKox8YF
         XyWpVaSsHRea0WwNl0YZzyg8ISzJ6HOw4vag761jg88XUsMWuXPbWLNixCc8LN8AdP74
         hIhJD3tdYCBU1GmA6K/hl3mIdLuvbn29NXc9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G7faJzsD3RoI+9ZciyV9NwH0zlHSWtEgk++NwoeQKTU=;
        b=Bl6wyu89XK6ELiZfRB8jkV8AkIVflXKCV+XrlPFLZu7zL4pVHsLyb+E+U3qZ21Y0bW
         6th4kfipMKoq2YfVnJ2DmibYYeAk/aiBufnCtblExnF2coz7fRyTAW06yf7npZKqJxQf
         HES1NlVcGhTFbSwZatGDZCxAzkaVzPKF9xQAYbldRQFzBDIpbGLS1heoOqEyuocAGFRb
         HnjBv7dBBsEtMVi/GXwSqLolNinGZUKXfzrOQy+j5d17M3vSxTYwkorZ+nMmj2GPnfQW
         y9xzyOVYkCDftxyKh7DM3t5DtTBZO7+p73XWCi+vbh6L68KNT1IkrLYECKO1gmCbcxa+
         qo5A==
X-Gm-Message-State: ABuFfojba3KHl+h3pw9qHV/HNpVzG/c0z599AEzXCSqQSb8G6iIxXTx4
        x667ZqadQmxgFqYsl9pkItjRKSSzTNM=
X-Google-Smtp-Source: ACcGV627QSZhpVk0iWv5tqUTHFSJ+M0L4Z3p+Cmz6UJbcHrI2WdocUC1HHUP5qIPScloTwlSj7EDGg==
X-Received: by 2002:adf:9244:: with SMTP id 62-v6mr758366wrj.130.1538038269464;
        Thu, 27 Sep 2018 01:51:09 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:51:08 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 09/11] efi/x86: earlyprintk - Add 64bit efi fb address support
Date:   Thu, 27 Sep 2018 10:50:36 +0200
Message-Id: <20180927085039.8391-10-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Ma <aaron.ma@canonical.com>

EFI GOP uses 64-bit frame buffer address in some BIOS.
Add 64bit address support in efi earlyprintk.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/early_printk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
index 5fdacb322ceb..7476b3b097e1 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/arch/x86/platform/efi/early_printk.c
@@ -26,12 +26,14 @@ static bool early_efi_keep;
  */
 static __init int early_efi_map_fb(void)
 {
-	unsigned long base, size;
+	u64 base, size;
 
 	if (!early_efi_keep)
 		return 0;
 
 	base = boot_params.screen_info.lfb_base;
+	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
 	size = boot_params.screen_info.lfb_size;
 	efi_fb = ioremap(base, size);
 
@@ -46,9 +48,11 @@ early_initcall(early_efi_map_fb);
  */
 static __ref void *early_efi_map(unsigned long start, unsigned long len)
 {
-	unsigned long base;
+	u64 base;
 
 	base = boot_params.screen_info.lfb_base;
+	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
 
 	if (efi_fb)
 		return (efi_fb + start);
-- 
2.18.0

