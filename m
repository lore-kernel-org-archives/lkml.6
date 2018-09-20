Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B18ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CD821526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHEnsRQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CD821526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbeITVRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:17:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40583 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeITVRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:17:22 -0400
Received: by mail-io1-f66.google.com with SMTP id l14-v6so7739332iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HylYz28m2nx/QMAXHpp6zM2fvp38YUoBEEQ93LCIKXU=;
        b=KHEnsRQPbkWURLASSvSW4NbwutDGw0IWdG+t61HDieRpqfaeIcW4Q1cwZHomZhfww+
         5u5SH0i6dOJsPad9C0pkVsFqxJBH8ceYgvjt45Lj3a0WwKd55WY1DoblkQt13TCgUHLo
         RqVNZSnpxFpJghKHf7M07OecDvVNhSGgslwlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HylYz28m2nx/QMAXHpp6zM2fvp38YUoBEEQ93LCIKXU=;
        b=IIK6ImmxkAkV1cHKdk5Olk8yR9/LSIpCZYl7IrRpGvJX0BmQQY67TH5fyVhcuOyxGJ
         aIyEtBFrkxM0IKg5CtMz2Ggd+qxZvyhZD/UUhPjtKYTQEV5lcPNA2KGsY01EuM0AE3Xw
         dLovh92vZKpkHqliGxpsT1scSFlOQRshu6+kMHL/01cg7l2KaOyjprkDI0tcqXKaw6GO
         C8fGKicJPistGKfXq1RWxOwgG2t45r169U20+UdZxzrhMMTHPb0X+ySw0IlKTTFJ4cTA
         InIhW4JcDLnwmycXl5x+u5ZTv67LcyHIAAiJjXiS1t1AoM0qPuzE0KhdkIuAKto8BtmE
         C8Hg==
X-Gm-Message-State: APzg51A7UJX2efC4/ehJ2j9UO6EJQ61nwHx0JX4i7B+W7nY1FUCnSUds
        xnKiy46RGbHWOGpCMrko4npbPFlon886whJohdPFBg==
X-Google-Smtp-Source: ANB0VdY40CEyxsaM+sI4rW3GFGlkRyxLsOIqqyxskn5fDuz43eXr+iVt/xF8B6e8HffB1PMBSp6SwnUHaIwxR1UIxmo=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr21220438ioa.277.1537457600156;
 Thu, 20 Sep 2018 08:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180909225605.16463-3-jmkrzyszt@gmail.com> <20180919221729.21179-1-jmkrzyszt@gmail.com>
In-Reply-To: <20180919221729.21179-1-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 08:33:07 -0700
Message-ID: <CACRpkdYcVmL=3VxfcW9O5TAGKMaEvt2sPFdHgd8w3-8XUdY6ww@mail.gmail.com>
Subject: Re: [PATCH v5] mtd: rawnand: ams-delta: use GPIO lookup table
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 3:17 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
>
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents.
>
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Changelog:
> v5:
> - rebased on nand/next
> - resubmitted to linux-mtd as a stand-alone patch

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
