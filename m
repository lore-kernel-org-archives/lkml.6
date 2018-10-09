Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3164BC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14D7204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NaxsYXo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14D7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeJJGyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:54:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43213 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeJJGyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:54:01 -0400
Received: by mail-vs1-f66.google.com with SMTP id w85so3296185vsa.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYoGDuR6gRz8lX7gm8abV/f1vWcmOY5yeZxnQTsJWZU=;
        b=NaxsYXo6fMXDFQ1yJ6uY1m2R/agBz9t3tub/RjmKV97KduruQSbHqheiga5tWmysWN
         I1ElmOvvdgE9DkF2taPzNkSOMqSZpaKOPBxraICuXKKs/k9JfUxWUWdpHDnmlSDWTfVM
         qT5oJCIJND6hdaNXvPt2E+C9cfw3FQYgWPez0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYoGDuR6gRz8lX7gm8abV/f1vWcmOY5yeZxnQTsJWZU=;
        b=B5gCn7arOpqk2trj21gmJ1g6kcc1Jy3+BPZQko8BOEybTipX6AziYpXDem/X5+2r9S
         WJjy1gsN8rSkvJwKnDmzter0q1gobMRkiEp0WNb5ZN/i7K+zX2WqwVdhDdun2pUQ2ZNT
         LkgiAd/P1WU2RsGN/y9lusGP4wSnzsvyvYd3BTZAop2/+whxWMHyzPseOH2P8ZZkwdyj
         jU+pZLNwIhdEpaCWjsG7XQT399e6MVZTMDHNlghodGOlqOm16svZ+/Sf1NL/6IUNNbJ6
         25Y80LZyX7qKoviOCZK+AxIsn2/j8CVx1GUKEqb4dr9qgKH8B2b9T9FSA27UivdEbjhM
         Z5jg==
X-Gm-Message-State: ABuFfoiy19QerW8v82WPkT0S6Lf5q6Kg+zgLY9dChXjy1TpLMhvZGkjI
        AWwsFviA4cyIWk3TMMfFsHDYTZoTdbI=
X-Google-Smtp-Source: ACcGV61Lf+0x+RbtL7WgTT+BVxL8eMBcP4HvzQCFBAZ76Nx0OVMC6gLmEjFx777SXElcMA27VGUGBg==
X-Received: by 2002:a9f:2237:: with SMTP id 52mr12371338uad.33.1539128080405;
        Tue, 09 Oct 2018 16:34:40 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id x197sm5728222vsc.3.2018.10.09.16.34.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 16:34:39 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id z130-v6so3303195vsc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 16:34:39 -0700 (PDT)
X-Received: by 2002:a9f:3743:: with SMTP id a3mr1678337uae.86.1539128078892;
 Tue, 09 Oct 2018 16:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181009222527.74260-1-briannorris@chromium.org>
In-Reply-To: <20181009222527.74260-1-briannorris@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Oct 2018 16:34:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vh4NWUS--dDU5N0b86ZoRd7kEj7Zuk5VCE=WkaRWp=tg@mail.gmail.com>
Message-ID: <CAD=FV=Vh4NWUS--dDU5N0b86ZoRd7kEj7Zuk5VCE=WkaRWp=tg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom: q6v5: shore up resource probe handling
To:     Brian Norris <briannorris@chromium.org>
Cc:     ohad@wizery.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sibis@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 9, 2018 at 3:33 PM Brian Norris <briannorris@chromium.org> wrote:
> +       if (q6v5->wdog_irq < 0) {
> +               if (q6v5->wdog_irq != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev,
> +                               "failed to retrieve wdog IRQ: %d\n",
> +                               q6v5->wdog_irq);
> +               return q6v5->wdog_irq;
> +       }

optional: Since there's the same pattern 5 times here, I wonder if we
should abstract it out to a helper function that would print the
error?

...in the ideal case it would be somewhere that all Linux drivers
could use since this is a super common pattern, but that might be a
bit too much yak shaving...


> @@ -237,8 +260,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>         disable_irq(q6v5->handover_irq);
>
>         q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
> -       if (q6v5->stop_irq == -EPROBE_DEFER)
> -               return -EPROBE_DEFER;
> +       if (q6v5->stop_irq < 0) {
> +               if (q6v5->stop_irq != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev,
> +                               "failed to retrieve stop IRQ: %d\n",
> +                               q6v5->stop_irq);
> +               return q6v5->stop_irq;

Nitty nit that it's the "stop-ack" IRQ, not the "stop" IRQ.  The error
message below this one calls it stop-ack too so it would be ideal to
keep it consistent between the two error messages.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
