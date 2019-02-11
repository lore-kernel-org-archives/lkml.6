Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4147821B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549893119;
	bh=Si2EORoumwTMHF/RZaWkz0+WLMhSP0DdIkNxKy2uzOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qjiTnM43mJ/S8dtVg4OnndAZ9yrKbKVW76CKPu1JNzAcN/80d8H2tDwcVrDCl6MzN
	 kGBWBZ0TkQYMXkLn0S/DUwIzsnf16VJGkXmerOBSgofbnbZS8KhUT7YxTdtuSWE6KG
	 5VvDDGI87abnfSZJXPKGNRrO+FfcL35ZvgQIaxyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfBKNv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbfBKNv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:51:57 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F456222AC;
        Mon, 11 Feb 2019 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549893116;
        bh=Si2EORoumwTMHF/RZaWkz0+WLMhSP0DdIkNxKy2uzOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XctpyHAImyEEpcRS7GJmBLaNy3wpnhUfKBfS0Dn4mCxMN+zDLKpUgJlACMzD4cdwG
         IKVQGrSAsKItV3WNx2ShGw03fYX/PcrtiD2bX4ea03S2ynJ7xYicGGiL70T0EAov8z
         gSFb/VTFihHydC9N4lWm6t5fDLbIfydo2ISIHQr8=
Received: by mail-lj1-f182.google.com with SMTP id e17-v6so1894267lja.8;
        Mon, 11 Feb 2019 05:51:56 -0800 (PST)
X-Gm-Message-State: AHQUAuZwF9jjCedMILU0euSipRgJET3D5gnKHTC1Gc0W2XliYBBLforL
        ayPtZV5mn01XrSl7bqCLp+yRXSnQRTy/3e+J8F8=
X-Google-Smtp-Source: AHgI3IYcA9KYqdj7cmcNsU0nqoMI6NIgEVs5hgCTVIhpmklK29A+NX6CdZ64PwQ89phO6PMCLaZ8L6aolXh/h6D6wSA=
X-Received: by 2002:a2e:999a:: with SMTP id w26-v6mr13933575lji.169.1549893114512;
 Mon, 11 Feb 2019 05:51:54 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170141epcas1p29a038bfd0df69df10e916ea8a695a85b@epcas1p2.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-17-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-17-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:51:43 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfPO_4=8p_EQ7zf-x6Ty3CkibysVW1HoqzcjxAmfQv_WA@mail.gmail.com>
Message-ID: <CAJKOXPfPO_4=8p_EQ7zf-x6Ty3CkibysVW1HoqzcjxAmfQv_WA@mail.gmail.com>
Subject: Re: [PATCH 16/22] ASoC: samsung: i2s: Get rid of a static spinlock
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 18:01, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> This patch makes the spinlock serializing access to the primary/secondary
> PCM a per I2S controller lock, rather than a global one. There is no need
> to have a global lock across multiple I2S controllers in the SoC.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
