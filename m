Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D5FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF8F21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iz3GvEBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfB0UBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:01:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33593 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfB0UBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:01:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so8485788pgl.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xH132//de+yu6qTUcGSCNrTMI70q0Q584KNYfmrdhFA=;
        b=iz3GvEBp9BU1O0JNjEaqgMzN+pR7UXZGZPAIAk2Yg2YR1SoycZvpMO7W2Q8CpN7K7s
         9dDf/WhDmYB2ktHkKPXB5CT11ryFS/o8iHXO5/tyUN4dCi3d8wBllFqD5k9gQ5+SnBIC
         50AW0+QGwCKj6icLruGO5U5ZoBF5INcoMMi0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xH132//de+yu6qTUcGSCNrTMI70q0Q584KNYfmrdhFA=;
        b=cx5TJ5tvuHX1iG5EquBIwv4TXBJp+L9C1Ak/3251rqUIi97CKRYwzc0nWV3Nhnu7Li
         sBmBVc+UAr9jUuCjlECDdRYMU5cvYzVaHl+DbjFOJTxZ1t0hVUDTDAnNs6GBx+gzPSUh
         9CdaKsMzrsEFLUlonZwp6vjEoA3AL08P3JtzGhWet787JxQGT5EuvLq+sUDl2kLLgbbs
         d92VZOsMfwyaRRQSvWdovwdopsopwxcwsJhUDlCcp2d1E547MjanPIgrvKq25KAlRFYP
         5ttMXzjFtfv1lzS8MhQbql+WVN7GXos15tcEcNYLs+fQOVLQulzsjIApG2w1TaC1VOiP
         vC6Q==
X-Gm-Message-State: AHQUAubO3jsnlhr4BW65BXLjm4hTdf1byDS/xqSFqW2bmRXKkXYx30QC
        3hJAIF8/H2u19kZ/J+iVnnqUkA==
X-Google-Smtp-Source: AHgI3IYQIEFhf8kOBuMM2neu5iHszJ3l52qceUNgvO3eG0awOBVYOimg3In++a3r51eK2ekS9eF/NA==
X-Received: by 2002:a63:9149:: with SMTP id l70mr4627938pge.65.1551297700046;
        Wed, 27 Feb 2019 12:01:40 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c3sm26695246pfg.53.2019.02.27.12.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 12:01:38 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH v2 2/3] x86/asm: Avoid taking an exception before cr4 restore
Date:   Wed, 27 Feb 2019 12:01:31 -0800
Message-Id: <20190227200132.24707-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227200132.24707-1-keescook@chromium.org>
References: <20190227200132.24707-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of taking a full WARN() exception before restoring a potentially
missed CR4 bit, this retains the missing bit for later reporting. This
matches the logic done for the CR0 pinning. Additionally updates the
comments to note the required use of "volatile".

Suggested-by: Solar Designer <solar@openwall.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/special_insns.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 1f01dc3f6c64..6020cb1de66e 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -97,18 +97,24 @@ extern volatile unsigned long cr4_pin;
 
 static inline void native_write_cr4(unsigned long val)
 {
+	unsigned long warn = 0;
+
 again:
 	val |= cr4_pin;
 	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
 	/*
 	 * If the MOV above was used directly as a ROP gadget we can
 	 * notice the lack of pinned bits in "val" and start the function
-	 * from the beginning to gain the cr4_pin bits for sure.
+	 * from the beginning to gain the cr4_pin bits for sure. Note
+	 * that "val" must be volatile to keep the compiler from
+	 * optimizing away this check.
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

