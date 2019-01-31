Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ADC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E877C218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KJqYZqLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfAaIQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:16:58 -0500
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:14513
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfAaIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2KoAERSmntCVagM88zc1qtoLjC5V1jYSml6FkbWpKo=;
 b=KJqYZqLpV3g4yJnnq/fFkgb//oTBaTERww7cUJMzcHFIOApMRwCahJdQBa7xdYGd3EJUhKmJZOdZ8dNQKqibwa7w1mb1myDZeTnDjURWjDnfPPMQKNWIlA5h6lWyabUJ2QwmMNKNdEhrXxM0IwVbGT3yzYBHXiIgj4qpKX5XoKA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4436.eurprd04.prod.outlook.com (52.135.148.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 08:16:54 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 08:16:53 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [PATCH v3] firmware: imx: Add support to start/stop a CPU
Thread-Topic: [PATCH v3] firmware: imx: Add support to start/stop a CPU
Thread-Index: AQHUuJ/zljwGGsgqVEqW1pCa+zHOeKXJCQ5g
Date:   Thu, 31 Jan 2019 08:16:53 +0000
Message-ID: <AM0PR04MB4211CBB9D46FC6EDB9DA9F1680910@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190130133005.5732-1-daniel.baluta@nxp.com>
In-Reply-To: <20190130133005.5732-1-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4436;6:dYjwHs1VqigM4z4u+9NN1acmFTvx/HHclWv3AfSCf4IvsImIHuc4sgawoEg45060jV7RAKugn1V09UJf0UcHWBilQTmdE0ZSbZ1q3lYfBSm7SroeXmtG7p0TE5yV5XhwFJUMzvKdshKG/YMZ56Lh/yM9F+xBPMUycy3Bss7rkHaIvaOFKP3F9lK0yMp79K43EWum9KQvUiHcrTE3r9TjrLBeXP40/ZEnptLbCSRLqcuR6s3KOdOXEPXXxHycX14TYKlddWAiEZu4ImfzYdjJzAOkigJLColYKpRDXw9oT3woaQazvopx2VlH10y/M+PdOSSCFaqTfT0WXYBr8y9WYW0tZ84PLcZJamFd31M4VfVEW4xGrFqAnNtc/5X66CJBo6qaoww5mUABAlv9thJX4G6tJYAfJaT1RUJe7sBgIL1aFcEheSC0lScuaJrv1g5SgOMqx0ypRhMtIDn1rBirZA==;5:bWabK3DtiMT7kn+UrGCzDvS+3p/pGaIJeE53x/YBJ4fBywTcoVyzStWmVRXotnFocRFPIxgG6TmSUQrMk8s62DwK7oSedNsKiVFYME+2tz21K8iVrqRwj/1qzQl8CAB5xg9nIMe6hMU7jMl/Wyv62XqYXe3TF0OQoT21htsepMk74d2MiByLOgcOIIsTICbSWWgnnk8X9ztMlUOjWnCBww==;7:vWupaj0gSlEteHAZ07lxpfgBNA6cEDvd4Z9ifn4pxpl4MaaMJzPAuA4PAuvPuj0hm6+mHjaAtzXCzj0fUmkMQ/bZwGsKGX3k4PVYsDzMXA/DioGemRgv7q/HrP5Gy7Nvs9TveVz/2DB1vvXtpYmECw==
x-ms-office365-filtering-correlation-id: 61595ce5-f9ee-4132-571b-08d68754759d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4436;
x-ms-traffictypediagnostic: AM0PR04MB4436:
x-microsoft-antispam-prvs: <AM0PR04MB4436CF6D50183CD6CCD9F67780910@AM0PR04MB4436.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(189003)(199004)(13464003)(71200400001)(6506007)(9686003)(7696005)(110136005)(25786009)(316002)(4326008)(6436002)(54906003)(53936002)(53546011)(99286004)(55016002)(76176011)(7736002)(74316002)(305945005)(186003)(256004)(86362001)(66066001)(26005)(478600001)(81166006)(81156014)(68736007)(446003)(14454004)(97736004)(8676002)(44832011)(105586002)(486006)(33656002)(106356001)(2501003)(8936002)(2906002)(6116002)(39060400002)(229853002)(6246003)(71190400001)(102836004)(3846002)(476003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4436;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vu4EjFbQQ18A46HbhqA1tLHeJVOUM9xL9ZS+TmBNlNP0HZ32FGLHUoQofEoL+LXjY9coXmjESBKA2b1nlfZ3W1wOhgaMHJfhP+dRGpknizomHv6U8l+FtLcPwXP5A/5iUpUahtMGx5ZbSJ3BDvqPW1mJhrCRs8s3uxtbCLMVLp7AyPpMbKE2d3frK3gQLptpAhiAsAeeFnUyHvgmnRLFT/8v6CgXygBgTosnbgRQD5/M26oINMxm9wdwoiZk8LpC/uFVaMWNvE4oc2qBO/CS0PaTgXqIRyZQ+90ZKnez9mW2FcQvWdB+FV//UQZnreX7ulof0Po/4LmBnhEvfgkQYmHraIoN9ul2tpgYROvWj48qdxUkWAZZon1Uqv22e8QTDikY5MubYbz9Yd0RMsoZD7kKfHHa4iPPrBN3oSGoL8s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61595ce5-f9ee-4132-571b-08d68754759d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 08:16:53.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Daniel Baluta
> Sent: Wednesday, January 30, 2019 9:30 PM
> To: shawnguo@kernel.org
> Cc: s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> dl-linux-imx <linux-imx@nxp.com>; daniel.baluta@gmail.com; Aisheng Dong
> <aisheng.dong@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; S.j. Wang <shengjiu.wang@nxp.com>; Daniel
> Baluta <daniel.baluta@nxp.com>
> Subject: [PATCH v3] firmware: imx: Add support to start/stop a CPU
>=20
> This is done via RPC call to SCU.
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
> Changes since v2: (as per Aisheng's review)
> 	- rename address with phys_address
> 	- remove unnecessary uint8_t cast
> 	- use 'true' as last parameter of imx_scu_call_rpc to actually
> 	wait for a response from SCU.
>=20
>  drivers/firmware/imx/misc.c           | 38
> +++++++++++++++++++++++++++
>  include/linux/firmware/imx/svc/misc.h |  3 +++
>  2 files changed, 41 insertions(+)
>=20
> diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c in=
dex
> 97f5424dbac9..4b56a587dacd 100644
> --- a/drivers/firmware/imx/misc.c
> +++ b/drivers/firmware/imx/misc.c
> @@ -18,6 +18,14 @@ struct imx_sc_msg_req_misc_set_ctrl {
>  	u16 resource;
>  } __packed;
>=20
> +struct imx_sc_msg_req_cpu_start {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 address_hi;
> +	u32 address_lo;
> +	u16 resource;
> +	u8 enable;
> +} __packed;
> +
>  struct imx_sc_msg_req_misc_get_ctrl {
>  	struct imx_sc_rpc_msg hdr;
>  	u32 ctrl;
> @@ -97,3 +105,33 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc,
> u32 resource,
>  	return 0;
>  }
>  EXPORT_SYMBOL(imx_sc_misc_get_control);
> +
> +/*
> + * This function starts/stops a CPU identified by @resource
> + *
> + * @param[in]     ipc         IPC handle
> + * @param[in]     resource    resource the control is associated with
> + * @param[in]     enable      true for start, false for stop
> + * @param[in]     phys_addr   initial instruction address to be executed
> + *
> + * @return Returns 0 for success and < 0 for errors.
> + */
> +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> +			bool enable, u64 phys_addr)
> +{
> +	struct imx_sc_msg_req_cpu_start msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +
> +	hdr->ver =3D IMX_SC_RPC_VERSION;
> +	hdr->svc =3D IMX_SC_RPC_SVC_PM;
> +	hdr->func =3D IMX_SC_PM_FUNC_CPU_START;
> +	hdr->size =3D 4;
> +
> +	msg.address_hi =3D phys_addr >> 32;
> +	msg.address_lo =3D phys_addr;
> +	msg.resource =3D resource;
> +	msg.enable =3D enable;
> +
> +	return imx_scu_call_rpc(ipc, &msg, true); }
> +EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> diff --git a/include/linux/firmware/imx/svc/misc.h
> b/include/linux/firmware/imx/svc/misc.h
> index e21c49aba92f..031dd4d3c766 100644
> --- a/include/linux/firmware/imx/svc/misc.h
> +++ b/include/linux/firmware/imx/svc/misc.h
> @@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32
> resource,  int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resour=
ce,
>  			    u8 ctrl, u32 *val);
>=20
> +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> +			bool enable, u64 phys_addr);
> +
>  #endif /* _SC_MISC_API_H */
> --
> 2.17.1

