Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9D6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D2021721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JndamBC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfBGUYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:24:14 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38196 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBGUYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:24:14 -0500
Received: by mail-vk1-f195.google.com with SMTP id w72so300048vkd.5;
        Thu, 07 Feb 2019 12:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bYIL8cQreU3apb8WuK9wGn1i33FCMHOWR7pnhH11HHE=;
        b=JndamBC4se21TPTPoG6UTyo/qW/8CkptGF/uwsCBDQmT3TQ+bNIAzIKYbaH9Hd6b8G
         lLs5fFtT28eAnGJPdORK3+2ZB4IiZBHn9PpPYZFthegW0oZf+lzvbGCSYiSDnLfTimFL
         3TImx08QuNjS6BHVKHIgB3cTvB7x7mnDcGIeQ+J7Mzo8rAnkBm3CAl38FGLF9Yv109pY
         kA+IobuQbEPhukhThsHR7x5+yQ8xzj8X3d7FlV/O2/kzxPS9JrtkupL+FMsmGV3FDDBl
         ugyae4qXS0vqGN4LP8FMFp68vaKzz9z7aG1ydR+UQIjZerMx8aunflb2GrW7+ILOxVUl
         XbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bYIL8cQreU3apb8WuK9wGn1i33FCMHOWR7pnhH11HHE=;
        b=R5AcOcmubza8JAZNwvw+CgIHuneSUxCfzQISDaMkeZylqfm/+pNQiSrcPRZ8BYXEfH
         1v3INLUF9dhsTg7rsD/vv/FImfNFFA2uSO18fpFWgyIrwB+/5G1zySsJ56b1NVHd6ovn
         rGp7nzpCiQw2XJQVJiHH983+zjc6ZId//GFVbajzacwDarZvYudENQPe3ATuOM1jFhBZ
         ZN6rUW+Te2MW0WfUA3jSv5VfMQEnFdSL0b4QDiLM+IaQsgxMVeOgBBR6Oww4PRKGE8A+
         lznhfe+xi//O7z8aJMCLpg3p+9RfKb+UbFRpuZU4woq9tsuvoEJL1ryLPYm/jRxXTHlt
         PyyQ==
X-Gm-Message-State: AHQUAuZ+xc5Cz8WUWsDJbWYhnzTJ+9dvv3cS6ey5ouUXZGifldesMyR5
        AAVZJu1eILVsFQqq+lWQhlnWpuBjX5wG8LiyaDZHzGCp
X-Google-Smtp-Source: AHgI3IahF63LR5J8Bn96uINN9wKb2DnTVWLLNts8BGokOW0Ww4SDydZKvS0gOqEVABQ6PjaTPY7DznJ13/2nrGJ2KhE=
X-Received: by 2002:a1f:c041:: with SMTP id q62mr7319805vkf.50.1549571052727;
 Thu, 07 Feb 2019 12:24:12 -0800 (PST)
MIME-Version: 1.0
From:   Gerlando Falauto <gerlando.falauto@gmail.com>
Date:   Thu, 7 Feb 2019 21:24:00 +0100
Message-ID: <CABMprFit_4dv7FjjOUfFPSZgoL8AMM594qwi1SyB+x6iTcJpEg@mail.gmail.com>
Subject: debugging irq threaded handler not getting called
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having a hard time debugging a custom SPI device with multiple
interrupt GPIO pins, connected to a Samsung Artik 710 SoC module.

The device is a microcontroller acting as an SPI-CAN bridge (emulating
the hi3110, so SPI slave device) for two separate can busses.
[The idea was to make it emulate two separate hi3110 devices, each
with its own interrupt pin, and tweak the hi311x.c driver].
So I have 2 instances of the same device in the device tree, each with
its own GPIO as interrupt source:

    can0: can@0 {
      /*.... */
        interrupts = <26 IRQ_TYPE_LEVEL_HIGH>;
    }

    can1: can@1 {
      /*.... */
        interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
    }

Interrupts are requested as threaded and one-shot, on HIGH level:

    unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_HIGH;
    ret = request_threaded_irq(spi->irq, NULL, hi3110_can_ist,
                   flags, DEVICE_NAME, priv);


The threaded IRQ handler essentially does its job and always returns
IRQ_HANDLED:

    static irqreturn_t hi3110_can_ist(int irq, void *dev_id) {

      /* Does its business */
      return IRQ_HANDLED;
    }

I understand having a level trigger with ONESHOT should just re-enable
the interrupt at the end of the threaded handler.
Two interrupts could occur at mostly the same time, and this approach
seems to handle concurrency correctly with their locks.
The SPI bus is shared, but transactions look just fine.

What happens is that under moderately heavy load (100+100 irq/s),
after some minutes one of the two interrupts is not served anymore.
On a logic analyzer, the interrupt pin stays high forever with no
interaction with the SPI bus.
What's weird is that it's always the second instance to expose this
behavior. The first instance keeps working just fine, serving its
interrupts nicely.

I traced execution of the threaded handler on the analyzer, driving a
GPIO high/low at the very start/end of the handler.
You can see it go high right after the interrupt goes high, and go low
afterwards.
So the handler code always returns, and IRQ_HANDLED is the only
possible return value.

When this issue happens, the interrupt pin goes high but the driven
GPIO stays low -- this means the threaded handler never gets called.
I assume there's nothing more I should do other than just returning
IRQ_HANDLED to get the interrupt to get re-enabled, but I suspect
this doesn't really happen for some reason.

I also tried swapping the two interrupt lines, but again it's always
the second instance to get disabled, even though it's now on a
different pin.

Any suggestion on how I can dynamically inspect whether (and WHY?) the
interrupt was left disabled?
I saw some interesting entries in sysfs to inspect irq status
(https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-irq)
but I'm running a custom 4.4 kernel so that's unfortunately not available.
Any idea would be highly appreciated!

Thank you,
Gerlando
