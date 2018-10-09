Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D863C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66D3213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6GpxPmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66D3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJINRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:17:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37352 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeJINRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:17:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so531172wmt.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xutPH9V/gCWYoz9+4ZaUY2xd0PLETlGDWqLm4kuQVBw=;
        b=C6GpxPmn3v2Uy2CEFP8jS2cDN2ryu1gX9Ug0zT+FWrmEr5Krn7XZrI1f8HXczgjQxM
         5jnOM+qa4NAd6graeyXQnPWhdSttvlct9vvWNbtixK0zCQ48Ot0zISam6lZhB4tdecef
         nzAqCiu4T7CyimrzYR/IZQyFmWjzuakJEkSB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xutPH9V/gCWYoz9+4ZaUY2xd0PLETlGDWqLm4kuQVBw=;
        b=lGfprTvKWtG8li4x+lHn21wjEq44jDXEDFhOPuBPqggYVgdqoYE4Wnvs3lH4jsJ/vc
         aidLnuf5VX+winTwzuQGyfn+Xyx2UynnCMmNw+ufWurUdSLI2PolQhE7YKFQfbCiXd10
         OCSJ1dW5NQd2l708qqVSgfiO8DgCfGk2Zfz+j4T4ZIZi63Bm5HtHXAnt9g1Lo8FakOpH
         WQqAyIPXQwKgJ8nn9tRWGLh+k1ma/aMg1mh64eROPk9xwScxQbnzBRRVhmVeLkuL9AgM
         R8yRZrpA5TwgEmr3G86Liien8EVuCVM0IEY7C0q39WLJhxU5PXDvCmYY1E3Zuh821DUO
         fgrQ==
X-Gm-Message-State: ABuFfogf3Gkx7vkXQKB8dDnDaA8+voBf4tlRD9vdhncW3c9VnTIAiPj1
        attQcZPNyUo55vaTgqfTOfraXA==
X-Google-Smtp-Source: ACcGV61BbehdGeUFz3q8ETD+IwLMRQHDSNUaCqDOMPI99xn+RADcFHDxpG0clKWSwMfJpCUqQiSrsg==
X-Received: by 2002:a1c:ae08:: with SMTP id x8-v6mr669381wme.86.1539064945670;
        Mon, 08 Oct 2018 23:02:25 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id t66-v6sm8329309wmt.5.2018.10.08.23.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:02:24 -0700 (PDT)
Date:   Mon, 8 Oct 2018 23:02:22 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        sboyd@kernel.org, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/7] regulator/mfd: Support ROHM BD71847 power
 management IC
Message-ID: <20181009060222.GA4324@dell>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <20180921172959.GG20825@sirena.org.uk>
 <20180921180241.GA4358@dell>
 <20180921181217.GI20825@sirena.org.uk>
 <20180921185258.GC4358@dell>
 <20180928071437.GB9389@localhost.localdomain>
 <20180928133046.GL20825@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928133046.GL20825@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018, Mark Brown wrote:

> On Fri, Sep 28, 2018 at 10:14:37AM +0300, Matti Vaittinen wrote:
> 
> > I was just wondering if I could do something to help get this patch
> > series applied? Mark, have you had the time to take a look on pickable
> > ranges addition yet? Should I do some rebasing/resending? Are you giving
> > me a nudge if I can do something?
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so 
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> Sending content free pings just adds to the mail volume (if they are
> seen at all) and if something has gone wrong you'll have to resend the
> patches anyway so resending with any comments addressed is generally a 
> much better approach.

Steeling and adding to an Emacs key-combo for easy insertion into mails!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
