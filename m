Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 782EBC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9CA2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fhJX+X2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9CA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935687AbeFMN2Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:28:25 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45829 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935655AbeFMN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:28:23 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3-v6so3924344lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxi3E+0EYPM/bWQa6eUMyfy6hnoZblU3LLsSYPTD6nM=;
        b=fhJX+X2agVQlcqhnyt8sL8XovCen7xMQYj8/TYap9TethGNO8niu/3gNcKun/V1fLX
         jCP9s0d0fNLInMnWhjmKy+ekk1GYhrcXHo0l2qQEG4qE8rwOAkRnrHtpJSQ/FWacQHtc
         52B/XxsHpHna6/5P/EblImHZxweDKhZt2y0ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxi3E+0EYPM/bWQa6eUMyfy6hnoZblU3LLsSYPTD6nM=;
        b=Yqv9gusuUUp5nPjsnvABWwoZOb8ey1Og6JIdEcs4fv5Wf3edV9PBqo+0Zj1u+vNKot
         E/WzROMISOzvR88bmi0pSU0tgR/N06HS03xQwX2P1Q9dMxXu+6ndXRDO2uSRcAriKpkD
         BBKmzQABM/TmYYCk6m6Bsbn5y9cC4WVcdhpxzTqPQiEkFCuoFhspahgImT31IUM6jHnr
         3kR7+TABteYeSjZUN3NtZZHqpuVvokWwNklJyFjo4HWjs50Ph5yZtspTCAagBvX1UY+1
         GDIcshDS27F73OyAf2jdFzFko7zsi64GecH7i6s85NODGhXn+pD+zAHHYWPrvXneNp7m
         py/g==
X-Gm-Message-State: APt69E0MUshXCUnRm9LAM0GDdl92ulefjSh1QDvkZDBJUg0JGNNtBqPn
        Q3ZqXHJ8daywYM0zFAXQUmNbEg==
X-Google-Smtp-Source: ADUXVKITtZTM3LV1ewxKmu4YK2CeFWFvyVdm0mO6VraDhcgLDh1OPLSQXIF7t38sDjxFyZx5eoZAcA==
X-Received: by 2002:a2e:2161:: with SMTP id h94-v6mr3347983ljh.58.1528896501659;
        Wed, 13 Jun 2018 06:28:21 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e27-v6sm572970lfb.86.2018.06.13.06.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 06:28:21 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:28:19 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Govind Singh <govinds@codeaurora.org>, bjorn.andersson@linaro.org
Cc:     kvalo@codeaurora.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: FW: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
Message-ID: <20180613132819.GA12603@centauri.ideon.se>
References: <20180612113907.15043-1-niklas.cassel@linaro.org>
 <20180612113907.15043-2-niklas.cassel@linaro.org>
 <7058492257914633b55fcd423e4c0b59@aphydexm01b.ap.qualcomm.com>
 <47cf8ec1b11d727ea928a307a431d4a2@codeaurora.org>
 <20180612124403.GA26986@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612124403.GA26986@centauri.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:44:03PM +0200, Niklas Cassel wrote:
> On Tue, Jun 12, 2018 at 06:02:48PM +0530, Govind Singh wrote:
> > On 2018-06-12 17:45, Govind Singh wrote:
> > > -----Original Message-----
> > > From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Niklas
> > > Cassel
> > > Sent: Tuesday, June 12, 2018 5:09 PM
> > > To: Kalle Valo <kvalo@codeaurora.org>; David S. Miller
> > > <davem@davemloft.net>
> > > Cc: Niklas Cassel <niklas.cassel@linaro.org>; netdev@vger.kernel.org;
> > > linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > ath10k@lists.infradead.org
> > > Subject: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
> > > 
> > > ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
> > > 
> > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > ---
> > >  drivers/net/wireless/ath/ath10k/Kconfig | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/wireless/ath/ath10k/Kconfig
> > > b/drivers/net/wireless/ath/ath10k/Kconfig
> > > index 54ff5930126c..6572a43590a8 100644
> > > --- a/drivers/net/wireless/ath/ath10k/Kconfig
> > > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> > > @@ -42,7 +42,8 @@ config ATH10K_USB
> > > 
> > >  config ATH10K_SNOC
> > >  	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
> > > -	depends on ATH10K && ARCH_QCOM
> > > +	depends on ATH10K
> > > +	depends on ARCH_QCOM || COMPILE_TEST
> > >  	---help---
> > >  	  This module adds support for integrated WCN3990 chip connected
> > >  	  to system NOC(SNOC). Currently work in progress and will not
> > 
> > Thanks Niklas for enabling COMPILE_TEST. With QMI set of
> > changes(https://patchwork.kernel.org/patch/10448183/), we need to enable
> > COMPILE_TEST for
> > QCOM_SCM/QMI_HELPERS which seems broken today. Are you planning to fix the
> > same.
> 
> 

This patch is good as is.

However, Govind's QMI patch set together with this patch
resulted in build errors.

FTR, these are fixed by:
https://marc.info/?l=linux-kernel&m=152880985402356
https://marc.info/?l=linux-kernel&m=152889452326350


Regards,
Niklas
