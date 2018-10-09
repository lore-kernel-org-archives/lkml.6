Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A06C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD79B2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvYCCzwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD79B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJJHIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:08:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45590 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:08:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id v18-v6so3266450edq.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEAxdQUbLebE70D4n/NrlUOCPelNYX3qIfEFFRgPQ8E=;
        b=gvYCCzwXVUfdHVH4/UmtkTA6vKHSmf+yrPTD0ZsLB8WIv1DW3Mxu3jBJtJ0TyjRaaV
         l25RffQJmK9k24ISW8T3poaAoAdz/7C8bEziFgT/arO10M34H3btVtFK8cYUyozgSx2a
         FyS/aDeLZp/xeHHLCtRRaBOrD5BlZ8meNZ2/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEAxdQUbLebE70D4n/NrlUOCPelNYX3qIfEFFRgPQ8E=;
        b=AIYiA5kZiU87v2/3eJgw3MHan1xdWKGlvNZkOVCQ71QmruZbQyMAq6s5BnhQQZUAbR
         Vrm9/DgAKkikobUBiM+Bf9jbXuoLARIfh0nrgLSsSvmtm8v6VlYCqqwbyLf7ofC7Y189
         vsmgOKMyBtigVlQ+L3WVTch6lWO2ac8Q2cAl1+D5OIjth8STBxwuyvbKNHf3bwsLkyf3
         0ejxW6DKgodGPiuY8qco9ucpmR7vWk4g2aswA7ZTAGDmsYnxKg6FgbA6ZSqmIPOLGGXX
         eBoq46gdNR0nvgbz8SCyQFkh3vNphViqyLoeUPWqdAxRYdGhKgCPYEvquMjwzYt28N6d
         S54Q==
X-Gm-Message-State: ABuFfoiMu5OfYoghsDRWWNlxpLzfRObAmX0PZHsZOajWgMYrdsvkICla
        s6p3k3NLfSNHKhx76Ira9MXDSIPkuE0=
X-Google-Smtp-Source: ACcGV603h/TjNjW6ySVJmjXenIuONfQOv96eoJbxQAfeobJHsnkxGhLdJx6Rua/AW8miyZspkSkNMg==
X-Received: by 2002:a17:906:c51a:: with SMTP id bf26-v6mr30297063ejb.142.1539128925020;
        Tue, 09 Oct 2018 16:48:45 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id i19-v6sm3865556ejv.73.2018.10.09.16.48.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 16:48:43 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id c1-v6so3289195ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 16:48:43 -0700 (PDT)
X-Received: by 2002:a50:cb03:: with SMTP id g3-v6mr37161949edi.287.1539128923126;
 Tue, 09 Oct 2018 16:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181009222527.74260-1-briannorris@chromium.org> <CAD=FV=Vh4NWUS--dDU5N0b86ZoRd7kEj7Zuk5VCE=WkaRWp=tg@mail.gmail.com>
In-Reply-To: <CAD=FV=Vh4NWUS--dDU5N0b86ZoRd7kEj7Zuk5VCE=WkaRWp=tg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 9 Oct 2018 16:48:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP5iBWgX1K3=QHke4ZoqO72hLk6Q09=cP3X-esrTOhk+w@mail.gmail.com>
Message-ID: <CA+ASDXP5iBWgX1K3=QHke4ZoqO72hLk6Q09=cP3X-esrTOhk+w@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom: q6v5: shore up resource probe handling
To:     Doug Anderson <dianders@chromium.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, sibis@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 4:34 PM Doug Anderson <dianders@chromium.org> wrote:
> On Tue, Oct 9, 2018 at 3:33 PM Brian Norris <briannorris@chromium.org> wrote:
> > +       if (q6v5->wdog_irq < 0) {
> > +               if (q6v5->wdog_irq != -EPROBE_DEFER)
> > +                       dev_err(&pdev->dev,
> > +                               "failed to retrieve wdog IRQ: %d\n",
> > +                               q6v5->wdog_irq);
> > +               return q6v5->wdog_irq;
> > +       }
>
> optional: Since there's the same pattern 5 times here, I wonder if we
> should abstract it out to a helper function that would print the
> error?

I'll leave that up to Bjorn. I don't personally care to do this, but I
also acknowledge that there are a bunch of drivers that do this wrong.

> ...in the ideal case it would be somewhere that all Linux drivers
> could use since this is a super common pattern, but that might be a
> bit too much yak shaving...

Yeah, I'll pass on shaving that yak.

> > @@ -237,8 +260,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
> >         disable_irq(q6v5->handover_irq);
> >
> >         q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
> > -       if (q6v5->stop_irq == -EPROBE_DEFER)
> > -               return -EPROBE_DEFER;
> > +       if (q6v5->stop_irq < 0) {
> > +               if (q6v5->stop_irq != -EPROBE_DEFER)
> > +                       dev_err(&pdev->dev,
> > +                               "failed to retrieve stop IRQ: %d\n",
> > +                               q6v5->stop_irq);
> > +               return q6v5->stop_irq;
>
> Nitty nit that it's the "stop-ack" IRQ, not the "stop" IRQ.  The error
> message below this one calls it stop-ack too so it would be ideal to
> keep it consistent between the two error messages.

Ack. I thought I double checked on comparing the error messages.

Bjorn already has this on his radar, so I'll let him decide if he
wants other changes, or if he wants to make his own transformations
before applying it.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
Brian
