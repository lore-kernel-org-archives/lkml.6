Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691CDC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2412A20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn3aPXV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2412A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbeFTNhg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754101AbeFTNhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:37:33 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33F120846;
        Wed, 20 Jun 2018 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529501853;
        bh=KbDOPDM66ETxBSlPC8Xp7mV5cqmnvxTXsAsXbvkL+sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pn3aPXV6Un9rEuOjMgdgaUKljQXJrNssi3W8PIR1coHjTxNLwCToS+JsVe7cHhm02
         hH0pBkbtQU7+KwjuO0vlV7gpuoR1f5Z5qgG5yHy8uRxtHtutzdfCGrjweGXIoE2v7E
         w6YCxO6/Uu9bKa76bChIMu/RMEkM4+bMJIiRDq38=
Date:   Wed, 20 Jun 2018 19:07:25 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwrng: msm - Add support for prng v2
Message-ID: <20180620133725.GB27187@vkoul-mobl>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <20180619095430.26358-3-vkoul@kernel.org>
 <152947431955.16708.15247307054260887941@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152947431955.16708.15247307054260887941@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 22:58, Stephen Boyd wrote:
> Quoting Vinod Koul (2018-06-19 02:54:30)
> > Qcom 8996 and later chips support prng v2 which requires to
> > implement only .read callback for hwrng.
> > 
> > This version of chip has multiple Execution Environments (EE) and
> > secure world is typically responsible for configuring the prng.
> 
> Sometimes secure world is not configuring the rng though. I prefer we
> have a DT flag for this to indicate if secure world has configured it or
> not and then skip the init logic when the bool property is present in
> DT. Then the DT property can be set on firmwares that are making things
> blow up when we try to read the 'configured' register. I'd also file a
> bug to qcom to tell them to unlock that config register for reads so
> that things can work simpler, but who knows how that will work out.

I dont feel that would be required. See below..

> It really sounds like the hardware isn't actually different, just the
> firmware has decided to be more strict about making reads fail now.

So in this case base hw block seems similar but consists of multiple
Execution Environment (EEs) and all of these contain only data
registers. Only secure environment has configuration. Each one has its
own register space.

In a case where we dont have secure world, we can point to secure
environment with v1 ops, so driver shall configure and run.

Thanks
-- 
~Vinod
