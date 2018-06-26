Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B889C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95882643C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WZ6XF0ZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95882643C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965273AbeFZCWu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:22:50 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:63931
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965199AbeFZCWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6epo9iWY7jTG5MwEz+qNEEl+/2WKmlLjQ3Z0L/fB3k=;
 b=WZ6XF0ZMQxBbQVXRgdbjlT068xBmFHPywSBqJA04HTIq1YzUd2CPMbeTo3KO0MbIB9Xpyg/mbUX0WpIVZlZvDmFpFIFDe+D3U6+Ap4A/pkcB82/lE5JhZxkYYoWCjCKQLSItO14egkmZtP/7MDDtUcJuiC0xByH/q8+6bsOf/eE=
Received: from HE1PR04MB1450.eurprd04.prod.outlook.com (10.163.176.12) by
 HE1PR04MB0954.eurprd04.prod.outlook.com (10.162.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Tue, 26 Jun 2018 02:22:43 +0000
Received: from HE1PR04MB1450.eurprd04.prod.outlook.com
 ([fe80::6c56:638d:9996:7449]) by HE1PR04MB1450.eurprd04.prod.outlook.com
 ([fe80::6c56:638d:9996:7449%4]) with mapi id 15.20.0884.024; Tue, 26 Jun 2018
 02:22:43 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] usb: chipidea: tegra: Use aligned DMA on Tegra114/124
Thread-Topic: [PATCH] usb: chipidea: tegra: Use aligned DMA on Tegra114/124
Thread-Index: AQHUDFpm0PE1NBcUBUKlRUz+xBOptKRx0DSg
Date:   Tue, 26 Jun 2018 02:22:42 +0000
Message-ID: <HE1PR04MB1450E820FEC8C9B31251057E8B490@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <20180625075843.31878-1-marcel@ziswiler.com>
In-Reply-To: <20180625075843.31878-1-marcel@ziswiler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB0954;7:pECi4+4BXUZC95haI3aYTtPrBiq4O4MNs47WKx+VQ2l8BZOpA5T0meriWtwnNEnzSX1wJHhD98au7uv5ZMj9Y8znWHfWJUdBg0EaBIWDcxJAUgeH4ux4SaNbamBNbqg4dGItbvVj3FoYQrUWWxJFI8OrDQ0SCRMdBNQtIvOosVJ5QMrX2Mgb1t6LM1k3C5YaF4/X7gUxkosuE+dEzVRHEh685sIK4rWqWr+vJqbrEYlUCB/As7XHzMxzJIlK/zS6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e98846f9-ce8e-47d2-640b-08d5db0bb2f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB0954;
x-ms-traffictypediagnostic: HE1PR04MB0954:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <HE1PR04MB09543521CF6CC0EFD7A854658B490@HE1PR04MB0954.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB0954;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB0954;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(99286004)(229853002)(8936002)(68736007)(7696005)(256004)(66066001)(44832011)(486006)(9686003)(5660300001)(55016002)(6116002)(6436002)(3846002)(2501003)(33656002)(2201001)(446003)(476003)(2906002)(25786009)(11346002)(5250100002)(6246003)(14454004)(4326008)(7736002)(86362001)(53936002)(39060400002)(478600001)(74316002)(8676002)(81166006)(81156014)(76176011)(106356001)(6506007)(105586002)(316002)(2900100001)(186003)(305945005)(26005)(102836004)(110136005)(97736004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB0954;H:HE1PR04MB1450.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +GQMhbRGE8Sy2fe2Np2Lrol4LR4eJ7fRnnZS/p2h6CB3RFXFDhjkIA+OPxzV7jvRKBzj6CcyCVjHnwHfkf0vLKgpwklHws7geJq0TimcYlkP2uDPAYwsQPejDci41ys4VomiB0/kYCb4/eQp6QWs6BIPQ9Qe5SaCLBl0YZrVAf8W6Xa7Iqih8m2yJdtvV+zStQSk84h8d1d9fHJhHQTKVB7WYq7lPLJy2KMYzD72FayHn6oQE6eHKrETe8kLoxnJjUPbUCKc/AREVjWhfLp4IyibDMXXUaiT8t7sfSlFhU+RuBHnRCtF7B9MqLg6E2Ds90vaAXuNyUu20YSvtqfK77P8gl2pRyYFa+nJ/GQRWwQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98846f9-ce8e-47d2-640b-08d5db0bb2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 02:22:42.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB0954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/=
ci_hdrc_tegra.c
> index 7f4d2b6af37a..772851bee99b 100644
> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> @@ -33,11 +33,11 @@ static const struct tegra_udc_soc_info
> tegra30_udc_soc_info =3D {  };
>=20
>  static const struct tegra_udc_soc_info tegra114_udc_soc_info =3D {
> -	.flags =3D 0,
> +	.flags =3D CI_HDRC_REQUIRES_ALIGNED_DMA,
>  };
>=20
>  static const struct tegra_udc_soc_info tegra124_udc_soc_info =3D {
> -	.flags =3D 0,
> +	.flags =3D CI_HDRC_REQUIRES_ALIGNED_DMA,
>  };
>=20
>  static const struct of_device_id tegra_udc_of_match[] =3D {
> --

Applied, thanks.

Peter
