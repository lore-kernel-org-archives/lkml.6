Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC9AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DBB2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3/GX/g5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DBB2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeH3Olq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:41:46 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:39053 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbeH3Olq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:41:46 -0400
Received: by mail-pf1-f178.google.com with SMTP id j8-v6so3697517pff.6;
        Thu, 30 Aug 2018 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TVQROg9WskiHC4Aj+1lfnwZqAT2RkY1Mgj+2OFztoms=;
        b=r3/GX/g53dbQvm2yKwep6BWSpfmxICFh0pBWnRMoh3k6WWB4aF6rJL9CWCR8ES4PxD
         f0jifb8AAREWgg9YC5Ti7uir1eKXR8LrEoL1rExmkWWGwnbsQHO9ceYuBKNio04FcN4a
         Eu5DC2KD5rFeyJSVT9b9MqLlUgX2X9djn9/qK5aCPF9zpOIfEqRiZsIU9vjqs4ju/AYY
         nJyaDr8gyHNfFnLOTR4EkC3ES+9qyi03a+Tak4LS+RtAfnw1GqnjnrQUXt9DFoMEo3jc
         p6Cj0bGKrKN41M4PfShX3hUL+u0pETs/JtAk4sTrSaxX9k+X9EOoKrArB1APSh5Oft2C
         rwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TVQROg9WskiHC4Aj+1lfnwZqAT2RkY1Mgj+2OFztoms=;
        b=FPmi2BQ/84q8jLaTOe9MR/sfvFzEd5SuQ8mSMwUP0rEidBYwcfNo6RcjPAT/5x4FZm
         b/xLuigKH/WrLkfOnMTUUTN7U+GIm6Ygk973+Chhabh0vfBcr+R9J81V5Bg+puA0pL3E
         1DBcupYSH8vSOUqfcfFplAPxuuSYRx/kMY5ysaU/5pXIsGhx0cX1nJDG/NupO0BSXnAt
         8RXp7tVax8/SJjgG3cUef7ka04jwLHI1VbVJlozG1gw+YqsUE2dACNia3RDX14UJaSmI
         tWhtwr6FxygO3O791hsMXT0MUVgbdd/kuLUPYqnDSKDT5n5zufztkKwPH2HgjdVp2zuU
         rw8A==
X-Gm-Message-State: APzg51Bhhs2DENdsWKRe/E3vYzwUq2tlyK+LAvrYxX6bV79qVkRJTzbt
        6iceyUPBOEbkbrzLBwN1v2Q=
X-Google-Smtp-Source: ANB0VdYWjpwxHteLnvGbccLbo0AMMPHpEF8L1B6ESEeQo1uZN+bKAyLmCLkMKx6brY0kjzMdMVzgig==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr9366090pgv.436.1535625616610;
        Thu, 30 Aug 2018 03:40:16 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k5-v6sm17449153pfj.30.2018.08.30.03.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 03:40:14 -0700 (PDT)
Date:   Thu, 30 Aug 2018 03:40:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Meelis Roos <mroos@linux.ee>,
        Linus Walleij <linus.walleij@linaro.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: various dma_mask fixups
Message-ID: <20180830104013.GA27089@roeck-us.net>
References: <20180829062401.8701-1-hch@lst.de>
 <20180829223821.GA29499@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829223821.GA29499@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:38:21PM -0700, Guenter Roeck wrote:
> On Wed, Aug 29, 2018 at 08:23:58AM +0200, Christoph Hellwig wrote:
> > Fix warnings and regressions from requiring a dma mask.
> 
> With this series applied, I see the following in my sh4 boot tests.
> 
> sb 1-1: new full-speed USB device number 2 using sm501-usb
> sm501-usb sm501-usb: OHCI Unrecoverable Error, disabled
> sm501-usb sm501-usb: HC died; cleaning up
> 
> This is a persistent problem. Reverting upstream commit 2f606da7823
> ("mfd: sm501: Set coherent_dma_mask when creating subdevices") does not
> make a difference.
> 
This failure is now seen in -next.

Guenter
