Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7271C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E76218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UFpQQXyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfBZXhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:37:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37247 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfBZXg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:36:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id q3so7010507pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+oYY7xbWtmy3I3xAdK40RKuX5lYtH9k01cC1Ag26GTE=;
        b=UFpQQXyv1WlG+vQ2VGQVeBpekJEgGJm2XiXC/0iqN9nei8flgJHMUhw+1gO/u6r5Z7
         0vm0yI+z26dsUE9TactgLhLPQvgHVxBI9LzDiQ3XZ2VyxREYHaViUVTcnjLuZEl7BgO0
         yrwaIBLzjSsVT03OTDfX79+D30OJwPVl2oPoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+oYY7xbWtmy3I3xAdK40RKuX5lYtH9k01cC1Ag26GTE=;
        b=t8G91vRKdOiNjxIJ5UFYnI7SZDyWQBKTb5R0mAcpcoeoOLye10Ek+7kh3tXc9JtegB
         dCIpBZN4305kiJzSSIs4dKOSkifqjJhrmHDs+pOF5X9jMqjiDNzFVdcSpiPtvcHuDhPd
         U4yzT1Fj7MXx7hwqOA1588YKaRe4tl1kR70yI3CLd9gJtjuL0H+tqA0+ajGIhN2UzJzM
         5/10R7cjPQT9bmTz816q01c0ZM5ptPAmgXufe/oNYmEkR96UUthcIiG3VTDOK92qTujX
         FZrQ2j6DuNvx7kAl7i0qJckjTDAMyP0UGxmHt8WGeMny2rQYsXiI387YF/zqQZozNp1c
         DGeg==
X-Gm-Message-State: AHQUAuYwJf2TePAgNugXIANGlydfPVfwmojASpVK8ja5r7z8Px0qofC9
        2Tlo/xaUEgSKzT2GVZkvk8aL5Q==
X-Google-Smtp-Source: AHgI3IYxRjSOI0v0d+U8i/glfBS5fF/2id9Tw7ZYe31sT6gSxDF2rJYY5yfnK8VNxonTJyUxWqvduQ==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr29293448plk.282.1551224217159;
        Tue, 26 Feb 2019 15:36:57 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y14sm22436097pgc.17.2019.02.26.15.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 15:36:54 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/asm: Avoid taking an exception before cr4 restore
Date:   Tue, 26 Feb 2019 15:36:46 -0800
Message-Id: <20190226233647.28547-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226233647.28547-1-keescook@chromium.org>
References: <20190226233647.28547-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of taking a full WARN() exception before restoring a potentially
missed CR4 bit, this retains the missing bit for later reporting. This
matches the logic done for the CR0 pinning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/special_insns.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 8416d6b31084..6f649eaecc73 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -97,6 +97,8 @@ extern volatile unsigned long cr4_pin;
 
 static inline void native_write_cr4(unsigned long val)
 {
+	unsigned long warn = 0;
+
 again:
 	val |= cr4_pin;
 	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
@@ -105,10 +107,12 @@ static inline void native_write_cr4(unsigned long val)
 	 * notice the lack of pinned bits in "val" and start the function
 	 * from the beginning to gain the cr4_pin bits for sure.
 	 */
-	if (WARN_ONCE((val & cr4_pin) != cr4_pin,
-		      "Attempt to unpin cr4 bits: %lx, cr4 bypass attack?!",
-		      ~val & cr4_pin))
+	if ((val & cr4_pin) != cr4_pin) {
+		warn = ~val & cr4_pin;
 		goto again;
+	}
+	WARN_ONCE(warn, "Attempt to unpin cr4 bits: %lx; bypass attack?!\n",
+		  warn);
 }
 
 #ifdef CONFIG_X86_64
-- 
2.17.1

