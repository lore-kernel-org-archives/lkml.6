Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22331C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7BE21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tQPdgNGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLZGq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:46:27 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:1636
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbeLZGq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDDSTqd9RsasrU+9lDaOgWFPaVm1NmfMMGkFfesU2LI=;
 b=tQPdgNGgculSJLmfednVB8IEGr1GEadWGrTfHWjSXxsJtNv6fq8/h819oIAX4cjC6KZAa2qE32pDll6FGstqnp7FeX9Si3TfYvQ4VP9RCV2h9NilG0oFpmzQvoOtAw4I/GQtI7I+dXL5lkCpXGxvDPzYGy5BWfwADVeXT8VDiuM=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB3167.eurprd04.prod.outlook.com (10.170.229.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 26 Dec 2018 06:46:23 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c92b:a786:d2c5:fa1e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c92b:a786:d2c5:fa1e%4]) with mapi id 15.20.1471.019; Wed, 26 Dec 2018
 06:46:23 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Kangjie Lu <kjlu@umn.edu>, Loic Poulain <loic.poulain@linaro.org>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: chipidea: add a check for the availability of next
 child
Thread-Topic: [PATCH] usb: chipidea: add a check for the availability of next
 child
Thread-Index: AQHUnL8Mky0gvP1kaECxXh3aAHJ66KWQky1A
Date:   Wed, 26 Dec 2018 06:46:23 +0000
Message-ID: <VI1PR04MB5327E1080FF6010A2FD0807B8BB50@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20181226020134.71351-1-kjlu@umn.edu>
In-Reply-To: <20181226020134.71351-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3167;6:g3NIqFPad6/tcmZ+EC1Vvng9WCDMk07Sf2KfOnZQNxwoSRimxjTZ3gEuVo/b2rbSBtYIOtpgnrYxCroQfbgWdXGD2EEXvQSEtv77ulQKKdGG9shBB44oYeFRUPXGqFDwvbyeddY0oz7OSd0LhRMQ85Dx4vPGiEKJ1muIDv50lRmyILu0mP+IVtrUUgPWDIsJwLDgpweS7QW7q74rM/Y9T8OJ4ma3uXtH71WfouwESV0E4gicgY5zyhruGg3H+PaOz8iDxLeOAIRPXnPdvkNhcdOgbX0aTF8hEGDqI0kBdhTJu8Biey+EgTjSM0NXSWFlbSAug6RZCiBGw8WTe6vLEp6h0JcUAZ38TDpFXF9gPlmxFx+2hQot85babBP13sUD48nZBXEapakWg4EbQqnQKRlcbngXwY1++zu0c8htQGVmkGi+54kg1lEjKO+BcO7iwDeMHL4yBMHBqyCefBJCzA==;5:/2ir4Ukb7O8qW7A3OlzJ6miMHEXFW1oUyNxXNtsJVgF9xx3f6y5PLTn8jVH/UAgRQGPJMxt001657t6WxuuzVwpurdIVCP8AW8yzCVbnbSu1SeJY7/f/nXgLHUpHJCAFXw3DQALVMnWyyKMJF/w4KlrQnfCtCuoy6VJxb2fB5Uo=;7:RsLaQOkfCvq8G7KLwKMkNAlqDiMfLMXDaqbmqZ25NT5+YSSehi14mRuNUQE4qJ4O3YqCntJCE5fMrK3c+/82aLhts7fbxYgGpzjlPN9JObL/0tWnJTDCJ/mU8za96bBmDDKiHhKqI3dcSiywLxqZRg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c834cddd-713d-4a13-7e99-08d66afdda01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3167;
x-ms-traffictypediagnostic: VI1PR04MB3167:
x-microsoft-antispam-prvs: <VI1PR04MB316754961525EE4E7B1781B38BB50@VI1PR04MB3167.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3167;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3167;
x-forefront-prvs: 0898A6E028
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(71200400001)(71190400001)(3846002)(6116002)(4326008)(81156014)(478600001)(81166006)(446003)(316002)(102836004)(8936002)(99286004)(5660300001)(6246003)(6506007)(11346002)(110136005)(54906003)(186003)(8676002)(2171002)(476003)(33656002)(66066001)(44832011)(305945005)(97736004)(256004)(14444005)(25786009)(2906002)(486006)(229853002)(9686003)(105586002)(55016002)(76176011)(6436002)(106356001)(26005)(53936002)(86362001)(14454004)(74316002)(68736007)(7736002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3167;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xkMPXjR094zWwt6IBWbzrs/maO0HPYFL/VpIzxunkta3R5zMtsD8ZKU4TOqrwJWX+CcCMxpb18d9dKAmM/VA5PFku+gygjN+c22KE3I/DuVMugXMWyrM8SDzf6BYyDN9rhFbnEFZ59xbThjIoZzDlUX4YD3P19GILU9Y5Sxsh8c5p7+W5dRCyMeJKDNUZhfsAc2KR/cUpaPsMKqU8ZPpkFaWy/bGaXDzxDnjFuzq2rKA6Ht4+9ENwlFRAle/n4l0y7R75QzHRIXzRZF7A3D4OOXVFAHoVE4gZnwD0eGWHvq7Mn6Prlfgxj03CdD9qafX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c834cddd-713d-4a13-7e99-08d66afdda01
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2018 06:46:23.5074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c
> b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 880009987460..7dc987b4036a 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -250,6 +250,8 @@ static int ci_hdrc_msm_probe(struct platform_device *=
pdev)
>  	ulpi_node =3D of_get_child_by_name(pdev->dev.of_node, "ulpi");
>  	if (ulpi_node) {
>  		phy_node =3D of_get_next_available_child(ulpi_node, NULL);
> +		if (!phy_node)
> +			dev_err(&pdev->dev, "no child nodes found\n");
>  		ci->hsic =3D of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
>  		of_node_put(phy_node);
>  	}

With "ulpi" node, but phy node is not found, I assume the controller can't =
work properly, we may need to
return error value.  Add loic to confirm.

Peter

