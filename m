Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B2C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED2821EC2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbtdX4+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED2821EC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeHIT4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:56:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34097 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbeHIT4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:56:46 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so2845562plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=PcFBIdm56J4VcOS3323480oATpUi/0b04KYiQNpp4rM=;
        b=jbtdX4+6/ixTU5Vh/xenFgJXTVEwJLJAQqfhDBcX88/zFLuFwPSmf6YElCsrDrlxnx
         HrYWdAeDa4/EY9Hb3irnSsiOMTZKxMLDvEB2u5t6n9LTmHG/xqofhYknffVXkvtbbmar
         sQZGrlz4GBVwYQ27ljeS+eGjJr9mCrK/bzmfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=PcFBIdm56J4VcOS3323480oATpUi/0b04KYiQNpp4rM=;
        b=SDQxwrECQdBH3TLtQs5+5CHmUG7h+S39LbETwF9ar++20a7oZYbPeqZX6YX/jPv3SH
         7Ku81vNHZaoGUzwgjQ/M+opxIsk0Sxie8uulnHYybE9E4oA0DHdpW+gWUMa5BfbhAqd2
         RrvAAwvqcGvvwf4exCzV4wYdP1EExDmQlcIwJHf+x6be8El53aVSMtCfXawiI9wxXW/Q
         QpLRudT4uJHsRqQz6wgVzfSsmS8ctKL3WBMEDmJETUhHf5x/Kl5SPRWGp17fdxY2/eLW
         neQWwEhL7eyyMcoLzbj6J6QJStr/YyW9xLii6QO9mdmGsCBCbsPyeX/YOgGPG9Djs6O8
         1m6g==
X-Gm-Message-State: AOUpUlEbYH6s5P+/Fz4X7yyR7uSwqipsaGj1fH/ONnjqhPohVRvsABnZ
        Dqy/kIx23ABRZ6zAfMmPJBTERg==
X-Google-Smtp-Source: AA+uWPws/WWJ021yX/DKYEyhu+YawdUAHk1ps6zTy3YWKGx8crS1UhPyicGrMWx+BTQ3tdo/llXm5w==
X-Received: by 2002:a17:902:c85:: with SMTP id 5-v6mr2900009plt.141.1533835854519;
        Thu, 09 Aug 2018 10:30:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id g20-v6sm9257466pfo.94.2018.08.09.10.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 10:30:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marc Zyngier <marc.zyngier@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180808072632.21f076b6@why.wild-wind.fr.eu.org>
Cc:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-2-ilina@codeaurora.org>
 <86600uy4vh.wl-marc.zyngier@arm.com> <20180801194538.GA6422@codeaurora.org>
 <86wot9wb9u.wl-marc.zyngier@arm.com> <20180802065104.GA27850@codeaurora.org>
 <86sh3xw7m9.wl-marc.zyngier@arm.com> <20180802125827.GB27850@codeaurora.org>
 <153370830708.220756.4595316550560511917@swboyd.mtv.corp.google.com>
 <20180808072632.21f076b6@why.wild-wind.fr.eu.org>
Message-ID: <153383585322.220756.9422019201626837843@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Date:   Thu, 09 Aug 2018 10:30:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier (2018-08-07 23:26:32)
> On Tue, 07 Aug 2018 23:05:07 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
> =

> > Quoting Lina Iyer (2018-08-02 05:58:27)
> > > On Thu, Aug 02 2018 at 01:27 -0600, Marc Zyngier wrote:  =

> > > >
> > > >Sure. But once woken up (GIC *and* TLMM), the gpio line (which I
> > > >assume is level) is still high at the TLMM input. So why isn't it
> > > >registering that state once it has been woken up?
> > > >
> > > >I can understand that it would be missing an edge. But that doesn't
> > > >hold for level signalling.
> > > >  =

> > > Sure, yes. Sorry for not registering your point in my response.
> > > Once woken up we should see the level interrupt in TLMM.  =

> > =

> > And the level type gpio interrupt will trigger the TLMM summary
> > interrupt line after the wakeup? So then the only thing that needs to be
> > replayed is edge interrupts? How are edge interrupts going to be
> > replayed?
> =

> Level interrupts should be taken care of without doing anything, by the
> very nature of being a level signal.

Right. I suspect we'll still need to configure the PDC to actually wake
up on the level triggered signal though so PDC needs to be told to
unmask the line.

> =

> Edge interrupts should be replayed using check_irq_resend() after
> taking the right locks and making the interrupt pending. Or, if there
> is a way for SW to make the interrupt pending at the TLMM level, to use
> that as a way to reinject the interrupt (which would be the preferred
> way, as it avoids all kind of ugly locking considerations).
> =


Ok. Looking at the hardware it seems that I can write the interrupt
status bit directly for an edge type interrupt and that causes the
interrupt handler to run. So that's good news, we can use that ability
to directly inject interrupts here.

