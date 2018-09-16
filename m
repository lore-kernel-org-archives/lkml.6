Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADCECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189C5206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMcDdB3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189C5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIPUie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 16:38:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34730 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeIPUid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 16:38:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so14834717wrd.1;
        Sun, 16 Sep 2018 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZfQijIPZfgdgNQuqsuqEELqF8EHTRS+Co8vtfK6lw8=;
        b=mMcDdB3eg30bIW5S0upN1pIjmIRnoobHHxM8pYqTaxC7+/HRUyZaC80wBWTLMeFPC7
         WE7dknRSgUXuBUvs4E38uropSPQAS4wAOomrAk7uuQu9JnBBSc/zv/KBvhcPBJmsQxN4
         jMVfhb677gikymz+ErIkdfQB+0hyAMPA75/xLD8zEMPCVuibT2a+ghjncUhPdQJrzo9u
         LTyHfrottIjBmVCbL4Kcc4XGsB5o6vHMV7X+KyncNjIrMVznVT8qOmThTqGrtrAb576P
         bhi/Liz0zCbkmdg2eUV4gmNU+igqNZFJq0r+/HTeB3HdlTQISm6OdP+Uvk4+wPn+kvus
         q2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZfQijIPZfgdgNQuqsuqEELqF8EHTRS+Co8vtfK6lw8=;
        b=DMk3KSYwjmTNZS5ebxRlBf8VY6VaZs0YVQYTPH+Sa4h//USp8XXtWGtP/C84Sw9Sef
         s/xt50X2WJOb0xHcZ9qI8E7B4e+4K7hphfXkFY4TByhODGewNi0qb7U7eVQSahsk4mlA
         s1ebZaIsHb1SHQZIVk53cYnK/hkhkiexif6/sch0S51A5oBzMtsVMQLatsHPnkmNpakX
         5gkyQMbcRu6r98zCnz6nPqD822g30jGwUS9wFiNNfiYRP8t04UZ3hlcPp4Cbq8V1lAuK
         GA7sAj4uweN0MkMmZJKXIalvp+rflzW1q9FfV8bxRc0Z5Xe4F2AGO85QzrUXdhQgsTk3
         7/sQ==
X-Gm-Message-State: APzg51DEI00niRZoFCqmZfqAKkJ367rbrG+mVcq5H4kUlO8o0wbJHM0G
        06Hs5FDKvceZgF+8cIGjEFU=
X-Google-Smtp-Source: ANB0Vdat1IAc+lL74h14KUsvYSKJwnd77xU5khy8F9kcZa3N0J1FQ2Is04Glco3ny+PlxKylfxSKTQ==
X-Received: by 2002:adf:8567:: with SMTP id 94-v6mr16345547wrh.223.1537110915934;
        Sun, 16 Sep 2018 08:15:15 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a6-v6sm4930662wmf.22.2018.09.16.08.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 08:15:15 -0700 (PDT)
Date:   Sun, 16 Sep 2018 08:15:13 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] iio: adc: max9611: Avoid implicit enum conversion warning
Message-ID: <20180916151513.GA10200@flashbox>
References: <20180915052511.2243-1-natechancellor@gmail.com>
 <20180916105351.1bf859ee@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916105351.1bf859ee@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 10:53:51AM +0100, Jonathan Cameron wrote:
> On Fri, 14 Sep 2018 22:25:11 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > Clang warns when an enumerated type is implicitly converted to another.
> > 
> > drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
> > enumeration type 'enum max9611_conf_ids' to different enumeration type
> > 'enum max9611_csa_gain' [-Wenum-conversion]
> >                         *csa_gain = gain_selectors[i];
> >                                   ~ ^~~~~~~~~~~~~~~~~
> > 1 warning generated.
> > 
> > Change the type of the variable 'gain_selectors' to int so that Clang
> > understands this is expected behavior.
> > 
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> How does this interact with the patch that Stefan Agner sent for
> the same issue last week?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=b1ec0802503820ccbc894aadfd2a44da20232f5e
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

Sorry for the overlap. My patch is not necessary. I was working off
of linux-next so I didn't catch this. I'll be better about checking
maintainer trees before sending patches in the future.

Thanks for the quick response!
Nathan

> > ---
> >  drivers/iio/adc/max9611.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > index 0538ff8c4ac1..3c358b16a8fa 100644
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
> >  				    u16 *adc_raw,
> >  				    enum max9611_csa_gain *csa_gain)
> >  {
> > -	enum max9611_conf_ids gain_selectors[] = {
> > +	int gain_selectors[] = {
> >  		CONF_SENSE_1x,
> >  		CONF_SENSE_4x,
> >  		CONF_SENSE_8x
> 
