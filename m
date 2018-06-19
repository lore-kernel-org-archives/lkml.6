Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5942C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C7E208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMKx5lI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C7E208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeFSEFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeFSEFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:05:07 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF6520693;
        Tue, 19 Jun 2018 04:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529381107;
        bh=Lj7aslPniQYElmUxY3/+WNfyrb9H/HdXpL6hQTHSY3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMKx5lI8JKx3pr20Z5ulDgHQU9jlSQhpTegTLQ4AUkHckRzZeoyaOINCkosuBaw8G
         Xdi24krq7DZp0O5bwdrfaXACN2FqoZnxnsiu7fXzqvwbLrKLRRJZPZV4UAV/8QU3bJ
         ZIypE52YTZpNkaYxQn8qC7vMkE6dKSSbGnQhBDcc=
Date:   Tue, 19 Jun 2018 09:34:58 +0530
From:   Vinod <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180619040458.GJ25852@vkoul-mobl>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180618182123.GT14924@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618182123.GT14924@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-18, 11:21, Bjorn Andersson wrote:
> On Mon 18 Jun 07:12 PDT 2018, Vinod Koul wrote:
> 
> > Qcom 8996 and later chips support prng v2 where we need to only
> > implement .read callback for hwrng.
> > 
> 
> The hardware still needs initialization, so I think you should expand
> this to mention that the initialization is moved to secure world and
> that's the reason why we only implement read.
> 
> The question is what happens in projects with other security models.

I did think about that, in those case a DT change would do the trick by
pointing to the TZ EE and loading v1 driver but then is DT board sepcific
or SoC specific, I think latter :(

Can we detect the model..?

> >  	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
> > @@ -154,6 +161,9 @@ static int msm_rng_probe(struct platform_device *pdev)
> >  		return PTR_ERR(rng->clk);
> >  
> >  	rng->hwrng = &msm_rng;
> > +	version = (unsigned long)of_device_get_match_data(&pdev->dev);
> 
> If this is "version" then please make it 1 or 2, if you agree with
> Stephen's suggestion of omitting the initialization of init I think this
> would be better as 0/1 and the variable named "skip_init".

ok will do

-- 
~Vinod
