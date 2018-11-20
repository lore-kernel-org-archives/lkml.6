Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423D4C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31DF20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZKP0TAdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31DF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbeKUDfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:35:36 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41567 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeKUDff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:35:35 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so1500904vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCvDkTrryc6h6D8BFtjV6gfC44cdnp3KB/9tnbV+mdM=;
        b=ZKP0TAdrN3zpn+tFQSNOz8SOe6kRvv9cgu1tgI93umgPUMPVL3yd05z9/kzerd3QQo
         IlR7ZyuLN61L6j+1m01OIiaHjoGQsQ1q1bcno958sih1ZlCqVg63A07/NFl0uHBP9VCd
         uoh8lXw0nFEq9F/o+JOH5n2urj6NU3TBp6K4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCvDkTrryc6h6D8BFtjV6gfC44cdnp3KB/9tnbV+mdM=;
        b=UfjqWoYLK3iNLptAOeSGAkbRr8wTLgpTV5SGrk2fl6UfVR0PxobWVJC4pPmUzAcMOF
         CK0YRbdEn1mg/CAfd9sbgIl+XzvfjTi2+k5x/5yzyeLkmRlyt8Dy+HxVpmyu0oVTEUpd
         Wky3urM19AQC25fosCR8viAhub2a6g6+n7LQ+yqwDw/+YrNAT5VduECfD66sIwUZkIHv
         xCD+sAB5O9oiaLoFKxElewFZ8se3IkMrr+NMNgutItdKAFX9ffXLIiWurY8P5r3JdWm9
         jdKBMQbo5HnPoUwDHMUzhMUIqfbHX/0/d3t8JI5ACWLSmK2GfoKC7/6wKRIPN/KvcEaR
         Uzkw==
X-Gm-Message-State: AA+aEWaFhzwJXarFnBFHqEkB4w42U3+fIuXYHdJbpM/ehKL+Kh2rorrT
        58dHUGdDFk8a7QkzV/pNJ7JbiAVtQ/Y=
X-Google-Smtp-Source: AJdET5dx4Q+LMy3r3WsASPIwHof/jHGrsnafR8k6JU4BlWLrg2GQqlryRTwOkTxf5RD9fnkfKX5DBA==
X-Received: by 2002:a67:8513:: with SMTP id h19mr1143616vsd.91.1542733525515;
        Tue, 20 Nov 2018 09:05:25 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id p136sm10159630vsc.18.2018.11.20.09.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:05:24 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id h128so563183vkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:05:22 -0800 (PST)
X-Received: by 2002:a1f:4301:: with SMTP id q1mr1219590vka.70.1542733521673;
 Tue, 20 Nov 2018 09:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20181120002654.1891-1-dianders@chromium.org> <20181120002654.1891-5-dianders@chromium.org>
 <20181120161055.GI3894@sirena.org.uk> <CAD=FV=UO1Dt3SeDs22EgH-95dWX+jq0sU7zzRgew11_DVw43cg@mail.gmail.com>
 <20181120165814.GM3894@sirena.org.uk>
In-Reply-To: <20181120165814.GM3894@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 09:05:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UpQ1RNXsSS9j5fUtFm+c7aMi+zoau7c3m4R=oakqL_ig@mail.gmail.com>
Message-ID: <CAD=FV=UpQ1RNXsSS9j5fUtFm+c7aMi+zoau7c3m4R=oakqL_ig@mail.gmail.com>
Subject: Re: [PATCH 5/7] regulator: core: add enable_count for consumers to
 debug fs
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 8:58 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 20, 2018 at 08:52:14AM -0800, Doug Anderson wrote:
>
> > I don't want to send v2 of things while you're still reviewing.  If
> > you have a chance give me a ping when you're ready for me to send out
> > v2 of things.  ...otherwise I'll plan to send it out later today or
> > tomorrow morning.
>
> I'm pretty much done for today so probably easier to just resend now,
> I've got other things in my queue to review anyway!

OK, got it.  NOTE: I think patch #3 ("regulator: core: Don't
double-disable supplies in regulator_disable_deferred()") needs no
resend and is ready to go if you think it's OK.  I won't plan to
repost that one.

-Doug
