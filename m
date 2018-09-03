Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FD7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BA52086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6J1vKzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeICXMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:12:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35592 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeICXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:12:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so525168pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RXFkhu1ME6EeskS955PMCdXwVr5HkohQXwFd76xhU3g=;
        b=H6J1vKzpQnhLQUdkGqh6461NH1ae+YmyodgLJ+C02vIA82m/9MGYIXNchciPtzn8ux
         A+zme8DzkdDOUtKFSwTJ79wJmjfUEmVH8oaw2XEz/FQeXB7nE8I4KAuXn41JFPEmlu70
         jBKy2kpFZcNwKMiSYh6xPRh7/BN7CT7skNUh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RXFkhu1ME6EeskS955PMCdXwVr5HkohQXwFd76xhU3g=;
        b=keHfDaO/b5OdOrk+0zaiDps0AV86ZlFT7hNvrmfaTWoTe5IIw0mbU3TpVCPkSNZGfR
         j0rDmiTutGR9AjuDgeF8vXQ7nM0V7cBpv4/t1QJgkVbT080JBCPgAKaLZNDyDfh4s9Jn
         k3/9Hzt6e4hS3yoggCCq5Oq8Iboa7mVvJFzUfv5B6Dy9Vf5WFT0B1QGwdkRki74JZIV9
         kvHaTZHzMwH0s49XEkoC0EXWkFq7bgx4v5TjlNIL2VpGKScuIu0502LYqbPlqF4hE/vk
         SWakX4OpjR7KtKxp3Fdq4RQOljwCDJH7xy+xb6Vay2as5/3MQq0yUoNiBMwjcnAgmJwX
         myfA==
X-Gm-Message-State: APzg51CsfjWQZBzRYZk4CbDewu2BPWx+oMyb3JgMlxrOeA61M39WoasV
        naxx3W+8FfIRP9i5Lj72eiRvHw==
X-Google-Smtp-Source: ANB0VdZJaLBp1v4x4WgEdFpY0dg7S8DKfJLghUBAhJehNN1xQ5aJ5VueBgn6TSnWVYbB8sGzCiLu6g==
X-Received: by 2002:a63:ec43:: with SMTP id r3-v6mr12850626pgj.295.1536000676833;
        Mon, 03 Sep 2018 11:51:16 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g25-v6sm36995248pfd.23.2018.09.03.11.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:51:16 -0700 (PDT)
Date:   Mon, 3 Sep 2018 11:55:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     kgunda@codeaurora.org
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V4 3/8] backlight: qcom-wled: Add new properties for
 PMI8998
Message-ID: <20180903185510.GB3153@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
 <20180807052355.GA23866@tuxbook-pro>
 <897ab82c450bff71658c1fa32e7e6021@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897ab82c450bff71658c1fa32e7e6021@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15 Aug 22:23 PDT 2018, kgunda@codeaurora.org wrote:

> On 2018-08-07 10:53, Bjorn Andersson wrote:
> > On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
> > > diff --git
> > > a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> > > b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> > [..]
> > >  - qcom,num-strings
> > >  	Usage:        optional
> > >  	Value type:   <u32>
> > >  	Definition:   #; number of led strings attached;
> > > -		      value from 1 to 3. default: 2
> > > -		      This property is supported only for PM8941.
> > > +		      value: For PM8941 from 1 to 3.
> > > +			     For PMI8998 from 1 to 4.
> > [..]
> > > +- qcom,enabled-strings
> > > +	Usage:        optional
> > > +	Value tyoe:   <u32 array>
> > > +	Definition:   Array of the WLED strings numbered from 0 to 3. Each
> > > +		      string of leds are operated individually. Specify the
> > > +		      list of strings used by the device. Any combination of
> > > +		      led strings can be used.
> > [..]
> > > 
> > >  Example:
> > > 
> > > @@ -99,4 +146,5 @@ pm8941-wled@d800 {
> > >  	qcom,switching-freq = <1600>;
> > >  	qcom,ovp = <29>;
> > >  	qcom,num-strings = <2>;
> > > +	qcom,enabled-strings = <0x00 0x01>;
> > 
> > Nit. I would assume that specifying qcom,num-strings = <2> implies that
> > the first 2 strings are used, so one would not also specify
> > qcom,enabled-strings.
> > 
> Thanks Bjorn for reviewing the series !
> 
> "qcom,enabled-strings" need be specified along with the "qcom,num-strings".
> Because the enabled-strings can be <0, 2> or <0, 3 > also. The driver picks
> the string
> configuration from the enabled-strings array and enable only those
> current-sinks.
> 

The original binding described qcom,num-strings to mean "the first N
strings", requiring qcom,enabled-strings now would break backwards
compatibility with this binding.

In the case that qcom,enabled-strings is specified we can easily derive
num-strings from the listed entires. So I would suggest that you look
for enabled-strings and if not found fall back to checking for
num-strings.

Regards,
Bjorn
