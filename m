Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298B8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4D821104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EAb+AQBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4D821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391423AbeKLI1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:27:31 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:35040
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389369AbeKLI1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE4zM++uDSqIccaBocMhAwsp+vSkAHqM2UyrdoSFy08=;
 b=EAb+AQBzKi/he5Xi5Ichia58jFAG87k4UCP17jbcz3EcDgYnt8HhX6bBapMS+2taSX4OeSCfp/PzUITRvpGdIRiRgxZfEQs22YIjt3bNQaG6JiQsZvqNWnyshzw1vF1kv3HzK1iXXXwOFwro8jAt1NK57pGMaXOMNk3AMxGjuVk=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4707.eurprd04.prod.outlook.com (20.176.214.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sun, 11 Nov 2018 22:37:26 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.044; Sun, 11 Nov 2018
 22:37:26 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] pinctrl: imx: make sure that maps are fully initialized
Thread-Topic: [PATCH] pinctrl: imx: make sure that maps are fully initialized
Thread-Index: AQHUeRxcpZvOE9dgrEKdKoRDg7Q4RA==
Date:   Sun, 11 Nov 2018 22:37:26 +0000
Message-ID: <AM0PR04MB4290D734ED5D039A903DA2DBEEC00@AM0PR04MB4290.eurprd04.prod.outlook.com>
References: <1541871439-4882-1-git-send-email-martin@kaiser.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4707;6:eeMUwIqQHNp8VkYtNc6ivt9gebQLFSsTeHjUm87KU6JQ03MAdzdbcZUFyjGwAHcn1ePz4kFUp8czMoCcHuax1ihe1UsC1c/Au3JE0U9igWKEZ9UmORmbhvZd8/LvMTlWI8dumNfD+fvmYeh2dy0JHCN05V0obqSnwgI3Ga9kYsTtrb7u3FRBlRXeMJgqFtpLDdPH0ZaZzZFJ9gpEmEPDNzn7eigTjViViIF/X/Il+7duSGnqhR55LI4gw9cGN7Nzq7WLspn/riIkHPTgtX2ioAovKZVESBUfe2rWTgDRC2Hw3dleITT0xqvucRF8q5rxWXcCuinHrdUy5HVC1/gWSrXx4HIcHXegnh61hBGz7oTCSGzp88P5phoQ9YTfbPbtx8XoVLCCz5WcUm3NKoOCFmyDoLIwAJ6Iulnt31Nj1gSSoTa5F5+leq7m0ijp2/OMNIQS+hjWpWJI/T9Z0TNqrw==;5:FMXGfWNy/Fj8ux8Jr7K2a72PHku/Vqjg9zl2Twzq37OnD2reZo/OeWSDYv6/vimCpP3VOLOxm7ChbWkIPtyOsbuZdRAvtl/IA9bQ7yjc3nGLQhnWXm5k+WlQi7RHA7E9kFCLzETYxWu11vvuTt9IDxXMqhPzbw7C0cC3mb3TqWQ=;7:UeRiQ5M4rb7wEtn4Pe0jOTHhkVRTB2OnVuv2nSriRdN4hh0FQiv4TRQzBocklGGQ29qxo61r/XUQsK2qho8P4TgOwVLcGJE2Bk+54pPH+5MK/frzpzTALlaGRVm6ylPdpplUi1xv0aEZVLD4goQZ3Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 80be335c-6e1a-4f41-3e68-08d648264160
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4707;
x-ms-traffictypediagnostic: AM0PR04MB4707:
x-microsoft-antispam-prvs: <AM0PR04MB4707FBF3AA9FBC86E24B85E4EEC00@AM0PR04MB4707.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4707;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4707;
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(305945005)(102836004)(105586002)(53546011)(76176011)(14454004)(68736007)(7696005)(478600001)(106356001)(99286004)(6506007)(316002)(54906003)(81156014)(110136005)(81166006)(8676002)(4326008)(8936002)(39060400002)(71200400001)(71190400001)(66066001)(25786009)(33656002)(74316002)(7736002)(26005)(3846002)(486006)(229853002)(6116002)(476003)(2906002)(5660300001)(53936002)(446003)(2900100001)(97736004)(186003)(6436002)(6246003)(256004)(55016002)(44832011)(86362001)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4707;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: awsjMSS+Eyup78oCW2uyrKZs9Y4KcRSbRI22V/PUMU49GwZ2k07zbyWYvmCIVYoqtH/9jpbG98ucilWqpzkfxqTMw9HY6OTXcglTaDf06wXIlfKEfe5SdRR0muNY4nLugg/H7penMFr+XLrUlD7G4DMhdHlMDyKATJ6ZuimwFOTiO70/Qu7C4xoFnwcwPBZkk48iWlpfB8fO7NVkjYyjHA3BMQHM1QEGLrQbVtuNP2G8T7487R3rZMGQhXs63GpnfTrzpo3WQjafVN2R3Lx1tdeIWzJqoS9UW5b+GU15Rlzov5kTWBt4nxjX7aYzPeB5KnsMcFTTz792jRJIEygfn1vNsZWQNYOOtGlO2J20BMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80be335c-6e1a-4f41-3e68-08d648264160
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2018 22:37:26.1662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 7:37 PM, Martin Kaiser wrote:=0A=
> The commit that added scu based pinctrl support introduced a regression=
=0A=
> for the mmio case. In the for-loop where the maps are initialized, we=0A=
> end up creating a partially initialized map in some cases. This causes a=
=0A=
> kernel panic when such a map is used at a later stage.=0A=
> =0A=
> Fixes: b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support")=0A=
> Cc: A.s. Dong <aisheng.dong@nxp.com>=0A=
=0A=
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/fr=
eescale/pinctrl-imx.c=0A=
> @@ -108,9 +108,6 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pct=
ldev,=0A=
>   	new_map++;=0A=
>   	for (i =3D j =3D 0; i < grp->num_pins; i++) {=0A=
>   		pin =3D &((struct imx_pin *)(grp->data))[i];=0A=
> -		new_map[j].type =3D PIN_MAP_TYPE_CONFIGS_PIN;=0A=
> -		new_map[j].data.configs.group_or_pin =3D=0A=
> -					pin_get_name(pctldev, pin->pin);=0A=
>   =0A=
>   		if (info->flags & IMX_USE_SCU) {=0A=
>   			/*=0A=
> @@ -126,7 +123,12 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pc=
tldev,=0A=
>   			new_map[j].data.configs.num_configs =3D 1;=0A=
>   		}=0A=
>   =0A=
> -		j++;=0A=
> +		if (new_map[j].data.configs.num_configs) {=0A=
> +			new_map[j].type =3D PIN_MAP_TYPE_CONFIGS_PIN;=0A=
> +			new_map[j].data.configs.group_or_pin =3D=0A=
> +				pin_get_name(pctldev, pin->pin);=0A=
> +			j++;=0A=
> +		}=0A=
=0A=
Sorry but I don't think this is correct.=0A=
=0A=
The new_map array is allocated with kmalloc_array so we can't rely on =0A=
new_map[j].data.configs.num_configs being initialized to zero unless =0A=
assigned to.=0A=
=0A=
I was looking at the ssue before I saw your patch and posted an =0A=
different fix. I can't find a give link right now, it takes a while to =0A=
show up in public archives.=0A=
