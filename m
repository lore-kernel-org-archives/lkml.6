Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAD8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1F920811
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CBqA5Wrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfBGD6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:58:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35564 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfBGD6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:58:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so4177013pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 19:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4vE9BU00uVWm07pHSl9XmaBqTKJTzMk4dRaKirmkAwg=;
        b=CBqA5Wrr5nQY0/io8LQVu2pwnh/AIGUtm3+pmy7XdGF2oStq4rizz1j9etGI1NO1Zn
         XURTlghKfEjPqbAnIqd0hKGTfRW+xUZkz8k7qrY4KtEDxMTb+Vr3LcTu4TESmgHD4WO7
         B8A5knEHG7wGmXGSBYchv80nJEPyX3aEen/9nb6AZRzBm0Ji3t42niAONu1H8MPo3BN5
         nDh4lD+hhOLwCwzBctqmNUOv2Dh8JtJQq2XlHKZsWOw96fIeHxlJ1BDSCcBN8YPigmAr
         BzpHDevJ1BPrAKUfbZjxz2j7n2AR8cBC2mbfKPXw4Yoei3/ahP60xJvYpJvwyiBtcgcC
         irlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4vE9BU00uVWm07pHSl9XmaBqTKJTzMk4dRaKirmkAwg=;
        b=NEDQPsR2Rfoxh2KiN5EajB7Qv3qMj3vNtz/abZiz3engN48H9lplmlTDGiYdQr5z/3
         t1Lu6CPbC+zyf7KH8AordGUI5HDvpXkUcsPuDPAdduIp0NdB87jdzoIKLcKfMXF+pReh
         LbIwjKrszzn0WqYd1stJHp2kQorYks4Z1WACyO104i2z02ecvNDwx83y/dz1XcpZJmcm
         YSWmXd1mXQ+bOJDpVyJLzXglnVU7QKQr4fmyGa+lDj6AbEvrWdAh7giS+ECmwnb9/655
         nl/og5qsO/YAiuLi+RmQvatuZW6I9wanKRB8bvz5jwgYar6wpbz2otNYngeWgcFNSXle
         gI6g==
X-Gm-Message-State: AHQUAubVWxf5Q1EcAazCg3VCG8XrQV3EEXa3mMO2lw+JLggOUpekZE0H
        HV9oo4CZRbYIP6gS7VcUlcq2aQ==
X-Google-Smtp-Source: AHgI3IaFp5sgEjJOCrn46BYjHmUjilzFj3AdOVe9WGP1fBe+lpzmN8tIosQ11mVSNyJcFcSb5SlsPQ==
X-Received: by 2002:a65:4784:: with SMTP id e4mr3129018pgs.12.1549511886237;
        Wed, 06 Feb 2019 19:58:06 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id d3sm9706256pgl.64.2019.02.06.19.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 19:58:05 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH v6 0/4] clk: meson-g12a: Add EE clock controller driver
In-Reply-To: <5C55CDCE.9030502@baylibre.com>
References: <20190201145345.6795-1-jbrunet@baylibre.com> <5C55CDCE.9030502@baylibre.com>
Date:   Wed, 06 Feb 2019 19:58:04 -0800
Message-ID: <7hbm3ogshf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Le 01/02/2019 15:53, Jerome Brunet a =C3=A9crit :
>> This purpose of this patchset is to the main clock controller of the
>> g12a SoC family
>>=20
>> This patchset depends on the recent rework the meson clock directory [7].

[...]

> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> I'm applying these to next/drivers for Linux 5.1-rc1, is it necessary to
> have a tag for the headers ?

Only if we have some users that we want to merge in the v5.1 cycle
(which I haven't seen yet.)

Kevin
