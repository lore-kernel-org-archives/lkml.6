Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E06C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CBC208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVW+0dQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CBC208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeGaGLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:11:35 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:33011 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeGaGLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:11:34 -0400
Received: by mail-pl0-f50.google.com with SMTP id 6-v6so6561617plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 21:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlQ8rbL5ascRr6NwFoul3SYyyZfOpET4WF/paOAuaM8=;
        b=UVW+0dQ8furMCQEgC2DqwFXHH0knVZhF60hELuhbs+DCkbtghnLaFKoOgb8CskRKKV
         HRPsBVRl9DY/njJdikoFPm+mM2DLoTFazaa6kr/b58cdJObsaD1VL/TXMtxWwPZybUG4
         tQgnTDgGmmlIJ2IsIIfCI1nHx61fmAfWHsXqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlQ8rbL5ascRr6NwFoul3SYyyZfOpET4WF/paOAuaM8=;
        b=mb5PkZt++3C0aStSYlnjD2vZd61neB8jt3eumt7H/Qh3TJWvb1aJksmK+4zJ1c7KwF
         xq0OtGz2wM9Lk8mSZOCzOIy9m3I3yXfnmgVOBBXxqgxwT9OhfsflxW/yZKhLycGDbFVc
         0Mt73DD1vn6XmKJoAZtLePd06YX6x293ebnkEunorIWNznStqm5W0U1eY/gBH2pjm5CF
         34OBuMyZ9fM1PIjs9xJvmlYS7dBv/pJBGMSxPTdvWlcJHgU4vHgkroavoRgDIBbFnpcl
         05fSbY7SI0d5TxTbEvnpIKpynjbQ9omf4b0UHDqN9WlpQVmiQ3NSnwmYP3rEHeIbRvxc
         Mn4w==
X-Gm-Message-State: AOUpUlE1Fh8wpJwZdygO+qBH/U/v9cUauxTYAgo9hlbHf+UxYtcSxGg0
        eg3TwPyAAwTDwUljSaOATFOiVNIYpSI=
X-Google-Smtp-Source: AAOMgpcH9xIVuxqqwKZnCuXm+ZUs1dfMHJCCWHJwrQgMToS0R3W7eg8RuoIKHsooIug2omIxpvgRIQ==
X-Received: by 2002:a17:902:74c2:: with SMTP id f2-v6mr18723408plt.260.1533011595663;
        Mon, 30 Jul 2018 21:33:15 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q81-v6sm27627103pfd.15.2018.07.30.21.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 21:33:14 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:34:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 0/4] ARM: davinci: complete the conversion to using
 the reset framework
Message-ID: <20180731043403.GF5090@builder>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
 <CAMRc=Me1JTuw40tMWaai2oKMxmc_ktN2OKBhF8tmGt0cQ6magg@mail.gmail.com>
 <e4bd9f57-617a-a59e-5d05-be1a6b3e6b3d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4bd9f57-617a-a59e-5d05-be1a6b3e6b3d@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Jul 05:08 PDT 2018, Sekhar Nori wrote:

> Hi Bjorn,
> 
> On Thursday 21 June 2018 05:11 PM, Bartosz Golaszewski wrote:
> > 2018-06-21 12:52 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> >> Hi Bartosz,
> >>
> >> On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> These are the remaining patches that still need to be merged in order
> >>> to complete the conversion of the davinci dsp driver to using the reset
> >>> framework.
> >>>
> >>> They apply on top of v4.18-rc1 with David Lechner's remaining patches
> >>> merged.
> >>
> >> Series looks good to me.
> >>
> >> To preserve bisect, shouldn't the order of applying be patch #3, #4, #1
> >> and #2 ?
> >>
> >> Given the dependencies and to preserve bisect its easiest if I take the
> >> series with acks from remoteproc and clock maintainers.
> >>
> >> Open to other suggestions as well.
> >>
> >> Thanks,
> >> Sekhar
> > 
> > Oops you're right about the order. Do you want me to resend?
> 
> With your ack, I can queue 1/4 for v4.19 and provide an immutable commit
> to you (on top of v4.18-rc1) for you to merge any further changes you
> want to queue from your tree.
> 

I'm not sure why I didn't see your request earlier, sorry about that.

I seem to have one other davinci patch from Suman, which should be
possible to merge without any conflicts. So there's no need for an
immutable branch at this time.

Regards,
Bjorn
