Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5C9C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D28520811
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBKBqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:46:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52826 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726101AbfBKBqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:46:16 -0500
X-IronPort-AV: E=Sophos;i="5.58,357,1544457600"; 
   d="scan'208";a="54007648"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Feb 2019 09:46:14 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 9939F4B6ED88;
        Mon, 11 Feb 2019 09:46:13 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 09:46:16 +0800
Date:   Mon, 11 Feb 2019 09:46:05 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Baoquan He" <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <mingo@redhat.com>,
        <keescook@chromium.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <ard.biesheuvel@linaro.org>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20190211014605.GC1544@localhost.localdomain>
References: <20181025103345.GF14020@nazgul.tnic>
 <20181025134050.ggiir77ehntikbwg@gabell>
 <20181106184519.GA16391@zn.tnic>
 <20181106193636.svyjwuwrlgnpuyyf@gabell>
 <20181106204511.GO13712@zn.tnic>
 <20181106222133.lb7674yzszivzihd@gabell>
 <20181108105129.GA7543@zn.tnic>
 <20181110105422.GA20023@zn.tnic>
 <20181111134556.qxv2v4g7dl5irzo7@gabell>
 <20190205150514.fvztftk75swgfayd@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190205150514.fvztftk75swgfayd@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 9939F4B6ED88.AFEDA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:05:16AM -0500, Masayoshi Mizuma wrote:
[...]

Hi Masa,

Sorry for delay, since last days were Chinese holiday.

>diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>index c5a949335..7dd61b943 100644
>--- a/arch/x86/boot/compressed/acpi.c
>+++ b/arch/x86/boot/compressed/acpi.c
>@@ -288,6 +288,7 @@ int count_immovable_mem_regions(void)
> 	struct acpi_subtable_header *sub_table;
> 	struct acpi_table_header *table_header;
> 	char arg[MAX_ACPI_ARG_LENGTH];
>+	unsigned long long possible_addr, max_possible_addr = 0;

This line is so long that it should be added in first line.

> 	int num = 0;
> 
> 	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
>@@ -308,10 +309,19 @@ int count_immovable_mem_regions(void)
> 			struct acpi_srat_mem_affinity *ma;
> 
> 			ma = (struct acpi_srat_mem_affinity *)sub_table;
>-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
>-				immovable_mem[num].start = ma->base_address;
>-				immovable_mem[num].size = ma->length;
>-				num++;
>+			if (ma->length) {
>+				if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
>+					possible_addr =
>+						ma->base_address + ma->length;
>+					if (possible_addr > max_possible_addr)
>+						max_possible_addr =
>+							possible_addr;
>+				} else {
>+					immovable_mem[num].start =
>+						ma->base_address;
>+					immovable_mem[num].size = ma->length;
>+					num++;
>+				}
> 			}

It looks better in another mail where you add a new function.

Thanks,
Chao Fan

> 
> 			if (num >= MAX_NUMNODES*2) {
>@@ -320,6 +330,7 @@ int count_immovable_mem_regions(void)
> 			}
> 		}
> 		table += sub_table->length;
>+		boot_params->possible_mem_addr = max_possible_addr;
> 	}
> 	return num;
> }
>diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
>index 60733f137..5b64b606e 100644
>--- a/arch/x86/include/uapi/asm/bootparam.h
>+++ b/arch/x86/include/uapi/asm/bootparam.h
>@@ -156,7 +156,7 @@ struct boot_params {
> 	__u64  tboot_addr;				/* 0x058 */
> 	struct ist_info ist_info;			/* 0x060 */
> 	__u64 acpi_rsdp_addr;				/* 0x070 */
>-	__u8  _pad3[8];					/* 0x078 */
>+	__u64  possible_mem_addr;			/* 0x078 */
> 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
> 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
> 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
>diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
>index 3f452ffed..71fc28570 100644
>--- a/arch/x86/mm/kaslr.c
>+++ b/arch/x86/mm/kaslr.c
>@@ -70,6 +70,30 @@ static inline bool kaslr_memory_enabled(void)
> 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
> }
> 
>+static unsigned int __init kaslr_padding(void)
>+{
>+	unsigned int rand_mem_physical_padding =
>+				CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>+#ifdef CONFIG_MEMORY_HOTPLUG
>+	unsigned long long max_possible_phys, max_actual_phys, threshold;
>+
>+	if (!boot_params.possible_mem_addr)
>+		goto out;
>+
>+	max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << TB_SHIFT);
>+	max_possible_phys = roundup(boot_params.possible_mem_addr,
>+					1ULL << TB_SHIFT);
>+	threshold = max_actual_phys +
>+		((unsigned long long)rand_mem_physical_padding << TB_SHIFT);
>+
>+	if (max_possible_phys > threshold)
>+		rand_mem_physical_padding =
>+			(max_possible_phys - max_actual_phys) >> TB_SHIFT;
>+out:
>+#endif
>+	return rand_mem_physical_padding;
>+}
>+
> /* Initialize base and padding for each memory region randomized with KASLR */
> void __init kernel_randomize_memory(void)
> {
>@@ -103,7 +127,7 @@ void __init kernel_randomize_memory(void)
> 	 */
> 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
> 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
>-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>+			kaslr_padding();
> 
> 	/* Adapt phyiscal memory region size based on available memory */
> 	if (memory_tb < kaslr_regions[0].size_tb)
>-- 
>2.20.1
>
>Thanks,
>Masa
>
>


