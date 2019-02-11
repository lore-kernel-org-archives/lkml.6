Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1DFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4435F20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jaov2wJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBKJ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:58:14 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:55296
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfBKJ6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3a4oNEomQhGkgXthQKDplQWCz5F0jiy5JARVjuXcUI=;
 b=jaov2wJO7nC6B05AKJ2mESYa8WDF47DyyQdpPnwKHLQQ0scNz3/i1suMNp8YpJvZagp3ab8RxrrktCw/uuUYY5kHNKGZTLLvE/tZX9+a58cGIKtffeBeFdnuK1GkZ0RXr1CAfQVg+u4D7+iOwagef5BybiDsTU0Ip8OYHphZVAM=
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com (20.177.55.216) by
 VI1SPR01MB0363.eurprd04.prod.outlook.com (20.178.120.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 09:58:04 +0000
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b0fe:dee7:b2d3:9355]) by VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b0fe:dee7:b2d3:9355%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 09:58:04 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/9] usb: roles: Find the muxes by also matching
 against the device node
Thread-Topic: [PATCH v2 6/9] usb: roles: Find the muxes by also matching
 against the device node
Thread-Index: AQHUuLVSCFz0E1ZQKUWUh+dd3nT5iqXablHw
Date:   Mon, 11 Feb 2019 09:58:04 +0000
Message-ID: <VI1PR04MB4558283CA9D752D5452FA09989640@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <20190130160259.46919-7-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190130160259.46919-7-heikki.krogerus@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR01MB0363;6:nBAC+ZghSAYqjSoPAu/1FaqygnVc7CFvSOFVsN66ObYh1aHNL9lApAWHRCuC4gRfSnGzDbWCIGWotO53f6mhAfkvBoJ+TFTID3E2qlg6NmfYC7CCTlOO5BkAHoru2Eqkb6MKBWwjOdoZ67g6ouBmnfrOdLbVx9aYADjSmYLUqMS/HWpG7QLSS9+Ph39iqfJSziV3YpSbIxvfP5VYNaV9BTFb7kWjAXsLN3ngj5MQYOnzx4wdoZxdHU/S1lqAa6wL8cSSotnJFFgIZm727sgpN7bDW2N/rY2mQIFlgudppvUUmD37khM4bTFceXMNKzs73UwQMz8SEzlVwLi3crmrBc6Tc8edRbZSVEerwDSFnsAJUzNxcIEdpMwvd3/ijwYIUgQb/91T8uOAYSLqo8vIWS8p+ECDAiZ8pX2zUs2M484sIsb9yEjKniE0c3EkoDL+5B0rwCUE6IHhquem3BHiLw==;5:cbjCRi75EvgmNfCLsblWoHzPS4P1c6VYh+WPeAH6RmLMsDvm94UKo78V1DBeCZqbutsJo5oXgDhUuo3ooeRoIzqDvLaV/VOMGy7VbiTMTI9vnFcga8bAwpIZGVsZMpLXtyzhtnm67uBRRPJP73yPuQAbneQYjcPZUm2CFfewp3llfaf6rYWr7IIutlnFVnDpgllZbtKqcBKNMJha86/i8Q==;7:v8zwsOGY1MxM1Azgfpy25GM94hjA3wpKYk+bUGVj0ep3mP2E0vSUq3rbt5hZovqoe/vkuJWirp4TcdUpeK1VhFA4YObnkg2YE9oKoqAU76n+Pa0ZvszE9zTOF6gNqrxRquJ8hYemozl9t86b9K+rlQ==
x-ms-office365-filtering-correlation-id: 0e5b0f7b-51e1-45a4-1b5f-08d690076ab7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR01MB0363;
x-ms-traffictypediagnostic: VI1SPR01MB0363:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1SPR01MB036331C4E575691DF522A99689640@VI1SPR01MB0363.eurprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(8676002)(478600001)(81166006)(4326008)(316002)(8936002)(486006)(229853002)(4744005)(186003)(7696005)(74316002)(71190400001)(81156014)(966005)(68736007)(446003)(66066001)(71200400001)(476003)(44832011)(11346002)(54906003)(110136005)(14454004)(55016002)(6306002)(9686003)(6436002)(2906002)(102836004)(305945005)(25786009)(105586002)(106356001)(76176011)(7736002)(6246003)(97736004)(26005)(6116002)(3846002)(33656002)(6506007)(99286004)(86362001)(53936002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB0363;H:VI1PR04MB4558.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qkugnWVz2rJdTdLRib9efTNS4TzjbEQKsERIAyVwhC/Ato21DtP3dUjularo6/6x6VSQ3/Y4zxLKqz5QojzyPTrAciCXeF2GJwJhhYwEZevkk+/t7wve8iwFP8Gxt9Z3soDaled58hRR0m2FNi/hobGTB0DyoGD/kWQDCZltYeH7P4clSh2Mxon/JpSx8z1YvpvvdjJqa+hCL5oohXbxd7pmfQfSyrcb8E2j/cpvsPotNe6jDC/2Mr8UzoZavDM99DeEPiKc/j+QSxtu7krzYmPeM3PdVKQm5nZXTI30tib84uvVTQIVLU3ZbXK1kejPvZUbsh+lFo+TKliup/w8fJEnztY6pA6ESFgqivyVVXS6ULSCA5JC8RklbfZmZboYhGvrReghpS4fhPz1kUvBjWdghofdBTAjHTTBKsP22IU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5b0f7b-51e1-45a4-1b5f-08d690076ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 09:58:04.7688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB0363
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

> @@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct
> usb_role_switch *sw)  }  EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
>=20
> -static int __switch_match(struct device *dev, const void *name)
> +static int switch_fwnode_match(struct device *dev, const void *fwnode)
> +{
> +	return dev_fwnode(dev) =3D=3D fwnode;

You missed the comment
https://lkml.org/lkml/2019/1/22/437

return dev_fwnode(dev->parent) =3D=3D fwnode;

Jun
