Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51E6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB70214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XseuU/Sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB70214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbeGMApO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:45:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39664 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbeGMApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:45:13 -0400
Received: by mail-pl0-f67.google.com with SMTP id p23-v6so117584plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Br+Ut7Adx8WfxmtbhyErzhCOz+hxoNRE6rn4bCoOl6Y=;
        b=XseuU/ScbDlqDh/a/SDhgRypjR2J4tgn9O8osFn9eaPIhB3fuDCZMp1x6WCcwrBGkO
         6YjKGC9LYEZEYlXMY3hXpIHs+2712SAV4/aK9MBrn5XYNi4AexMQXlXKtrbexKlxXMY+
         cP2gwnceDH1CPmMVPrMEAh6cZrAbT8CT2LBNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Br+Ut7Adx8WfxmtbhyErzhCOz+hxoNRE6rn4bCoOl6Y=;
        b=ZSyEY1ne3BmFrxG7Ztt4Ls412TXFxv60dz6I8nyhx3+/E6uDQxdgHS0x+yHNF98Nb1
         1MZMSdTWNntBchmMUArDlPQcF3e31xNMxr38Kl458RgMvb488tmP2ILZo0Ko0oOO20ls
         RNejSfDUBI6nAo+0TlNyJw2lUt8Gd05mcbCPswi2p35xYb0+75pBuxtsg/TpSZerkQsE
         rKYwTsc8hqRfM41QPLKpAvnfC+C+fz8h/oRHHurWduy4ZLTPbRp1tJGW3LbbcFZQhCh3
         Af3YSAU1FSGDa7kLeHf+BqVz8vPKLMtZBtoYhbs2qZ5IJEvm85DRDpVObha/ViNDVZ4I
         2/Cg==
X-Gm-Message-State: AOUpUlET3kCFtOif+g94JSIXRxZlr1hOQm28a0Xtl6myVkIuYZOj6vbb
        ALHszwfGyfVAbp1qwURYPxhUWQ==
X-Google-Smtp-Source: AAOMgpeR3fIKT0gAPz1A4UMTWTvYboCWGZjzcP9Wk622cOgH1FzkFY1cI1Tb+TWCfRIi0TyHh7W0vQ==
X-Received: by 2002:a17:902:292b:: with SMTP id g40-v6mr4199676plb.273.1531441991391;
        Thu, 12 Jul 2018 17:33:11 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id d188-v6sm41666859pfc.96.2018.07.12.17.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:33:10 -0700 (PDT)
Date:   Fri, 13 Jul 2018 09:34:36 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
Message-ID: <20180713003434.GZ28220@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, tbaicar@codeaurora.org,
        bhsharma@redhat.com, dyoung@redhat.com, james.morse@arm.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712164918.GA26935@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
> Hi Akashi,
> 
> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
> > This patch series is a set of bug fixes to address kexec/kdump
> > failures which are sometimes observed on ACPI-only system and reported
> > in LAK-ML before.
> 
> I tried picking this up, along with Ard's fixup, but I'm seeing a build
> failure for allmodconfig:
> 
> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
> 
> I didn't investigate further. Please can you fix this?

Because CONFIG_ACPI is on and CONFIG_EFI is off.

This can happen in allmodconfig as CONFIG_EFI depends on
!CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.

Looking at __acpi_get_mem_attributes(), since there is no information
available on memory attributes, what we can do at best is
  * return PAGE_KERNEL (= cacheable) for mapped memory,
  * return DEVICE_nGnRnE (= non-cacheable) otherwise
(See a hunk to be applied on top of my patch#4.)

I think that, after applying, acpi_os_ioremap() would work almost
in the same way as the original before my patchset given that
MAP memblock attribute is used only under CONFIG_EFI for now.

Make sense?

-Takahiro AKASHI

> Will
---8<---
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index ed46dc188b22..cad3ed2666ef 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -238,6 +238,7 @@ void __init acpi_boot_table_init(void)
 
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 {
+#ifdef CONFIG_EFI
 	/*
 	 * According to "Table 8 Map: EFI memory types to AArch64 memory
 	 * types" of UEFI 2.5 section 2.3.6.1, each EFI memory type is
@@ -255,5 +256,9 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_WT);
 	if (attr & EFI_MEMORY_WC)
 		return __pgprot(PROT_NORMAL_NC);
+#else
+	if (memblock_is_map_memory(addr))
+		return PAGE_KERNEL;
+#endif
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
