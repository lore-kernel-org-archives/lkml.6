Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06737ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC51C20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pekoUhWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC51C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeJaIDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:03:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44950 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeJaIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:03:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id j13-v6so3110555pff.11;
        Tue, 30 Oct 2018 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7tZFK7bYGAH6azDS0jVMH4AjaPmsUCiqxVsDGGft9WU=;
        b=pekoUhWp8L+hjF7Ch1fACgCku/k3gVF4ZdZg0wCG8M1BpHpxZB3YKfTWnYSA00mzzx
         Tp3zcbLWvGFbO+7CIruB1A1KqN1tnbanZV2xExwvM2c7lbDUcohQVV1ESRfpiG6diGSU
         IwE/rr2hVUQ4LVciwznpwYV0JKu60fDKR8jwAa4F2L9fAWVB+RgNLqUKwyI0VKc1Za92
         wJuAcp2Gq1SeJW+5vtxd5810zg4VxYMLAK/NthpnkNCK7eoTfiz407wdTI94kthWhvvl
         zOcj70EhzIJIkx6X2srInTDIPe7Xt0nLvM+XsMjpKlFtpAbLAwAyRL0tMwaJuywkBpyH
         pNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7tZFK7bYGAH6azDS0jVMH4AjaPmsUCiqxVsDGGft9WU=;
        b=dg2P3gs4zXA3hjAiYOB+UIAomIERWPcEOiWqNEN4TipK7UsCWX+SMKx1J66sCMmfyH
         5UkDdLjVpZPGzwUpGGpcGkubrObEMDAi8IajSw/5q3HjNbyOmklgRQ6+QnnsJW2nm6qr
         EXo/29CUrWuxY43kgdJZ5cNuuZYs8+0loMwGE/Kkix8O5nilXkI9aJ70lHaYBcZ13j0x
         KaOB7hXwZ1YFhbJMP2vBoSNkPAUBKnAKULGs2Ct2BpfzRR/5ITUKHvoUzraW87DVgn0t
         pRT2oSt9L6JZB4rqstd5zjqzETnRAe+z+g5xKi2FVmI7GJhIKnVJxSFvArHeIwV4uv4o
         rfag==
X-Gm-Message-State: AGRZ1gLIFReB16ilfxMXh+vmkI0BNKbua0DHHNeDsNdOvuIh75r6xOwP
        tbkOcMx254SPLwpigSG0Cqp0fWb8
X-Google-Smtp-Source: AJdET5eCk0WV+MPNK6/Jjx0WrYAmBBB7IOwp4iC4TbQysw7UuDUgKHgTAoN9+UKJfx1XTHpyn9v7gA==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr668872pgd.446.1540940871337;
        Tue, 30 Oct 2018 16:07:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f14-v6sm3431689pgr.87.2018.10.30.16.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 16:07:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: [PATCH v2 3/6] of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
Date:   Tue, 30 Oct 2018 16:07:18 -0700
Message-Id: <20181030230721.28429-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030230721.28429-1-f.fainelli@gmail.com>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have central and global variables holding the physical
address and size of the initrd, we can have
early_init_dt_check_for_initrd() populate
phys_initrd_start/phys_initrd_size for us.

This allows us to remove a chunk of code from arch/arm/mm/init.c
introduced with commit 65939301acdb ("arm: set initrd_start/initrd_end
for fdt scan").

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c | 6 ------
 drivers/of/fdt.c   | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 87d59a53861d..4bfa08e27319 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -236,12 +236,6 @@ static void __init arm_initrd_init(void)
 	phys_addr_t start;
 	unsigned long size;
 
-	/* FDT scan will populate initrd_start */
-	if (initrd_start && !phys_initrd_size) {
-		phys_initrd_start = __virt_to_phys(initrd_start);
-		phys_initrd_size = initrd_end - initrd_start;
-	}
-
 	initrd_start = initrd_end = 0;
 
 	if (!phys_initrd_size)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 76c83c1ffeda..e34cb49231b5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -925,6 +925,8 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	end = of_read_number(prop, len/4);
 
 	__early_init_dt_declare_initrd(start, end);
+	phys_initrd_start = start;
+	phys_initrd_size = end - start;
 
 	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n",
 		 (unsigned long long)start, (unsigned long long)end);
-- 
2.17.1

