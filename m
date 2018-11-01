Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A276DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A50C20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="etJTYeH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A50C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeKARJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:09:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36108 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeKARJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:09:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so587590wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tUR4IQpwICYxhBQ67901PfibyZIwe2MECcAPe6a+XmM=;
        b=etJTYeH+4AjaKJzDStByYP71fck6hVC5zMKFZtcdLmInvthbOYC2e6hWtcfiq57d5A
         VGfmOxdyPS+MjXhh1pZhKmMKOz5XZtfPdVcBcLG7T4RXxJ3256EJRMmOhJlbrw8dSRzc
         MkHje3vXX4DzC6/haX/t8QM2Q0DwTjOp7Ewag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tUR4IQpwICYxhBQ67901PfibyZIwe2MECcAPe6a+XmM=;
        b=Vblf0oo4kPfFhLg2AmtAgE0NhCEElHToujxHTl3baEFHhUXW3thxsMEaCbpnAk7BKj
         pWsU7AExwAJJuTRmzjJN2JEyP1rX41OaVZUNG0UmCjpGgcwvlQCN+oYUXSlJeyt2U7x2
         UD8yYinXGWiUwdOnDuekj8qfnsVLxyhPDtuK6vjT0Ud4UHGnT82fIV7sDYT41LDksIzX
         THme2vF4ZN2TB+W2rzwLRdLx386L/w/nBdlncMmKuvx+sZP1F8QKnf24y7jjj2OMw2iN
         6HUIKiJWxk6AfdF1Uu90G0hzl+RA8/ON7E7RQs6d1xKh7lij4Zuqjd/+X1ktTQ/JgwQe
         i5DA==
X-Gm-Message-State: AGRZ1gLW9ya9S1hFNg4rztkZg2LPlA9b5w43zLu7oR4yD0vedBQOSci2
        N9MAXxD8czS/Oz8O5IuVHGjYLQ==
X-Google-Smtp-Source: AJdET5fv7p3c6fsZQ5W36rSM6w5hZiw+YvrIyhad4xHdEtv4tpxwxWJT77vHeJlDhuDaHuoaj/+mWQ==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26-v6mr4885898wma.82.1541059635089;
        Thu, 01 Nov 2018 01:07:15 -0700 (PDT)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id z6-v6sm6842165wrs.19.2018.11.01.01.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 01:07:14 -0700 (PDT)
Date:   Thu, 1 Nov 2018 08:07:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v3 1/3] mfd: upboard: Add UP2 platform controller driver
Message-ID: <20181101080712.GB15973@dell>
References: <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1541018689-20625-1-git-send-email-dan@emutex.com>
 <1541018689-20625-2-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1541018689-20625-2-git-send-email-dan@emutex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, Dan O'Donovan wrote:

> UP Squared (UP2) is a x86 SBC from AAEON based on Intel Apollo Lake. It
> features a MAX 10 FPGA that routes lines from both SoC and on-board
> devices to two I/O headers:
> 
>                                 +------------------------+
>                                 | 40-pin RPi-like header |
>                          +------|         (HAT)          |
>                          |      +------------------------+
>     +-------+    +--------+
>     |       |    |        |     +------------------------+
>     |  SoC  |----|  FPGA  |-----|  Custom UP2 pin header |
>     |       |    |        |     |        (EXHAT)         |
>     +-------+    +--------+     +------------------------+
>                          |
>                          +------* On-board devices: LED, VLS...
> 
> This is intended to enable vendor-specific applications to customize I/O
> header pinout, as well as include low-latency functionality. It also
> performs voltage level translation between the SoC (1.8V) and HAT header
> (3.3V).
> 
> Out of the box, this block implements a platform controller with a
> GPIO-bitbanged control interface. It's enumerated by ACPI and provides
> registers to control:
> 
> - Configuration of all FPGA-routed header lines. These can be driven
>   SoC-to-header, header-to-SoC or set in high impedance.
> 
> - On-board LEDs and enable lines for other platform devices.
> 
> Add core support for this platform controller as a MFD device, exposing
> these registers as a regmap.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  drivers/mfd/Kconfig         |  17 +++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/upboard.c       | 336 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/upboard.h |  44 ++++++
>  4 files changed, 398 insertions(+)
>  create mode 100644 drivers/mfd/upboard.c
>  create mode 100644 include/linux/mfd/upboard.h

Looks like you've ignored the review comments here too.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
