Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138B0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B464821104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SdaUVC9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B464821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeKUOHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:07:15 -0500
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:35089
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbeKUOHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW6Cskk7L2V0V29Qs0VPrXyc4kiWKE3JSaZXz39TvFI=;
 b=SdaUVC9TREs7GbV28JDClB6RmIIJhxwxePD9iXvheul1NaXhPZhSlaiA8TpvZm2D5LFwMnKJhfR5qUQnlspj/Q0zPAOKL8W/4yoFLvKF0n648W4Cmt8A+gjMBRK2A/b5emgT8wqEikqPoIxAk44H7S1yfmvOu8csEE7ZFKs/Mv8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4756.eurprd04.prod.outlook.com (20.176.215.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.33; Wed, 21 Nov 2018 03:34:28 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 03:34:28 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/1] can: flexcan: Add self wakeup support
Thread-Topic: [PATCH V3 1/1] can: flexcan: Add self wakeup support
Thread-Index: AQHUeipzLGhxc+FcrUWbbTW8KJQ8BKVZnCKw
Date:   Wed, 21 Nov 2018 03:34:28 +0000
Message-ID: <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
In-Reply-To: <20181112015047.4252-2-qiangqing.zhang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4756;6:5njklIq1NWblLy1IIMzFQbDel7DGcDR69NZbZ5gF6GIWZXKygLgp6BPVN2qZKLeL1tI38iS9wdTS/aP/CMx2VdCu4f/og8GPb3wohJrzUjQ2oq7IrBN7lDkf9VW2j20+4bUnQLsI7OW77yrHJZrXWENoGrog9VoXyeKOpeLB9S4ggGlyMAi8DJS1Z2nBfaOPmK+qFXex4r/1OjOXZWVkjG/70ShKBA2yiL2rhsL/CyV54y2HRy8sGFx4Gu4L44HESlLRmM00gZczw6K7uhG5zZ4jlywKvn9rO+toRhad/CMbc3pLlt3nNK8Y+RkeHJrwugItCHWGMGActOgvifrx3c5r0/dAQO971HipatS85ejDMIyvQJNpB1dvKF2efMoDPW45um4IlWu1AFbU1BsDN4hX9qrX1w9bU01lO8PgYwJn3m6zR+fhsUNC96zR6ZirTgA4u0Osi1++BGqNdWHFLA==;5:Rc2VQYRzoK5/V4IMAfh3s63Opupu+HMCMZ6Gh30APp8na74ZGN0eJWca6KJ2CnfTJBb7E5Af+faFD125lh83qSHHscuqWXkRSP2GsURKsZ5L53jqivrCfEcirLFDGXeEMwlPH1WBUhQKIqCvvYywHEEZ8ldD7QEk0336er9KqQ4=;7:2iBjpkxhNSnhk48Z4IOo66q8kW9nlerLPnD5UiFYQQ8S3UYGtBXjvPUaxWTxSvZDIirD5FTeYLpOdXBHrG90PdXMkHUCpmJCGkZ8HkX6Uvy5lDbKdLyKJUmiDxTqFfaY092SQ72waTMUdXpeqRyjDA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 78d71da0-7808-443b-d6df-08d64f623dd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4756;
x-ms-traffictypediagnostic: AM0PR04MB4756:
x-microsoft-antispam-prvs: <AM0PR04MB475605460D06019AB3EBEBF380DA0@AM0PR04MB4756.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4756;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4756;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(13464003)(199004)(189003)(8676002)(478600001)(53936002)(2501003)(575784001)(86362001)(229853002)(486006)(8936002)(105586002)(68736007)(476003)(6436002)(81166006)(74316002)(2201001)(305945005)(66066001)(81156014)(7736002)(5024004)(11346002)(446003)(106356001)(97736004)(256004)(7696005)(71200400001)(14454004)(76176011)(6246003)(102836004)(71190400001)(2900100001)(6116002)(2906002)(6506007)(4326008)(99286004)(55016002)(14444005)(186003)(316002)(5660300001)(25786009)(54906003)(33656002)(110136005)(26005)(3846002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4756;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EOvFP2rsrgKLawpKW8QyOP80RTuS6BNXR7UPxXacCZHmg0E/6XC6fyo+oa5rHa7SxQ8VhFfCTI/0/s8C+mNDWFmSQEaK1OboYbAH1SKNfrLi5+8zdU/y9wmkvLjWan+DLjEiZ48eTqQjB0x4f0gHbjYjWZFC/Bd4rr0+sqPeuQlV7krctDnxLQJSaKGAedWO7JABsUW7rd+9+ok4igNbcn0ZXz/g3UVAa84lcKKuIxtj6s/oAQSCKeoSQI7M7d2QGNdW17AMisjWf+Vyi/nY8URXJAMYcv945Qg7eVE80vI8XR7f1q7ghF6HYzMkYPctOZPgcBPYVvfZghITLWSggq5O8zjZZNeG+jFPN5mvRpw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d71da0-7808-443b-d6df-08d64f623dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 03:34:28.1274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joakim Zhang
[...]
>=20
> If wakeup is enabled, enter stop mode, else enter disabled mode.Self wake=
 can
> only work on stop mode.
>=20
> Starting from IMX6, the flexcan stop mode control bits is SoC specific, m=
ove it
> out of IP driver and parse it from devicetree.
>=20
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 175
> +++++++++++++++++++++++++++++++++++---
>  1 file changed, 163 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c index
> 3813f6708201..d21d0db8c83e 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -19,12 +19,17 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>

This two lines seems not neccesary

> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
>=20
>  #define DRV_NAME			"flexcan"
>=20
> @@ -132,7 +137,8 @@
>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)  #define
> FLEXCAN_ESR_ALL_INT \
>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
> +	 FLEXCAN_ESR_WAK_INT)
>=20
>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>  /* Errata ERR005829 step7: Reserve first valid MB */ @@ -191,6 +197,7 @@
>  #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp
> based offloading */
>  #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for
> error passive */
>  #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE
> register access */
> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE	BIT(8) /* Setup stop mode to
> support wakeup */
>=20
>  /* Structure of the message buffer */
>  struct flexcan_mb {
> @@ -255,6 +262,14 @@ struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
>  };
>=20
> +struct flexcan_stop_mode {
> +	struct regmap *gpr;
> +	u8 req_gpr;
> +	u8 req_bit;
> +	u8 ack_gpr;
> +	u8 ack_bit;
> +};
> +
>  struct flexcan_priv {
>  	struct can_priv can;
>  	struct can_rx_offload offload;
> @@ -272,6 +287,7 @@ struct flexcan_priv {
>  	struct clk *clk_per;
>  	const struct flexcan_devtype_data *devtype_data;
>  	struct regulator *reg_xceiver;
> +	struct flexcan_stop_mode stm;
>=20
>  	/* Read and Write APIs */
>  	u32 (*read)(void __iomem *addr);
> @@ -295,7 +311,8 @@ static const struct flexcan_devtype_data
> fsl_imx28_devtype_data =3D {
>=20
>  static const struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG |
> FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
> -		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
> FLEXCAN_QUIRK_BROKEN_PERR_STATE,
> +		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
> FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> +		FLEXCAN_QUIRK_SETUP_STOP_MODE,
>  };
>=20
>  static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D { @@
> -392,6 +409,40 @@ static void flexcan_clks_disable(const struct flexcan_p=
riv
> *priv)
>  	clk_disable_unprepare(priv->clk_per);
>  }
>=20
> +static void flexcan_wake_mask_enable(struct flexcan_priv *priv) {
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_mcr;
> +
> +	reg_mcr =3D priv->read(&regs->mcr);
> +	reg_mcr |=3D FLEXCAN_MCR_WAK_MSK;
> +	priv->write(reg_mcr, &regs->mcr);
> +}
> +
> +static void flexcan_wake_mask_disable(struct flexcan_priv *priv) {
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_mcr;
> +
> +	reg_mcr =3D priv->read(&regs->mcr);
> +	reg_mcr &=3D ~FLEXCAN_MCR_WAK_MSK;
> +	priv->write(reg_mcr, &regs->mcr);
> +}
> +

Please combine those two functions into one, also improve the name a bit.
e.g.
flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enable)

> +static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv) {
> +	/* enable stop request */
> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +						1 << priv->stm.req_bit, 1 << priv->stm.req_bit); }
> +
> +static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv) {
> +	/* remove stop request */
> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +						1 << priv->stm.req_bit, 0);
> +}
> +
>  static inline int flexcan_transceiver_enable(const struct flexcan_priv *=
priv)  {
>  	if (!priv->reg_xceiver)
> @@ -955,6 +1006,10 @@ static int flexcan_chip_start(struct net_device *de=
v)
>  		reg_mcr |=3D FLEXCAN_MCR_FEN |
>  			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
>  	}
> +
> +	/* enable self wakeup */
> +	reg_mcr |=3D FLEXCAN_MCR_SLF_WAK;
> +

Should we check before setting as we already have a SETUP_STOP_MODE quirk?

>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>  	priv->write(reg_mcr, &regs->mcr);
>=20
> @@ -1240,6 +1295,60 @@ static void unregister_flexcandev(struct net_devic=
e
> *dev)
>  	unregister_candev(dev);
>  }
>=20
> +static int flexcan_setup_stop_mode(struct platform_device *pdev) {
> +	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device_node *node;

Probably gpr_np is better.

> +	struct flexcan_priv *priv;
> +	bool wakeup =3D true;
> +	phandle phandle;
> +	u32 out_val[5];
> +	int ret;
> +
> +	if (!np)
> +		return -EINVAL;
> +
> +	/* stop mode property format is:
> +	 * <&gpr req_gpr req_bit ack_gpr ack_bit>.
> +	 */
> +	ret =3D of_property_read_u32_array(np, "fsl,stop-mode", out_val, 5);
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "no stop-mode property\n");
> +		return ret;
> +	}
> +	phandle =3D *out_val;
> +
> +	node =3D of_find_node_by_phandle(phandle);
> +	if (!node) {
> +		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
> +		return PTR_ERR(node);
> +	}
> +
> +	priv =3D netdev_priv(dev);
> +	priv->stm.gpr =3D syscon_node_to_regmap(node);
> +	if (IS_ERR(priv->stm.gpr)) {
> +		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
> +		return PTR_ERR(priv->stm.gpr);
> +	}
> +
> +	of_node_put(node);
> +
> +	priv->stm.req_gpr =3D out_val[1];
> +	priv->stm.req_bit =3D out_val[2];
> +	priv->stm.ack_gpr =3D out_val[3];
> +	priv->stm.ack_bit =3D out_val[4];
> +
> +	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x
> ack_bit %u\n",
> +			node->full_name, priv->stm.req_gpr,
> +			priv->stm.req_bit, priv->stm.ack_gpr,
> +			priv->stm.ack_bit);
> +
> +	device_set_wakeup_capable(&pdev->dev, wakeup);

If 'wakeup' variable is not changeable, then not need use it.

> +
> +	return 0;
> +}
> +
>  static const struct of_device_id flexcan_of_match[] =3D {
>  	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_dat=
a, },
>  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_dat=
a, },
> @@ -1400,6 +1509,12 @@ static int flexcan_probe(struct platform_device
> *pdev)
>=20
>  	devm_can_led_init(dev);
>=20
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
> +		err =3D flexcan_setup_stop_mode(pdev);
> +		if (err)
> +			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
> +	}
> +
>  	pm_runtime_put(&pdev->dev);
>=20
>  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n", @=
@
> -1437,10 +1552,18 @@ static int __maybe_unused flexcan_suspend(struct
> device *device)
>  	int err =3D 0;
>=20
>  	if (netif_running(dev)) {
> -		err =3D flexcan_chip_disable(priv);
> -		if (err)
> -			return err;
> -		err =3D pm_runtime_force_suspend(device);
> +		/* if wakeup is enabled, enter stop mode
> +		 * else enter disabled mode.
> +		 */
> +		if (device_may_wakeup(device)) {
> +			enable_irq_wake(dev->irq);
> +			flexcan_enter_stop_mode(priv);
> +		} else {
> +			err =3D flexcan_chip_disable(priv);
> +			if (err)
> +				return err;
> +			err =3D pm_runtime_force_suspend(device);

This is mixed with runtime pm.
I would suggestion you first upstream wakeup support.
Then runtime pm later separately.

Regards
Dong Aisheng

> +		}
>=20
>  		netif_stop_queue(dev);
>  		netif_device_detach(dev);
> @@ -1461,10 +1584,14 @@ static int __maybe_unused
> flexcan_resume(struct device *device)
>  		netif_device_attach(dev);
>  		netif_start_queue(dev);
>=20
> -		err =3D pm_runtime_force_resume(device);
> -		if (err)
> -			return err;
> -		err =3D flexcan_chip_enable(priv);
> +		if (device_may_wakeup(device)) {
> +			flexcan_wake_mask_disable(priv);
> +		} else {
> +			err =3D pm_runtime_force_resume(device);
> +			if (err)
> +				return err;
> +			err =3D flexcan_chip_enable(priv);
> +		}
>  	}
>  	return err;
>  }
> @@ -1489,10 +1616,34 @@ static int __maybe_unused
> flexcan_runtime_resume(struct device *device)
>  	return 0;
>  }
>=20
> +static int __maybe_unused flexcan_noirq_suspend(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev) && device_may_wakeup(device))
> +		flexcan_wake_mask_enable(priv);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused flexcan_noirq_resume(struct device *device) {
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev) && device_may_wakeup(device)) {
> +		disable_irq_wake(dev->irq);
> +		flexcan_exit_stop_mode(priv);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct dev_pm_ops flexcan_pm_ops =3D {
>  	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
> -	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend,
> flexcan_runtime_resume,
> -						NULL)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend,
> flexcan_noirq_resume)
> +	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend,
> flexcan_runtime_resume,
> +NULL)
>  };
>=20
>  static struct platform_driver flexcan_driver =3D {
> --
> 2.17.1

