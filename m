Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B1C2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ3rid4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbeL0XCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:02:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41214 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeL0XCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:02:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so19521399wrs.8;
        Thu, 27 Dec 2018 15:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=fLELQD4JXgCT/r0PIvOYlrh7WN5Faf5K04yz+v20rAE=;
        b=CZ3rid4Ow9qubxqL1wUT3OQhJ5BNlYIXwGl4Gfr64dck6K01TArGZfB6TWsePt+JCU
         CGQ1q6583w/XEp44Y8xyP6sHpifIjG+mdPNmPLVPMTLBct1y3Cb+tvciJ+7MVB80rsRJ
         aFXkw32wVST5VMJLzAabxZffQSuFQncQwxFbu/peoYnXiUoj2det0vnx3+AIr67ZPoPy
         Gj9y9En6W2GZw7pu58WUeHUqNvTQsfDSpcJoEUk83lBIFVI1vbQXuPxxCyWNH5MKsohZ
         FEJpzMBmy23rzWvb8ESDesYeQL9X/5gnYLtEw0zHY4PnXqPnLECQg3TBsEEi8Cf9vQXJ
         g8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=fLELQD4JXgCT/r0PIvOYlrh7WN5Faf5K04yz+v20rAE=;
        b=fm4MuAiRKhjAqSawirB2zf//HCoIDikN/j+4gCJnhclm/FH3G3SGroxP6WQd/6zu3u
         zlc+jvj3fNncG/wlQSe2pwAOUWYwjjSYgRmntZqTiLWFGRYNBhhrtPENUzI2QUxXR1Kv
         wpqZEVWH/vk68q4b2gQV2BioITb/U7UkMYcfqdSPRKqB6YhF5P3Wday/c6i9+ezeBF1c
         A8xYJdqvL3wWg3z+odff456PNDfaDgvw4JGa1Fm+UUuTkgSOsxfQ4act19gye5/WKAzn
         mdMdmLDOsvnAa3XoNMaQU+jdCrJA3DYtmLuFTtmT9MDduV1ZDzFZnRB8PuMLAFaOa201
         I6Ag==
X-Gm-Message-State: AJcUukcZrN2BbQ4yxehyNUgFjzk0XJZ3+zfHV9eGmc/XvaOnQhqBOFJq
        Ox16Z9dGVz74WP9z0VJeCmw=
X-Google-Smtp-Source: ALg8bN5XS6bWIru15+MBztKd79y+uTBl5rr861JL7cG8EYZS1YDFdHJIPHuWO7tVqfXvKvFyjb+gfg==
X-Received: by 2002:adf:82a4:: with SMTP id 33mr22184511wrc.252.1545951742282;
        Thu, 27 Dec 2018 15:02:22 -0800 (PST)
Received: from festbox ([85.204.4.237])
        by smtp.googlemail.com with ESMTPSA id k135sm49209322wmd.42.2018.12.27.15.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 15:02:21 -0800 (PST)
Message-ID: <4085fc648ff5086bd6e6237d74d2a11e945a617b.camel@gmail.com>
Subject: Interrupt storm from pinctrl-amd on Acer AN515-42
From:   Leonard Crestez <cdleonard@gmail.com>
To:     Daniel Kurtz <djkurtz@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Drake <drake@endlessm.com>,
        Nitesh Kumar Agrawal <Nitesh-kumar.Agrawal@amd.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Fri, 28 Dec 2018 01:02:19 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My Acer Nitro 5 AN515-42 laptop with a Ryzen 2700U hangs on boot with 
recent kernel on an interrupt storm from pinctrl-amd.

Older kernels work but this seems to be because this module was disabled 
by default. I tried to copy over old driver from 4.9 but it still 
experiences same issue.

Digging a little deeper it seems the touchpad interrupt is active on 
boot and since it's configured as "level" and no touchpad driver is 
available yet there does not seem to be any way to clear it.

I don't know how this should be handled, booting with an active enabled but 
unclearable interrupt seems like a platform bug to me. There is even an 
option to set touchpad to "basic" which does some sort of ps2 emulation 
but the IRQ issue still happens!

One workaround is to explicitly disable the interrupt from the handler 
if no mapping is found; this will keep it disabled until 
amd_gpio_irq_set_type is called later.

--- drivers/pinctrl/pinctrl-amd.c
+++ drivers/pinctrl/pinctrl-amd.c
@@ -567,22 +567,27 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
                        regval = readl(regs + i);
                        if (!(regval & PIN_IRQ_PENDING) ||
                            !(regval & BIT(INTERRUPT_MASK_OFF)))
                                continue;
                        irq = irq_find_mapping(gc->irq.domain, irqnr + i);
-                       generic_handle_irq(irq);
+                       if (irq) {
+                               generic_handle_irq(irq);
+                               ret = IRQ_HANDLED;
+                       }
 
                        /* Clear interrupt.
                         * We must read the pin register again, in case the
                         * value was changed while executing
                         * generic_handle_irq() above.
                         */
                        raw_spin_lock_irqsave(&gpio_dev->lock, flags);
                        regval = readl(regs + i);
+                       /* Disable if pending but unmapped */
+                       if (!irq && (regval & PIN_IRQ_PENDING))
+                               regval &= ~BIT(INTERRUPT_ENABLE_OFF);
                        writel(regval, regs + i);
                        raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-                       ret = IRQ_HANDLED;
                }
        }
 
        /* Signal EOI to the GPIO unit */


When in "i2c mode" the touchpad has an ACPI hid "ELAN0504", there are
many similar compatibe hids in elan_i2c driver and if I add this one it
probes successfully and handles irqs but fails to report input (i2c 
read data is invalid).

Same laptop experiences some severe p-state throttling issues so there
are many things wrong here. Let me know if you want more version info
or ACPI dumps.

--
Regards,
Leonard

