Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20593C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AAB20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iG7hZN9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AAB20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbeGLIyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:54:05 -0400
Received: from mail-ve1eur01on0085.outbound.protection.outlook.com ([104.47.1.85]:43775
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeGLIyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwQ0gS046T3ncVNWS7/QOuE7oTpMvaOkNe9veSLiHnQ=;
 b=iG7hZN9UzgC4hMtVia/BXrPzliKW1+8u37ggp7m8wXSwl8IuEbbZyJwh939HetOlfXF7NFvRSzJabqRWw588Xd3pkB2IYYpqq1I5u/kx+C8bCmAbl6c9T34YVOSQ+rhmpqZAGYSRp6yOQKx9yZ3LvTFGnIMtvsFFd3DemPkc83M=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5185.eurprd04.prod.outlook.com (20.177.42.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 08:45:25 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 08:45:25 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
 changing frequency
Thread-Topic: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
 changing frequency
Thread-Index: AQHUGbdziVAWYrtsW0OzeeypcdN2J6SLRbyA
Date:   Thu, 12 Jul 2018 08:45:25 +0000
Message-ID: <AM0PR04MB4211E2E422D988E6F4775FA280590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180712080725.14250-1-stefan@agner.ch>
In-Reply-To: <20180712080725.14250-1-stefan@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5185;7:fAAdFUNH1BqtuMJw4htRY6S0Q8/uts9x+jGck6ZbA8Tvphlso8Tt53tOvmWTjlVOPrANobwgmHcmWNQflJXn18vn+GFfZAc7gLkmB3F3bnauKl/yd+9im5qLQustO8urEjKKC/+21pZeVCJ92MPFymYFizRVdMqUyimPvXjqmMZOf9fvYwbnhG/7Jch6DKXwejd1GmFxSyUk4hWsq99ldi6+V9c2SANbi5joUDXz4Q8Iy0vcHwp50KVBqSrttiew
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bde4dd97-6730-4bad-6ce4-08d5e7d3cff9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5185;
x-ms-traffictypediagnostic: AM0PR04MB5185:
x-microsoft-antispam-prvs: <AM0PR04MB5185209337A75D92304D008A80590@AM0PR04MB5185.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5185;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5185;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(189003)(199004)(13464003)(53546011)(14454004)(68736007)(229853002)(256004)(14444005)(5660300001)(8936002)(2900100001)(81156014)(9686003)(8676002)(33656002)(81166006)(76176011)(6506007)(7736002)(53936002)(476003)(74316002)(5250100002)(7696005)(26005)(2906002)(25786009)(446003)(6116002)(4326008)(186003)(11346002)(66066001)(305945005)(102836004)(105586002)(478600001)(575784001)(6436002)(486006)(86362001)(110136005)(99286004)(2201001)(55016002)(6246003)(97736004)(316002)(2501003)(54906003)(106356001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5185;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: epZEk/uuD5TfEFUa4LXPEEXDivxr/s87PhKc2CiN4xJ3eyMDZYbPQ83YDewukjHnNjGA04HU2sUIqscCZS8rzFlGx0H+62+DoMOIBwwZDOvCfuINee+xM50wBqeKqu/cehUxCquLYD+1BGp6U2zMinAsUhgJR5kFlDp42wjmsWCwyzevyyva3LWDX+yzrh4/uQEv0tYPZOMgKf0gq50p/v3QbMJcNQKqQXjvY6haTKdiRjrdijdw6glBKU8aReaMZeoCAS/n59eDxHJjoI733bMNplVjnhGHXwJUv0F1voUwumMuLkA8So32I/zelJwdVWs4XzeWMMD2oKfFWWdZlQLRErRfAsK5uhtYFTpqg/U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde4dd97-6730-4bad-6ce4-08d5e7d3cff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 08:45:25.5358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Thursday, July 12, 2018 4:07 PM
> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
> <stefan@agner.ch>
> Subject: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
> changing frequency
>=20
> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency is =
set to 0.
> However, it could be that the stack asks for a frequency change while clo=
cks
> are on. In that case the function clears the divider registers (by cleari=
ng
> ESDHC_CLOCK_MASK) while the clock is enabled! This causes a short period
> of time where the clock is undivided (on a i.MX 6DL a clock of 196MHz has
> been measured).
>=20
> For older IP variants the driver disables clock by clearing some bits in
> ESDHC_SYSTEM_CONTROL.
>=20
> Make sure to disable card clock before changing frequency for uSDHC IP
> variants too.

Looks ok to me.
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index 85fd5a8b0b6d..acacd8481473 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct
> sdhci_host *host,
>  	int div =3D 1;
>  	u32 temp, val;
>=20
> +	if (esdhc_is_usdhc(imx_data)) {
> +		val =3D readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> +			host->ioaddr + ESDHC_VENDOR_SPEC);
> +	}
> +
>  	if (clock =3D=3D 0) {
>  		host->mmc->actual_clock =3D 0;
> -
> -		if (esdhc_is_usdhc(imx_data)) {
> -			val =3D readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> -			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -					host->ioaddr +
> ESDHC_VENDOR_SPEC);
> -		}
>  		return;
>  	}
>=20
> --
> 2.18.0

