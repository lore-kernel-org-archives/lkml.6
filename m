Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE2C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A730F214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeLZLCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 06:02:05 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37447 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 06:02:04 -0500
Received: by mail-ua1-f67.google.com with SMTP id u19so4994077uae.4;
        Wed, 26 Dec 2018 03:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9djZcI5bEEy+IbSNFLtmKFWQfpa25K2OdZiC9sF4BpY=;
        b=AT7pyyGpBVQSXW3la34bf8dV9nAdA/LQG/SXkILO9j007Y8YhnSvvpnDWPHwzqOx+Z
         2tmK5fiywrOs5/2U8ow3YRyvN5fo4pIHksp0DnRUlicqhzlpbaqm8/6u7Sjz0fzChE3Q
         BY/SyIcqdwuWNAdBlLDv1SbjLRcsZ+PX55ro0kLLIuXUyxVHoAGZyLS8t7cgsjsaiBUS
         GSCg/91hgfhDa2EaC35rgVi18cSHTUgiI0ZBGUw+eHMr/cSPMSrHPbS0SduCwd9W3RkL
         hQvraWpbWehAHRz0X+EXvhu09AapLpCCpiWz5KGtBttH7I9Z6gM1Kmi9R1C1n8YH7xcB
         u/eg==
X-Gm-Message-State: AJcUuke0O1eEWsUz9/PLnMD5Tj0yqu1Ss+SkycGD7+jTnbG2tsftZBvj
        nI5T5zwgf43oy3tPdB0wVWkNHIe1VZCgehRan+Q=
X-Google-Smtp-Source: ALg8bN4dY3RFRB0xxPZNhEK1cKXLjg9YhmGjgKsCFIeRNeLcG1BR6FmDe5G9GqqBSPQKHOqMzvjjAG09qXfvZQINvDQ=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr7021867uae.75.1545822121736;
 Wed, 26 Dec 2018 03:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Dec 2018 12:01:49 +0100
Message-ID: <CAMuHMdUyxcYcT7uAhsQ0xa++yzi3TnBhNS90O6Achz3KD6E4dA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] i2c: move handling of suspended adapters to the core
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Sat, Dec 22, 2018 at 9:26 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Here is the new version without specific I2C helpers but using the
> 'is_suspended' flag from the PM core. I didn't like messing with the
> flag directly, so I did a helper in patch 1. So far, I like the
> approach. The diffstat looks nice, and i2c-rcar.c and i2c-sh_mobile.c
> rejected rightfully too later transfers without further modifications.
> Tested on a Renesas Lager board (R-Car H2).
>
> I dropped a few Tested-by tags because I think this approach is too
> different from V1 to keep them. I hope you guys can have a look again.
> Thanks for all the testing, so far!
>
> A branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/reject-when-suspended
>
> If this series is acceptable, I'd suggest to take it via my i2c tree
> after rc1. And then I'll provide an immutable branch for the PM tree to
> pick. Let me know if this works for you.

This breaks resume of the CS2000 clock driver on Salvator-X(S) (and
presumable ULCB, too):

    Accessing already suspended I2C/SMBus adapter
    WARNING: CPU: 1 PID: 1186 at drivers/i2c/i2c-core-smbus.c:551
__i2c_smbus_xfer+0x38/0x66c
    Modules linked in:
    CPU: 1 PID: 1186 Comm: s2idle Not tainted
4.20.0-salvator-x-08442-ge5992c41ac706409 #264
    Hardware name: Renesas Salvator-X board based on r8a7795 ES1.x (DT)
    pstate: 60400005 (nZCv daif +PAN -UAO)
    pc : __i2c_smbus_xfer+0x38/0x66c
    lr : __i2c_smbus_xfer+0x38/0x66c
    sp : ffffff8013413880
    x29: ffffff8013413880 x28: ffffffc6f78b4820
    x27: 0000000000000010 x26: ffffff8010cf6178
    x25: ffffff8013413976 x24: 0000000000000002
    x23: 0000000000000016 x22: ffffffc6f7872088
    x21: 0000000000000000 x20: 000000000000004f
    x19: ffffffc6f7872088 x18: 000000000000000a
    x17: 0000000000000000 x16: 0000000000000000
    x15: 0000000000029c80 x14: 0720072007200720
    x13: 0720072007200720 x12: 0720072007200720
    x11: 0720072007200720 x10: 0720072007200720
    x9 : ffffff801100e6d0 x8 : 6461207375424d53
    x7 : ffffff8011c825c8 x6 : ffffff8011c82000
    x5 : 0000000000000000 x4 : ffffff8013414000
    x3 : ffffff80134136e0 x2 : 00000046ee875000
    x1 : 82c6d7c720d64000 x0 : 0000000000000000
    Call trace:
     __i2c_smbus_xfer+0x38/0x66c
     i2c_smbus_xfer+0x64/0x98
     i2c_smbus_read_byte_data+0x40/0x6c
     cs2000_bset.isra.1+0x2c/0x58
     __cs2000_set_rate.constprop.7+0x8c/0x134
     cs2000_resume+0x14/0x1c
     dpm_run_callback+0x15c/0x2d8
     device_resume_early+0x98/0xec
     dpm_resume_early+0x3b0/0x454
     suspend_devices_and_enter+0x7bc/0xbb0

The CS2000 driver uses SET_LATE_SYSTEM_SLEEP_PM_OPS().

Suspend/resume of the BD9571 driver works fine, as that one uses
SET_SYSTEM_SLEEP_PM_OPS().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
