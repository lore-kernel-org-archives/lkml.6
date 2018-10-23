Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85778C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429F120671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aMK9MwIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429F120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeJXESz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:18:55 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35604 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeJXESz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:18:55 -0400
Received: by mail-ua1-f67.google.com with SMTP id m18so995904uaq.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKQMypQnIGQh99gY/hsyCj5Db3yMQkudKk6U9RoS1Lc=;
        b=aMK9MwIYpmC1Z/HReHnt84twbT0kSGWSSQPZHDe0g3Ht4njgKNRUMQgB1Gkp6HKTw1
         kUKnzcijuODAXgztEHkSyw/T5ZJZkihYvpEt+5jeQZ8gIABKT9hI4Z6efoiUJgtLxvAf
         Z1wnabvrKopHS5VA4P3UJrt1Jui/IAw2EOj9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKQMypQnIGQh99gY/hsyCj5Db3yMQkudKk6U9RoS1Lc=;
        b=TCDgfYGK76qGSnfbp+VPmLl8yFv2dDEhgCjYgwr7kYZUQZx3DuZADuG8mbF3XGrPve
         7g3cE5Qt0yB/IJ+4VDdoECqymdZErpslXsrxySkXkvuMFaXszlrLh8GrcJVmlpbpbRoM
         T3d4G6oII3CqZWsM415yZYPB8Zj4WWMzulbeQFWERYS7uRVnROFuJOP3InIQyawga2Gq
         HY5pH3xZ/wJRJy9FVQuNAdLGgIMErYhFn5OOph4WuR4dw1BcXO+TPBMaVR6HNumfiDeu
         RGWYagz5JpbLDHTiy3IYkvPRpUv5NoPHolse4QT/cHC7/tEyxpKuQRoYv0CBu7kqDxJQ
         /iGw==
X-Gm-Message-State: ABuFfoj9uFqa2LxLiwaD5kIWaftWev+d6bKlKonkKPfvWKdgYQk4Acjp
        PKjmtjGQ7JvKPTaP8fX2P57myAoyV/Q=
X-Google-Smtp-Source: ACcGV60WjK7ftTWSneNTGkHEvQasg3rJlrZePWk9BtsxZrv/vTnQpaJBOLvfNDHvjegtGzut1QitJw==
X-Received: by 2002:ab0:5c61:: with SMTP id a33mr22196802uag.59.1540324443229;
        Tue, 23 Oct 2018 12:54:03 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a19sm446346uan.14.2018.10.23.12.54.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:54:02 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id y195so1673335vsc.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:54:02 -0700 (PDT)
X-Received: by 2002:a67:7988:: with SMTP id u130mr10932991vsc.119.1540324441924;
 Tue, 23 Oct 2018 12:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181023010707.153647-1-ryandcase@chromium.org>
In-Reply-To: <20181023010707.153647-1-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Oct 2018 12:53:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XN5wa_7C8X3epEx=VpcEYSgTj7fxuvVsWDGkpaEkh-3w@mail.gmail.com>
Message-ID: <CAD=FV=XN5wa_7C8X3epEx=VpcEYSgTj7fxuvVsWDGkpaEkh-3w@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-qcom-qspi: Fix remaining driver nits
To:     ryandcase@chromium.org
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Oct 22, 2018 at 6:07 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> Address remaining comments from original driver patch series
>
> * Move RD_FIFO_CFG to be ordered corretly
> * Expand spinlock comment
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/spi/spi-qcom-qspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
