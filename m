Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CA4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0F920846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="WxR2LEXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0F920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754840AbeFTJLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:11:30 -0400
Received: from mail-he1eur01on0043.outbound.protection.outlook.com ([104.47.0.43]:7630
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754677AbeFTJLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G5O+C8D6urhPr8Z7s1OdmKqnrh0A/rbW3HIANxt+bE=;
 b=WxR2LEXjfMyI7BoHrwEsAnDxviB1kcf+r+IprXZ4opfAozzGWzrad7c/DSalCQS8gwFUx5Px89SCpmtRvzUvx25Qjqh14lfEgGGH75gPpT7hP1UjRJJGCVzYVWcPd4SNhmkXmtyW2sAQsnvSQfd4ZszaYDFh5MXHyNNXEzrogWk=
Received: from DB5PR05MB1320.eurprd05.prod.outlook.com (10.162.157.157) by
 DB5PR05MB1270.eurprd05.prod.outlook.com (10.162.157.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Wed, 20 Jun 2018 09:11:19 +0000
Received: from DB5PR05MB1320.eurprd05.prod.outlook.com
 ([fe80::98:523a:12a9:d0bf]) by DB5PR05MB1320.eurprd05.prod.outlook.com
 ([fe80::98:523a:12a9:d0bf%3]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 09:11:19 +0000
From:   Michael Shych <michaelsh@mellanox.com>
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH 2/5] i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
Thread-Topic: [PATCH 2/5] i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
Thread-Index: AQHUCHQXFrOEx2Xz00uyqJiFAT4beaRo3Bcg
Date:   Wed, 20 Jun 2018 09:11:19 +0000
Message-ID: <DB5PR05MB13204C9C94ADA30ABA1575AAD9770@DB5PR05MB1320.eurprd05.prod.outlook.com>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-3-peda@axentia.se>
In-Reply-To: <20180620085157.30121-3-peda@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michaelsh@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR05MB1270;7:IUtt7YyjUT17GS/qtnpXU8jDgqKClohQ/xjUr6qyZLPdzee6IAjQDUctbIGNLXVdXnKs8QULpczmkcDY39owLLf1ph8EJKkKHEIObWQqbRGk9sj/vU7FOwija0NgX7m5gF1HUPJ/i4OdfR+GxSfrsgYjdH/+nFM8WfFey7BZD8Vd1hp0LHkgqv1Lqx51KXtU04EKI3Iardb2B4aYBJyiNwBJu14WcaJYs5gfJsufEDp/IA75+1wBePlv9AhQQJHP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 83b16e3c-5d18-42b3-6176-08d5d68dc939
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR05MB1270;
x-ms-traffictypediagnostic: DB5PR05MB1270:
x-microsoft-antispam-prvs: <DB5PR05MB127086F6DF920ED022C00225D9770@DB5PR05MB1270.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB5PR05MB1270;BCL:0;PCL:0;RULEID:;SRVR:DB5PR05MB1270;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(346002)(366004)(199004)(13464003)(189003)(15760500003)(7736002)(305945005)(39060400002)(25786009)(26005)(81166006)(5250100002)(8676002)(4326008)(33656002)(3660700001)(81156014)(3280700002)(9686003)(74316002)(99286004)(2501003)(2906002)(6246003)(7696005)(97736004)(53936002)(106356001)(105586002)(229853002)(68736007)(3846002)(6116002)(55016002)(76176011)(5660300001)(186003)(86362001)(478600001)(476003)(446003)(102836004)(54906003)(14454004)(316002)(486006)(53546011)(2900100001)(11346002)(6506007)(66066001)(6436002)(8936002)(110136005)(70780200001)(133343001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR05MB1270;H:DB5PR05MB1320.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lr5vwku3lBO2naWx4aCh5rFq6pyMa3eD4wcJyTZeMBZlPQkPc2MsAzP5QiP+EqYJea0S+KCdBZTr3+l2UFZgltSJijNpw+8Uy1LC2l9W6fz7p5jvXtJJiGcoSKKhtnRqe5h7/d19+uVGuL6LdAtN+vgQXD4OGl5up0SzpkXip4SB6cdmKu20FYEQriiN/OxM0/sBCaIXhrZss7uZCsSOo73XnbIwsKWq1Nu+D03U5KuTQiMajUHJyfcKBcq2+yi0dC2ooE/7hKVt8y840ITY5bpaZsiuLbg1vZ8PDZrc7TYrZ1w/UfxeJCTKAA0JJ1qENJHWS7WmZNghU9E7vmt1Zw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b16e3c-5d18-42b3-6176-08d5d68dc939
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 09:11:19.6746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR05MB1270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Wednesday, June 20, 2018 11:52 AM
> To: linux-kernel@vger.kernel.org
> Cc: Peter Rosin <peda@axentia.se>; Wolfram Sang <wsa@the-dreams.de>;
> Vadim Pasternak <vadimp@mellanox.com>; Michael Shych
> <michaelsh@mellanox.com>; Guenter Roeck <linux@roeck-us.net>;
> Akinobu Mita <akinobu.mita@gmail.com>; Jean Delvare
> <jdelvare@suse.com>; linux-i2c@vger.kernel.org
> Subject: [PATCH 2/5] i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
>=20
> This simplifies the code, and you get retries for free if the adapter
> does not support ->master_xfer.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Michael Shych <michaelsh@mellanox.com>

> ---
>  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-
> mux-mlxcpld.c
> index 12ad8d65faf6..f2bf3e57ed67 100644
> --- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> @@ -94,31 +94,11 @@ static int mlxcpld_mux_reg_write(struct i2c_adapter
> *adap,
>  				 struct i2c_client *client, u8 val)
>  {
>  	struct mlxcpld_mux_plat_data *pdata =3D dev_get_platdata(&client-
> >dev);
> -	int ret =3D -ENODEV;
> -
> -	if (adap->algo->master_xfer) {
> -		struct i2c_msg msg;
> -		u8 msgbuf[] =3D {pdata->sel_reg_addr, val};
> -
> -		msg.addr =3D client->addr;
> -		msg.flags =3D 0;
> -		msg.len =3D 2;
> -		msg.buf =3D msgbuf;
> -		ret =3D __i2c_transfer(adap, &msg, 1);
> -
> -		if (ret >=3D 0 && ret !=3D 1)
> -			ret =3D -EREMOTEIO;
> -	} else if (adap->algo->smbus_xfer) {
> -		union i2c_smbus_data data;
> -
> -		data.byte =3D val;
> -		ret =3D adap->algo->smbus_xfer(adap, client->addr,
> -					     client->flags, I2C_SMBUS_WRITE,
> -					     pdata->sel_reg_addr,
> -					     I2C_SMBUS_BYTE_DATA, &data);
> -	}
> +	union i2c_smbus_data data =3D { .byte =3D val };
>=20
> -	return ret;
> +	return __i2c_smbus_xfer(adap, client->addr, client->flags,
> +				I2C_SMBUS_WRITE, pdata->sel_reg_addr,
> +				I2C_SMBUS_BYTE_DATA, &data);
>  }
>=20
>  static int mlxcpld_mux_select_chan(struct i2c_mux_core *muxc, u32 chan)
> --
> 2.11.0

