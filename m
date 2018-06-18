Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9FBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40C3208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zqLARv5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40C3208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934536AbeFRQyk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754619AbeFRQyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:54:38 -0400
Received: from localhost (unknown [122.167.71.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1F520863;
        Mon, 18 Jun 2018 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529340878;
        bh=MOKzRQPybiFQkQeGTcN8+Nbot3QMvDB3IU+aWEoiwE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zqLARv5WhlUbp5u9cGtBL8hNXKEEoLhB1bGEGrWqzAQ7Hedk01dv1IY5In4CuzD5k
         H610XfkKPjwOhPBY3Rx+HHXDktzrgCyP4HgPJr8eINtyS4HY4uJh63apGEihKKT+eT
         bC1arpGuaDJPX5oRYa+GAzA852j7bums7Czn+ihg=
Date:   Mon, 18 Jun 2018 22:24:27 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] hwrng: msm - Move hwrng to a table
Message-ID: <20180618165427.GI25852@vkoul-mobl>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-2-vkoul@kernel.org>
 <152933750484.16708.1950713243960317531@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152933750484.16708.1950713243960317531@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-18, 08:58, Stephen Boyd wrote:
> Quoting Vinod Koul (2018-06-18 07:12:57)
> > @@ -127,6 +125,13 @@ static void msm_rng_cleanup(struct hwrng *hwrng)
> >         msm_rng_enable(hwrng, 0);
> >  }
> >  
> > +static struct hwrng msm_rng = {
> > +       .name = KBUILD_MODNAME,
> > +       .init = msm_rng_init,
> > +       .cleanup = msm_rng_cleanup,
> > +       .read = msm_rng_read,
> > +};
> > +
> >  static int msm_rng_probe(struct platform_device *pdev)
> >  {
> >         struct resource *res;
> > @@ -148,12 +153,10 @@ static int msm_rng_probe(struct platform_device *pdev)
> >         if (IS_ERR(rng->clk))
> >                 return PTR_ERR(rng->clk);
> >  
> > -       rng->hwrng.name = KBUILD_MODNAME,
> > -       rng->hwrng.init = msm_rng_init,
> > -       rng->hwrng.cleanup = msm_rng_cleanup,
> 
> Wouldn't it be a lot easier to skip assigning the init and cleanup
> functions on v2 devices with an if statement? It would be smaller size
> wise too because then we don't have two structs for v1 and v2 hwrngs.
> Plus the patch would be smaller overall because we would do everything
> else pretty much the same besides the if condition in probe.

Yes it would be an alternate approach and would involve lesser code
change.

My personal preference is table based init rather open coding and it
makes adding future revs easier, but said that I can change this...

-- 
~Vinod
