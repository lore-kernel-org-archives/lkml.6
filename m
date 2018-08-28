Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F01C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6F208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1sD4dFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF6F208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeH1HKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 03:10:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40155 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeH1HKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 03:10:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so93192plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 20:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XqVY13ctqCmZNLdkXkl0It0wv9BBmcQ2gHNsbE+VX2Y=;
        b=k1sD4dFdL9pJ4I60PriTd8TGmKgrdXmYrFxd2Stc8uploZ8eiT6wlJkOGBld6SUf++
         CUaDBSI7+NglKTKJ1pFEe11128aIFH1fzjsUYzqBHChV99aOVzQ8Ol28poIAlBzXNpcC
         /Savka5gAhxptrAfazpOnBLc4WGUW/gyqu7OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XqVY13ctqCmZNLdkXkl0It0wv9BBmcQ2gHNsbE+VX2Y=;
        b=iM+k5V4AU184Aq6GN1nhZuC6RNVNUc4uHr2NLXzP/PCC8PX/szX0Wy73XyupdudNn1
         7V1NjPM3K9+Gz06sPIBzKs4G1ePSBDI7wAOTLhdTjySVujp5EcmI01gA+JxEVWW0jYmS
         GIy9PKCRrluB4kQcTYCFYSFC0JnxzX6N2L3cxIbjtC4ERH+qB84PcUz5IGOdLYTKq9Lp
         +Idjk/fHNkvNOB2DIUAwvm8iaWKMETZE/errY1fAlVxUOmMXb5t+q4uXYZLvkfEM1qG9
         IF9ZWZ1HI2UIhhJktJ9dUhUxhul9ErtzSHKlsNg7ZqtcB+NLF0i/lWY9+igArfmtHJED
         bJFQ==
X-Gm-Message-State: APzg51ADNtK31gUiovmUVAVl9oaN03wKTnB38r8ogEEdvxCY73FaqiaN
        2ABG4SoFT0nEdbxRqZEp+Upd5Q==
X-Google-Smtp-Source: ANB0VdZUu7rcV1dSSRr1lnIXQc7fiPkIeGakIFUhaz0G8Zm9a41QQKIxE4EM1fLg2s2alxRZdINM9A==
X-Received: by 2002:a17:902:6b89:: with SMTP id p9-v6mr15412414plk.272.1535426437336;
        Mon, 27 Aug 2018 20:20:37 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 87-v6sm884078pfn.103.2018.08.27.20.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 20:20:36 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:20:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org,
        rplsssn@codeaurora.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20180828032034.GG2523@minitux>
References: <20180817163849.30750-1-ilina@codeaurora.org>
 <20180817163849.30750-2-ilina@codeaurora.org>
 <CACRpkdb+Opdn1eWZSRydS1Bafpqwcg83xEcT-YJC6D-kSSi1ew@mail.gmail.com>
 <20180827165644.GR5081@codeaurora.org>
 <20180828002641.GC2523@minitux>
 <20180828014652.GB13998@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828014652.GB13998@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27 Aug 18:46 PDT 2018, Lina Iyer wrote:
> On Mon, Aug 27 2018 at 18:26 -0600, Bjorn Andersson wrote:
> > On Mon 27 Aug 09:56 PDT 2018, Lina Iyer wrote:
[..]
> > > Thanks, I will look into Hans's RFCv2. But what would help me would be
> > > to avoid creating the IRQ for the GPIO itself (I have the latent IRQ),
> > > if I could just return that instead in gpio_to_irq(), it might be
> > > easier. I understand ->to_irq() is supposed to be a translate function
> > > only, I can avoid the dance of enabling and diabling the PDC IRQ on
> > > suspend and resume.
> > > 
> > 
> > I did implement gpio_to_irq() like this in the PMIC gpio/mpp drivers and
> > we've since concluded that we need to move this to some hierarchical
> > interrupt controller, because people like Linus expect to be able to say
> > 
> >  interrupts = <&gpio_controller 1 IRQ_TYPE_EDGE_RISING>
> > 
> > which is something used all over the place with the TLMM driver today.
> 
> Does it have to be &gpio_controller, can it be another interrupt controller?
> 
> Say,
> 	interrupts-extended = <&pdc 1 IRQ_TYPE_EDGE_RISING>;
> 

It would require that the GPIO interrupt number space of the PDC matches
the pin numbering of the TLMM, to be somewhat maintainable.

And it would still require DT-writers to know that if the implementation
of a compatible, that references a TLMM IRQ, wants to mark the IRQ wake
capable it needs to reference the PDC instead...while still having a
pinmux/pinconf setting for the TLMM.

And for gpio_to_irq() we would need to do the mapping that you suggest,
so the TLMM still needs to have all these references to the PDC.


So I think it would be nice if we could avoid this scenario, but I don't
have any good ideas of how to do this right now...

Regards,
Bjorn
