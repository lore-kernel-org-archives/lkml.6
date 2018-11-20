Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3860C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD53E20684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8ZCIcEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD53E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeKUCo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:44:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39120 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeKUCoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:44:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so1740309lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pFEaPtxwJQQsrHFsfH0KnbF2TO1mwut7FqKexdVvnsc=;
        b=Q8ZCIcEqJvFi5IMip9PWRjVQbdk7msJG+pzUAWvVATTePnrzdDwpp1Uxuu1YbMkvzJ
         ADdX1aVnzHaB+Kk4o10lCszjLvzsZHWf4q0VGmYHdC+zxKVsq3CglHwJmJLQKH2B2TW2
         5dkypbC5a3HdcMREcg7O3WnkZ7cbUQ6llfQ8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pFEaPtxwJQQsrHFsfH0KnbF2TO1mwut7FqKexdVvnsc=;
        b=o/4H2ZZ7hgLokDt17oV4gFqrw3+I9qOU29gi9yuA2ksm2hwjT9KVUu2OgEOuxqBxDu
         wipSAX6eYgUUqsyEji/aSsJGxKUUqBeiil6EcgeH7P142Q6O0b1sIB3mhkLMJohd4yQ2
         LM/vQ+zXPjHjvQT4T5xIIHxr58dsNVui44PgqSREI9uEbo6zMUXEwGNGMVmminKpsHLc
         Z/QnK9i+pgmOcJx2IbCoKuaZ0aVh4WT1QwF4gd2RaedMpHkwTNuiHgJW1+PcFCB/E9X4
         34Tw6FrhDKSdNWLhuhQK4zpyRCwkR44GvRg18XPve/pQxyENcbba5BG5n+pPExhk0h/B
         7caA==
X-Gm-Message-State: AGRZ1gKaAh8T5rANZ26XtV83MHpfbxfIgxjBuufP4p1O0wBQ9f9EXh/t
        pWxrNBjeKFhl2KE+R66frA+9cg==
X-Google-Smtp-Source: AJdET5cDch7tr8ByrfIO40LvVtkRr/Rl8sclzTejopUkg4rdrMppO7/ET17OLzWWtTQ9VJQQsua1HA==
X-Received: by 2002:a19:1f0a:: with SMTP id f10mr1388670lff.94.1542730500466;
        Tue, 20 Nov 2018 08:15:00 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id h85-v6sm5407971ljf.68.2018.11.20.08.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 08:14:59 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:14:57 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: opp: Extend qcom-opp bindings with
 properties needed for CPR
Message-ID: <20181120161457.GA12783@centauri.lan>
References: <20180627045234.27403-3-rnayak@codeaurora.org>
 <20181015124749.27276-1-niklas.cassel@linaro.org>
 <20181105231745.GA25883@bogus>
 <20181109163917.GA6673@centauri.lan>
 <eab94dd1-1d8f-4306-cced-1e34171ef1e7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab94dd1-1d8f-4306-cced-1e34171ef1e7@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 09:42:05AM +0530, Rajendra Nayak wrote:
> 
> 
> On 11/9/2018 10:09 PM, Niklas Cassel wrote:
> > On Mon, Nov 05, 2018 at 05:17:45PM -0600, Rob Herring wrote:
> > > On Mon, Oct 15, 2018 at 02:47:49PM +0200, Niklas Cassel wrote:
> > > > Extend qcom-opp bindings with properties needed for Core Power Reduction
> > > > (CPR).
> > > > 
> > > > CPR is included in a great variety of Qualcomm SoC, e.g. msm8916 and
> > > > msm8996, and was first introduced in msm8974.
> > > > 
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > > ---
> > > > Hello Rob, Rajendra,
> > > > 
> > > > Sorry for not replying sooner.
> > > > Since Rob wanted the binding to be complete before merging,
> > > > this is my proposal to extend the OPP binding with properties
> > > > needed to support CPR (both for msm8916 and msm8996).
> > > > I've discussed the proposal with Viresh, and this proposal
> > > > seems better than what I previously suggested here:
> > > > https://lore.kernel.org/lkml/20181005204424.GA29500@centauri.lan/
> > > > 
> > > >   .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
> > > >   1 file changed, 19 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> > > > index db4d970c7ec7..3ab5dd84de86 100644
> > > > --- a/Documentation/devicetree/bindings/opp/qcom-opp.txt
> > > > +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> > > > @@ -23,3 +23,22 @@ Required properties:
> > > >   representing a corner/level that's communicated with a remote microprocessor
> > > >   (usually called the RPM) which then translates it into a certain voltage on
> > > >   a voltage rail.
> > > 
> > > I've lost the context here. Please send this all together.
> > 
> > Will do, as soon as I've gotten your feedback on this mail.
> 
> Niklas, are you still waiting for feedback on this mail from Rob?

Yes.

Rajendra, I realize that your patches have been ready for merging for
a long time, and this fuse-level is quite complex, so the discussion
has been taken longer than expected. Sorry for that.

Hopefully Rob will reply soon, or perhaps he could agree to merge your
binding as is, and I could extend it later, when we have reached a
consensus.


Kind regards,
Niklas
