Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpKIysY6v84P3iP10Vw7DhDtvxW98HGOXnvjfWzxqcPZDAR+xPbUGKtnqi6GPnHRdvofc7l
ARC-Seal: i=1; a=rsa-sha256; t=1525767358; cv=none;
        d=google.com; s=arc-20160816;
        b=Xb1nRIQT2qsjnbXDOGeaKX2ijrfivO1HhPVsoTM4MW8F7V/DkGfDgq8o31jbzru12O
         xwKowJSqP317vMymsMaIV9zlCyEw2r9JaA3aOurv/z9k56GpAAjWYzzJ8ME1rJ47Js+0
         Kh9Phrreqyo5lGXNXBxDH0vQ5CLApr5bkxQu0XcYUMYnWD+X6TEOuqQWrrAkZesXdik7
         fQ2ZlLLBVeXqF9eClCJIlzJg0yS45bWsh8X2d5R2XP2pHKvgSDzNbk86sgEybFBnii+w
         3VGsM0Wg7KPNzoHN7e024eprZk2QR08TQ9a2HmGnPnlNtp0Sxiii3bbsvAqjq3jj7Wly
         EEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=RzUFLi0RFPh4QSaGJccWWiPrIAUdl1T9eQOeOkr369U=;
        b=Tkyj4o1ULAptQFwSBbqgtRCPTKKYUKfpZm5tKAojxvGXgonbYsfCZ41ilfcqAG9fZM
         8bbMh/CQrQbVlQMF0zZsfFlfMB1StWKy7+8P0XdIn8rJvHqF6J/mJ4zNt/B4Ax8bbbjK
         A6b3YC83B3JcmhjiaSYFb0pqabz8vBdsFUm4aO2XE2wTw6jHKWNc6pyITg07vWxNhhHW
         4baByLHC7G7o3yO6R6iuOp739y5UIVarLQHjJDTplGnckeJly6QKFPUVUm/FvPMRLa0r
         QauMyrHwlVOZ1SXrmE1uRoa1VUKwp/HT0XQOt4HLASBePucTgZml4UlD9IdqURWJM5Z7
         eWeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YA04jYbM;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YA04jYbM;
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
Subject: [PATCH 4.14 42/43] irqchip/qcom: Fix check for spurious interrupts
Date: Tue,  8 May 2018 10:11:01 +0200
Message-Id: <20180508074010.706606097@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882882129701424?=
X-GMAIL-MSGID: =?utf-8?q?1599883034124430488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
