Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA2FC04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A811214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A811214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeHVBR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:17:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42130 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHVBR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:17:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id q204-v6so5570235oig.9;
        Tue, 21 Aug 2018 14:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZCrU7sKSacy1VBSF9agKPmwdt5c58S7qyS84QVXni0=;
        b=kntbw4ZxtadYq9EYj+kQZibcR7jt/xlLddImiKTble3j3ysE/peDQX7O59SkPew1Tl
         /P9o8xwb8rKAb/gCOwXlQEhGHOQlOs/cSauDhG25SoR+pX/+Rw2pgFszx8dMOXKc9eqM
         LlicIqzXvdGomw2A327UetXf6VIvf+68Cm0vf5roPL0qh7XFfoDhyKZXW2TD60NqwOAd
         Om+wMkrhm2wQMCB7f5hJA4XwxL5X32MuG1HZTq+ZxAiI6YrUJfyIs6o4HvY4uul4SztM
         R8hdAQ1CkroKyEFTzgWUpac0IhAmCMkNWq5xZ0UE7N9s9wK52mFrG+zG/LgjvYSHeVK2
         znHw==
X-Gm-Message-State: APzg51BOy6rLvg2dSYvis2zEChmfTGTFhpySIzZyx16nAj/tq7VsfJRS
        6ihHXmBgvXxlex9V1+hQ7BwTOS8=
X-Google-Smtp-Source: ANB0VdblvkToPRzOo7Ixv52+DBNOhOLdDTkHco9Y6T0ZgSXVNqjZWnPlBA7yDP+efbzrLgrO4OKMew==
X-Received: by 2002:aca:c5d8:: with SMTP id v207-v6mr1251450oif.264.1534888531275;
        Tue, 21 Aug 2018 14:55:31 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x126-v6sm18785332oig.15.2018.08.21.14.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:55:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH 5/8] c6x: use common built-in dtb support
Date:   Tue, 21 Aug 2018 16:55:21 -0500
Message-Id: <20180821215524.23040-6-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821215524.23040-1-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the common build support for built-in dtb files just requires
adding a .dtb.o target to obj-y.

The dtb now needs to be copied when unflattened because an init section
is used now.

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
I couldn't find a built cross-compiler for c6x, so this had no testing.

 arch/c6x/boot/dts/Makefile      | 11 +----------
 arch/c6x/boot/dts/linked_dtb.S  |  2 --
 arch/c6x/include/asm/sections.h |  1 -
 arch/c6x/kernel/setup.c         |  4 ++--
 arch/c6x/kernel/vmlinux.lds.S   | 10 ----------
 5 files changed, 3 insertions(+), 25 deletions(-)
 delete mode 100644 arch/c6x/boot/dts/linked_dtb.S

diff --git a/arch/c6x/boot/dts/Makefile b/arch/c6x/boot/dts/Makefile
index b212d278ebc4..fd937f781d16 100644
--- a/arch/c6x/boot/dts/Makefile
+++ b/arch/c6x/boot/dts/Makefile
@@ -6,14 +6,5 @@
 DTC_FLAGS ?= -p 1024

 ifneq ($(DTB),)
-obj-y += linked_dtb.o
+obj-y += $(DTB).dtb.o
 endif
-
-quiet_cmd_cp = CP      $< $@$2
-	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
-
-# Generate builtin.dtb from $(DTB).dtb
-$(obj)/builtin.dtb: $(obj)/$(DTB).dtb
-	$(call if_changed,cp)
-
-$(obj)/linked_dtb.o: $(obj)/builtin.dtb
diff --git a/arch/c6x/boot/dts/linked_dtb.S b/arch/c6x/boot/dts/linked_dtb.S
deleted file mode 100644
index cf347f1d16ce..000000000000
--- a/arch/c6x/boot/dts/linked_dtb.S
+++ /dev/null
@@ -1,2 +0,0 @@
-.section __fdt_blob,"a"
-.incbin "arch/c6x/boot/dts/builtin.dtb"
diff --git a/arch/c6x/include/asm/sections.h b/arch/c6x/include/asm/sections.h
index d6c591ab5b7e..dc2f15eb3bde 100644
--- a/arch/c6x/include/asm/sections.h
+++ b/arch/c6x/include/asm/sections.h
@@ -8,6 +8,5 @@ extern char _vectors_start[];
 extern char _vectors_end[];

 extern char _data_lma[];
-extern char _fdt_start[], _fdt_end[];

 #endif /* _ASM_C6X_SECTIONS_H */
diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
index 786e36e2f61d..509c5f086496 100644
--- a/arch/c6x/kernel/setup.c
+++ b/arch/c6x/kernel/setup.c
@@ -270,7 +270,7 @@ int __init c6x_add_memory(phys_addr_t start, unsigned long size)
 notrace void __init machine_init(unsigned long dt_ptr)
 {
 	void *dtb = __va(dt_ptr);
-	void *fdt = _fdt_start;
+	void *fdt = __dtb_start;

 	/* interrupts must be masked */
 	set_creg(IER, 2);
@@ -363,7 +363,7 @@ void __init setup_arch(char **cmdline_p)
 					 memory_end >> PAGE_SHIFT);
 	memblock_reserve(memory_start, bootmap_size);

-	unflatten_device_tree();
+	unflatten_and_copy_device_tree();

 	c6x_cache_init();

diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index 1fba5b421eee..584bab2bace6 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -90,16 +90,6 @@ SECTIONS
 		*(.switch)
 	}

-	. = ALIGN (8) ;
-	__fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET)
-	{
-		_fdt_start = . ;	/* place for fdt blob */
-		*(__fdt_blob) ;		/* Any link-placed DTB */
-		BYTE(0);		/* section always has contents */
-	        . = _fdt_start + 0x4000;	/* Pad up to 16kbyte */
-		_fdt_end = . ;
-	}
-
 	_etext = .;

 	/*
--
2.17.1
