Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD82C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4087217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lKk6aiCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4087217CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeHEB3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:29:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42105 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeHEB3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:29:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so3417348edp.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpAXIh6rmbWqaElkvs+IlvvBQ5Bg7OguAlpxgj6Mwgg=;
        b=lKk6aiCQ9hV0dgdg1VZ/kToiK2yowKo0kSWxOo4mKRtIfgRAuHdJibPw42XP+CT1uj
         ihfXxYVktN9Jy5UX9Q/2wYIEgn1QYNJiD3ugkrbbigGmyC+tuF/c1wnjx+AL/9BygI0q
         5TST56bzXRszY2yRrVK+62VJhgd/5lPuLMaTQxA6VlYLc+BHSGSarNGTBc4npDFaNkZm
         xoHu06sXBTuU5eT6XhvElkvOmdtnDAdcmLcowH6d/9zpozyyt2xNMUdC68gb3SmJYPZQ
         pGJLZ6MXvZWiK3Ac+t465K+BmmtpMYAJZsFTQlverDpxf3aplCS1A593ayjKCrOwYlSe
         flZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpAXIh6rmbWqaElkvs+IlvvBQ5Bg7OguAlpxgj6Mwgg=;
        b=fYMC1bL35Zgwnloty9phq/74f1cnV9Aw95DEW7sa5pAFXCBZxHTv63X8JX/YxhORBn
         fspbXB6oFBGemsG9gDLHRfOnG3X4eUMdng1WwMu9bTAG9fSmo0kp6c+fLtSM02pES+pq
         tT77Ln6qbNAcA73HhWYionZcydS123Hptl7DcXbCRgbg6vTrk4byzVmrTpjPRpWgnGWI
         yBORIt5fYkUbvWBx9BhdSm/t8iPSrz7WijQXA+OozLI/d5RQvXUbCUF0Nw46hrRaTwV5
         FQzIVjVQzNOn6+AUcSz+Y6ZNCY7fnMiZ/10A/GrL6Uyy2kRav5V3Augx46WyJdlbphdW
         8Bcw==
X-Gm-Message-State: AOUpUlFsolLc8rN8L+kiyE+Dsr878JPLFipgQIlwHBl8ZL40bF2iv8JY
        TkYtRbKpq9hsP6xe8l121oewAA==
X-Google-Smtp-Source: AAOMgpcTjt9y3ycM5hvCBlD2YoAZGpde+aW7c3CYnK1OJXE3IMo+nvVNByJypBNBTLh8W1yIpohmKg==
X-Received: by 2002:a50:b505:: with SMTP id y5-v6mr12331575edd.195.1533425200346;
        Sat, 04 Aug 2018 16:26:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id c34-v6sm9602280edc.71.2018.08.04.16.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 16:26:39 -0700 (PDT)
Message-ID: <1533425198.2679.148.camel@arista.com>
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
From:   Dmitry Safonov <dima@arista.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org
Date:   Sun, 05 Aug 2018 00:26:38 +0100
In-Reply-To: <20180804232102.GA3982@flashbox>
References: <20180804082702.434482435@linuxfoundation.org>
         <20180804082706.427556290@linuxfoundation.org>
         <20180804180734.GA25546@flashbox> <1533422007.2679.141.camel@arista.com>
         <20180804224956.GA5384@flashbox> <1533424322.2679.144.camel@arista.com>
         <20180804232102.GA3982@flashbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 16:21 -0700, Nathan Chancellor wrote:
> On Sun, Aug 05, 2018 at 12:12:02AM +0100, Dmitry Safonov wrote:
> > On Sat, 2018-08-04 at 15:49 -0700, Nathan Chancellor wrote:
> > > dmesg output attached, please let me know if you need anything
> > > else.
> > 
> > Could you try with this diff instead?
> > It looks like, I'm too bad with shifts and shifted for 64 bytes.
> > 
> > -- 
> > Thanks,
> >              Dmitry
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 7d860a22e5fb..b78bb7dc06fe 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1011,7 +1011,7 @@ static int netlink_bind(struct socket *sock,
> > struct sockaddr *addr,
> >  
> >  	if (nlk->ngroups == 0)
> >  		groups = 0;
> > -	else
> > +	else if (nlk->ngroups < 64)
> >  		groups &= (1ULL << nlk->ngroups) - 1;
> >  
> >  	bound = nlk->bound;
> 
> This fixed my issue. If needed:
> 
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> 

Thanks for the testing, sorry again for the breakage.
Will send the patch shortly (with sizeof(unsigned long long) instead of
hard-coded 64). Hopefully, not too late.

(and then will go to bed and feel myself awful - not knowing C after so
many years).

-- 
Thanks,
             Dmitry
