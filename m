Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E609C214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TbOeeP3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E609C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbeKUXgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:36:14 -0500
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:45372
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727486AbeKUXgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpiBoiJIpHcOVZkL3xn64kyXUNcaFsP4CiNCLARwBY4=;
 b=TbOeeP3+OH7WfAgr4XU1rnjVb4Wn0l2O6TFa+EscsQMe18ToBkLAxzhJeM9u54e4L73cdPciGBD05td/BkVaqyVfuIXBI+3EG5ARBlHewFAsw88cphYKqGyUA1qJnOLO1NZ4LfZj2XDdF36AVjPtrvueWNx0crc2ahcEfI3bm8k=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5780.eurprd04.prod.outlook.com (20.178.202.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 13:01:44 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 13:01:44 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/1] can: flexcan: add self wakeup support
Thread-Topic: [PATCH V4 1/1] can: flexcan: add self wakeup support
Thread-Index: AQHUgZY4VvHZKYhbxkiYG7EMB9VSQaVaLpEQgAACqwA=
Date:   Wed, 21 Nov 2018 13:01:44 +0000
Message-ID: <AM0PR04MB421114AAD79CB723AB22DD0E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
 <20181121122957.2684-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB421154D4E5F03AC4D222F7E480DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421154D4E5F03AC4D222F7E480DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5780;6:gomJiG2hQ4DeEzY1bn/VliTH7Pv0efPz+FOHtW8oIbA8fU03F8wZbRUa270c6HWMPFekU/gYMh/6XDarl7jQBDg9CZHEYt0VcmZZ8kLBMWXSUCwDTReGt086Wxky6JlHFHOarsABdYP1DKilj+YmeY08JbuBNIwfdCxbEUbtCqAdDg4gOqAKbbnZZOWWiQL0VsM70QNBleciyLHtkZqgrO7TlTkfptjtl8GYbKQr1eBg9BAZWEVatca+SZhd8s8yRSfgLpHVZBVgALwBSVJV1KS+bhiOj19fPIps+aZPjobmNThSyNzkYCC/fPL1e9/lQyt4tJs7Dsmk3G/K3iQUvNqJd1pTpQtlOYq5c9BQ2CcIQKoYx0qXxbqsMUS2ruyBY2KOUIBYuE8yDGifWKrd7UD99qxXQb7HQfUfP2OJEute/HaaCBb3ayzujufkA8pUfRSVCYeiO1tyMMy+TzVwVg==;5:eVXmwN3qqUkHTl3SCXt/bFQdpi2jFKHyRZI5cKd4w/SKtmfMSph8UjhnhQ3U94q5+Fm0dwrETLA1FxbZdd0UXWqMxpsi/yqu7OgKZ+y4JQvtvxgntosT5tFygga9qFPggwblTxGBoIftFKUfd5Yy5kgcd0yBX6uX3Za50JxZXMA=;7:GuPLNK9+PhGdp4KpOq/w59dnrC85frdESH7ZHJLThGo8ATo6v6Ufc1EtC1GgYi0lxUXK5NZRnZDX5dFyL6WJKysNt0rkCefjA5s5hvANn9unwkpc8dtqpUEOb5ILfktZOKyeZJnQiU7u0ecH+dssmw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 640bdc6e-45a1-4624-481f-08d64fb17cf8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5780;
x-ms-traffictypediagnostic: AM0PR04MB5780:
x-microsoft-antispam-prvs: <AM0PR04MB5780C8C7CFBDABF238412E3580DA0@AM0PR04MB5780.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5780;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5780;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(13464003)(199004)(189003)(76176011)(229853002)(54906003)(53546011)(6506007)(110136005)(7696005)(316002)(7736002)(305945005)(2900100001)(4326008)(25786009)(33656002)(5660300001)(6436002)(74316002)(6116002)(3846002)(97736004)(478600001)(2906002)(99286004)(9686003)(11346002)(446003)(476003)(486006)(55016002)(106356001)(8936002)(53936002)(81156014)(81166006)(8676002)(93156006)(105586002)(71190400001)(71200400001)(2501003)(5024004)(14444005)(256004)(6246003)(86362001)(2201001)(186003)(26005)(66066001)(14454004)(68736007)(2940100002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5780;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LLQ61F43UENmNLARJLupMaamB0ZrfbtMDLiNRNqM7s5F05F8uRcGCzTpauYCewRfpmMIMshxRXCWRz6nf9MDKsyNKMc7fveTeQIo9vztNlNdFjfMWYZdXEX4Y5qLht0eoJYgcJ3uo0CLGllSkXCiHdc/R3i3r6gfj/klDLA1JN1UC9KVHZHD2fg7euECb4Ga5JMekfe/TSQsOn/IUrdR92MsDnFfujep61Xc4ixfTni5/6tbd0IiOWqZvXWTdQSI3luH4kgwn5XF7nwJC1V85nsb5Zc7bTQYsB98DdF3DJ4cyxriFe5kSRzlSqlxGCEHJ3oBDFW7tZGij90BgbsHURBPvq0i54SN0rXBMDdT6wQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640bdc6e-45a1-4624-481f-08d64fb17cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 13:01:44.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Aisheng DONG
> Sent: Wednesday, November 21, 2018 9:00 PM
> To: Joakim Zhang <qiangqing.zhang@nxp.com>; linux-can@vger.kernel.org;
> mkl@pengutronix.de
> Cc: wg@grandegger.com; linux-kernel@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: RE: [PATCH V4 1/1] can: flexcan: add self wakeup support
>=20
> This mostly looks good to me.
> A few minor comments
>=20

BTW, you should re-send the series with binding doc patch if it's still not=
 merged.

Regards
Dong Aisheng

> > -----Original Message-----
> > From: Joakim Zhang
> > Sent: Wednesday, November 21, 2018 8:32 PM
> > To: linux-can@vger.kernel.org; mkl@pengutronix.de
> > Cc: wg@grandegger.com; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>; Aisheng DONG <aisheng.dong@nxp.com>; Joakim
> Zhang
> > <qiangqing.zhang@nxp.com>
> > Subject: [PATCH V4 1/1] can: flexcan: add self wakeup support
> >
> > From: Aisheng Dong <aisheng.dong@nxp.com>
> >
> > If wakeup is enabled, enter stop mode, else enter disabled mode. Self
> > wake can only work on stop mode.
> >
> > Starting from IMX6, the flexcan stop mode control bits is SoC
> > specific, move it out of IP driver and parse it from devicetree.
> >
> > Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
> > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > ---
> >  drivers/net/can/flexcan.c | 163
> > +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 154 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> > index 8e972ef08637..83431810316e 100644
> > --- a/drivers/net/can/flexcan.c
> > +++ b/drivers/net/can/flexcan.c
> > @@ -19,11 +19,14 @@
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/regmap.h>
> >
> >  #define DRV_NAME			"flexcan"
> >
> > @@ -131,7 +134,8 @@
> >  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)  #define
> > FLEXCAN_ESR_ALL_INT \
> >  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
> > -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
> > +	FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
> > +	FLEXCAN_ESR_WAK_INT)
> >
> >  /* FLEXCAN interrupt flag register (IFLAG) bits */
> >  /* Errata ERR005829 step7: Reserve first valid MB */ @@ -190,6 +194,7
> @@
> >  #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp
> > based offloading */
> >  #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt
> for
> > error passive */
> >  #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE
> > register access */
> > +#define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop
> > mode to support wakeup */
> >
> >  /* Structure of the message buffer */  struct flexcan_mb { @@ -254,6
> > +259,14 @@ struct flexcan_devtype_data {
> >  	u32 quirks;		/* quirks needed for different IP cores */
> >  };
> >
> > +struct flexcan_stop_mode {
> > +	struct regmap *gpr;
> > +	u8 req_gpr;
> > +	u8 req_bit;
> > +	u8 ack_gpr;
> > +	u8 ack_bit;
> > +};
> > +
> >  struct flexcan_priv {
> >  	struct can_priv can;
> >  	struct can_rx_offload offload;
> > @@ -270,6 +283,7 @@ struct flexcan_priv {
> >  	struct clk *clk_per;
> >  	const struct flexcan_devtype_data *devtype_data;
> >  	struct regulator *reg_xceiver;
> > +	struct flexcan_stop_mode stm;
> >
> >  	/* Read and Write APIs */
> >  	u32 (*read)(void __iomem *addr);
> > @@ -293,7 +307,8 @@ static const struct flexcan_devtype_data
> > fsl_imx28_devtype_data =3D {
> >
> >  static const struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {
> >  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG |
> > FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
> > -		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
> > FLEXCAN_QUIRK_BROKEN_PERR_STATE,
> > +		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
> > FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> > +		FLEXCAN_QUIRK_SETUP_STOP_MODE,
> >  };
> >
> >  static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
> > @@
> > -353,6 +368,35 @@ static inline void flexcan_write_le(u32 val, void
> > __iomem
> > *addr)
> >  	iowrite32(val, addr);
> >  }
> >
> > +static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool
> > +enable) {
> > +	struct flexcan_regs __iomem *regs =3D priv->regs;
> > +	u32 reg_mcr;
> > +
> > +	reg_mcr =3D priv->read(&regs->mcr);
> > +
> > +	if (enable)
> > +		reg_mcr |=3D FLEXCAN_MCR_WAK_MSK;
> > +	else
> > +		reg_mcr &=3D ~FLEXCAN_MCR_WAK_MSK;
> > +
> > +	priv->write(reg_mcr, &regs->mcr);
> > +}
> > +
> > +static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv) =
{
> > +	/* enable stop request */
> > +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> > +			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit); }
> > +
> > +static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv) {
> > +	/* remove stop request */
> > +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> > +			   1 << priv->stm.req_bit, 0);
> > +}
> > +
> >  static inline void flexcan_error_irq_enable(const struct flexcan_priv =
*priv)
> {
> >  	struct flexcan_regs __iomem *regs =3D priv->regs; @@ -940,6 +984,10 @=
@
> > static int flexcan_chip_start(struct net_device *dev)
> >  		reg_mcr |=3D FLEXCAN_MCR_FEN |
> >  			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
> >  	}
> > +
> > +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE)
> > +		reg_mcr |=3D FLEXCAN_MCR_SLF_WAK;
>=20
> Please try if you can merge this into flexcan_enable_wakeup_irq().
> If not, you can check with device_can_wakeup() as the stop parsing may fa=
il.
>=20
> > +
> >  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
> >  	priv->write(reg_mcr, &regs->mcr);
> >
> > @@ -1244,6 +1292,58 @@ static void unregister_flexcandev(struct
> > net_device
> > *dev)
> >  	unregister_candev(dev);
> >  }
> >
> > +static int flexcan_setup_stop_mode(struct platform_device *pdev) {
> > +	struct net_device *dev =3D platform_get_drvdata(pdev);
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	struct device_node *gpr_np;
> > +	struct flexcan_priv *priv;
> > +	phandle phandle;
> > +	u32 out_val[5];
> > +	int ret;
> > +
> > +	if (!np)
> > +		return -EINVAL;
> > +
> > +	/* stop mode property format is:
> > +	 * <&gpr req_gpr req_bit ack_gpr ack_bit>.
> > +	 */
> > +	ret =3D of_property_read_u32_array(np, "fsl,stop-mode", out_val, 5);
> > +	if (ret) {
> > +		dev_dbg(&pdev->dev, "no stop-mode property\n");
> > +		return ret;
> > +	}
> > +	phandle =3D *out_val;
> > +
> > +	gpr_np =3D of_find_node_by_phandle(phandle);
> > +	if (!gpr_np) {
> > +		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
> > +		return PTR_ERR(gpr_np);
> > +	}
> > +
> > +	priv =3D netdev_priv(dev);
> > +	priv->stm.gpr =3D syscon_node_to_regmap(gpr_np);
>=20
> Better to put node here to cover failure case?
>=20
> Regards
> Dong Aisheng
>=20
> > +	if (IS_ERR(priv->stm.gpr)) {
> > +		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
> > +		return PTR_ERR(priv->stm.gpr);
> > +	}
> > +
> > +	of_node_put(gpr_np);
> > +
> > +	priv->stm.req_gpr =3D out_val[1];
> > +	priv->stm.req_bit =3D out_val[2];
> > +	priv->stm.ack_gpr =3D out_val[3];
> > +	priv->stm.ack_bit =3D out_val[4];
> > +
> > +	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x
> > ack_bit %u\n",
> > +		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit,
> > priv->stm.ack_gpr,
> > +		priv->stm.ack_bit);
> > +
> > +	device_set_wakeup_capable(&pdev->dev, true);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct of_device_id flexcan_of_match[] =3D {
> >  	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_d=
ata, },
> >  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D
> > &fsl_imx28_devtype_data, }, @@ -1396,6 +1496,12 @@ static int
> > flexcan_probe(struct platform_device
> > *pdev)
> >
> >  	devm_can_led_init(dev);
> >
> > +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
> > +		err =3D flexcan_setup_stop_mode(pdev);
> > +		if (err)
> > +			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
> > +	}
> > +
> >  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",
> >  		 priv->regs, dev->irq);
> >
> > @@ -1426,9 +1532,17 @@ static int __maybe_unused
> > flexcan_suspend(struct device *device)
> >  	int err;
> >
> >  	if (netif_running(dev)) {
> > -		err =3D flexcan_chip_disable(priv);
> > -		if (err)
> > -			return err;
> > +		/* if wakeup is enabled, enter stop mode
> > +		 * else enter disabled mode.
> > +		 */
> > +		if (device_may_wakeup(device)) {
> > +			enable_irq_wake(dev->irq);
> > +			flexcan_enter_stop_mode(priv);
> > +		} else {
> > +			err =3D flexcan_chip_disable(priv);
> > +			if (err)
> > +				return err;
> > +		}
> >  		netif_stop_queue(dev);
> >  		netif_device_detach(dev);
> >  	}
> > @@ -1447,14 +1561,45 @@ static int __maybe_unused
> > flexcan_resume(struct device *device)
> >  	if (netif_running(dev)) {
> >  		netif_device_attach(dev);
> >  		netif_start_queue(dev);
> > -		err =3D flexcan_chip_enable(priv);
> > -		if (err)
> > -			return err;
> > +		if (device_may_wakeup(device)) {
> > +			flexcan_enable_wakeup_irq(priv, false);
> > +		} else {
> > +			err =3D flexcan_chip_enable(priv);
> > +			if (err)
> > +				return err;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused flexcan_noirq_suspend(struct device
> > +*device) {
> > +	struct net_device *dev =3D dev_get_drvdata(device);
> > +	struct flexcan_priv *priv =3D netdev_priv(dev);
> > +
> > +	if (netif_running(dev) && device_may_wakeup(device))
> > +		flexcan_enable_wakeup_irq(priv, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused flexcan_noirq_resume(struct device *device) =
{
> > +	struct net_device *dev =3D dev_get_drvdata(device);
> > +	struct flexcan_priv *priv =3D netdev_priv(dev);
> > +
> > +	if (netif_running(dev) && device_may_wakeup(device)) {
> > +		disable_irq_wake(dev->irq);
> > +		flexcan_exit_stop_mode(priv);
> >  	}
> > +
> >  	return 0;
> >  }
> >
> > -static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend,
> > flexcan_resume);
> > +static const struct dev_pm_ops flexcan_pm_ops =3D {
> > +	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend,
> > +flexcan_noirq_resume) };
> >
> >  static struct platform_driver flexcan_driver =3D {
> >  	.driver =3D {
> > --
> > 2.17.1

