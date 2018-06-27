Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA59C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D3425E67
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U24smYfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D3425E67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeF0HCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbeF0HBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:01:53 -0400
Received: from localhost (unknown [106.201.61.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7335325791;
        Wed, 27 Jun 2018 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530082913;
        bh=DHnTsjADK66S93R77642TYs8G4jHOm/8Arr1nxj5Iz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U24smYfmQI9ZjWlk2+JJKQIITRW06xtcrGhaxmyLEXeJts07Pqz455Wq8O3K/8Cpd
         1qSRL5bBjmIGEprcjkYlKJez3G/kUWFj/tox7D72gVK3WcnN+XCZKK8tpjJk3/EQS+
         QNMmqvnmHS0dfmOpzCCqzT5HbrwvekkOXOHJczAw=
Date:   Wed, 27 Jun 2018 12:31:44 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180627070144.GG22377@vkoul-mobl>
References: <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <52764537.cSZCttAJ1I@tauon.chronox.de>
 <20180627062701.GF22377@vkoul-mobl>
 <170012246.0U45yCEtus@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170012246.0U45yCEtus@tauon.chronox.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

Thanks for quick reply,

On 27-06-18, 08:43, Stephan Mueller wrote:
> > On 27-06-18, 08:13, Stephan Mueller wrote:
> > > The key is:
> > >         alg->base.cra_ctxsize   = sizeof(struct drbg_state);
> > > 
> > > during initialization since the kernel crypto API allocates that buffer
> > > for
> > > you and releases it during deallocation.
> > 
> > The difference here is that memory is allocated by crypto and driver has
> > no way to pass "it's" own data while doing registration. Ideally
> > registration should accept a pointer/long and pass that back on a
> > callbacks
> 
> Looking at your code, it seems you do what makes sense: there is only one 
> instance of the driver, if at all. Thus, having qcom_rng_dev as static makes 
> sense. The kernel crypto API allows arbitrary instances of the RNG as well as 
> frequent allocations and deallocations. And this is why there must be a 
> disconnect between the one hardware-resource driver-instance data structure 
> and the (potentially) multiple crypto API RNG instances and their data 
> structures.

For now it is true, but somehow doesn't make me happy to bank on that..

> > 
> > Currently am doing bunch of initialization in .probe (platform driver)
> > and I think recommendation would be to move that to .cra_init, which seem
> > plausible but I don't have pdev to read hw_resource etc.. so would still
> > need to get that.
> 
> It seems that your allocation during probe relates to the hardware resource 
> where you only have one in the system. Thus, doing the allocation here makes 
> sense. And, you do not want to perform probe or such resource allocation once 
> per crypto API RNG instance allocation. As said, there can be multiple or even 
> they can be allocated and deallocated frequently. This in particular applies 
> if your driver's "stdrng" has the highest prio which means that it will be 
> allocated and deallocated frequently.

Right, that is how I visualized it.

Is there a way where we can tweak the register API to pass hw_resource
pointer and get that back? Would that work with the security model in
crypto.

I do not like globals and somehow don't feel that we should do it that
way

Thanks for the quick look on the code.

~Vinod
