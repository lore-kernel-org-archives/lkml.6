Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0ECC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59389214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFPWtYWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59389214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeHVTwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:52:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44208 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVTwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:52:21 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so4135878oih.11;
        Wed, 22 Aug 2018 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/IOhb7r4z7zWuIjEz6ym+awQzrWrwQIZPjGD84tB0hI=;
        b=FFPWtYWb7fENWhaSTIQK/S4RuSBUNFs6bu/LNmK3bLxdniMFMNL0da5atJeKeB4i50
         T4W8jGcRQQcD/SdaYVCTsgeUycnwblEObg1oD+feJYhCuYoD5zpmAyhGJ/fLWJz6OjwZ
         2Dt5OS/mii6uLETZ+rqECkYNsOaQ+1Q+AM65y/L/Pz6lk0pAslne/9he90j2oZduJ61k
         NZEx7ANfaVeD7IgekdnbSiz1CXWMzz6N3W/iMvAulHtfI0Qoeh857ayctC2j4rqtwCsb
         glW3MZ2+EASbTOhsrMUptHzrj+KL7BIaL5EYBlyqzCRb7H3/EIHwtUI9cer1ZQk4a4GY
         3vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/IOhb7r4z7zWuIjEz6ym+awQzrWrwQIZPjGD84tB0hI=;
        b=gZKerljxtfyq82OoGuuZ5b47RCTI4fl96XdLT5Q995fOq7QylFpGeZkuhrOLpECuhJ
         BOj3Ie02KPHpPBRp+T7VUj3PWb4h7GkoWGt1zGvzxEdVslYFEGB9ywmnswiOTh5dX4y/
         h6zGL5qwYS1kGCMPVOlQZ/zuurOH67+YmqMZ9jHMTIsxHsRiu292rhqRtK5/noqTBQVD
         TLHTZZMwWNSOL74wqjDbE8fcTh9FcnoQgV+FGHyXrd/KJo3bVe0W2c8qs12Cyj2dhAoU
         Ls928whUWKX4P0xVoN3vKGbxRMiG60ZBfF+6DY01CMphkz5oWQl0T4gqiBXVErDRazEQ
         bgyQ==
X-Gm-Message-State: APzg51CABkInBVP4sOr81VdSnvF63Pl/84hKb7quHKJQojPV3U0a+1p/
        FJj2jVOBKihLH/Ku/J1t3TD26//xat0Henlc+q4=
X-Google-Smtp-Source: ANB0VdakZ5uTz8TlRei222kXPA8Bev/UOFurT+/4T2xkHGtTGK+AL+4i6UqyDsJHbqPm4XsJY/8Q14dKQBSFJz/Kgqg=
X-Received: by 2002:aca:d986:: with SMTP id q128-v6mr4395579oig.349.1534955208163;
 Wed, 22 Aug 2018 09:26:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 09:26:47
 -0700 (PDT)
In-Reply-To: <20180822155137.10018-4-jan.tuerk@emtrion.com>
References: <20180427132445.3458-1-jan.tuerk@emtrion.com> <20180822155137.10018-1-jan.tuerk@emtrion.com>
 <20180822155137.10018-4-jan.tuerk@emtrion.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Aug 2018 13:26:47 -0300
Message-ID: <CAOMZO5Bb=T49ZOfsc+LbUKM8iRH7GAFkKyFMT_FCfkT16LDdDw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
To:     Jan Tuerk <jan.tuerk@emtrion.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:51 PM, Jan Tuerk <jan.tuerk@emtrion.com> wrote:
> All recent emtrion modules based on i.mx6 make use of the DA0963.

s/DA0963/DA9063/

In the Subject line there is also the same typo.
