Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFDC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDE5206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU7TEqlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDE5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeHOXQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:16:10 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45851 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeHOXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:16:09 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so929467pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FHTzydqAuAVlyRVJPr0bDkDU/YB8L0syLydxFr574Xs=;
        b=XU7TEqlTSSY/y4Eh54gYKuR9goUlIvLS+dUzVvJrMsIVj4cqXDyBA8yVn7x/EIiAZk
         7dJp9tETfAauhHk1EG5FnY9YarwwrJL+yZIdJIt+EvLQp7M52vbwI+65tnyHDzk1b6Zs
         s4zMkOSrVm1G3fG8ZIyD4Bi+oYqBnOBO3tpxqhx1voI3jCohNNxhq1s52cR1gOTvl2v7
         UPWEbbXLTuCRvPxaNZdd+TfPzgYXe6O/7Q2xt7zwRJLudEzF7KFkIydYCLHap2OBkOdA
         yvyzeDPI0u4FRs+84zbFWzy4nGZBUCNvgAJUtwnxXGPDA3lT+fN649Uv4ene9ME/143T
         8z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=FHTzydqAuAVlyRVJPr0bDkDU/YB8L0syLydxFr574Xs=;
        b=mJJpXLdHj5Qb7fSpplA/E4nQRgMpCVm7kBRX93rMnI0X4sYQuHMt5N+W2D2D/tW48T
         3ONHZKyh9mI4oQYbMu9lchMvpkLkQKHP/xOLITF0cVMgiWGhs1WIbxS8aWWPWfSViIcf
         9AbjanTOhRQbxbmmAg4LqWQaWZHwPli/dcSKRNs75SypMG+yBl5xT7xDsfivEzAKFUgw
         gTeQpfqcZaDEjJktlmPd/XY4kvU8kt18G1rSMfBrEEIB9N+QAyhIMzMz+s6Z66qzjutf
         c1hfUpHG6hx7iFNDLALEhDEHowcL5W6zmpFbbNR0T019HqBPLUDKuKjqX8xaa0x5w+ua
         rkbw==
X-Gm-Message-State: AOUpUlGyi7/0NkoNJuUBAL2bBTirucc28onkcj6W4RmbCBR7mhJN6x13
        b+7QJUFXw/aGQk4WrC07eQ3EPufR
X-Google-Smtp-Source: AA+uWPyGWh4oTMT9Eqv0qG17YnR/XaoLUKClruBLzyR/PTjIEBnEukF5OnEo0ZU7qHtlal8h+suZXg==
X-Received: by 2002:a17:902:b608:: with SMTP id b8-v6mr25990548pls.312.1534364549810;
        Wed, 15 Aug 2018 13:22:29 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a17-v6sm35257103pfg.106.2018.08.15.13.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:22:29 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolai Stange <nstange@suse.de>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Sven Joachim <svenjoac@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] x86: i8259: Add missing include file
Date:   Wed, 15 Aug 2018 13:22:27 -0700
Message-Id: <1534364547-20300-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i8259.h uses inb/outb and thus needs to include asm/io.h to avoid the
following build error, as seen with x86_64:defconfig and CONFIG_SMP=n.

In file included from drivers/rtc/rtc-cmos.c:45:0:
arch/x86/include/asm/i8259.h: In function 'inb_pic':
arch/x86/include/asm/i8259.h:32:24: error:
	implicit declaration of function 'inb'

arch/x86/include/asm/i8259.h: In function 'outb_pic':
arch/x86/include/asm/i8259.h:45:2: error:
	implicit declaration of function 'outb'

Reported-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Suggested-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Fixes: 447ae3166702 ("x86: Don't include linux/irq.h from asm/hardirq.h")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I have not seen a patch fly by, so here it is.

 arch/x86/include/asm/i8259.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 5cdcdbd4d892..89789e8c80f6 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_I8259_H
 
 #include <linux/delay.h>
+#include <asm/io.h>
 
 extern unsigned int cached_irq_mask;
 
-- 
2.7.4

