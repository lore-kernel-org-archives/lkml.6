Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD90120666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Op5uHJIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD90120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeI1Whe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:37:34 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:44485 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbeI1Whe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:37:34 -0400
Received: by mail-yw1-f52.google.com with SMTP id s73-v6so2829349ywg.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rAliPsEEmE8/q/MuEloh9XNX81VuNKKq0cwq6sEdfKA=;
        b=Op5uHJIp+tg/y5JArqD/0AKSS07sQiviJEe37e5atEkaSQc/a+UFScL8NtakaYRYG7
         LR9jJGi+rUAuuzU18+arlJ+bSi2Nkh6an9xC9SScXdfBgDXBdP1Coay5kortkUQlVTE7
         4qWEne9++fV4NVVEwSgepqd7m4rwtTmYhgEdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rAliPsEEmE8/q/MuEloh9XNX81VuNKKq0cwq6sEdfKA=;
        b=rcs0zOYPHl40sVP9FDAQZcvarthZ5Gl+BLLxiGwA9T+AqzGYPTKxAMykh6blAzS05C
         cTLFL2Cm2z2+Obru3/t9TCX1uiXmQzXJUTcX7MjH/Wpnwe6DTYrIMZLlpnWhl+77W5FE
         Ep0EiBEx+DdvYzq5Z+vcok6+WtKLKBVIFzChgC0DJVn6yXMimhRUQgjMRsdA7LmxTjAP
         Bg1auUjm5XTPRUul/GgIzDwgElpg5SSQaLFqTB+gLX2PnJJmY4hXsmfc0qXqlq8roOcf
         ZN1mRXOWHTiw/5HOv6F3mcXr8Mb7QMqK/aeEo6c6WMKhYsPSoeuQ0fxCuSeg+i/vIdaa
         zXtw==
X-Gm-Message-State: ABuFfoiWyTuHG8gv1R6GO9BQF4To2SkxPgMbAaS34D28QCUH4nBdgmSf
        zORvCPOVrK6ku3wyvTIp11Z2Ln2th80=
X-Google-Smtp-Source: ACcGV61gLpY4eVriZXXYJwKi8h+j1migse2eMY3sVw5bNGJQ0ijYJ2oj0EnoIMeE3xGxaciWxAPmIg==
X-Received: by 2002:a0d:cf05:: with SMTP id r5-v6mr8830520ywd.389.1538151185176;
        Fri, 28 Sep 2018 09:13:05 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 82-v6sm2071495ywb.23.2018.09.28.09.13.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 09:13:03 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 5-v6so2875319ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:13:03 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr3973268ybk.209.1538151183188;
 Fri, 28 Sep 2018 09:13:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 09:13:02
 -0700 (PDT)
In-Reply-To: <20180928050823.pggznhgv47wu4pd4@gondor.apana.org.au>
References: <20180919021100.3380-1-keescook@chromium.org> <20180928050823.pggznhgv47wu4pd4@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 28 Sep 2018 09:13:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKBPb64Po2up1FVWoGkUio3zJQuKnpfv7A=F0ci7r4FzA@mail.gmail.com>
Message-ID: <CAGXu5jKBPb64Po2up1FVWoGkUio3zJQuKnpfv7A=F0ci7r4FzA@mail.gmail.com>
Subject: Re: [PATCH crypto-next 00/23] crypto: skcipher - Remove VLA usage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:08 PM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> All applied.  Thanks.

Awesome! Thanks :)

-Kees

-- 
Kees Cook
Pixel Security
