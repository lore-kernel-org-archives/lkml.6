Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B4AC4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDC620857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDC620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeIFE0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:26:08 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36557 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeIFE0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:26:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id r69-v6so17144345oie.3;
        Wed, 05 Sep 2018 16:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6TQUk/tlo44b4q/BoWZVHk3v/GbjgWViAdwLo1tLgLA=;
        b=HWH58wDaOHxrHbo8wGeZ4CLjdRdfEX+PEQfHfidF6rEglytjfC30451xKBgTCIUayb
         uLrqxFY8vZT/8ogbhPPehSUn7KAKk9YnVVZaY3TKlaD94pbwIcHUGWSOsi5qRhx0iLTu
         Zur/EyT6DHQFd3qmh6El8Hnvth0CkbF74J6EkMkRqLIim9HnvG0YYXPTHn336K/GDD5e
         CghRnY+lfyE09T2CyU4A3h1TbF6YaaQNdlmzT/QSjc+iEebVC+iHF8oUWPTCetrJF6hv
         b9l/18Zsy/aEujEQJalZe4jIhug0MlLjwMmhqrHDOesmTDD2B6olJFDCEdf2Ig+3XnYz
         wB1Q==
X-Gm-Message-State: APzg51AefYtDOtFJZgsiRRJQUAVfKLN1Z0F0sr82ISuiX3kTqub7iTX4
        aVka0zUloA/FEHjn0eGV6Irh5yk=
X-Google-Smtp-Source: ANB0VdaFPPPOffQq1wDa8I3TPIGxI+SzeULHS83MGBwZc6q7y7xcU4+CtCakV28fG+YA3J77G5cgFw==
X-Received: by 2002:aca:dbc2:: with SMTP id s185-v6mr102000oig.251.1536191614946;
        Wed, 05 Sep 2018 16:53:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH v2 5/9] c6x: use common built-in dtb support
Date:   Wed,  5 Sep 2018 18:53:23 -0500
Message-Id: <20180905235327.5996-6-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905235327.5996-1-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
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
Please ack so I can take the whole series via the DT tree.

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
