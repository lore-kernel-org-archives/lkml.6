Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653CE20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIAQQIIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653CE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeJYSmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:42:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38188 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeJYSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:42:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so8688560wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=91Pueav4Vw9V+WXsy+uizg0dhkk5+RqR+VUJsReywuQ=;
        b=BIAQQIIltiYMHPywmhFNNBwWuwNSkY2Att38iyzwkaZFEvIOE1e/DqPjQsK127/F2N
         ANcx9U+iwz1qVLP+AWPZ5ptBs9kBr8SmQEHYKhCVJYD0JuwCSUVZjbntyveLC79kPfWF
         3Ka5g42dwM3AOU6slkacAm02QqvIfJBoDAeyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=91Pueav4Vw9V+WXsy+uizg0dhkk5+RqR+VUJsReywuQ=;
        b=e/NRefKGbJIf8CNpjPgRPD7FYXA3+FiRFpu+gGWCsj76kwo4qPdgYZfLunYFbGTDa6
         RMDDuiD7dRKmAA7fSNgUjpYpu7kSZo1H0r20ZRWkpUzQCTxO5SrpjBkiZGeJoawuOZUH
         Y65Fj5hIu8ezPWy8aq9acJ/OA9rSNWYerW6FEVm4LRuhAAXPua4yWcL9tTgrCwYpthTD
         x3Ar+nZY6K9nlxI7yjep9GsLAjI+6R1iZEMzhFiLQjhUxbxvS2PYNzarSnCiSUrBtmvh
         QtKAjhamOp83nPogr+hurZHKOUK3PId62WbJx1fTDbR1q0zUI6pqGkJ+nnt2sTi/u1su
         myzQ==
X-Gm-Message-State: AGRZ1gLD/u+aaYKUnpr8TgxrciQhSZaF2jKIRco8zD6TO7qQv60p/vHv
        Qd6nn6xICRT/ntnJptiuwYbtLOQSSxI=
X-Google-Smtp-Source: AJdET5cZM/Evupm6zHPancrZLQCEdeXdF2FuP/hv9LfAGYcpPVVqS8H1TETVCl1RfXtyP8d7L0DNYw==
X-Received: by 2002:adf:94a3:: with SMTP id 32-v6mr1155337wrr.98.1540462240551;
        Thu, 25 Oct 2018 03:10:40 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id v30-v6sm6844819wra.67.2018.10.25.03.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 03:10:39 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:10:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mattias Wallin <mattias.wallin@stericsson.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: ab8500-core: Return zero in
 get_register_interruptible()
Message-ID: <20181025101037.GR4939@dell>
References: <20181018080534.yw2crvhguen5vajg@kili.mountain>
 <20181025082508.GJ4939@dell>
 <20181025084643.tz72tsh7fulsnnzq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181025084643.tz72tsh7fulsnnzq@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018, Dan Carpenter wrote:

> On Thu, Oct 25, 2018 at 09:25:08AM +0100, Lee Jones wrote:
> > On Thu, 18 Oct 2018, Dan Carpenter wrote:
> > 
> > > I just noticed this in review.  The get_register_interruptible() should
> > > return zero on success but it instead returns the value that it read.
> > > 
> > > I looked at all the places that called this directly and they check for
> > > negatives and treat greater than or equal to zero as success.  This
> > > function is also called as the ->get_register() function pointer.  Some
> > > of the callers of that treat all non-zero returns as errors, so it's
> > > possible that this bug causes some problems in real life.
> > > 
> > > I could not find any callers that rely on the current behavior, and this
> > > makes the function align with the get_register_interruptible() in
> > > ab3100-core.c.
> > > 
> > > Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/mfd/ab8500-core.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> > > index 30d09d177171..66458a329127 100644
> > > --- a/drivers/mfd/ab8500-core.c
> > > +++ b/drivers/mfd/ab8500-core.c
> > > @@ -252,16 +252,18 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
> > >  	mutex_lock(&ab8500->lock);
> > >  
> > >  	ret = ab8500->read(ab8500, addr);
> > > -	if (ret < 0)
> > > +	if (ret < 0) {
> > >  		dev_err(ab8500->dev, "failed to read reg %#x: %d\n",
> > >  			addr, ret);
> > > -	else
> > > -		*value = ret;
> > > +		return ret;
> > 
> > Looks like you just broke the AB8500.
> > 
> 
> 
> Oh wow.  I screwed up the locking.
> 
> 
> > What is it you're trying to achieve here?  Apart from attempting to
> > return with the mutex still held, what semantics have you changed?
> > 
> 
> Sorry that wasn't clear.  Here is the relevant bits from the commit
> message.
> 
> > > function is also called as the ->get_register() function pointer.  Some
> > > of the callers of that treat all non-zero returns as errors, so it's
> > > possible that this bug causes some problems in real life.
> 
> We're returning positive non-zero values on success instead of zero.
> It's definitely a bug, but I'm not sure if it has an impact in real
> life.

Oh, I see.

Maybe:

	return (ret > 0) ? 0 : ret;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
