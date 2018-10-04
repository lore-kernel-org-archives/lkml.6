Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2B0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C755321473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4fXPgq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C755321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJDP0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:26:23 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:40689 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeJDP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:26:23 -0400
Received: by mail-io1-f44.google.com with SMTP id w16-v6so7226833iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/WUmzkdF/fk4ktL33DmDmI0KxA3V7GEhh9xis7amoM=;
        b=P4fXPgq/JhwUfpIhImG/08BZV5FTR/HDqDMiLFFhd0UToAVUVmrhbGpF54texp90eb
         HzPGG4lnjqj02Fistx9oE7MFpHsg4UwJQ3oDDs8Cmz8hbuKBPfEhvghXckjY6WYvJGAb
         QjgA8Q9osldhAGEzgLqbL0Uc9pm81HzLIzM74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/WUmzkdF/fk4ktL33DmDmI0KxA3V7GEhh9xis7amoM=;
        b=I9lIGLch/XXOkj1eFheSH6Z7gmk/JhsxqwYmyrKbZyw3LBfgiVBaQvCTpH++sfo7C0
         aWq+xhDVpmx5lerShqn+oAA8wY23fiWHuJjvW0SJCysQLL14F4dGygfBAJkkkDsAYOcH
         GqkAFVCreOIMUsp2R3DOmVeNYsGzgpygZuejdc1HuYbEVt31dw6kKiIVyHsDAqlAPmRP
         rzQugswXZ9CCfRAoRKu9AfT9gCiQPKY00QTamShFo+jtSdUGxcNEK0w9fWUb/64/Qzr5
         4WYmZRjk3jaIDcPoKWomx4QWliZQluwfr53hDia+14Hcw8sYneb/fr1k2a3SFsXflkEw
         qIew==
X-Gm-Message-State: ABuFfog9k0QxUY7hOhxj+ZbbRt4li5l727qPar1qPiXZ/x+t8EUk8kmj
        WE18HLuQidWUKF16x/3KSHl49Kt9VEx1AFE/YJRimQ==
X-Google-Smtp-Source: ACcGV61ntl8Rn9gGqrgo/P/ZaaMdhLNKvAHpJyJTv3shwsBscKfo87ky2hboxD+1Du0G9k7wzyc1yAVx23sPMH2i9y4=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr3738422iog.175.1538642054940;
 Thu, 04 Oct 2018 01:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <9aec322678417753fe4022691f4bfdbe@codeaurora.org>
In-Reply-To: <9aec322678417753fe4022691f4bfdbe@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Oct 2018 10:34:03 +0200
Message-ID: <CACRpkdazxOt0E0J8D763_Mc5RVxpYTrfNgHYkMVQB+GVi1S9Hw@mail.gmail.com>
Subject: Re: protected pins and debugfs
To:     psodagud@codeaurora.org
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 2:38 PM Sodagudi Prasad <psodagud@codeaurora.org> wrote:

> This is regarding the protected pins configuration reading and printing
> from non-secure operating systems.

I do not think anyone with security in mind should have debugfs
enabled. But maybe that is beside the point.

> GPIO framework is checking whether pin is in use(flag FLAG_REQUESTED) or
> not in gpiolib_dbg_show().
>
> If GPIO chip drivers are overriding the dbg_show callback, drivers are
> not checking whether a pin is really in use or not to print
> configuration details.
>      if (chip->dbg_show)
>                  chip->dbg_show(s, chip);
>          else
>                  gpiolib_dbg_show(s, gdev);

Ah that is right. Because some drivers can inspect all pins whether they
are requested or not.

> Can we use a simple/common solution like below?  It will check whether a
> pin is in use or not before printing configuration data with the help of
> gpiochip_is_requested().

In the msm case I think maybe you want to inspect the valid_mask
instead, so you display debugfs info for all pins you can inspect
in hardware but avoid the "invalid" ones which I half-guess is used
by ACPI in your case.

Yours,
Linus Walleij
