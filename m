Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2219AC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB0920665
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB0920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeJ0RyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 13:54:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbeJ0RyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 13:54:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9R94SqT105631
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 05:14:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ncm689np0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 05:14:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sat, 27 Oct 2018 10:13:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 27 Oct 2018 10:13:51 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9R9Dorm61735080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 27 Oct 2018 09:13:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0E2642042;
        Sat, 27 Oct 2018 09:13:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F27A42041;
        Sat, 27 Oct 2018 09:13:45 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.63])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 27 Oct 2018 09:13:44 +0000 (GMT)
Date:   Sat, 27 Oct 2018 10:13:42 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linux@armlinux.org.uk
Subject: Re: [PATCH v4 1/2] arm64: Get rid of __early_init_dt_declare_initrd()
References: <20181026223951.30936-1-f.fainelli@gmail.com>
 <20181026223951.30936-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026223951.30936-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18102709-0028-0000-0000-0000030E3500
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102709-0029-0000-0000-000023CA5454
Message-Id: <20181027091341.GB6770@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810270086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Fri, Oct 26, 2018 at 03:39:50PM -0700, Florian Fainelli wrote:
> ARM64 is the only architecture that re-defines
> __early_init_dt_declare_initrd() in order for that function to populate
> initrd_start/initrd_end with physical addresses instead of virtual
> addresses. Instead of having an override, just get rid of that
> implementation and perform the virtual to physical conversion of these
> addresses in arm64_memblock_init() where relevant.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/include/asm/memory.h |  8 --------
>  arch/arm64/mm/init.c            | 26 ++++++++++++++++----------
>  2 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..dc3ca21ba240 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -168,14 +168,6 @@
>  #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
>  #endif
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -#define __early_init_dt_declare_initrd(__start, __end)			\
> -	do {								\
> -		initrd_start = (__start);				\
> -		initrd_end = (__end);					\
> -	} while (0)
> -#endif
> -
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/bitops.h>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3cf87341859f..98ff0f7a0f7a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -364,6 +364,9 @@ static void __init fdt_enforce_memory_region(void)
>  void __init arm64_memblock_init(void)
>  {
>  	const s64 linear_region_size = -(s64)PAGE_OFFSET;
> +	unsigned long __maybe_unused phys_initrd_size;
> +	u64 __maybe_unused phys_initrd_start;
> +	u64 __maybe_unused base, size;
>  
>  	/* Handle linux,usable-memory-range property */
>  	fdt_enforce_memory_region();
> @@ -414,8 +417,11 @@ void __init arm64_memblock_init(void)
>  		 * initrd to become inaccessible via the linear mapping.
>  		 * Otherwise, this is a no-op
>  		 */
> -		u64 base = initrd_start & PAGE_MASK;
> -		u64 size = PAGE_ALIGN(initrd_end) - base;
> +		phys_initrd_start = __pa(initrd_start);
> +		phys_initrd_size = __pa(initrd_end) - phys_initrd_start;

If initrd_{start,end} are defined by the command line they already would be
physical addresses.

> +
> +		base = phys_initrd_start & PAGE_MASK;
> +		size = PAGE_ALIGN(phys_initrd_size);
>  
>  		/*
>  		 * We can only add back the initrd memory if we don't end up
> @@ -459,15 +465,15 @@ void __init arm64_memblock_init(void)
>  	 * pagetables with memblock.
>  	 */
>  	memblock_reserve(__pa_symbol(_text), _end - _text);
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	if (initrd_start) {
> -		memblock_reserve(initrd_start, initrd_end - initrd_start);
> -
> -		/* the generic initrd code expects virtual addresses */
> -		initrd_start = __phys_to_virt(initrd_start);
> -		initrd_end = __phys_to_virt(initrd_end);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> +		memblock_reserve(phys_initrd_start, phys_initrd_size);

this is not needed, as we do memblock_reserve() for the same area earlier.

What do you think of my version (below)?

> +		/*
> +		 * initrd_below_start_ok can be changed by
> +		 * __early_init_dt_declare_initrd(), set it back to what
> +		 * we want here.
> +		 */
> +		initrd_below_start_ok = 0;
>  	}
> -#endif
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -- 
> 2.17.1
> 

From 0e5661c6f1ac2d4b08a55d38c6bc224c187af14f Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sat, 27 Oct 2018 12:04:58 +0300
Subject: [PATCH] arm64: Get rid of __early_init_dt_declare_initrd()

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override, just get rid of that
implementation and perform the virtual to physical conversion of these
addresses in arm64_memblock_init() where relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 40 +++++++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b9644296..dc3ca21 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9d9582c..dd665be3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,6 +61,8 @@
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
+static phys_addr_t phys_initrd_start, phys_initrd_end;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
@@ -71,8 +73,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_end = start + size;
 	}
 	return 0;
 }
@@ -363,6 +365,7 @@ static void __init fdt_enforce_memory_region(void)
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+	u64 __maybe_unused base, size;
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -407,14 +410,23 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
+	    (initrd_start || phys_initrd_start)) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		if (phys_initrd_start) {
+			initrd_start = __phys_to_virt(phys_initrd_start);
+			initrd_end = __phys_to_virt(phys_initrd_end);
+		} else if (initrd_start) {
+			phys_initrd_start = __pa(initrd_start);
+			phys_initrd_end = __pa(initrd_end);
+		}
+
+		base = phys_initrd_start & PAGE_MASK;
+		size = PAGE_ALIGN(phys_initrd_end - phys_initrd_start);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -433,6 +445,13 @@ void __init arm64_memblock_init(void)
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+
+			/*
+			 * initrd_below_start_ok can be changed by
+			 * __early_init_dt_declare_initrd(), set it back to what
+			 * we want here.
+			 */
+			initrd_below_start_ok = 0;
 		}
 	}
 
@@ -454,19 +473,10 @@ void __init arm64_memblock_init(void)
 	}
 
 	/*
-	 * Register the kernel text, kernel data, initrd, and initial
+	 * Register the kernel text, kernel data and initial
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
-	}
-#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.7.4

-- 
Sincerely yours,
Mike.

