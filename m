Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A4C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741002082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BBbfmOlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741002082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbeKEBcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:32:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36716 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbeKEBcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:32:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id s15-v6so5834973lji.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 08:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H21m1/axjPcZh0QhIMC8vfJ7sj13RSBTbwrLEoF7S4k=;
        b=BBbfmOlEwIOqUP8Bh7eRCeW1tG9a+udPZnS8nVscTQTBIGZAMgAmk43ykvqgWwNnO+
         mnafbAcqW9s0uKHQrexUYShBClWgwBvRWGxUL2sPYN+mSS5S+Q2AGJmF3c0pUvPZbN1Q
         wb8KKJITy67szDb2K+fKzyZFJWpuuWV0ldfs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H21m1/axjPcZh0QhIMC8vfJ7sj13RSBTbwrLEoF7S4k=;
        b=Fp7LQvgYqG5t5vEu0rVoIQHe2OHz7bbeEMLkyga4R1BigHon+z5SP1L6LUZ/b7qj/f
         vwqCzB+VHQ9KvkRp2b7mQ6cb23U41fvHPRQ5j9zZxdVwgR+uaAaUqw6SkMluCmSs3lg2
         gOK0/bQXxQaYlSGipcc57EMueoQxp19X6c0e52/ef/v45yfTwbFgyQkPj5z9/c7jE+cJ
         paW85WG7r3GfwZBTu06k+TYHfU+eyO+5CVuJwtwAvzRLR02oMWSLFAlHx/PnCvCSWF6y
         izxzdTC+Yf6+ZVTQxx1Z3gVoZ5ERQ6Igl2VChKRjzf40HV9wdEy/ZjhRSFzfu1Zbosrq
         YsJQ==
X-Gm-Message-State: AGRZ1gJ2b5Z8kkCqgpkL7EFKxtngyieto4Qj99vQ4Fp2uyk7X+3AQQuL
        XzTy6XYfHina2YiUMwKyfoTrfNx5wzU=
X-Google-Smtp-Source: AJdET5fLdmzIRraW8hf8jKcbXZ7kODUk+XeR2W2cldDO5SRRloXGPomrsIk0Jj0mTRGAASF7pdDI7g==
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr9127664ljj.120.1541348234529;
        Sun, 04 Nov 2018 08:17:14 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r26-v6sm1547lji.25.2018.11.04.08.17.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 08:17:13 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id c16so4404074lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 08:17:13 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr10440256lfa.106.1541348232794;
 Sun, 04 Nov 2018 08:17:12 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1811041030130.3160@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811041030130.3160@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Nov 2018 08:16:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJ+CvSxeOoAR-gH78OZvcaKOO+gWpT66KThvkMMxaa7g@mail.gmail.com>
Message-ID: <CAHk-=wgJ+CvSxeOoAR-gH78OZvcaKOO+gWpT66KThvkMMxaa7g@mail.gmail.com>
Subject: Re: [GIT pull] timer updates for 4.20-rc1
To:     tglx@linutronix.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, daniel.lezcano@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 1:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A set of commits for the new C-SKY architecture timers.

Pulled,

                    Linus
