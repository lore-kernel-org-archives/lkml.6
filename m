Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpTybT0imR11BqAW7tLn0MR9swFGHZ3vy24MUYBcwglCsHSmroPkHIjaEKZ5nRed5bFEX3I
ARC-Seal: i=1; a=rsa-sha256; t=1525767213; cv=none;
        d=google.com; s=arc-20160816;
        b=GV0EeUPUOXQb0G2b20Ksf2x3VI7Jd6Api37gNXscbKteWce64ZxOu8mhLp7J1LfRQy
         ylEpkcJT15ellea/YzhZJdrx0mb9/kENku1p8qNia5rDrLw7IwjhhJ0XWj1h0bFTIE9E
         Wg4KUVWQRTtfRyLLZjgOcCCGDTC5hWnE8kqbNCIEB1l9kiD/vBKVtZ4ObsDVurOarLGT
         jP7ZuXGHQDTmOPQ+hu8f6ocImNVbb2mnWY9haIrrmq1sjI4vW7LOpmET7H8ZhbrF8J5I
         YY/RX99hDhXl/FIuqTaI80+7+x1lychku+cFLfDmsb2Q6LVfwiwnpKUnsDbRxfwwJ+lt
         RFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ovD+F4UL8fF+M2tDFrMQmzYzEgfgznWK8oZltfptZCQ=;
        b=lHfMDuFE4xGklNdehDlPfO9i7FwF9G350gWP0SPmVOCrU7deHsS5zgk8XLY3cLEGPA
         pBVCpGr5A68IZF/gDAUTAysU0bvMl1vMSFljQLRRswqja6VYimCmAMEeVXPR7Dc6FVgS
         PeS9GqF49zAexQOiSCgxDbOtKuQtkbqCISfV+b1AMjaqymBIcY584YahPy3KBoQlJdV3
         vQrLC0OSr2IVFM5r/yKuiaSaR7PTgAqHFRdEcu1oGNo+ytNtxWxtiBNxL/R+Ph14RN0k
         zkCHk0hi/0Gm9YYuP/Hbj1CHcuH1+h3VYAxSK0k4U5VT+/otVts2/Um0WAjMbu4QvZv8
         yN9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WNKCOypH;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WNKCOypH;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Agustin Vega-Frias <agustinv@codeaurora.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	timur@codeaurora.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4.16 48/52] irqchip/qcom: Fix check for spurious interrupts
Date: Tue,  8 May 2018 10:10:46 +0200
Message-Id: <20180508073934.885061518@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882882129701424?=
X-GMAIL-MSGID: =?utf-8?q?1599882882129701424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Agustin Vega-Frias <agustinv@codeaurora.org>

commit 1bc2463cee92ef0e2034c813d5e511adeb58b5fd upstream.

When the interrupts for a combiner span multiple registers it must be
checked if any interrupts have been asserted on each register before
checking for spurious interrupts.

Checking each register seperately leads to false positive warnings.

[ tglx: Massaged changelog ]

Fixes: f20cc9b00c7b ("irqchip/qcom: Add IRQ combiner driver")
Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: timur@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1525184090-26143-1-git-send-email-agustinv@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/qcom-irq-combiner.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -68,7 +68,7 @@ static void combiner_handle_irq(struct i
 
 		bit = readl_relaxed(combiner->regs[reg].addr);
 		status = bit & combiner->regs[reg].enabled;
-		if (!status)
+		if (bit && !status)
 			pr_warn_ratelimited("Unexpected IRQ on CPU%d: (%08x %08lx %p)\n",
 					    smp_processor_id(), bit,
 					    combiner->regs[reg].enabled,
