Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD869C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C892183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpCUVwn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfAKOV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:21:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35767 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbfAKOVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:21:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so10921749lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enPHFx+y8o9yYHCTzjTk9LyXO4vNmWSgfGtOdNSIEqA=;
        b=FpCUVwn37X1RV2pIH33nrrlnUmE17n1BSO9ibak00msAxPT4KcXpW1IXR0FkxHmnH7
         z5hdGxxvsKndIceSAS3aolDEfMkYt96mCoV7tylkMO5oD3nXqHEIEU0+smf+NwR9x5Rv
         6jaVqvqEmfkz8kbID8GMzcK6uFbp9Ewpgk+dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enPHFx+y8o9yYHCTzjTk9LyXO4vNmWSgfGtOdNSIEqA=;
        b=FKUctn2fP1+8oxBY3NnfrAVV6JU6qk65FRvyT2CNWwg8y3YQl7c8ZDAHRkFWo/ezoI
         QtymLc6DgQRET1ut3Wq1wL2jYHti/you3WA065yrt+kICHXd4Pa8q1UU0whWTD6xm1x0
         4OGh0SSbprnMynMoumAJX3k6UidAE5n7KaHzZs07YNwqTmaMkIs4OhwwqvBPGOGOh8Qi
         wzkIphxdl8IAk0vi+JhvB4U2nCsqXorczXfSvEimOKhqhbMO2/+IB3CwuRHEBfonFGXU
         gqqYgbz0Xuw+oNYvskaBSzQjIclz6H4nW457N3j7QDo3WgT20yexTKzNHjmsfGx9jOgC
         RmGQ==
X-Gm-Message-State: AJcUukeVW1cOqLbsfPyG+ool5jPAnpKWbCkHNuclF5wrEWzbC7YjTBYV
        prvtqgRKQHF5vAwoQBpFqDHxvITcz4RAz87hl8WFRg==
X-Google-Smtp-Source: ALg8bN4tNpde0dSO8cdYxZe2WTqchIb1xRBQQy2tPzwV/zabltpqy4PPafIFjm/Qjg1nSuTrSI7e0MD/E7EYRtMbty0=
X-Received: by 2002:a19:f813:: with SMTP id a19mr7881853lff.67.1547216511510;
 Fri, 11 Jan 2019 06:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 15:21:39 +0100
Message-ID: <CACRpkdYgBsvNR1PFuzmMegpjraWRi58ACb-=mBrUDvLoi_5J_g@mail.gmail.com>
Subject: Re: [RFT][PATCH v1] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 7:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> New quirk enforces search for GPIO based on its type.
> Note, supplied index in the mapping table must be 0.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(...)

>  sound/soc/intel/boards/bytcr_rt5651.c | 74 ++++-----------------------

Do we have an ACK from the maintainer of this file?
It's Hans I think. Ideally also from Mark Brown.

Yours,
Linus Walleij
