Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3272C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A273C213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PCR0BaEq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KtbTm/IA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A273C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeJCT0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:26:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeJCT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:26:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 37C1860C61; Wed,  3 Oct 2018 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538570305;
        bh=t1v4pEJjPNE+FRpJ81BoYEO/76ocEr6eiBO4I5TX8jk=;
        h=Date:From:To:Cc:Subject:From;
        b=PCR0BaEq4UPIMelh6DV+gVuS89R1BKCIKCVb9GSbtPnyQcu6oV+OZ+lU13Pwt4oiR
         LYgMX/6fT+aJaSeg8hVKPqNYXiR4b/FFmeV0H1cYe7jmanxN7N0KAYizNg5IwThluc
         CS7F2IqyeGKoyGDReNbnRR0amebNrdyzMRN5nrBo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9DB0D60C55;
        Wed,  3 Oct 2018 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538570304;
        bh=t1v4pEJjPNE+FRpJ81BoYEO/76ocEr6eiBO4I5TX8jk=;
        h=Date:From:To:Cc:Subject:From;
        b=KtbTm/IAgqKm4jkdRJ9CCzthDu7Zjo4VvxK95ZYrqP38rS3RYxIvxG+dd20rRuCmR
         9HDcY/VKFRlwpMSG3Uy1bW0MUXANzX4oZWyF31+xlA1m3fhCOcjehQEIBlxjmrzaQE
         FJ6m9CDClKao10HnQhcT6J8RKIEvHBLNgK1NPRUY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Oct 2018 05:38:24 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     linus.walleij@linaro.org, sboyd@codeaurora.org,
        linux-gpio@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: protected pins and debugfs
Message-ID: <9aec322678417753fe4022691f4bfdbe@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is regarding the protected pins configuration reading and printing 
from non-secure operating systems.
GPIO framework is checking whether pin is in use(flag FLAG_REQUESTED) or 
not in gpiolib_dbg_show().

If GPIO chip drivers are overriding the dbg_show callback, drivers are 
not checking whether a pin is really in use or not to print 
configuration details.
     if (chip->dbg_show)
                 chip->dbg_show(s, chip);
         else
                 gpiolib_dbg_show(s, gdev);

I think, reserved-gpio-ranges solution may move the problem to dts 
settings maintenance as they change from platform to platform.
https://lore.kernel.org/patchwork/patch/878107/
https://lore.kernel.org/patchwork/patch/878106/
https://lore.kernel.org/patchwork/patch/878109/

Can we use a simple/common solution like below?  It will check whether a 
pin is in use or not before printing configuration data with the help of 
gpiochip_is_requested().

index fef0970..2ca1440 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -579,16 +579,20 @@ static void msm_gpio_dbg_show_one(struct seq_file 
*s,
         seq_printf(s, " %-8s: %-3s %d", g->name, is_out ? "out" : "in", 
func);
         seq_printf(s, " %dmA", msm_regval_to_drive(drive));
         seq_printf(s, " %s", pulls[pull]);
+       seq_puts(s, "\n");
  }

  static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip 
*chip)
  {
         unsigned gpio = chip->base;
         unsigned i;
+       const char *label;

         for (i = 0; i < chip->ngpio; i++, gpio++) {
+               label = gpiochip_is_requested(chip, i);
+               if (!label)
+                       continue;
                 msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
-               seq_puts(s, "\n");
         }
  }

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
