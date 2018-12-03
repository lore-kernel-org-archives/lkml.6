Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BADC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D41206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZXUxv+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D41206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLCHyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:54:54 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42396 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeLCHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:54:54 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so12674019qtq.9;
        Sun, 02 Dec 2018 23:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrSGmEmCmctVABvMIJ8SgSrl/TKDAGeiz9gzxzRolcU=;
        b=DZXUxv+fL66pObqWqMBlJIbJ1cmfv9QMNw+v3d3cn16mvCzyY9FYhUJtIzLNlIyUvk
         aZ68XlnM1TgAY8tKBDpOyHRlkCvrRPKiJuyRfqpx9VEJNBcYgqwQNoZWBYsxwDeEUBgJ
         T7WWljO6/raQDGy0+j41uzMO43wpge7PYasM2dKJIUAy+wU44CS6PAISDIIpcvDFIsyQ
         feHxndWFnkc2KZnK9pLJ4afEB5FSXnmewqzWtMnNFqhhFx+H+AxogXSMebYRGUJWHlPM
         MbS0S+ZxlFhY/MVX3oP7Fvj/cFAUuZMj/zNyd4HrjuGYfhHVBLw2rNAEHwhkcfQk4Q4R
         s5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrSGmEmCmctVABvMIJ8SgSrl/TKDAGeiz9gzxzRolcU=;
        b=nvJbR0cNLXD7gnbqqw6TLdH9fa/mt8c95IjQ1PUA09K0OlmdB5YRLsowusOAdxBu97
         9+DddwfqgzdQkmqdCIsdf437y+yMzSmGrc23TBT12WptXC77Dfm2tVJJf/onKzQD9BsT
         YKtIbQVaBdDMJTCiUiqcguQnexuTUhF1ArOeojZHWqGmqKjrraD7r6lAlpMetC34PmBN
         jES51A88R0pPNjWSBnAUCP4U4XljsDG1n0UDI6tbObAZkjOh01AxDg8tQMEHSzwbD1Ai
         J0fOAlvAToHTTk5ER9b95nGL/gMTFxl+GCSyvALqY/GUrsfMz+j0bkdVP3SmCZyVsaC6
         RYFw==
X-Gm-Message-State: AA+aEWaC+NUukxdl3rOXzM0lJxW1yCW4MngYMhFRsVw5zW5fmy4O1+JB
        giDHVTGC2pqFA1v74g3N3S89nJNtISn8v/+K/QM=
X-Google-Smtp-Source: AFSGD/X0pdnpmyCILjdCPYTnh8KN0uqkin0YivVYE7iHBjO5/rnb9GX60IZPwiYqYTVMBu+nWmEGDeIYmW6uIJa1ot8=
X-Received: by 2002:a0c:c2ce:: with SMTP id c14mr15177923qvi.7.1543823691629;
 Sun, 02 Dec 2018 23:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20181116162403.49854-1-lkundrak@v3.sk> <20181116162403.49854-7-lkundrak@v3.sk>
 <20181202231328.GB23087@wrath>
In-Reply-To: <20181202231328.GB23087@wrath>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 09:54:40 +0200
Message-ID: <CAHp75Vc9pbj-jTQ86qV54FDtxzzoY-vvgH9qtvoFWWY1JQOMew@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] Platform: OLPC: Add XO-1.75 EC driver
To:     Darren Hart <dvhart@infradead.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 1:13 AM Darren Hart <dvhart@infradead.org> wrote:
> On Fri, Nov 16, 2018 at 05:23:52PM +0100, Lubomir Rintel wrote:
> > It's based off the driver from the OLPC kernel sources. Somewhat
> > modernized and cleaned up, for better or worse.
> >
> > Modified to plug into the olpc-ec driver infrastructure (so that battery
> > interface and debugfs could be reused) and the SPI slave framework.

> > - Count the terminating NUL in LOG_BUF_SIZE
> > - Make olpc_xo175_ec_is_valid_cmd() return -EINVAL instead of -1
> >   on error
> > - Spell keyboard/touchpad in full for CHAN_KEYBOARD/TOUCHPAD messages
> > - Use a #define for PM wakeup processing time
> > - Log a message on unknown event
> > - Escape logging payload with %*pE
> > - Replace an open-coded min()
> > - Correct an error code on short read
> > - replaced PM callback #ifdefs with __maybe_unusedm SET_RUNTIME_PM_OPS
> >   and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> > - dev_get_drvdata() instead of a round-trip through platform device
> > - s/unsigned char x/u8 x/ in olpc_xo175_ec_resume()
> > - Use GENMASK() instead of 0xffff for the event mask
> > - Replace cmd tx/resp rx buffers with structures
> > - Turned suspend hint arguments into a struct, and tidied up the comment
>
> Just from these comments, each of these could be a separate patch. You
> can group related things together, or those that change the same line or
> function for example. Order them with cleanups / non-functional-changes
> first, followed by functional changes.
>
> >
> > Basically all of the above is based on the review by Andy Shevchenko.
>
> Andy, what was your intent for Lubomir here? From the above, this looks
> like it should be several patches to me.

This is a new module, I don't see why it can't be one patch. For the
existing code I agree with you.

-- 
With Best Regards,
Andy Shevchenko
