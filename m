Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD45C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6AF2408D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjRpK3hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6AF2408D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934063AbeFZS3O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:29:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43619 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeFZS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:28:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id c5-v6so7056980wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7rtDqZRn08p6IrU2qqSvkpaXuaNX+BLXDAxvrNGfhOo=;
        b=EjRpK3hSgSPZ2IbhYyfsOubGNygDOsFKwCM0O9hlft6LOomb81jMgHZLG1WCI+dNvN
         vwGB/iCq21birz/AHBNXyBGsrgQ3lbnnHrZNJiAiEeBSCceRQxS55arQGPVFuWr7/Pbl
         NbboOjYq/dzf210TIurgGShTofSDL0QKmSEho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7rtDqZRn08p6IrU2qqSvkpaXuaNX+BLXDAxvrNGfhOo=;
        b=am1TWE3DgI1tiLy7Bh18CSDaN8IIFJU9lBdnSks4lh2R9B1TnMkDn7nv9DX4gOxN4T
         Kni/Y52Jki6uZCF1hKmYwpfMTWSHVzRJL42JQBBxAHWDz5bXQiWSaTpCeZJKuy7HZAme
         V2XoyT9+Ruuf3gTPCeJO8Kv5Nl9E5s7/+TV0Dzrx35NpYxD8r5zQXLkZEfCFhECWVD29
         Ddb7bf0PKUoJY+vRee3Fw8KF6ictIJCwbqHfKARt0Sip/HWuFvwke4/t5wAS5IUOKu2H
         iokZ45klytsFDKH4JLSBLYNJh47ceysHLNWqSzlWnGzroYW6VzgeHf5/0qvwYXGmRIcZ
         EyjA==
X-Gm-Message-State: APt69E0gFlVc8yqpWGuQZDJtsWViSgyp2pBBIh7S6cM/ceCIG9mVAqY7
        WOznHZIYUl/WHhuaq+RdmL72iEUCe/k=
X-Google-Smtp-Source: AAOMgpeqCv6MP65JB2MZyHSB5NRIj76tnLImVw+2rpBcVe9+O7CH4hwqsUezXu42dAe+1h4BQlRAlw==
X-Received: by 2002:adf:8425:: with SMTP id 34-v6mr2402558wrf.72.1530037729483;
        Tue, 26 Jun 2018 11:28:49 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:d037:e907:f0a2:a5ea])
        by smtp.gmail.com with ESMTPSA id s17-v6sm1707664wmc.34.2018.06.26.11.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:28:48 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v9 5/6] PCI: Add support for relative addressing in quirk tables
Date:   Tue, 26 Jun 2018 20:28:00 +0200
Message-Id: <20180626182802.19932-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the PCI quirk tables to be emitted in a way that avoids absolute
references to the hook functions. This reduces the size of the entries,
and, more importantly, makes them invariant under runtime relocation
(e.g., for KASLR)

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/quirks.c | 12 +++++++++---
 include/linux/pci.h  | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de848658..0ba4e446e5db 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -64,9 +64,15 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 		     f->vendor == (u16) PCI_ANY_ID) &&
 		    (f->device == dev->device ||
 		     f->device == (u16) PCI_ANY_ID)) {
-			calltime = fixup_debug_start(dev, f->hook);
-			f->hook(dev);
-			fixup_debug_report(dev, calltime, f->hook);
+			void (*hook)(struct pci_dev *dev);
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+			hook = offset_to_ptr(&f->hook_offset);
+#else
+			hook = f->hook;
+#endif
+			calltime = fixup_debug_start(dev, hook);
+			hook(dev);
+			fixup_debug_report(dev, calltime, hook);
 		}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..51baa3ab5195 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1795,7 +1795,11 @@ struct pci_fixup {
 	u16 device;			/* Or PCI_ANY_ID */
 	u32 class;			/* Or PCI_ANY_ID */
 	unsigned int class_shift;	/* should be 0, 8, 16 */
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	int hook_offset;
+#else
 	void (*hook)(struct pci_dev *dev);
+#endif
 };
 
 enum pci_fixup_pass {
@@ -1809,12 +1813,28 @@ enum pci_fixup_pass {
 	pci_fixup_suspend_late,	/* pci_device_suspend_late() */
 };
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				    class_shift, hook)			\
+	__ADDRESSABLE(hook)						\
+	asm(".section "	#sec ", \"a\"				\n"	\
+	    ".balign	16					\n"	\
+	    ".short "	#vendor ", " #device "			\n"	\
+	    ".long "	#class ", " #class_shift "		\n"	\
+	    ".long "	#hook " - .				\n"	\
+	    ".previous						\n");
+#define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)			\
+	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)
+#else
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
 				  class_shift, hook)			\
 	static const struct pci_fixup __PASTE(__pci_fixup_##name,__LINE__) __used	\
 	__attribute__((__section__(#section), aligned((sizeof(void *)))))    \
 		= { vendor, device, class, class_shift, hook };
+#endif
 
 #define DECLARE_PCI_FIXUP_CLASS_EARLY(vendor, device, class,		\
 					 class_shift, hook)		\
-- 
2.11.0

