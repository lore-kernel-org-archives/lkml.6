Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17D4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8B9208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEko/cPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8B9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeK3Agu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:36:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47030 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeK3Agt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:36:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so1703916ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 05:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXNk+IykTkPI3Ka56ikEPDA+/mFhxUHNSWUcQaJqz90=;
        b=WEko/cPrBxaH2C6kyl+fU62qPqaJd4s+S0IEX11fTiHRAvt1Vac1u9Q9Ejlkdzf6+o
         x+QLA+irB1AOjb+6YOQJifc39baeC2MEVqttBu2z3QeIHnBsBx5Zm9p8CP7jw93mQUyT
         u8PoUZEkBKuwKyYp2LCX0KY93SuHtFcgtdOTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXNk+IykTkPI3Ka56ikEPDA+/mFhxUHNSWUcQaJqz90=;
        b=jPvVYv3F9BULqEBL9xc5c6e4+I23cuJX9mlTbxcwyZH9bmjF55D9+xSuwr/zM2X4k1
         92ouL9srM0gnArXu3qwkfqTPYmsELrw6U1FZQHOAPRW4hceuhsobe6gAam2KDIPa4NbB
         YVgyWBmIgMgkaMYpkep6NfpWvOV7ylqz3O2of1q2VefiOuckdtdC6nuNuzUpAUlO2sxs
         R2HVLtAjhw0FsDw65iHarobnqcuXgpsCYysUOs3zqjU2ehouOb4ig77IG84UqjXd2Yi2
         XxZyBNNPzEa9iV7RuKY6OaonpIuGWFguJinhNKRSlqS4NAX4MUDm4UvDMGuXhXjT+yqU
         rrww==
X-Gm-Message-State: AA+aEWa3f0EXKLuf0ka+nYiGXoDbYl6NxIYQdT5v+4gkGIBnukDMBZXw
        iEF80Ldph0PQIspbj9bWI+zz1g==
X-Google-Smtp-Source: AFSGD/WwTiGaSDEvKUVxVuwFqBoof9jN3OdsDXjuhJ5wkJl4ZnFqyWA8monFwsP7RptjS4oQLSODdA==
X-Received: by 2002:a2e:8989:: with SMTP id c9-v6mr1133783lji.124.1543498284927;
        Thu, 29 Nov 2018 05:31:24 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id 85-v6sm299063lja.16.2018.11.29.05.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 05:31:23 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] irq: Request and release resources for chained IRQs
Date:   Thu, 29 Nov 2018 14:31:19 +0100
Message-Id: <20181129133119.29387-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses a bug in the irqchip core that was triggered
by new code assuming a strict semantic order of the irqchip
calls:

 .irq_request_resources()
 .irq_enable()
 .irq_disable()
 .irq_release_resources()

Mostly this is working fine when handled inside manage.c,
the calls are strictly happening in the above assumed order.

However on a Qualcomm platform I get the following in dmesg:

WARNING: CPU: 0 PID: 1 at ../drivers/gpio/gpiolib.c:3513
	 gpiochip_irq_enable+0x18/0x44
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0
     Not tainted 4.20.0-rc4-00002-g1b8a75b25c6e-dirty #9
Hardware name: Generic DT based system
[<c03124ac>] (unwind_backtrace) from [<c030d994>] (show_stack+0x10/0x14)
[<c030d994>] (show_stack) from [<c0b48aec>] (dump_stack+0x78/0x8c)
[<c0b48aec>] (dump_stack) from [<c03213e4>] (__warn+0xe0/0xf8)
[<c03213e4>] (__warn) from [<c0321514>] (warn_slowpath_null+0x40/0x48)
[<c0321514>] (warn_slowpath_null) from [<c06ad5d0>]
	     (gpiochip_irq_enable+0x18/0x44)
[<c06ad5d0>] (gpiochip_irq_enable) from [<c0371198>] (irq_enable+0x44/0x64)
[<c0371198>] (irq_enable) from [<c0371258>] (__irq_startup+0xa0/0xa8)
[<c0371258>] (__irq_startup) from [<c03712ac>] (irq_startup+0x4c/0x130)
[<c03712ac>] (irq_startup) from [<c03716d0>]
	     (irq_set_chained_handler_and_data+0x4c/0x78)
[<c03716d0>] (irq_set_chained_handler_and_data) from [<c081c17c>]
	     (pm8xxx_probe+0x160/0x22c)
[<c081c17c>] (pm8xxx_probe) from [<c07f439c>] (platform_drv_probe+0x48/0x98)

What happens is that when the pm8xxx driver tries to register
a chained IRQ irq_set_chained_handler_and_data() will eventually
set the type and call irq_startup() and thus the .irq_enable()
callback on the irqchip.

This irqchip is in drivers/pinctrl/qcom/pinctrl-msm.c and known
as TLMM.

However, the irqchip core helpers in GPIO assumes that
the .irq_request_resources() callback is always called before
.irq_enable(), and the latter is where module refcount and
also gpiochip_lock_as_irq() is normally called.

When .irq_enable() is called without .irq_request_resources()
having been called first, it seems like we are enabling
an IRQ on a GPIO line that has not first been locked to be
used as IRQ and we get the above warning. This happens since
as of
commit 461c1a7d4733d ("gpiolib: override irq_enable/disable")
this is strictly assumed for all GPIO-based IRQs.

As it seems reasonable to assume that .irq_request_resources()
is always strictly called before .irq_enable(), we add the
irq_[request|release]_resources() functions to the internal
API and call them also when adding a chained irqchip to
an IRQ.

I am a bit uncertain about the call site for
irq_released_resources() inside chip.c, but it appears this
path is for uninstalling a chained handler.

Cc: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Fixes: 461c1a7d4733d ("gpiolib: override irq_enable/disable")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 kernel/irq/chip.c      | 2 ++
 kernel/irq/internals.h | 3 +++
 kernel/irq/manage.c    | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index a2b3d9de999c..eef67a0b1889 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -947,6 +947,7 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		if (desc->irq_data.chip != &no_irq_chip)
 			mask_ack_irq(desc);
 		irq_state_set_disabled(desc);
+		irq_release_resources(desc);
 		if (is_chained)
 			desc->action = NULL;
 		desc->depth = 1;
@@ -974,6 +975,7 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		irq_settings_set_norequest(desc);
 		irq_settings_set_nothread(desc);
 		desc->action = &chained_action;
+		irq_request_resources(desc);
 		irq_activate_and_startup(desc, IRQ_RESEND);
 	}
 }
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ca6afa267070..f408a7544c6a 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -75,6 +75,9 @@ extern void __enable_irq(struct irq_desc *desc);
 #define IRQ_START_FORCE	true
 #define IRQ_START_COND	false
 
+extern int irq_request_resources(struct irq_desc *desc);
+extern void irq_release_resources(struct irq_desc *desc);
+
 extern int irq_activate(struct irq_desc *desc);
 extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9dbdccab3b6a..38bb0ec07180 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1108,7 +1108,7 @@ static int irq_setup_forced_threading(struct irqaction *new)
 	return 0;
 }
 
-static int irq_request_resources(struct irq_desc *desc)
+int irq_request_resources(struct irq_desc *desc)
 {
 	struct irq_data *d = &desc->irq_data;
 	struct irq_chip *c = d->chip;
@@ -1116,7 +1116,7 @@ static int irq_request_resources(struct irq_desc *desc)
 	return c->irq_request_resources ? c->irq_request_resources(d) : 0;
 }
 
-static void irq_release_resources(struct irq_desc *desc)
+void irq_release_resources(struct irq_desc *desc)
 {
 	struct irq_data *d = &desc->irq_data;
 	struct irq_chip *c = d->chip;
-- 
2.19.1

