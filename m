Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CADA217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="uBU5XUWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbeLSMhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:37:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37204 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLSMhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:37:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so9425376plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 04:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=876CmMkVFCgLjYrQ0X6AShW5JqnqwBSR+DsbIhBCkd0=;
        b=uBU5XUWg7KvEDHR1fm9t3486h0yU4PmkQ4+37L4qSridL1mImgq1Y7CWmLAZTYd9yI
         mk69gjWBjX8ecF+TFnahT4J2B4o6sFbA9+a1yBNF3j2AjCzS9nc2KtTTbqiR3tTuYyoj
         ttLYk+D6jZ77dCIv3hOXgDk8SYLMPd4VCMpZYFLS0VJbqlC3AuZRAPHlhAJCUsn8odSh
         6nD/VLZ1V97KB85kwchFZ2OyesQ3EL5Iwbh9kqHGrzlBNVqokE5DE3JLkcbcqWL1lx/d
         gpAb50tHiim05LeQEHE5/iJi9+45CPRaDgDzkyWJXNXYVp8YkfPM3aR/BdKbZ1DmGhOT
         yGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=876CmMkVFCgLjYrQ0X6AShW5JqnqwBSR+DsbIhBCkd0=;
        b=Gziu1GEVlXQwuA88ZtvBaJ1cr5gbVDpH5Zmzft5cLdR5PWCzbcan6UUqV+o/dqQ0vX
         eWLb03N3JtSQdFZMUpfc+cR1OEekzrOIFpnXGSfkJMEidXnrfGRvBIMCJt5+L3Loqsst
         0E9m40hfQH58bODMPeN3TKfVgcnQQEkYzrlupIw2VBdo4VfclT6YxDc8aNgNuEnA3btL
         9RmMBx3e+ySyXiCWR6n9BbbzGFymP/JhHnf6GDXTVpl0717+mbtZdG6twuPKQr9eD8zA
         KNmFYjShObO+RjzyC1SL7h/K6hNhTt1oKH7NHVUdP3EhBKmUAHJyoJvtgv3s0qNY3/G/
         Lk8A==
X-Gm-Message-State: AA+aEWZRORbChrsz5Fv2Hs8DOXBvoPTrHWkDcGnwe6RFFkTIsgDtwNro
        Wxz2cKsMoJu2hWLph2BdOqDysw==
X-Google-Smtp-Source: AFSGD/XUc39wOjpxu/MD0OtxBuKALWgi982I+6PHuqFy5vRA9mzt+cy92cbYBwus32oocY5UVYfH3Q==
X-Received: by 2002:a17:902:2867:: with SMTP id e94mr20339041plb.264.1545223030407;
        Wed, 19 Dec 2018 04:37:10 -0800 (PST)
Received: from localhost.localdomain ([106.51.16.106])
        by smtp.gmail.com with ESMTPSA id z10sm12471746pfg.120.2018.12.19.04.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:37:09 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2] RISC-V: Make BSS section as the last section in vmlinux.lds.S
Date:   Wed, 19 Dec 2018 18:06:57 +0530
Message-Id: <20181219123657.61270-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objcopy only emits loadable sections when creating flat kernel
Image. To have minimal possible size of flat kernel Image, we should
have all non-loadable sections after loadable sections.

Currently, execption table section (loadable section) is after BSS
section (non-loadable section) in the RISC-V vmlinux.lds.S. This
is not optimal for having minimal flat kernel Image size hence this
patch makes BSS section as the last section in RISC-V vmlinux.lds.S.

In addition, we make BSS section aligned to 16byte instead of PAGE
aligned which further reduces flat kernel Image size by few KBs.

The flat kernel Image size of Linux-4.20-rc4 using GCC 8.2.0 is
8819980 bytes with current RISC-V vmlinux.lds.S and it reduces to
7991740 bytes with this patch applied. In summary, this patch reduces
Linux-4.20-rc4 flat kernel Image size by 809 KB.

Signed-off-by: Anup Patel <anup@brainfault.org>
---

Changes since v1:
 - Introduce MAX_BYTES_PER_LONG define and use it in-place of
   0x10 magic value

 arch/riscv/kernel/vmlinux.lds.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 65df1dfdc303..1e1395d63dab 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -18,6 +18,8 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 
+#define MAX_BYTES_PER_LONG	0x10
+
 OUTPUT_ARCH(riscv)
 ENTRY(_start)
 
@@ -74,8 +76,6 @@ SECTIONS
 		*(.sbss*)
 	}
 
-	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
-
 	EXCEPTION_TABLE(0x10)
 	NOTES
 
@@ -83,6 +83,10 @@ SECTIONS
 		*(.rel.dyn*)
 	}
 
+	BSS_SECTION(MAX_BYTES_PER_LONG,
+		    MAX_BYTES_PER_LONG,
+		    MAX_BYTES_PER_LONG)
+
 	_end = .;
 
 	STABS_DEBUG
-- 
2.17.1

