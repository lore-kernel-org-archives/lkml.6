Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233E4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB4320843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="HTwXNT2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB4320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeIZU7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:59:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45857 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIZU7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:59:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id c13-v6so10651215otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1FKhB8Dkv6BRpoSLUs/1kP8ecAdQI6jhk4KYTXIB7ao=;
        b=HTwXNT2U+X7M/vMzqu5FwxtgIKF7sHlGf7qZGLieB+HvPwj5HdagKWUnnQibfmRAh0
         WyeNFDjjvoMm8G3YoCyHSmiSbYlEUeVmih2CzYUdlKEPVi8YboZEb3fMNQ/CuLIJVI2n
         n4cjVlst+x8Fl0aycCWdvebleT3geUkNQB25M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1FKhB8Dkv6BRpoSLUs/1kP8ecAdQI6jhk4KYTXIB7ao=;
        b=coF216NI2RegVkpbUm3jfJDNvnVJnw9dbwvpfxfuJrznqltAc7jL3lIEiKk3ERv4DR
         i0oUUzALzZnAL5cqzW2gFow+d01ATx3rRaPGH3eJZet4g3Tdz13joR4JTlP8+KWYRMWR
         5UG47r4EgrT1lfkdIVUNRMl7MQpf3NGJujPP97afBrOgEO6WVLxJaMK6+VDw4/7xSYb3
         oX1ZswiSggZSoQK27HafJ3zBRrRbS1XNm2kNLDCOoocjDQmF1FrCyn47IdTLwMrLhWSb
         0JaKsRyKlAr5ADzPFpCwB3ckIg8N6/gcFYfIncjZIphQZ83Q34NOR4qpdQhLpV1K94rJ
         SJLg==
X-Gm-Message-State: ABuFfoiMANhUtMXJrhu3Qx3Z7wNUHfbBgCTyC8VWC8CyjLgN8osXY0eg
        37/R7Mg7td34NNb9qsWC54i5Uw==
X-Google-Smtp-Source: ACcGV60Md7yDPl+EFRo+k3xjM7x4LeBCT3IAzRm6nH/4hl0OYZu1fLD0GA/ELKAcvWpuikn5tmk60g==
X-Received: by 2002:a9d:48a:: with SMTP id 10-v6mr4038983otm.361.1537973174737;
        Wed, 26 Sep 2018 07:46:14 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id n185-v6sm308961oig.42.2018.09.26.07.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:46:13 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id s69-v6so4604562oie.10;
        Wed, 26 Sep 2018 07:46:13 -0700 (PDT)
X-Received: by 2002:aca:853:: with SMTP id 80-v6mr748716oii.333.1537973173170;
 Wed, 26 Sep 2018 07:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535039998.git.starnight@g.ncu.edu.tw> <f7ea222671a2bc6fe0a060c4bdb1ebae162d0d91.1535039998.git.starnight@g.ncu.edu.tw>
 <f74c033a-fadc-fb8c-9469-6e6a32339cd8@suse.de>
In-Reply-To: <f74c033a-fadc-fb8c-9469-6e6a32339cd8@suse.de>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Wed, 26 Sep 2018 22:46:08 +0800
X-Gmail-Original-Message-ID: <CAC=mGzhOnEfx7NwURMbtc9eqOabu2_FYTz7aZKuEi6m72nUxXQ@mail.gmail.com>
Message-ID: <CAC=mGzhOnEfx7NwURMbtc9eqOabu2_FYTz7aZKuEi6m72nUxXQ@mail.gmail.com>
Subject: Re: [RFC 2/3 net] lorawan: Add macro and definition for LoRaWAN class modlue
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "linux-kernel@vger.kernel.org>," <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter ROBYNS <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>, fomi@rakwireless.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas F=C3=A4rber <afaerber@suse.de> =E6=96=BC 2018=E5=B9=B49=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8812:06=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Jian-Hong,
>
> Many thanks and sorry for the delay. This patch mostly looks good and
> should go in before its first uses, so I would like to queue it soon for
> my hardware-MAC module drivers - but some questions below. Also a typo
> in the subject, and we should probably prepend "net: " and I would
> personally not mention the module here as it's a userspace API.
>
> Am 23.08.18 um 19:15 schrieb Jian-Hong Pan:
> > This patch add the macro and definition for the implementation of
> > LoRaWAN protocol.
>
> I would fix up the grammar nits in my tree then.

Oh!  The grammar things should be fixed.  Thanks
And, I am preparing V2 patch, too.

> >
> > Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> > ---
> >  include/linux/socket.h              | 5 ++++-
> >  include/uapi/linux/if_arp.h         | 1 +
> >  include/uapi/linux/if_ether.h       | 1 +
> >  net/core/dev.c                      | 4 ++--
> >  security/selinux/hooks.c            | 4 +++-
> >  security/selinux/include/classmap.h | 4 +++-
> >  6 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index aa1e288b1659..e5c8381fd1aa 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -209,8 +209,9 @@ struct ucred {
> >                                */
> >  #define AF_XDP               44      /* XDP sockets                  *=
/
> >  #define AF_LORA              45      /* LoRa sockets                 *=
/
> > +#define AF_LORAWAN   46      /* LoRaWAN sockets                      *=
/
> >
> > -#define AF_MAX               46      /* For now.. */
> > +#define AF_MAX               47      /* For now.. */
> >
> >  /* Protocol families, same as address families. */
> >  #define PF_UNSPEC    AF_UNSPEC
> > @@ -261,6 +262,7 @@ struct ucred {
> >  #define PF_SMC               AF_SMC
> >  #define PF_XDP               AF_XDP
> >  #define PF_LORA              AF_LORA
> > +#define PF_LORAWAN   AF_LORAWAN
> >  #define PF_MAX               AF_MAX
> >
> >  /* Maximum queue length specifiable by listen.  */
> > @@ -343,6 +345,7 @@ struct ucred {
> >  #define SOL_KCM              281
> >  #define SOL_TLS              282
> >  #define SOL_XDP              283
> > +#define SOL_LORAWAN  284
> >
> >  /* IPX options */
> >  #define IPX_TYPE     1
> > diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
> > index 1ed7cb3f2129..2376f7839355 100644
> > --- a/include/uapi/linux/if_arp.h
> > +++ b/include/uapi/linux/if_arp.h
> > @@ -99,6 +99,7 @@
> >  #define ARPHRD_6LOWPAN       825             /* IPv6 over LoWPAN      =
       */
> >  #define ARPHRD_VSOCKMON      826             /* Vsock monitor header  =
       */
> >  #define ARPHRD_LORA  827             /* LoRa                         *=
/
> > +#define ARPHRD_LORAWAN       828             /* LoRaWAN               =
       */
> >
> >  #define ARPHRD_VOID    0xFFFF        /* Void type, nothing is known */
> >  #define ARPHRD_NONE    0xFFFE        /* zero header length */
> > diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ethe=
r.h
> > index 45644dcf5b39..b1ac70d4a377 100644
> > --- a/include/uapi/linux/if_ether.h
> > +++ b/include/uapi/linux/if_ether.h
> > @@ -148,6 +148,7 @@
> >                                        * aggregation protocol
> >                                        */
> >  #define ETH_P_LORA   0x00FA          /* LoRa                         *=
/
> > +#define ETH_P_LORAWAN        0x00FB          /* LoRaWAN               =
       */
> >
> >  /*
> >   *   This is an Ethernet frame header.
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f68122f0ab02..b95ce79ec5a8 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -297,7 +297,7 @@ static const unsigned short netdev_lock_type[] =3D =
{
> >        ARPHRD_IRDA, ARPHRD_FCPP, ARPHRD_FCAL, ARPHRD_FCPL,
> >        ARPHRD_FCFABRIC, ARPHRD_IEEE80211, ARPHRD_IEEE80211_PRISM,
> >        ARPHRD_IEEE80211_RADIOTAP, ARPHRD_PHONET, ARPHRD_PHONET_PIPE,
> > -      ARPHRD_IEEE802154, ARPHRD_VOID, ARPHRD_NONE};
> > +      ARPHRD_IEEE802154, ARPHRD_LORAWAN, ARPHRD_VOID, ARPHRD_NONE};
> >
> >  static const char *const netdev_lock_name[] =3D {
> >       "_xmit_NETROM", "_xmit_ETHER", "_xmit_EETHER", "_xmit_AX25",
> > @@ -314,7 +314,7 @@ static const char *const netdev_lock_name[] =3D {
> >       "_xmit_IRDA", "_xmit_FCPP", "_xmit_FCAL", "_xmit_FCPL",
> >       "_xmit_FCFABRIC", "_xmit_IEEE80211", "_xmit_IEEE80211_PRISM",
> >       "_xmit_IEEE80211_RADIOTAP", "_xmit_PHONET", "_xmit_PHONET_PIPE",
> > -     "_xmit_IEEE802154", "_xmit_VOID", "_xmit_NONE"};
> > +     "_xmit_IEEE802154", "_xmit_LORAWAN", "_xmit_VOID", "_xmit_NONE"};
> >
> >  static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lo=
ck_type)];
> >  static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lo=
ck_type)];
>
> All your new constants except SOL_LORAWAN are always next to a LoRa one,
> but not in these two arrays. I don't have such changes in my original
> LoRa patch - am I missing such an array extension for ARPHRD_LORA then,
> or what is the criteria for when to add this?

That is for "ip" related commands or something else I did not discover.
For example:
$ ip link show lora0
4: lora0: <NOARP,UP,LOWER_UP> mtu 20 qdisc noqueue state UNKNOWN mode
DEFAULT group default qlen 1000
    link/[828] 01:02:03:04 brd ff:ff:ff:ff

The 828 is ARPHRD_LORAWAN.

Regards,
Jian-Hong Pan
