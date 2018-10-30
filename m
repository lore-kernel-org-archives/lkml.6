Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D41BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE36F2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7NtfVHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE36F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJ3WFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:05:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42002 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeJ3WFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:05:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id f3-v6so11289913ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vl0HyFr3dq0xQVM/zfnWXgc5CNEk/3xLwfWTWcjCfpM=;
        b=W7NtfVHt3bBDIuNjvD21RQOjjQq5qApO+fAPTQC0xY3qhcpYAw3BCZ8b0HElMGlJsP
         d29JydY+h/AOCJidktxkgJonZ4OpSpvjl+i+xhANxNm20+kzGq1Ae0v7EmgRaPINDxyE
         h5x9kjlBovtxlPpHBI+EvmR0ZyqYab8sMK9VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vl0HyFr3dq0xQVM/zfnWXgc5CNEk/3xLwfWTWcjCfpM=;
        b=LmBlbNaQPhqgd7ET2CIqc+BB2hrFnGlMaqABzBFHINtUBCMb0ga8QV6Ar13jTcqpki
         8CfMf7Gpp3AQZIWwAGv6a3s4Xi+vEdkjofvTD25m7ICSf8QTBtq6Hl1XTTfoGaBA9y21
         qBL9dMX90S/6kr7+vn2UTiRnPvcolHLUh3T0qRUjA/ccEPh6WmHQiu9dwcDw8L9bMkKL
         TRr+BOJKaTM5l0YLyZknNeYE68LB1DnnZ868IE9xy5zfegZUVzKHV/6XjrStJ9tAzSye
         HkDdgjqu+MZBHdC7Xs0hV5J3VMvxtruK03l1HhirLbaVN6YLVpeQq96QCE28H1dH/h8B
         0EYA==
X-Gm-Message-State: AGRZ1gLllRn5TxwALZAdgyCEYM3EXeQCI3QffDIQ/TAFKG82b/LQi0Z3
        l1dYOAvSdWscx9YAKIgArfDUC+99owUKcOOAN/cOxA==
X-Google-Smtp-Source: AJdET5ep5UtXupS+A46j4VxkOqI1D4iNjKKFJCSiapPlV0Q/Fuk6cprTaNfF1a4ri3RKh8hesWUaRK6cBToRvOhJk+c=
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr6689100ljc.120.1540905149686;
 Tue, 30 Oct 2018 06:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com> <20181021200002.1472-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200002.1472-2-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:12:17 +0100
Message-ID: <CACRpkdaU8_0G5zmiXHpjLzvKQXUuqY_A0XUkGV0jOWaCfok8zg@mail.gmail.com>
Subject: Re: [PATCH 1/6] gpio: gpio-dwapb: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Hoan Tran <hotran@apm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied for v4.21.

Yours,
Linus Walleij
