Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E570BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A528820834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkcvKaoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A528820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeJZNmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:42:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35084 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJZNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:42:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id l17-v6so5330324pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ntiGPzFssMdy2OqMwCn0JGUhJZB01M8PpPnY6qzn/1E=;
        b=YkcvKaoDkuQMO3pdJJlVQJa3pecKR8MO9400ipt0Yi+RL/Hxm4WTdufq3DnX3jHR0n
         CNMyisZv32v16E52pj/y7Uj2Pecqi0najfmW6CDorr5EKYuwoz+NlQ4+uSbcaW5cQnMN
         PbvuYuwgjUjWvRgLkAKW90XIWqtrTI8sHkqSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ntiGPzFssMdy2OqMwCn0JGUhJZB01M8PpPnY6qzn/1E=;
        b=h18fNosLY6M9h8VjExmgX0d9kreaoBkay/M4GHJW47beMKrzBzI5oLo/Aa3isOn5C8
         O5IXfu6B+rYrJFAgcR9gMCCOE366thGcsPscSWsLPKSNSPdxMqPAX0N2S3mN6pQ6pOZa
         3uMMH1H7T7WIQRpcBLnXTNQeDChIOSODIHfQ+9abhPmyWfEw/+j9FTFLqyp0T/zbTQhZ
         244yy5s4H7v5rBqzUAIitLDSRKAXFgaNeeJAWKL6YRdOJcvEy7a33oQQmDQgjToPfoa1
         UOvFA2Sc3uwbzrg0U8sws6Ny/0HcQZgW5KrO/H8iP1k9OaQVE+jYSaU1f08kW6RuX/SS
         5pqg==
X-Gm-Message-State: AGRZ1gJXMBryTwyu6QglWV3D74ZBWRDCZAwu9jngKthr+SLwUMfZYwUH
        qL4mDMXjIKtV/MswXWPwWdlPJQ==
X-Google-Smtp-Source: AJdET5eFrb/GMmMgvAMi+akp3cERAJMR6DIHbLtsZu3cgvqhykUVtA0JI4r2CaGecsQmveoGAc32SA==
X-Received: by 2002:a63:6643:: with SMTP id a64-v6mr2033673pgc.15.1540530412615;
        Thu, 25 Oct 2018 22:06:52 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id m18-v6sm12800626pfk.149.2018.10.25.22.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:06:52 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 1/4] m68k: rename system call table file name
Date:   Fri, 26 Oct 2018 10:36:14 +0530
Message-Id: <1540530377-3509-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org>
References: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system call table entries are present in syscalltable.S.
One of the patch in this patch series will generate the sys-
tem call table entries using the system call table generation
script and which will replace the existig table file.

In order to come up with a common naming convention across
all architecture, we need to change the file name to syscall-
_table.S. This change will unify the system call table gener-
tion implementation across all architecture.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/kernel/Makefile                            | 2 +-
 arch/m68k/kernel/{syscalltable.S => syscall_table.S} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/m68k/kernel/{syscalltable.S => syscall_table.S} (99%)

diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index dbac7f8..5f40ce6 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -15,7 +15,7 @@ extra-$(CONFIG_SUN3)	:= sun3-head.o
 extra-y			+= vmlinux.lds
 
 obj-y	:= entry.o irq.o module.o process.o ptrace.o
-obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
+obj-y	+= setup.o signal.o sys_m68k.o syscall_table.o time.o traps.o
 
 obj-$(CONFIG_MMU_MOTOROLA) += ints.o vectors.o
 obj-$(CONFIG_MMU_SUN3) += ints.o vectors.o
diff --git a/arch/m68k/kernel/syscalltable.S b/arch/m68k/kernel/syscall_table.S
similarity index 99%
rename from arch/m68k/kernel/syscalltable.S
rename to arch/m68k/kernel/syscall_table.S
index 2c8402e..6145bc0 100644
--- a/arch/m68k/kernel/syscalltable.S
+++ b/arch/m68k/kernel/syscall_table.S
@@ -6,7 +6,7 @@
  *
  *  Copyright (C) 1998  D. Jeff Dionne <jeff@lineo.ca>,
  *                      Kenneth Albanowski <kjahds@kjahds.com>,
- *  Copyright (C) 2000  Lineo Inc. (www.lineo.com) 
+ *  Copyright (C) 2000  Lineo Inc. (www.lineo.com)
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
  *  Linux/m68k support by Hamish Macdonald
-- 
1.9.1

