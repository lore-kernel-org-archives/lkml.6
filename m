Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7377C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F9626618
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZgoHoss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F9626618
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFZHdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:33:49 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51478 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeFZHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:33:48 -0400
Received: by mail-it0-f67.google.com with SMTP id 128-v6so839323itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7EvucRpwFo0YlzzBs/PE2D4RLsvRqZn96d0dR/qlWI=;
        b=dZgoHossziaJkSlcns9voRDJcFQTzbKjFe/Z2P4h5HAsopw7Hr08uItbRXUgTJ/Xou
         OFaKvdEPXbgrY6fiCn4ThCAXvdYGQBsTq09XDioo19KcwNmtinom87Gl1gORP+OmInzo
         dVOFPK0dj3yHIREJYPDrywzf4AHwK9z+DtXPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7EvucRpwFo0YlzzBs/PE2D4RLsvRqZn96d0dR/qlWI=;
        b=TXFmRwyMfwBXWdCeftGdynVFtpZjyU+ogc0/niOGJWdfTpN59kID8neHMpuPHbaDL7
         C4LcdRm9zAqwz43trc8jub+4rrRnkUFZaEq6c4s7TgvfEBtclCE8pGBTb8tM24HIOj9W
         U96HXnfBgmnX65LoBso7qnph6YUoFkMZ+t+GsbC26X1xWLnDXk9IfRlijB5CXfZKC603
         3fDeFvlYZY9X5/toSGiDCtHQSlt7P/tx/o7FbDkAYpfPRf9GOJ5WK5rnSlKXOmdZADE1
         iDeNfcnZ+J5MpgRpZj5Xx7mwDjq6ybwi8Q37PdD0cQ1Zz1V3YXpJAESu+LDaiO5Q+2hT
         p3Hg==
X-Gm-Message-State: APt69E1PdH4YPQ1n9IUZ4P/G4QRN72rlLjsa2TvUEQFo7GEAU2mdmzzB
        ivsNmhSj3GbTL7dQ5i30Cq7k91zreLlgbo/Pvz03bG+z
X-Google-Smtp-Source: AAOMgpey8vandYy8Y2no0MfAyvYAYk6OxErYhNZauKgoxZQrTbYGRmNUp6gwzb5qkEHIvWngHCKI7Y6EdQ2jz4PHk0c=
X-Received: by 2002:a24:5746:: with SMTP id u67-v6mr540508ita.38.1529998427736;
 Tue, 26 Jun 2018 00:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180621185442.17086-1-geert@linux-m68k.org>
In-Reply-To: <20180621185442.17086-1-geert@linux-m68k.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jun 2018 09:33:36 +0200
Message-ID: <CACRpkdbCBO3mgPm3czUvBMqrFHvxDqkmfKH9v2X0UMypjjOe_g@mail.gmail.com>
Subject: Re: [PATCH] w1: Allow compile test of GPIO consumers if !GPIOLIB
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
>
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
> ---
> v3:
>   - Add Acked-by,

I think my last change to w1 I just put into the GPIO tree.

Should I simply carry this patch in the GPIO tree?

Yours,
Linus Walleij
