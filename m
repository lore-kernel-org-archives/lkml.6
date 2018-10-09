Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE65C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A169B21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9ekYKVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A169B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJINwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:52:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36878 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeJINwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:52:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id y11-v6so457426wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f1LE+fuCOHL7G05Gu6dofBOQSogK/95XhyKefcWmaQE=;
        b=S9ekYKVYBqkNHnV9uSe6leKpkrnidTgKHiwypc89ea30D6CJ1GaLdZjQHhK9xnPBWS
         4HFPSE7rsosTaa1hEPsfFEmn9pYbpravqBXw8UZXM+966BUUtbHU3qxrw+Qaz4uG5VTL
         Xmc4YF0JYAJx1yu0QwSD23OyyBsyIqPmJXR8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f1LE+fuCOHL7G05Gu6dofBOQSogK/95XhyKefcWmaQE=;
        b=jBqdWyuRoiiqe4lZiehjQpRhD97VrwmAr0Vjpou6xMB30MxChEJ2ZcSlxVWxPYOq1e
         qwYjkIZjkbRech4Ya1b49IAKjAmKT82QcH9vPftPP3v4nqLHdMggWNa+zDLpJjWDZ3TS
         GvE3C6NMpALHJEwimf3+ZA/MQSRK1WSOjzMgWCar9xDEuyv9dGiz8I4TQsXYLCAwXyqO
         buxvwagk1+gaGr5/wY8MgOgTvmSuTPwlZZQjv/+spNIsG2QFlod8wBgzRq5sqBwpVrwl
         iXz0nE/OgXXNp6MI4RytqN8Y4yX5n/jVrhsf2nphnvSRFFYznLIHhFt7qj64m9da+0Ee
         QmZw==
X-Gm-Message-State: ABuFfogxQZrc1sfuArLo+05ZfMvtD/oZa1ETHUkFweFpGRQcuwmqOD30
        Hzm2B9/Y7XEqP70xM1rwrdQgjA==
X-Google-Smtp-Source: ACcGV61IMrL1QQF4r6gLj40Ih2wDHHUO7PqKVSbYEGKfTyNLfUkFuuv6b+GRg75OQUzyNY7Vq5K0VA==
X-Received: by 2002:adf:b64e:: with SMTP id i14-v6mr19715990wre.14.1539067003223;
        Mon, 08 Oct 2018 23:36:43 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id c21-v6sm927144wmh.26.2018.10.08.23.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:36:42 -0700 (PDT)
Date:   Mon, 8 Oct 2018 23:36:40 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        robh@kernel.org, linux-mips@linux-mips.org,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
Message-ID: <20181009063640.GB32033@dell>
References: <5bb4c6ad.1c69fb81.42bb.93ecSMTPIN_ADDED_MISSING@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bb4c6ad.1c69fb81.42bb.93ecSMTPIN_ADDED_MISSING@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Oct 2018, Paul Cercueil wrote:
> Le 3 oct. 2018 3:02 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
> > On 03/10/2018 14:51, Paul Cercueil wrote: 
> > > 
> > > Le 3 oct. 2018 2:47 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a 
> > > écrit : 
> > >> 
> > >> On 03/10/2018 12:32, Paul Cercueil wrote: 
> > >>> 
> > >>> Le 1 oct. 2018 10:48, Daniel Lezcano <daniel.lezcano@linaro.org> 
> > >>> a écrit : 
> > >>>> 
> > >>>> On 31/07/2018 00:01, Paul Cercueil wrote: 
> > >>>> 
> > >>>> [ ... ] 

Paul,

I think there is something wrong with your mailer since your replies
are being scattered across my inbox un-threaded, making conversations
very difficult to follow.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
