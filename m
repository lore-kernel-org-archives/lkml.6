Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B211C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01C724687
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vrkt+ZVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01C724687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933139AbeGDGKq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932586AbeGDGKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:10:44 -0400
Received: from localhost (unknown [171.76.122.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CD024687;
        Wed,  4 Jul 2018 06:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530684643;
        bh=6k0wGA0K2mOvi7kkjpgV590JAND5taF4A4cJwIK6wOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vrkt+ZVWq2fz8jmweSCbE/x7ocSPA8EmEsokH0RaprGLke0rrY/PWMgr+FhPmSz2I
         Gi/GhVJgYKLz1oHmxNu8dr7geQ8pOB+OZ1dmVJSWeUJnlLNlfN0PXas452ALqEc/is
         /xy0WZ+eHufZHVTneoeLvr92zmS6am/Jy7ecz3SE=
Date:   Wed, 4 Jul 2018 11:40:35 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 3/6] crypto: Add Qcom prng driver
Message-ID: <20180704061035.GY22377@vkoul-mobl>
References: <20180703060434.19293-1-vkoul@kernel.org>
 <20180703060434.19293-4-vkoul@kernel.org>
 <2990655.vKmMgW600W@tauon.chronox.de>
 <20180704041059.GT22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704041059.GT22377@vkoul-mobl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-18, 09:40, Vinod wrote:
> Hi Stephan,
> 
> On 03-07-18, 15:28, Stephan Mueller wrote:
> > Am Dienstag, 3. Juli 2018, 08:04:31 CEST schrieb Vinod Koul:
> > > +static int qcom_rng_read(struct qcom_rng *rng, void *data, size_t max)
> > > +{
> > > +	size_t currsize = 0;
> > > +	u32 *retdata = data;
> > 
> > How can you be sure that this cast is appropriate? I.e. how is it guaranteed 
> > that data is 4-byte aligned?
> 
> While reading we check the alignment:
> 
>                /* make sure we stay on 32bit boundary */
>                if ((max - currsize) < WORD_SZ)
>                        break;
> 
> > Also, the data variable in qcom_rng_generate is a u8 -- shouldn't this type be 
> > used instead of a void?
> 
> That does make sense to me. IIRC the read is for a byte. I will check
> this and update it

Okay so I rechecked this, the hardware gives 32 bits of random data. I
am thinking of splitting the word and updating by each byte. That way
trailing zero can also be avoided which is the case now

-- 
~Vinod
