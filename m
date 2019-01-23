Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEA7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E94F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfAWLS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:18:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50056 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbfAWLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:18:27 -0500
X-IronPort-AV: E=Sophos;i="5.56,510,1539619200"; 
   d="scan'208";a="52651487"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 19:18:25 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id B175B4BAC826;
        Wed, 23 Jan 2019 19:18:23 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 19:18:29 +0800
Date:   Wed, 23 Jan 2019 19:17:17 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <kasong@redhat.com>
Subject: Re: [PATCH v16 5/7] x86/boot: Early parse RSDP and fill in
 boot_params
Message-ID: <20190123111717.GF15754@localhost.localdomain>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
 <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: B175B4BAC826.AB050
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 07:08:48PM +0800, Chao Fan wrote:
[...]
> #endif /* CONFIG_ACPI */
>diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>index 8dd1d5ccae58..86fa8bf56d68 100644
>--- a/arch/x86/boot/compressed/misc.c
>+++ b/arch/x86/boot/compressed/misc.c
>@@ -382,6 +382,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> 	debug_putaddr(trampoline_32bit);
> #endif
> 
>+	/*
>+	 * Very early parse RSDP and fill in boot_params.
>+	 * Early parsing is only executed once, and later anyone who
>+	 * needs RSDP can gain RSDP address by boot_params but not parse again.
>+	 */
>+	boot_params->acpi_rsdp_addr = get_rsdp_addr();
>+

Hi Boris and Kairui,

I splite my v15 PATCH 5/6 to two patches, this v16 5/7 is new added.
Since as Boris said much code such as Kairui's need RSDP where is not
related to KASLR, but in my v15 version, the function entry is only
in kaslr.c. So I expose get_rsdp_addr() as not static, and fill in
boot_params without #ifdef KASLR issue ot MEMORY_HOTREMOVE and so on.
More code can gain the RSDP by boot_params.

Since in KALSR, we need RSDP to parse SRAT and gain memroy information,
so I put  boot_params->acpi_rsdp_addr = get_rsdp_addr(); just before
choose_random_location(), in which KASLR works. Then in this version
v16 PATCH 6/7, only try to gain RSDP by boot_params and not parse again.

So I think this method can cover other people's usage, such as Kairui
Song, how do you think this change.

Thanks,
Chao Fan

> 	/*
> 	 * The memory hole needed for the kernel is the larger of either
> 	 * the entire decompressed kernel plus relocation table, or the
>diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>index 764ad50c0119..e1dd15769cf3 100644
>--- a/arch/x86/boot/compressed/misc.h
>+++ b/arch/x86/boot/compressed/misc.h
>@@ -119,3 +119,10 @@ static inline void console_init(void)
> void set_sev_encryption_mask(void);
> 
> #endif
>+
>+/* acpi.c */
>+#ifdef CONFIG_ACPI
>+acpi_physical_address get_rsdp_addr(void);
>+#else
>+static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
>+#endif
>-- 
>2.20.1
>


