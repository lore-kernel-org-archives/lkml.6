Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56752C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A6B2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EeRdbvNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfBEP5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:57:08 -0500
Received: from mail-eopbgr780084.outbound.protection.outlook.com ([40.107.78.84]:36317
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbfBEP5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONYkPZG6nTYID11Y4qjPUrq+iYk2C0EKc03ZurAndsw=;
 b=EeRdbvNv6bwq2ac3AAjNmYoco03djZhHxgT58ho8EAPiMxEfpSGUsl2yhGLZ3Fm8kYXa8o3RiphcpzqUTfgEEjoxooZoj8CzkiN++ejUZMpGUvP3Kka7LQelkcNHnjxt5wvZI1LLv+d8Rez0pJTrHWERYW/GYP7UDwr2Oe21wa0=
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com (10.160.195.140) by
 BY1PR0301MB1319.namprd03.prod.outlook.com (10.161.206.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Tue, 5 Feb 2019 15:57:02 +0000
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::fcbe:8732:1ba9:5036]) by BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::fcbe:8732:1ba9:5036%5]) with mapi id 15.20.1558.026; Tue, 5 Feb 2019
 15:57:02 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Nikolaus Voss <nv@vosn.de>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: RE: [PATCH 2/2] drivers/gpio/gpio-adp5588.c: switch to events system
Thread-Topic: [PATCH 2/2] drivers/gpio/gpio-adp5588.c: switch to events system
Thread-Index: AQHUvWXkd7oK00JUOkqKtQyho5Jlo6XRWsHw
Date:   Tue, 5 Feb 2019 15:57:02 +0000
Message-ID: <BY1PR0301MB0901ED3A4CA9AA2A0E1701FE8E6E0@BY1PR0301MB0901.namprd03.prod.outlook.com>
References: <c1638e5c06be365ad205e4717fd9f226cd1983a2.1549379326.git.nikolaus.voss@loewensteinmedical.de>
 <3230ace6f820fccadb51097ae9ba9f5ee247d79b.1549379326.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <3230ace6f820fccadb51097ae9ba9f5ee247d79b.1549379326.git.nikolaus.voss@loewensteinmedical.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR0301MB1319;6:31x1uE0WoimCHEUFCHAKddXLOD0B6qi/9imnL6QkBE7gm3aWn/WuQvVlFzYiFEVJXVaJsqqrZvkfxCHLTZ/5q9csrr0lpoxeE2rB3jJXYPGcjzjYG/brf6zr0eGh7M/kdEsrn8Fyuw5sCql1lvTW8ESvsGBXxC4Ck6NwDipv1D9tcWvvCt8/QuYoshx+9eNZzJPQIV3ZkrnFTrdNbBpL2xUzlwzR7LlR1ufjzNjIE+TdEfZngaFaT7mt/bDPKNKbxRmb4wqH8OwqPvyzPtFuC4CTKcF1DzMwgySTjqvoHH7c4KCgJPr2jSZKz9zBpzjpZKn/cqgSOuOEOutUa0nGl3HecsMp+k2TMsgHBTwLbajkTLkLlpEUcmS8kLxEcT11H8t5+yF/Q4iVz9/i1xlev8/NalJOC0xfsncP4xMXRoM1xBc7dSyKohPY8YsL49uj9iL1WJrKXtFB6HWLvuTxsA==;5:o1v7jVs12Eypfz9DRY2OAxJrB+gNxP2tKrd5EmGbEUhM1tqmko5zyRCXlfrDldSTCcemBRI6d6WesxzvVR+ZdFmTvKw92bky09IGIhhiPXVaAbeINjCG6or6sNdkAoX5rtjzBnl6Pt1eJeeZMNftUELS6w6A+F68NGslebseB0FAf0VE7shiiWfuEzMcoLtSs1BQynvBLUadQ3t/8Fi4JA==;7:PlDr9+ueoLBezAg0cPqKYV864aTWFaeBuH3iSu7sRnTfMpfGQPWbMcLnkflIxXyGXl9hcCCPdg0YNCp1FJcYyZRfiWxFALKx4Nnb6ZMLfxpnC/1C2fKnMjIvgqBP78UU8c9Q3kiee0qTlE1bRrr8wA==
x-ms-office365-filtering-correlation-id: 22431f17-f333-4fb2-2e33-08d68b8291c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY1PR0301MB1319;
x-ms-traffictypediagnostic: BY1PR0301MB1319:
x-microsoft-antispam-prvs: <BY1PR0301MB1319578434B1C56E630763DD8E6E0@BY1PR0301MB1319.namprd03.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(13464003)(189003)(199004)(76176011)(486006)(7696005)(99286004)(68736007)(256004)(33656002)(53936002)(71190400001)(72206003)(106356001)(4326008)(55016002)(9686003)(478600001)(25786009)(2906002)(66066001)(446003)(26005)(97736004)(6436002)(6506007)(81166006)(316002)(105586002)(110136005)(11346002)(14444005)(305945005)(476003)(81156014)(54906003)(7736002)(8676002)(71200400001)(14454004)(74316002)(102836004)(229853002)(6116002)(3846002)(86362001)(6246003)(186003)(53546011)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0301MB1319;H:BY1PR0301MB0901.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vu+JJT93QyU7j8oOXJbNUvToukRdJuPU28hCjUPnzrAwZc/xGYAsZQEkc8jWGIAgDxaX0pYU9LtSlyXVBQJBN6wmfHGsAJLGNbdTbFBiPEglbH4qWdd58NyF9ww8NQlAYelongf0SUS0iTQdYKNVuTTRKie9TTAG+GIskKE0eIqXIWZybQC9oQ2rP/2PL5crN4jqGi8gL8Bo3uDo3oW0tlZmud7iRJbkacrysYAweATcTJIcJLrs6aMUFDk08My8aBy+3vhSV+0EOCGbv+6J2Y5TsLnKP6SYz+fA3S0ax5j8RtnBBBhktWfZDr1/Mi179jRJzJbM6qdzow5isRyKUlCn8YpMY4wWMnywFyEIK1WwK/SvUS2y31C0bB+7UH4aiVnhWcPRhl0faTNdNi+AhUXRZ2z364ncrxj/YkWu3sE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22431f17-f333-4fb2-2e33-08d68b8291c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:57:02.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0301MB1319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nikolaus Voss [mailto:nv@vosn.de]
> Sent: Dienstag, 5. Februar 2019 14:31
> To: Hennerich, Michael <Michael.Hennerich@analog.com>; Linus Walleij <lin=
us.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org; linux-kernel@vger.kernel.org; Nikolaus Vo=
ss <nikolaus.voss@loewensteinmedical.de>
> Subject: [PATCH 2/2] drivers/gpio/gpio-adp5588.c: switch to events system
>=20
> Interupts were generated using GPIN interrupts of
> ADP5588. These interrupts have two important limitations:
> 1. Interrupts can only be generated for either rising or
>    falling edges but not both.
> 2. Interrupts are reasserted as long as the interrupt condition
>    persists (i.e. high or low level on that GPIN). This generates
>    lots of interrupts unless the event is very short.
>=20
> To overcome this, ADP5588 provides an event system which queues
> up to 10 events in a buffer. GPIN events are queued whenever the
> GPIN is asserted or deasserted. This makes it possible to support
> generating GPIN interrupts for both edges and to generate only one
> interrupt per state change.
> Thus it is possible to chain the gpio-keys driver for some GPIOs.

Looks like a viable and much better solution. This already works pretty wel=
l for the input driver.
I can't test at the moment, but I assume you already did.

Well done and thanks for this patch!

>=20
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>


> ---
>  drivers/gpio/gpio-adp5588.c | 85 ++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
> index 0a8cfccba818..6583a3787035 100644
> --- a/drivers/gpio/gpio-adp5588.c
> +++ b/drivers/gpio/gpio-adp5588.c
> @@ -36,12 +36,11 @@ struct adp5588_gpio {
>         struct mutex irq_lock;
>         uint8_t dat_out[3];
>         uint8_t dir[3];
> -       uint8_t int_lvl[3];
> +       uint8_t int_lvl_low[3];
> +       uint8_t int_lvl_high[3];
>         uint8_t int_en[3];
>         uint8_t irq_mask[3];
> -       uint8_t irq_stat[3];
>         uint8_t int_input_en[3];
> -       uint8_t int_lvl_cached[3];
>  };
>=20
>  static int adp5588_gpio_read(struct i2c_client *client, u8 reg)
> @@ -180,15 +179,9 @@ static void adp5588_irq_bus_sync_unlock(struct irq_d=
ata *d)
>                         mutex_unlock(&dev->lock);
>                 }
>=20
> -               if (dev->int_lvl_cached[i] !=3D dev->int_lvl[i]) {
> -                       dev->int_lvl_cached[i] =3D dev->int_lvl[i];
> -                       adp5588_gpio_write(dev->client, GPIO_INT_LVL1 + i=
,
> -                                          dev->int_lvl[i]);
> -               }
> -
>                 if (dev->int_en[i] ^ dev->irq_mask[i]) {
>                         dev->int_en[i] =3D dev->irq_mask[i];
> -                       adp5588_gpio_write(dev->client, GPIO_INT_EN1 + i,
> +                       adp5588_gpio_write(dev->client, GPI_EM1 + i,
>                                            dev->int_en[i]);
>                 }
>         }
> @@ -219,21 +212,17 @@ static int adp5588_irq_set_type(struct irq_data *d,=
 unsigned int type)
>         uint16_t gpio =3D d->hwirq;
>         unsigned bank, bit;
>=20
> -       if ((type & IRQ_TYPE_EDGE_BOTH)) {
> -               dev_err(&dev->client->dev, "irq %d: unsupported type %d\n=
",
> -                       d->irq, type);
> -               return -EINVAL;
> -       }
> -
>         bank =3D ADP5588_BANK(gpio);
>         bit =3D ADP5588_BIT(gpio);
>=20
> -       if (type & IRQ_TYPE_LEVEL_HIGH)
> -               dev->int_lvl[bank] |=3D bit;
> -       else if (type & IRQ_TYPE_LEVEL_LOW)
> -               dev->int_lvl[bank] &=3D ~bit;
> -       else
> -               return -EINVAL;
> +       dev->int_lvl_low[bank] &=3D ~bit;
> +       dev->int_lvl_high[bank] &=3D ~bit;
> +
> +       if (type & IRQ_TYPE_EDGE_BOTH || type & IRQ_TYPE_LEVEL_HIGH)
> +               dev->int_lvl_high[bank] |=3D bit;
> +
> +       if (type & IRQ_TYPE_EDGE_BOTH || type & IRQ_TYPE_LEVEL_LOW)
> +               dev->int_lvl_low[bank] |=3D bit;
>=20
>         dev->int_input_en[bank] |=3D bit;
>=20
> @@ -249,41 +238,32 @@ static struct irq_chip adp5588_irq_chip =3D {
>         .irq_set_type           =3D adp5588_irq_set_type,
>  };
>=20
> -static int adp5588_gpio_read_intstat(struct i2c_client *client, u8 *buf)
> -{
> -       int ret =3D i2c_smbus_read_i2c_block_data(client, GPIO_INT_STAT1,=
 3, buf);
> -
> -       if (ret < 0)
> -               dev_err(&client->dev, "Read INT_STAT Error\n");
> -
> -       return ret;
> -}
> -
>  static irqreturn_t adp5588_irq_handler(int irq, void *devid)
>  {
>         struct adp5588_gpio *dev =3D devid;
> -       unsigned status, bank, bit, pending;
> -       int ret;
> -       status =3D adp5588_gpio_read(dev->client, INT_STAT);
> +       int status =3D adp5588_gpio_read(dev->client, INT_STAT);
>=20
> -       if (status & ADP5588_GPI_INT) {
> -               ret =3D adp5588_gpio_read_intstat(dev->client, dev->irq_s=
tat);
> -               if (ret < 0)
> -                       memset(dev->irq_stat, 0, ARRAY_SIZE(dev->irq_stat=
));
> +       if (status & ADP5588_KE_INT) {
> +               int ev_cnt =3D adp5588_gpio_read(dev->client, KEY_LCK_EC_=
STAT);
>=20
> -               for (bank =3D 0, bit =3D 0; bank <=3D ADP5588_BANK(ADP558=
8_MAXGPIO);
> -                       bank++, bit =3D 0) {
> -                       pending =3D dev->irq_stat[bank] & dev->irq_mask[b=
ank];
> +               if (ev_cnt > 0) {
> +                       int i;
>=20
> -                       while (pending) {
> -                               if (pending & (1 << bit)) {
> -                                       handle_nested_irq(
> -                                               irq_find_mapping(
> -                                                  dev->gpio_chip.irq.dom=
ain,
> -                                                  (bank << 3) + bit));
> -                                       pending &=3D ~(1 << bit);
> -                               }
> -                               bit++;
> +                       for (i =3D 0; i < (ev_cnt & ADP5588_KEC); i++) {
> +                               int key =3D adp5588_gpio_read(dev->client=
,
> +                                                           Key_EVENTA + =
i);
> +                               /* GPIN events begin at 97,
> +                                * bit 7 indicates logic level
> +                                */
> +                               int gpio =3D (key & 0x7f) - 97;
> +                               int lvl =3D key & (1 << 7);
> +                               int bank =3D ADP5588_BANK(gpio);
> +                               int bit =3D ADP5588_BIT(gpio);
> +
> +                               if ((lvl && dev->int_lvl_high[bank] & bit=
) ||
> +                                   (!lvl && dev->int_lvl_low[bank] & bit=
))
> +                                       handle_nested_irq(irq_find_mappin=
g(
> +                                             dev->gpio_chip.irq.domain, =
gpio));
>                         }
>                 }
>         }
> @@ -303,7 +283,6 @@ static int adp5588_irq_setup(struct adp5588_gpio *dev=
)
>=20
>         adp5588_gpio_write(client, CFG, ADP5588_AUTO_INC);
>         adp5588_gpio_write(client, INT_STAT, -1); /* status is W1C */
> -       adp5588_gpio_read_intstat(client, dev->irq_stat); /* read to clea=
r */
>=20
>         mutex_init(&dev->irq_lock);
>=20
> @@ -330,7 +309,7 @@ static int adp5588_irq_setup(struct adp5588_gpio *dev=
)
>                                     client->irq);
>=20
>         adp5588_gpio_write(client, CFG,
> -               ADP5588_AUTO_INC | ADP5588_INT_CFG | ADP5588_GPI_INT);
> +               ADP5588_AUTO_INC | ADP5588_INT_CFG | ADP5588_KE_IEN);
>=20
>         return 0;
>  }
> --
> 2.17.1

