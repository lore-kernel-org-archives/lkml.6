Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C7C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 00:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A932B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 00:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FGqZsw0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeL0An4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 19:43:56 -0500
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:63136
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727842AbeL0Anz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 19:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beYPvKEm1bt53lEcScAHj6vn/zmXc3dCtWwgosTjA+Q=;
 b=FGqZsw0GgD89ylFBkXSQjrEEA9n3gMMYckOa5aFuH/rYmlUxv6i3cTWCS52e+QO1k878me/pwb5YF4SQ4OaL9W8Cqx0wIr6nW6iXpSJ6hj0zbakqrNBO0YS3NB6SSRaNf5TNjfZgCzj9BRjga2tVt+M5KmyhVaqZfouKrPyVND0=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB4672.eurprd04.prod.outlook.com (20.177.56.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Thu, 27 Dec 2018 00:43:51 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c92b:a786:d2c5:fa1e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c92b:a786:d2c5:fa1e%4]) with mapi id 15.20.1471.019; Thu, 27 Dec 2018
 00:43:51 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: chipidea: add a check for the availability of
 next child
Thread-Topic: [PATCH v2] usb: chipidea: add a check for the availability of
 next child
Thread-Index: AQHUnUoO9MIG4EkfUUeSNsgWZSwNq6WRvrmg
Date:   Thu, 27 Dec 2018 00:43:50 +0000
Message-ID: <VI1PR04MB5327BBB98B2C0AD6E4D713058BB60@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20181226183643.76912-1-kjlu@umn.edu>
In-Reply-To: <20181226183643.76912-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4672;6:/L/Ebd8HqRwnLCI99132JU9fLaa63RqmpdNnXTrt7u/i1sL10jzlXhy1UqlqEPv3zSU9qcN/LAOJSjD0v1neRk7Ni9fDPOAtsUlTIN4gQWdBKoEu/KYfhmazAzRN16Cfv/C5P368u+otXCfur5Wd+95B5Y4gR0BSw/kVABqgv/MfSzeawTj1ZdnxOHKynYcX+9X0v5jl6acdcxxVutlA9aYrELwHkbWNsLkl8F1U6dHvNNUj97h3J+dBqj9VM/ejJoocIJvXkJSMU6vIR7+XUDRYtGcZioaYzYUQ3+trXJrkq09NwmEs2OQGN3ZgKRZbzKL+RHx7LDdSzv4xhT7qekpwZc7QpLB8EomZZ/OMKq4nHsPdm337waQLKbKMt4RJ3FzWWCa1lEhGhJhH3ecRU6mGmOPjmfglbpziS6+BQfNsoKhHnxguae61kjemruxDV1umFOa0SqqBAiK4Ii9l1g==;5:1n2cwsSdouLpfNnd7CzXwmqgTgFHeDMgxyLinMVKqKmAgdVMMesddjjzYT8qt3pTcXZVOmoKPTX4hem4/RJPN/3BLv/ikdlcQQfS3DqBbIvGlq0V0ojlUYepXVRSIUH7LjvE+hFfkG7s7ujHcdCLU/AR4WL5tgRUeLiIUUug2nI=;7:eoy4C+r7m7l8zWlWPZ8Z0oE79u+leRQxUpaqistzkWfLN7vyd89T0fo4Dk8XqcouT97b63yUy9yO+fbWJqVG2a1fEpMENRAaN/JEDYnEoe+lCCMIOn8KO0vzKUriwXKMxowF0jl/BR3pEzAntel4sQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dd8ba70a-3edf-444e-606e-08d66b945ed7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4672;
x-ms-traffictypediagnostic: VI1PR04MB4672:
x-microsoft-antispam-prvs: <VI1PR04MB4672DF379FE7F034AB5547ED8BB60@VI1PR04MB4672.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4672;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4672;
x-forefront-prvs: 0899B47777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(97736004)(476003)(86362001)(44832011)(6436002)(446003)(11346002)(3846002)(486006)(6116002)(71200400001)(71190400001)(316002)(76176011)(66066001)(54906003)(14454004)(478600001)(33656002)(6246003)(25786009)(102836004)(2906002)(4326008)(229853002)(74316002)(5660300001)(8676002)(81166006)(81156014)(7696005)(55016002)(256004)(26005)(186003)(6916009)(99286004)(68736007)(2171002)(53936002)(9686003)(6506007)(7736002)(105586002)(305945005)(8936002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4672;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gkUQF+W2iW/Drz9cqaslF3HUNMJF0uM0+T9vgzQAXKOODWx0a+40BUTNbUXvp467JImNK9tL/DiDszXnrR7GKPvh7oyRGE0bZCYlDFEYq+z36G+MuD6BosaF1rYPpjApBnA5fjIO4dMUZ1x4Z5zpgIguTYEEJS84jhNYYw0ApXitjfQLi8pzk2NYVZG//IBd0wm6g44L5c9ErkxO3ZnttjwY16TSWobq4q+xDKaV4OkIUaKcqfgsy7ihCekY1vYm3n1sXqH0WJq/xGbSKUlo2RDWVlJ3jAJigk3/fwj+lC4F+kARTZZhmnRtA+fmvk3C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8ba70a-3edf-444e-606e-08d66b945ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 00:43:50.8557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c
> b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 880009987460..b7f7acef72d4 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -250,6 +250,10 @@ static int ci_hdrc_msm_probe(struct platform_device
> *pdev)
>  	ulpi_node =3D of_get_child_by_name(pdev->dev.of_node, "ulpi");
>  	if (ulpi_node) {
>  		phy_node =3D of_get_next_available_child(ulpi_node, NULL);
> +		if (!phy_node) {
> +			dev_err(&pdev->dev, "no child nodes found\n");
> +			return -ENODEV;
> +		}

There are still two issues for this patch:
- It can't return -ENODEV directly, instead, it needs to goto err_mux
- Before goto err_mux, it needs to call of_node_put(ulpi_node);

Besides, for kernel code style, you may leave one blank line after if () {}=
 statement.

Peter

>  		ci->hsic =3D of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
>  		of_node_put(phy_node);
>  	}
> --
> 2.17.2 (Apple Git-113)

