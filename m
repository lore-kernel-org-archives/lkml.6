Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4028CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA0920838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hsbqdd1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfAGCGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:06:54 -0500
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:61856
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbfAGCGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCxXSbMhJBPgUawkL/35Jko6Zn3o+YnE0703TXiHr9A=;
 b=Hsbqdd1EbXovdMbOspvZnsPPFaaKhOdA5ylipgvKP35xRrd/WvYgjR0b8Kf5MhF/8fhXhirpH2SRkGJzmDeGqsnflX7bhc2X7Bg9UZJK8SzQE3a4zz0pnCzFygwsCXs+39EnJjuMC33BXzDvoOAHj7R4DlS0fhJyOkNgM9/h7Mg=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB6144.eurprd04.prod.outlook.com (20.179.27.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Mon, 7 Jan 2019 02:06:51 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c92b:a786:d2c5:fa1e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c92b:a786:d2c5:fa1e%4]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 02:06:51 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Aditya Pakki <pakki001@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [V2] usb: chipidea: add a check for the availability of
 next child
Thread-Topic: [PATCH] [V2] usb: chipidea: add a check for the availability of
 next child
Thread-Index: AQHUpQ+TvMZ2Zb2MoUKiuDq+XSXKFKWjELow
Date:   Mon, 7 Jan 2019 02:06:51 +0000
Message-ID: <VI1PR04MB53275100F04E35501B2786D18B890@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190105155847.3091-1-pakki001@umn.edu>
In-Reply-To: <20190105155847.3091-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6144;6:7mAvZKBPFwnHucRN0yb4vUQH9Fq9THzEGduoA6dliYljqk1A9ovSeKw4WNWmcOGzKbs/UfH/X4qJlwRzWMzXGqcK6Nhkmdx5CZKPQydUlHikFowNY8U+ziz4rhwI8Oj2pHbxGxm0f17KzDdy59P1efCibA93JDVAW9VBij3Px0i9eheldJsEh2KHyxgSURpzMnL7D8xXq2bixscGkbaPBZSmDITOqdvE4aTEGFi2+YQrekl0rzVQ2p3IjoPfnuB8tZzGs75ZSMZ1zQ/Bs0uZqyWedvzZtwlVUYpvQ6mD5EkQVKhSmmltGJ9ZR0V2LRL/fw6gzOc8T5F8HIho+1UQXYMgNupMPmN6WDjCx9iNhvdCHTKX1hgEnh55qneUq+LbX54asjKgUaREDgvKe2l7tTU9sALrEIF1CtduIkzWaZcw9UIG/ogUOzQSYvrb01wmSY3xLMAnW0eLy+Y8BPUcYA==;5:AwIvP1cAoeV8cwjEIB0dLgRg/7ZhgP9iixqFQfRDFH6NsXV1oDjmtA+uRVgnz4/9Wwx8k/0mV20GKGO4muU05LlwRX2078ossvhSKzGvRPTnanDmYR4DJmL523U/dtzvWJO4Eu9bz3Sd9oiNG4n5rvy4WjNweaPiuwZDoHxFqT7v0lN90pQOF8ZKKHVN0xVSQ/tWGzvSsSHYL+GlPiLrSg==;7:LoVhLKOPykveYkvO/2VU2g06b92/6VKZIMEx5tSTJmrRpIPxQR7jI8uDYoGSo5X2iaet6BsiWiMXyJaWR+26DV58/djstaGUgzdtLL2p1wxh8nppLPAnr6A8XH5G15FrTj0EwObUZDrUuhJviVaf9A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9cb5e457-dd4e-4632-0f91-08d67444c9de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6144;
x-ms-traffictypediagnostic: VI1PR04MB6144:
x-microsoft-antispam-prvs: <VI1PR04MB6144B41505B44D481DCA749F8B890@VI1PR04MB6144.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6144;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6144;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(2171002)(9686003)(7736002)(2906002)(99286004)(6116002)(76176011)(186003)(7696005)(71190400001)(71200400001)(26005)(3846002)(53936002)(102836004)(256004)(86362001)(11346002)(6246003)(81166006)(4326008)(476003)(486006)(25786009)(44832011)(14454004)(478600001)(446003)(8676002)(6506007)(229853002)(5660300001)(55016002)(54906003)(81156014)(97736004)(66066001)(8936002)(305945005)(106356001)(33656002)(105586002)(68736007)(6916009)(316002)(74316002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6144;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sTBn40+XPQTpZlhUtqpdlhjKl0af6Pj2hDMPj+kHbbL1Xg15Lt+gCiOv1qrotBMXWDqpTtXLTKvKBnYxGx7dtY529M/ta4yF0bWe5R7ONkJg+6ChZgP2txzdcfFNZVV7vEsfPil8taKwR+SOyAUYRX1DUffOlpBc7fbvjUgd9Fu7ATU40JzSRsdxwYqlJIDGNXSZ76CzL6mlqtrwVT9vdAbE0ahRYK5E6pWcH6CrUuVz/FnOsQd3yG/eUdizaXcUyEaW0TD3CweX5yRkMkKQDsXBLkVRhmrBYyGv3Xb8oYMH7fCq/O2RXDiluU7fl/is
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb5e457-dd4e-4632-0f91-08d67444c9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 02:06:51.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c
> b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 880009987460..813673eee815 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -250,6 +250,10 @@ static int ci_hdrc_msm_probe(struct platform_device
> *pdev)
>  	ulpi_node =3D of_get_child_by_name(pdev->dev.of_node, "ulpi");
>  	if (ulpi_node) {
>  		phy_node =3D of_get_next_available_child(ulpi_node, NULL);
> +		if (!phy_node) {
> +			ret =3D -EINVAL;
> +			goto err_mux;
> +		}

You may need to call of_node_put(ulpi_node) before goto, I commented it bef=
ore.

Peter

>  		ci->hsic =3D of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
>  		of_node_put(phy_node);
>  	}
> --
> 2.17.1

