Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05199C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C9B21A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQL9oMYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C9B21A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeHFMp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:45:57 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40759 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeHFMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:45:55 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so10568174iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP5Ns+Mox9oV1PNyfvOpnIajjrWChjL7jkXy8ayA3D0=;
        b=GQL9oMYzyMEb6Hs5lu+I5I+u95WR59PNzsjBtPKDZ545y7zdMGHnP7z2bpKsFDKObr
         UcbVHg947Y4sCdPPCLmx8ew0CEJ8v8p2uyqgMKo0jxgqZYwTnxHw6k7CvYsWP0668KDO
         xhi2yX/ye7gA8tellMe21Lz+/TShInDhDP8QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP5Ns+Mox9oV1PNyfvOpnIajjrWChjL7jkXy8ayA3D0=;
        b=VFuof2O8O9QDQ1Ydo+/Z1R17VSrWXVwb+LMl9Xqpjrh9mhULQd/9lzEQMCnUn1ATnZ
         9f2dx3NL0verIt8peql1O2tn8CC+4Df0ZD89uDqiVvG1UIr0rfQEi2QVxSgkVAB7sSLk
         hjmqDMgU4rGKgvnfwsApWmxIc9gydAovp2z34y3sdLV092MUwyqtY+zQHgZCOLb2xi/S
         k8nGOZfyQkHGSr/9ZFCEB67AsN36xrNyX7JAeDemN06vuen/WcWUk5eTyQk7LTbvhxcu
         zR3SccDf+Su6BSgPK/k/XXy6tJUIqz+PBmVQbOJk6TtmWx7ky9ih7i5UupH47qyLOAkW
         40Gw==
X-Gm-Message-State: AOUpUlHe0e71l1/FR5Ljt0VbiFXOHLl2PKCbP+Y9JxT2+FneIkmqytPq
        +glX8OYuUxBNlJhFSS3tBxN5EH+oMfEW2TSSDMe91Q==
X-Google-Smtp-Source: AA+uWPzbQPv+IcEZz/v5Km+mu0q+dPARs4UKWnz/TFHIxOnqE//ho4fGJAr7RH7bbYSkg0t337D7hBwfrtxUyH4FQGY=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr13567266ioa.277.1533551849048;
 Mon, 06 Aug 2018 03:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180802111144.12512-1-digetx@gmail.com> <4576764.PLucfz68jK@dimapc>
 <2086462.IQpRViTvQm@dimapc>
In-Reply-To: <2086462.IQpRViTvQm@dimapc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Aug 2018 12:37:16 +0200
Message-ID: <CACRpkdYqpK4fuQ4g0WORnNDOPhDebXXJHJH0oGUVd+qmfimqLA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to
 arch_init level
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 11:15 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> On Thursday, 2 August 2018 16:01:24 MSK Dmitry Osipenko wrote:
> > On Thursday, 2 August 2018 14:11:43 MSK Dmitry Osipenko wrote:
> > > There is a bug in regards to deferred probing within the drivers core
> > > that causes GPIO-driver to suspend after its users. The bug appears if
> >
> > I meant "before its users", of course. If the rest of the patches is fine,
> > please let me know if re-sending is needed or you'll correct the comment in
> > place while applying.
>
> Linus, please pick up the v2.

It's no big deal if the only difference is the commit message.

Yours,
Linus Walleij
