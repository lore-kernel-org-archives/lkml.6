Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F7EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A58E214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="m9V3s67z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A58E214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeIZWSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:18:02 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:37405 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeIZWSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:18:02 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 21d1137f;
        Wed, 26 Sep 2018 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=gj88kwP8hALO
        spsKo2ZO4ZJWaDA=; b=m9V3s67zvrbI8PxfFL8PQCoiadD/ipHoPg2KiMxYl2Go
        1MS0qKLCm4GhCeUuXj2Z8MKSb/F+L9hYQsLdJg6mq6mv5A0PDOmMqPHX8FBj1uJM
        vD2KU61p+FRLi3LuPPkuuT9QdI8+0Z9e84nV5XxC1QK/BXI9fDRI6Z2WgyWKBe7S
        C6xpeprha4CpjucGmsCxsLd11QLVctC1JUEfVPXkN+A6CMcdm3SLAUUV/XenUjpd
        Y5NpvdJ+Cmdb7E9s+YnmJuRjyMyn9ntlxlzCOI+eplIvwSI+F+ZnIIE4LY8wpul8
        aTMAzPqJhOWolMVcbMfEaIGPx9m8LyOsIlzCQy4EXw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9178ad68 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 15:45:48 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id e18-v6so28707374oti.8;
        Wed, 26 Sep 2018 09:04:21 -0700 (PDT)
X-Gm-Message-State: ABuFfogXM6TQSOy++mLt+JA5jTtaQlOv3rXX7Mh42lmxj0J7xXF23kDr
        j5BguCUgfHXWTeBvYVykqnrSGpYHQeG8j77pOjk=
X-Google-Smtp-Source: ACcGV61a9zlmHnw3fNEQC8Cj5gs7h9rK2P03aTKc6NgzXeJ/u8BQdAInJlINo4lScbbPsomLYwErPQQjeo3VLAAYocU=
X-Received: by 2002:a9d:4a9c:: with SMTP id i28-v6mr2379420otf.138.1537977861013;
 Wed, 26 Sep 2018 09:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <7830522a-968e-0880-beb7-44904466cf14@labo.rs>
In-Reply-To: <7830522a-968e-0880-beb7-44904466cf14@labo.rs>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 18:04:09 +0200
X-Gmail-Original-Message-ID: <CAHmME9oQJ9y51Pv7U=+=5uDA_tb+U1zWZdsLcyNMhdcFZmjM8Q@mail.gmail.com>
Message-ID: <CAHmME9oQJ9y51Pv7U=+=5uDA_tb+U1zWZdsLcyNMhdcFZmjM8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     labokml@labo.rs, Dave Taht <dave.taht@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On Wed, Sep 26, 2018 at 6:00 PM Ivan Lab=C3=A1th <labokml@labo.rs> wrote:
>
> On 25.09.2018 16:56, Jason A. Donenfeld wrote:
> > Extensive documentation and description of the protocol and
> > considerations, along with formal proofs of the cryptography, are> avai=
lable at:
> >
> >   * https://www.wireguard.com/
> >   * https://www.wireguard.com/papers/wireguard.pdf
> []
> > +enum { HANDSHAKE_DSCP =3D 0x88 /* AF41, plus 00 ECN */ };
> []
> > +     if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> > +             len =3D ntohs(ip_hdr(skb)->tot_len);
> > +             if (unlikely(len < sizeof(struct iphdr)))
> > +                     goto dishonest_packet_size;
> > +             if (INET_ECN_is_ce(PACKET_CB(skb)->ds))
> > +                     IP_ECN_set_ce(ip_hdr(skb));
> > +     } else if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
> > +             len =3D ntohs(ipv6_hdr(skb)->payload_len) +
> > +                   sizeof(struct ipv6hdr);
> > +             if (INET_ECN_is_ce(PACKET_CB(skb)->ds))
> > +                     IP6_ECN_set_ce(skb, ipv6_hdr(skb));
> > +     } else
> []
> > +     skb_queue_walk (&packets, skb) {
> > +             /* 0 for no outer TOS: no leak. TODO: should we use flowi=
->tos
> > +              * as outer? */
> > +             PACKET_CB(skb)->ds =3D ip_tunnel_ecn_encap(0, ip_hdr(skb)=
, skb);
> > +             PACKET_CB(skb)->nonce =3D
> > +                             atomic64_inc_return(&key->counter.counter=
) - 1;
> > +             if (unlikely(PACKET_CB(skb)->nonce >=3D REJECT_AFTER_MESS=
AGES))
> > +                     goto out_invalid;
> > +     }
> Hi,
>
> is there documentation and/or rationale for ecn handling?
> Quick search for ecn and dscp didn't reveal any.

ECN support was developed with Dave Taht so that it does the right
thing with CAKE and such. He's CC'd, so that he can fill in details,
and sure, we can write these up. As well, I can add the rationale for
the handshake-packet-specific DSCP value to the paper in the next few
days; thanks for pointing out these documentation oversights.

Jason
