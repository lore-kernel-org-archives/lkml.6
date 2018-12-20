Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FA6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904B3218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpVgCdp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbeLTSdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:33:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37827 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbeLTSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:33:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so3310199wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRKVRh4UbiqXePe+HnBwTMzrBMk8SH+LqmumIiSTs/Q=;
        b=DpVgCdp/+ob6lrRWpEcWp7ortuR6XnUa+FKuJXE25+r15tploMm9Ac9RETCw0fsI51
         40G0a7Ba9VhjtuDsVmThNyjcSMbeNVn+zb+OlPyNoSp/YUw8eQK0ZaHLtRmzgfszkMJM
         36W1wDblYP65mllw2Jb9Xl4ejkaTDzo6ExPZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRKVRh4UbiqXePe+HnBwTMzrBMk8SH+LqmumIiSTs/Q=;
        b=BevDjlPL1MaFOFWC+AEoz/dzjOo4mz0wiVoSK8E8Rpf9RyfpeiOZqHw7hOiBvVeKca
         Nn8T/XdnoTpkcRir+hTdMumrjx2V2qj4ZBp4Kwmo8Eoi2JCQZxZGpqutC7pQdydeddbG
         nSyB+fy1qlkD/3Yeq0MxpQHz6AAc8S26amHnTe+2bNGScG8YOUP2FNJMXUPEmw5RypY9
         aPsArFn9A7RynlbsvXKFAsumGVoqiSB17y9WSHgVuwcghw/AE8iAVFu3GpgBG0+gAIV3
         cDtU2UBLfpyBF3slIR+T946bv7IlOgq5UJ4YAATsMKf8HNoJJ0YBtWSLzmfHC2mii9W0
         yCeg==
X-Gm-Message-State: AA+aEWaLmk8l6/BX69wEOrdn+VAoWogQ93Hc9L1U4jGzo8r1J+Cd1J6O
        og1ussxweW1o8gyfVJor36fvoosVDeC6cSX0eup7Kjm+/eesFA==
X-Google-Smtp-Source: AFSGD/XLMv5AifI4PQDjeGCQRykFEDdrg+bwUtyKiW/M4O12wx4+8u2/FCnDVOmdzpD2mxfgP+/sRS3Da+Cmfsuuo0k=
X-Received: by 2002:a1c:d14d:: with SMTP id i74mr5925369wmg.100.1545330812697;
 Thu, 20 Dec 2018 10:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20181219000808.28382-1-semen.protsenko@linaro.org> <20181219143841.GC1338@alphalink.fr>
In-Reply-To: <20181219143841.GC1338@alphalink.fr>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 20 Dec 2018 20:33:21 +0200
Message-ID: <CAKaJLVvSZkdGG5Q2c25eyMBDZpLhEER57O_9U-LRSJ4GB9N7GQ@mail.gmail.com>
Subject: Re: [PATCH] ppp: Move PFC decompression to PPP generic layer
To:     Guillaume Nault <g.nault@alphalink.fr>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Wed, Dec 19, 2018 at 4:38 PM Guillaume Nault <g.nault@alphalink.fr> wrote:
>
> On Wed, Dec 19, 2018 at 02:08:08AM +0200, Sam Protsenko wrote:
> > Extract "Protocol" field decompression code from transport protocols to
> > PPP generic layer, where it actually belongs. As a consequence, this
> > patch fixes incorrect place of PFC decompression in L2TP driver (when
> > it's not PPPOX_BOUND) and also enables this decompression for other
> > protocols, like PPPoE.
> >
> > Protocol field decompression also happens in PPP Multilink Protocol
> > code and in PPP compression protocols implementations (bsd, deflate,
> > mppe). It looks like there is no easy way to get rid of that, so it was
> > decided to leave it as is, but provide those cases with appropriate
> > comments instead.
> >
> Yes, ideally we'd make PPP_PROTO() handle compressed protocol so that
> we wouldn't need to decompress protocol field in place. But other parts
> of the ppp code assume uncompressed protocol field in skb->data, so
> let's stick with the current behaviour for now.
>
> > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> > index 500bc0027c1b..10c4c8eec995 100644
> > --- a/drivers/net/ppp/ppp_generic.c
> > +++ b/drivers/net/ppp/ppp_generic.c
> > @@ -1965,6 +1965,14 @@ ppp_do_recv(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
> >       ppp_recv_unlock(ppp);
> >  }
> >
> > +/* Decompress protocol field in PPP header if it's compressed */
> > +static inline void
> > +ppp_decompress_proto(struct sk_buff *skb)
> >
> No need for inline keyword in .c files. Also, no need to split line
> before function name. I know older function declarations of
> ppp_generic.c do this, but let's stick to the general networking stack
> style instead.
>
> > +{
> > +     if (skb->data[0] & 0x01)
> > +             *(u8 *)skb_push(skb, 1) = 0x00;
> > +}
> > +
> This assumes that we have at least 1 byte of head room and 1 byte of
> linear data. Although that's what the original code did, I find that's
> a bit dangerous. Maybe prefix the function name with '__' and add a
> comment in the function description to warn the reader.
>
> >  void
> >  ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
> >  {
> > @@ -1986,6 +1994,7 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
> >               goto done;
> >       }
> >
> > +     ppp_decompress_proto(skb);
> >
> The pskb_may_pull(skb, 2) at the beginning of the functions is there
> because we're going to read the protocol field. It doesn't make sense to
> decompress it after this test (although technically that mostly works).
>
> However, if we move ppp_decompress_proto() before pskb_may_pull(), then
> callers must respect the requirements of ppp_decompress_proto().
>
> >       proto = PPP_PROTO(skb);
> >       if (!pch->ppp || proto >= 0xc000 || proto == PPP_CCPFRAG) {
> >               /* put it on the channel queue */
> > @@ -2074,6 +2083,9 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
> >       if (ppp->flags & SC_MUST_COMP && ppp->rstate & SC_DC_FERROR)
> >               goto err;
> >
> > +     /* At this point the "Protocol" field MUST be decompressed, either in
> > +      * ppp_decompress_frame() or in ppp_receive_mp_frame().
> > +      */
> >
> Or ppp_input(). In the general case (no multilink header and no compression)
> it's ppp_input() that'd decompress the protocol field.
>
> > @@ -2290,9 +2305,11 @@ ppp_receive_mp_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
> >
> >       /*
> >        * Do protocol ID decompression on the first fragment of each packet.
> > +      * We can't wait for this to happen in ppp_input(), because
> > +      * ppp_receive_nonmp_frame() expects decompressed protocol field.
> >        */
> ppp_input() is not going to be called anyway. I think you can omit the
> middle line entirely.

Thanks for the detailed review! All your points are well taken.
Already sent fixed v2, please review.
