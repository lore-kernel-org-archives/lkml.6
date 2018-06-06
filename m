Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPpBhinz"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43A8E601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeFFIca (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:32:30 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43079 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbeFFIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:32:29 -0400
X-Google-Smtp-Source: ADUXVKIAN8n84kgr/aPEtt+QjRrvfVC6IiyrHfBj7Js/5QYQtGsOH2vYehtYTeHo6uzQM/NuVx4lAIiup2EOJQzdRzI=
MIME-Version: 1.0
References: <1528231092-31472-1-git-send-email-arun.parameswaran@broadcom.com> <8bb9ab39-a38b-9492-975e-d76c864ff8ff@broadcom.com>
In-Reply-To: <8bb9ab39-a38b-9492-975e-d76c864ff8ff@broadcom.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Wed, 6 Jun 2018 10:32:16 +0200
Message-ID: <CAJiuCccVEMAzAsv61P60pEC6tvNGBpjgOPgbGE8En+CBDyx7wQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: dsa: b53: Fix for brcm tag issue in Cygnus SoC
To: scott.branden@broadcom.com
Cc: arun.parameswaran@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        vivien.didelot@savoirfairelinux.com, andrew@lunn.ch,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On Tue, 5 Jun 2018 at 22:55, Scott Branden <scott.branden@broadcom.com> wro=
te:
>
> Clement,
>
> Please test this works for your issue.

Tested on top of 4.17.0 with a BCM58305

Tested-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

>
>
> On 18-06-05 01:38 PM, Arun Parameswaran wrote:
> > In the Broadcom Cygnus SoC, the brcm tag needs to be inserted
> > in between the mac address and the ether type (should use
> > 'DSA_PROTO_TAG_BRCM') for the packets sent to the internal
> > b53 switch.
> >
> > Since the Cygnus was added with the BCM58XX device id and the
> > BCM58XX uses 'DSA_PROTO_TAG_BRCM_PREPEND', the data path is
> > broken, due to the incorrect brcm tag location.
> >
> > Add a new b53 device id (BCM583XX) for Cygnus family to fix the
> > issue. Add the new device id to the BCM58XX family as Cygnus
> > is similar to the BCM58XX in most other functionalities.
> >
> > Fixes: 11606039604c ("net: dsa: b53: Support prepended Broadcom tags")
> >
> > Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> Acked-by: Scott Branden <scott.branden@broadcom.com>
> > ---
> >   drivers/net/dsa/b53/b53_common.c | 15 ++++++++++++++-
> >   drivers/net/dsa/b53/b53_priv.h   |  2 ++
> >   drivers/net/dsa/b53/b53_srab.c   |  4 ++--
> >   3 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53=
_common.c
> > index 3da5fca..bbc6cc6 100644
> > --- a/drivers/net/dsa/b53/b53_common.c
> > +++ b/drivers/net/dsa/b53/b53_common.c
> > @@ -684,7 +684,8 @@ static int b53_switch_reset(struct b53_device *dev)
> >        * still use this driver as a library and need to perform the res=
et
> >        * earlier.
> >        */
> > -     if (dev->chip_id =3D=3D BCM58XX_DEVICE_ID) {
> > +     if (dev->chip_id =3D=3D BCM58XX_DEVICE_ID ||
> > +         dev->chip_id =3D=3D BCM583XX_DEVICE_ID) {
> >               b53_read8(dev, B53_CTRL_PAGE, B53_SOFTRESET, &reg);
> >               reg |=3D SW_RST | EN_SW_RST | EN_CH_RST;
> >               b53_write8(dev, B53_CTRL_PAGE, B53_SOFTRESET, reg);
> > @@ -1880,6 +1881,18 @@ struct b53_chip_data {
> >               .jumbo_size_reg =3D B53_JUMBO_MAX_SIZE,
> >       },
> >       {
> > +             .chip_id =3D BCM583XX_DEVICE_ID,
> > +             .dev_name =3D "BCM583xx/11360",
> > +             .vlans =3D 4096,
> > +             .enabled_ports =3D 0x103,
> > +             .arl_entries =3D 4,
> > +             .cpu_port =3D B53_CPU_PORT,
> > +             .vta_regs =3D B53_VTA_REGS,
> > +             .duplex_reg =3D B53_DUPLEX_STAT_GE,
> > +             .jumbo_pm_reg =3D B53_JUMBO_PORT_MASK,
> > +             .jumbo_size_reg =3D B53_JUMBO_MAX_SIZE,
> > +     },
> > +     {
> >               .chip_id =3D BCM7445_DEVICE_ID,
> >               .dev_name =3D "BCM7445",
> >               .vlans  =3D 4096,
> > diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_p=
riv.h
> > index 3b57f47..b232aaa 100644
> > --- a/drivers/net/dsa/b53/b53_priv.h
> > +++ b/drivers/net/dsa/b53/b53_priv.h
> > @@ -62,6 +62,7 @@ enum {
> >       BCM53018_DEVICE_ID =3D 0x53018,
> >       BCM53019_DEVICE_ID =3D 0x53019,
> >       BCM58XX_DEVICE_ID =3D 0x5800,
> > +     BCM583XX_DEVICE_ID =3D 0x58300,
> >       BCM7445_DEVICE_ID =3D 0x7445,
> >       BCM7278_DEVICE_ID =3D 0x7278,
> >   };
> > @@ -181,6 +182,7 @@ static inline int is5301x(struct b53_device *dev)
> >   static inline int is58xx(struct b53_device *dev)
> >   {
> >       return dev->chip_id =3D=3D BCM58XX_DEVICE_ID ||
> > +             dev->chip_id =3D=3D BCM583XX_DEVICE_ID ||
> >               dev->chip_id =3D=3D BCM7445_DEVICE_ID ||
> >               dev->chip_id =3D=3D BCM7278_DEVICE_ID;
> >   }
> > diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_s=
rab.c
> > index c37ffd1..8247481 100644
> > --- a/drivers/net/dsa/b53/b53_srab.c
> > +++ b/drivers/net/dsa/b53/b53_srab.c
> > @@ -364,7 +364,7 @@ static int b53_srab_write64(struct b53_device *dev,=
 u8 page, u8 reg,
> >       { .compatible =3D "brcm,bcm53018-srab" },
> >       { .compatible =3D "brcm,bcm53019-srab" },
> >       { .compatible =3D "brcm,bcm5301x-srab" },
> > -     { .compatible =3D "brcm,bcm11360-srab", .data =3D (void *)BCM58XX=
_DEVICE_ID },
> > +     { .compatible =3D "brcm,bcm11360-srab", .data =3D (void *)BCM583X=
X_DEVICE_ID },
> >       { .compatible =3D "brcm,bcm58522-srab", .data =3D (void *)BCM58XX=
_DEVICE_ID },
> >       { .compatible =3D "brcm,bcm58525-srab", .data =3D (void *)BCM58XX=
_DEVICE_ID },
> >       { .compatible =3D "brcm,bcm58535-srab", .data =3D (void *)BCM58XX=
_DEVICE_ID },
> > @@ -372,7 +372,7 @@ static int b53_srab_write64(struct b53_device *dev,=
 u8 page, u8 reg,
> >       { .compatible =3D "brcm,bcm58623-srab", .data =3D (void *)BCM58XX=
_DEVICE_ID },
> >       { .compatible =3D "brcm,bcm58625-srab", .data =3D (void *)BCM58XX=
_DEVICE_ID },
> >       { .compatible =3D "brcm,bcm88312-srab", .data =3D (void *)BCM58XX=
_DEVICE_ID },
> > -     { .compatible =3D "brcm,cygnus-srab", .data =3D (void *)BCM58XX_D=
EVICE_ID },
> > +     { .compatible =3D "brcm,cygnus-srab", .data =3D (void *)BCM583XX_=
DEVICE_ID },
> >       { .compatible =3D "brcm,nsp-srab", .data =3D (void *)BCM58XX_DEVI=
CE_ID },
> >       { /* sentinel */ },
> >   };
>
