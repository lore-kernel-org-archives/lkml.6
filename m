Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4F69AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED399208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSoyGnle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED399208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755972AbeFOH4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:56:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44976 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755925AbeFOH4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:56:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id p21-v6so4078555pgd.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fMJ059I9Pwpj92i+n/S50FPN4apoi+2vr23cvPMQsMY=;
        b=MSoyGnley1Z1Ck24b5BR2GqAtgAKtiz7OIEKeAAmi9N/0VBXz9l4bS4m9GfK+qr++3
         yqK7YlT+Uz+QCQTlZ2k4Sk7/GTm1XwOI7I/IKjh4qKfLrUQIlH22MUmertZG2NGQVAoz
         +z2cI7j2iEc4gp6W9/NVatyF3Q01o95C9KibQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fMJ059I9Pwpj92i+n/S50FPN4apoi+2vr23cvPMQsMY=;
        b=IHjr7WjIFQzXhHBnirVMM4kRoE9/cb4NiRHHbSp9yrX3bX7fXcPY6Pj1SgZWb6vmWJ
         2vnYzn9l3iRGex+6VOo+FlaGxGhPHW2cb/HNnVo75n7x1LZimoX/kNmuwr/1B+lQf2hz
         59TBeh4jgnWWe34nHN63f5x2Wo8+UB4urVOTMNIzS5DnXzb4M3u//GOb8ADPZyZVfLIV
         I1cvw7lMDh0x6WNUqRWf5xCKIgRuWGQZNpmMQK8xobjnRABM8/8L6fGzCckjXKIM/us6
         CFC3PFieQav1DeH/El0+dRA8ooshgOZ4vmL6KY78JnzjOPSIM1Ng9imy73CvDV8KZsh9
         GCUQ==
X-Gm-Message-State: APt69E0+eOW4OFakYsYhfSntE4NksIutgg8RC7OEz2O+j/T8vma4bqH0
        dpEo1HbzyTE78Zh3rV78Lfbdyw==
X-Google-Smtp-Source: ADUXVKI3vKaFhflf8cgC6vU/F9fTg6HChgfz7PYvapRpOxzw9ks2COObw1uKaYK8kw4Kob7STdzruQ==
X-Received: by 2002:a63:7f44:: with SMTP id p4-v6mr595097pgn.416.1529049380265;
        Fri, 15 Jun 2018 00:56:20 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id d9-v6sm11862437pfg.183.2018.06.15.00.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 00:56:19 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH 1/3] arm64: export memblock_reserve()d regions via /proc/iomem
Date:   Fri, 15 Jun 2018 16:56:21 +0900
Message-Id: <20180615075623.13454-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

There has been some confusion around what is necessary to prevent kexec
overwriting important memory regions. memblock: reserve, or nomap?
Only memblock nomap regions are reported via /proc/iomem, kexec's
user-space doesn't know about memblock_reserve()d regions.

Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
and thus possible for kexec to overwrite with the new kernel or initrd.
But this was always broken, as the UEFI memory map is also reserved
and not marked as nomap.

Exporting both nomap and reserved memblock types is a nuisance as
they live in different memblock structures which we can't walk at
the same time.

Take a second walk over memblock.reserved and add new 'reserved'
subnodes for the memblock_reserved() regions that aren't already
described by the existing code. (e.g. Kernel Code)

We use reserve_region_with_split() to find the gaps in existing named
regions. This handles the gap between 'kernel code' and 'kernel data'
which is memblock_reserve()d, but already partially described by
request_standard_resources(). e.g.:
| 80000000-dfffffff : System RAM
|   80080000-80ffffff : Kernel code
|   81000000-8158ffff : reserved
|   81590000-8237efff : Kernel data
|   a0000000-dfffffff : Crash kernel
| e00f0000-f949ffff : System RAM

reserve_region_with_split needs kzalloc() which isn't available when
request_standard_resources() is called, use an initcall.

Reported-by: Bhupesh Sharma <bhupesh.linux@gmail.com>
Reported-by: Tyler Baicar <tbaicar@codeaurora.org>
Suggested-by: Akashi Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/setup.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 30ad2f085d1f..5b4fac434c84 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -241,6 +241,44 @@ static void __init request_standard_resources(void)
 	}
 }
 
+static int __init reserve_memblock_reserved_regions(void)
+{
+	phys_addr_t start, end, roundup_end = 0;
+	struct resource *mem, *res;
+	u64 i;
+
+	for_each_reserved_mem_region(i, &start, &end) {
+		if (end <= roundup_end)
+			continue; /* done already */
+
+		start = __pfn_to_phys(PFN_DOWN(start));
+		end = __pfn_to_phys(PFN_UP(end)) - 1;
+		roundup_end = end;
+
+		res = kzalloc(sizeof(*res), GFP_ATOMIC);
+		if (WARN_ON(!res))
+			return -ENOMEM;
+		res->start = start;
+		res->end = end;
+		res->name  = "reserved";
+		res->flags = IORESOURCE_MEM;
+
+		mem = request_resource_conflict(&iomem_resource, res);
+		/*
+		 * We expected memblock_reserve() regions to conflict with
+		 * memory created by request_standard_resources().
+		 */
+		if (WARN_ON_ONCE(!mem))
+			continue;
+		kfree(res);
+
+		reserve_region_with_split(mem, start, end, "reserved");
+	}
+
+	return 0;
+}
+arch_initcall(reserve_memblock_reserved_regions);
+
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
 void __init setup_arch(char **cmdline_p)
-- 
2.17.0

