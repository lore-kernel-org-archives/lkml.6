Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33809C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF8C2463A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fNrismZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF8C2463A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeFVRCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:02:07 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44707 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754537AbeFVRCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:02:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id g26-v6so3220331pgn.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=H+Ji6nS9RYHrI9T/GDY2lUIR2+1671gfm3aYh78j4WQ=;
        b=fNrismZoZZbq5C9dakd4+Ohf5cOQje4ke12QDHxzFFZisEG/3WiZ2Wq8i+mG2arfTc
         6hCur/MW754h39i5m4NV7tukZKFh9T+bW6oEHfQZW6u0MTytVzN9e1Y4T/EWMVFXNFrl
         ac+HmJQcCQnWrCoYlWVq9iiwVwYSM6ZJ9/DcxgwlmRjUqclIv1yCgsjXAQXOWAngnofx
         Fa/2o0vtDU95pumU3fp8OpHNXQmu834SeAwhpluB5YoPcESmkwA3tj6+lBhny5mq0+9v
         04QDNwKlzDM2Y6GDjMA4MqHuhxM+e4T0/z8xhJDH3mbhrC2fBtHae/YOv9qlkZr7gqJs
         Qzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=H+Ji6nS9RYHrI9T/GDY2lUIR2+1671gfm3aYh78j4WQ=;
        b=Xh79IeRIYUwPB5uE6DjQvoS3yNFFTsbRucjA06r3K+Asg6UlludGxsjqbfdNNLbiDU
         zZRytRk59EEFvei1txLzAgMYFaLkvN8oXig/19FgxyItFG6MhcBY7DBUCwHuITc6Fp2u
         M0zSi7GDDwbAPU3/nW6JBDfZNyDpA+MN6Xafyp6vVZX0S0w969Zz0pYnc/L2HYPSObfW
         ZCj42VlrX9qe/l4EM0s5Mof5SaoQcRgf+clJfNl29YkIJZ+s7iiQkLbui/yToyngunMv
         0VAP9TCvYWYJYC1WuQYXc01LnQpwUOdaWGnFJ6FzggVQBimGi34tKYzO2qOOHnegNi48
         Ob1g==
X-Gm-Message-State: APt69E2Sld069WzNmx3ZDSWm/04fgI6YAAV/Xeip2ZNQREZe8Darvw7i
        L3DWT+fRkgdfPztlyjUb2iJ4+Q==
X-Google-Smtp-Source: ADUXVKKmblopOQKbY0PPsauJUn7rxPjEgWysswNIfWrGFgzRyvMi+rb6YCe0/GxYfTFsLxoIi338oA==
X-Received: by 2002:a65:664a:: with SMTP id z10-v6mr2185372pgv.43.1529686920961;
        Fri, 22 Jun 2018 10:02:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p22-v6sm17795790pfj.166.2018.06.22.10.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 10:02:00 -0700 (PDT)
Subject: [PATCH 3/5] arm64: Use the new GENERIC_IRQ_MULTI_HANDLER
Date:   Fri, 22 Jun 2018 10:01:24 -0700
Message-Id: <20180622170126.6308-4-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622170126.6308-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
 <20180622170126.6308-1-palmer@sifive.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Arnd Bergmann <arnd@arndb.de>, nicolas.pitre@linaro.org,
        vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, yamada.masahiro@socionext.com,
        alexandre.belloni@bootlin.com, Palmer Dabbelt <palmer@sifive.com>,
        pombredanne@nexb.com, Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, jhogan@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears arm64 copied arm's GENERIC_IRQ_MULTI_HANDLER code, but made
it unconditional.  I wanted to make this generic so it could be used by
the RISC-V port.  This patch converts the arm64 code to use the new
generic code, which simply consists of deleting the arm64 code and
setting MULTI_IRQ_HANDLER instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/arm64/Kconfig           |  4 +---
 arch/arm64/include/asm/irq.h |  2 --
 arch/arm64/kernel/irq.c      | 10 ----------
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..3d1011957823 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -74,6 +74,7 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
@@ -264,9 +265,6 @@ config ARCH_SUPPORTS_UPROBES
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
-config MULTI_IRQ_HANDLER
-	def_bool y
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index a0fee6985e6a..b2b0c6405eb0 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -8,8 +8,6 @@
 
 struct pt_regs;
 
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 static inline int nr_legacy_irqs(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 60e5fc661f74..780a12f59a8f 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -42,16 +42,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-void (*handle_arch_irq)(struct pt_regs *) = NULL;
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	if (handle_arch_irq)
-		return;
-
-	handle_arch_irq = handle_irq;
-}
-
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
-- 
2.16.4

