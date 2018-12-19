Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D594C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9DE217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zwnf5qoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbeLSSxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:53:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44385 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbeLSSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:53:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id n12so12271546qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9fl/aCX5m5Ur8ChHfXZr3/ukIHUp9kxU8GUbtmijdQ=;
        b=Zwnf5qoY/CoCfBvk+//3ZjPnGaRT86QmcyoJuHqaGsmsEfBUp/kiyM6kyZIahur596
         QduosiUpsqsQzwrfMyyjY+1IkLwjusVdchkSIOpVOyRnlJMkIsmJF1tVmlRovH541kRg
         lG6b23vMrq4fqsOLSHcYPglGEFdlfCJfSG2/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9fl/aCX5m5Ur8ChHfXZr3/ukIHUp9kxU8GUbtmijdQ=;
        b=W5AW19cHB/HYv1HeG7x3hBK6b1ziyLmo5+45EQW/I6psC3hgT1bt8An8lpNhLurKTi
         ttfbrbMqkS1zSAkcd7UbGC/0VvSXkubzDq4Swu/x0uZWwLMTFy/p/eCNJmM+2nCUS8QN
         mee5HKTPX+xc5O+WNQaMKpoTnjE95MiazItFEpG4EC7dkZGRQLSoZWQ2vSb37ztuoH+U
         EQdso4jmkDb8FgrWDitkd3AgP1gXt1AW+CoopP/tPMYhtb78qnxpGyGsCdpf1jOSkEN5
         UFfVBCTkEQh5q7T8trraehr1U5yltYrjKfrGYVi79oL6kMEHttH7x8atfxPwK6QrHFfi
         3/Tg==
X-Gm-Message-State: AA+aEWbaEg+7sAAtjCc4prx2EcOtdyKf2W7EpaG7Q+rpCBN1PMzc1Ukb
        Guo/gTon6X0fntstnnOR4VmpnlTW0TpFp1fyANi7bhqYiKQ=
X-Google-Smtp-Source: AFSGD/WnmoSuq+TlInep26+kyKtkTpC6orpFAxHOt768oroP6Vbs5k6CKEJvo64gK4rCYoRFknej/GR5NwkaJ/RzpZ4=
X-Received: by 2002:ae9:efd6:: with SMTP id d205mr20135298qkg.274.1545245596355;
 Wed, 19 Dec 2018 10:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20181219181747.118278-1-mka@chromium.org> <CAE=gft7BV=M4wpk304yhDV11ddNJSFGDYu8TRW3WOtDPLrRmnQ@mail.gmail.com>
In-Reply-To: <CAE=gft7BV=M4wpk304yhDV11ddNJSFGDYu8TRW3WOtDPLrRmnQ@mail.gmail.com>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Wed, 19 Dec 2018 10:53:05 -0800
Message-ID: <CACjz--=oKSoHbkqm9S94L3isUyNiM6MmoKPOSgxSc9uqQRYKGQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix wrap around of TX buffer
To:     Evan Green <evgreen@chromium.org>
Cc:     mka@chromium.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, msavaliy@codeaurora.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 10:50 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Wed, Dec 19, 2018 at 10:17 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Before commit a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix
> > softlock") the size of TX transfers was limited to the TX FIFO size,
> > and wrap arounds of the UART circular buffer were split into two
> > transfers. With the commit wrap around are allowed within a transfer.
> > The TX FIFO of the geni serial port uses a word size of 4 bytes. In
> > case of a circular buffer wrap within a transfer the driver currently
> > may write an incomplete word to the FIFO, with some bytes containing
> > data from the circular buffer and others being zero. Since the
> > transfer isn't completed yet the zero bytes are sent as if they were
> > actual data.
> >
> > Handle wrap arounds of the TX buffer properly and ensure that words
> > written to the TX FIFO always contain valid data (unless the transfer
> > is completed).
> >
> > Fixes: a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix softlock")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>
> Oh nice, so this did end up being your problem with corrupt
> characters? Strange though, I still would have expected this bug to
> result in inserted serial characters, rather than edited ones.
> Either way, this looks good to me.
>
> Reviewed-by: Evan Green <evgreen@chromium.org>

UART bluetooth firmware downloads consistently working for me again.

Tested-by: Ryan Case <ryandcase@chromium.org>
