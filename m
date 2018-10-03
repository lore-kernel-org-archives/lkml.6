Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE6AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7593020835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYyrJb5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7593020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJDAOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:14:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33551 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJDAOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:14:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id s4-v6so3806061plp.0;
        Wed, 03 Oct 2018 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PW5z9tExrunyFgR1YqlwQfLvem9RVj4xz/YWaHdSUI4=;
        b=TYyrJb5Sa2CLiCxOOndpq7P0gVwJWOM4XBbCYjz3Fi5ji0OVMe3tH0qiMRVcSP6qeP
         auYojLZMtv9hw/QQXR4g12QA1FnVqJ1I1+YGOjanzUum1Y9xzBbz8SsHTORkzOT2nUvj
         t0ru2BuMk7tZPQkzRzH2ucp5M51REkFT50h2BJ5ImGDNIWn0/6lWmmqjL8wanIWLdZos
         ID0Gsm0fXYalGvNr6D70vkrnLvI0qtI3Cd+2Z4w6NuHNFKs1Xo3+0rWfISNdjL0/W0ns
         eCjgP148ZZAPFgdWgl/OATkPm5voAaXOhron2DIhxW7NIE73M9ES1nwe8r84wAbSul2d
         sTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PW5z9tExrunyFgR1YqlwQfLvem9RVj4xz/YWaHdSUI4=;
        b=mlYhPhw5NekCmfmt78la0u5yKgJNYMUTrSaqeuIYa0PEUIpuR2FlNJk8Kq2+vs0EvX
         V/o2e8aRD/ImC5hHI7yGw45ETRhDSrNYZm0CbHl5YT6BEh9jl7Y8Orskoo6Ksz2/PnxO
         sCCpW1NJGDD6WMMgLWUenKRZsMh5C3W3wrupKDncJfO7oi6wnhoMY9T7KdnEKQ7I16zC
         FvQE7wZ3Csp7uBolkbzHXFSTBny8KmOlPPbUZONwoz6cOo1RP62B3EodGQTx/7f0epXp
         A8soB5CtTRtAzm+FYoATjrN2vuaTzvHivS+qW2pMQZTCd6kg41CvjMin0hG6+qfvOIi5
         Ip2Q==
X-Gm-Message-State: ABuFfog5ES+9a6DZVpR0mNIaSwhzWwK4lQOls9dGU3pOHRA7ek4AOal8
        TFOSNyfztFh1nQhowXwffZ4=
X-Google-Smtp-Source: ACcGV62xdz0lGz2uO5KFIPJkMmXp8GPlVVSsb2Kf9cpLipJCvv/cle3xurZTpljJaV08YB23dwuFpw==
X-Received: by 2002:a17:902:7c96:: with SMTP id y22-v6mr2615341pll.321.1538587482616;
        Wed, 03 Oct 2018 10:24:42 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m15-v6sm2917051pgt.28.2018.10.03.10.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:24:41 -0700 (PDT)
Date:   Wed, 3 Oct 2018 10:24:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4.18 000/228] 4.18.12-stable review
Message-ID: <20181003172440.GA7955@roeck-us.net>
References: <20181002132459.032960735@linuxfoundation.org>
 <af80bbc1-6753-01d2-1ecb-830720b38f48@roeck-us.net>
 <20181003162539.GA4653@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003162539.GA4653@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 09:25:39AM -0700, Greg Kroah-Hartman wrote:
> On Wed, Oct 03, 2018 at 05:59:09AM -0700, Guenter Roeck wrote:
> > On 10/02/2018 06:21 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.18.12 release.
> > > There are 228 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu Oct  4 13:24:08 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > 
> > 
> > Build results:
> > 	total: 137 pass: 137 fail: 0
> > Qemu test results:
> > 	total: 321 pass: 320 fail: 1
> > Failed tests:
> > 	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> 
> What is the status of that powerpc failure fix?  What's the odds it can
> get into mainline soon?
> 

The fix has been -next for about a week.

da08d8cb8cfc of: unittest: Disable interrupt node tests for old world MAC systems

You'll have to ask Rob (copied) if he plans to send a pull request before
the next commit window opens.

Guenter
