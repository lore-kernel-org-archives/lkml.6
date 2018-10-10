Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AE7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16392087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMG1m5Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16392087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJJNhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:37:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40396 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeJJNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:37:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id 1-v6so1994820plv.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQwyB6Ede0txptm73heStjghI/GMrnDddsxs4p8aYpA=;
        b=AMG1m5XmJZV55wO/2aWKq1HngArx927SK+6kJ37e24HY0g8IGBzwSDin4Rem4tYUJP
         HH7bRPQL7C+ZOS7yojDrOrUa6l9ZJ/1yEoPc6Dy1mVg3J0kN1oM011VwKBXx4/2lOTtg
         VXFfTgmUpDHhfcsNkCDrcY1YeZ2sF3CNMJeyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQwyB6Ede0txptm73heStjghI/GMrnDddsxs4p8aYpA=;
        b=SM/cpWjjqYsfZWZdupVr7hddLcannpU5mVJLTjte0q1FzP5eFIKruZakcZ5QwOO2oi
         sR/+Mu/RY3pvfdYpfin3P/kR0W2Le+r625P62P14PYrcpk54Dy37GWs+R9CUwzbFr/Fz
         jjFoqCsosdYmVlf/sjwNYaksCrKEQbI6+ivs+f9Jdf5SzVhpD0Lh6fNaUlv8YwXPmJg2
         3NLr/JhKtRkhJ4vZGFeFfc9FEnoVpeMPo7G0rHpoI3X5mxknwtY0yNSwh57sa8gYegaG
         +z/966pNZre35d/tqgeBroGPnt4+Ppo248f8sGClrGd8I8lgCT65fc/kNY+DIWb3epV9
         nong==
X-Gm-Message-State: ABuFfojGAEcW0mDn5hvOlTEkkhlru25VPJpS6zb3QIBYUCK1oREVmIyt
        RhIwn65OdOMtw4dFZlGyuWsTnQ==
X-Google-Smtp-Source: ACcGV60l/WpyeoM23QQvzcWALlvCCQ8KuQh/OE3JJjGrLKGonnETeN+TgOQ0QqwPEvgWVeXlMXlByg==
X-Received: by 2002:a17:902:b907:: with SMTP id bf7-v6mr21981004plb.259.1539152188080;
        Tue, 09 Oct 2018 23:16:28 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x17-v6sm27766958pfn.59.2018.10.09.23.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 23:16:27 -0700 (PDT)
Date:   Tue, 9 Oct 2018 23:19:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sibis@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5: shore up resource probe handling
Message-ID: <20181010061920.GS12063@builder>
References: <20181009222527.74260-1-briannorris@chromium.org>
 <CAD=FV=Vh4NWUS--dDU5N0b86ZoRd7kEj7Zuk5VCE=WkaRWp=tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vh4NWUS--dDU5N0b86ZoRd7kEj7Zuk5VCE=WkaRWp=tg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Oct 16:34 PDT 2018, Doug Anderson wrote:

> Hi,
> 
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
> 

Before breaking this code out to a common function shared between the
various q6v5 drivers this was a separate helper function, but that
wasn't pretty either :/

> ...in the ideal case it would be somewhere that all Linux drivers
> could use since this is a super common pattern, but that might be a
> bit too much yak shaving...
> 

Yeah I agree, it would be a nice helper but there's a bunch of variants
involved. I've added it on the "someday/maybe" list.

> 
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
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I applied the patch with the nit fixed and your r-b.

Thanks,
Bjorn
