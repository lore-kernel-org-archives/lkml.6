Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2210AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A2420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIcnHl8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfAKJyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:54:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43937 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfAKJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:54:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so14459444wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nkf9/5iA3E6KP4iOorpGJNEgxsrAnhqFpwiLvHdb7lg=;
        b=EIcnHl8JnL0fqQn6uGpdUkzn36mc3hQ2zifOp4JPzxmLwiO179GzbCLnpmHFcuHQ93
         Om/0KyMNA3UA4rccGU96pgfJwY3lP8g4BK4p53L2e5+5zmNtLR1Rn34ZCdxEjcRW085h
         Di0rxMiUcUAbPXz5yYHlNdQWZSC7TWATRptao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nkf9/5iA3E6KP4iOorpGJNEgxsrAnhqFpwiLvHdb7lg=;
        b=sgtRguIJuOtlE0jzTQoBxToGH3jmG2oBu6pfBpyTrHLAGiIM0D2+6fYryz5WJ5QY+G
         NND85b1zEVx6kvpuZYUUqJkKMs9skX1Gg7U+EZDp9shABzFW9a676OdpHEDrd7QQGc5g
         3LVQD0jN3EihMXAooEsLdtMaOGcUf6U+p0aCO88iMf9quMI9uaHwsM8Yj1qzpUOXkuCH
         YDnKYq0P2PsBVCxKeceaexJ+iK31xgPFiWrSbGcImeKA2pwB4zrb/nSOEs16HEQ7ZlFC
         VcWqCLruUIy9vV/JQbswmLh+F8GAr6U3cd65x67HtvHYKyL+YXD4sxZwYo81wxH7L8Qd
         svgA==
X-Gm-Message-State: AJcUukdXJNI3qCa/RGn6irRU5Df8fui3+mOGvbVWQ+fuyMNAUJTMni1x
        VedA1xSreNl1tpUM5qePkEduTA==
X-Google-Smtp-Source: ALg8bN56GVH2/sjleOq169ZKaNQdMURQeexzxkatzs56pWJTpsTbQdDVeUtfDiZH6iITIsZSaqx5vw==
X-Received: by 2002:adf:b307:: with SMTP id j7mr13532668wrd.46.1547200457315;
        Fri, 11 Jan 2019 01:54:17 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f137sm18810289wmg.29.2019.01.11.01.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 01:54:16 -0800 (PST)
Date:   Fri, 11 Jan 2019 09:54:14 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, mpm@selenic.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>, tee-dev@lists.linaro.org
Subject: Re: [PATCH v2 3/4] tee: add supp_nowait flag in tee_context struct
Message-ID: <20190111095414.nbnzbocdn32zypdc@holly.lan>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
 <20190110142355.bcgw62w2qk2mlzj6@holly.lan>
 <CAFA6WYPzA+rKMq58xVPghSe-mLa6fDi4t=1DYxakEaeG+ayQug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPzA+rKMq58xVPghSe-mLa6fDi4t=1DYxakEaeG+ayQug@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:00:49PM +0530, Sumit Garg wrote:
> On Thu, 10 Jan 2019 at 19:53, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > > index 9ddb89e..5d6c317 100644
> > > --- a/drivers/tee/tee_core.c
> > > +++ b/drivers/tee/tee_core.c
> > > @@ -105,6 +105,7 @@ static int tee_open(struct inode *inode, struct file *filp)
> > >       if (IS_ERR(ctx))
> > >               return PTR_ERR(ctx);
> > >
> > > +     ctx->supp_nowait = false;
> > >       filp->private_data = ctx;
> > >       return 0;
> > >  }
> > > @@ -981,6 +982,7 @@ tee_client_open_context(struct tee_context *start,
> > >       } while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
> > >
> > >       put_device(put_dev);
> > > +     ctx->supp_nowait = true;
> >
> > Why automatically set supp_nowait inside open_context() ?
> >
> 
> I think this is the default behaviour (non-blocking request) that any
> in kernel client would expect. Also this flag could be configured
> again before call to open_session() if any in kernel client requires
> different behaviour.

Makes sense. I think this is a deep enough behaviour to warrant proper
commenting though.


Daniel.
