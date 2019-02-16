Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6673C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84457222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BcKINYA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfBPKJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 05:09:48 -0500
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:44352
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfBPKJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 05:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzHdtGzR8bmCiGRzaBAmuro2QCHJnbfUXaoHVscWLKw=;
 b=BcKINYA2h7LmL3Z6Cp48sp8o8f5XKg1c+NiUZtt0nzUNWWyvF71x1fh8JXA8rQ6z+Z1qJPzmnQac5L0C8tjV281b0iYz6XR5Oyh+HZ3gT5V6i8nL05pz5hE6dYLats0nsONMwQsX53zgaxcF60RYX/y3m9krbs4a+CAJ5qeMLHk=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3536.eurprd04.prod.outlook.com (52.134.4.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Sat, 16 Feb 2019 10:09:42 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1622.018; Sat, 16 Feb 2019
 10:09:42 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vicencb@gmail.com" <vicencb@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: simple-card: Fix refcount underflow
Thread-Topic: [PATCH] ASoC: simple-card: Fix refcount underflow
Thread-Index: AQHUxd+7Rfekf4ZvxUOM7mRbKeq/IQ==
Date:   Sat, 16 Feb 2019 10:09:42 +0000
Message-ID: <20190216100927.10017-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0019.eurprd05.prod.outlook.com
 (2603:10a6:800:92::29) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac4479d1-2dfc-48a8-287e-08d693f6ddc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3536;
x-ms-traffictypediagnostic: VI1PR0402MB3536:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3536;23:3+xVtMmZ9ZY3rC7Lhf0oEMalhdqizUHQgG3WD?=
 =?iso-8859-1?Q?Et6iK9lMd/Nh84kl+2oNF9K5MuM433I5bIGndudlLUNK6BYj61pn0Gg+8Y?=
 =?iso-8859-1?Q?VfgBOByGjfIFTh9rhPyR5dDeBxSZJZR1RXILrxb8y8FFzYly9uqbMxcf+p?=
 =?iso-8859-1?Q?EhIwRAAL3zkEBQg1MzLvSfJ18iI+CwxpKDTk6ueLZuWXfN35Fj1WLOkaCW?=
 =?iso-8859-1?Q?IFHjUqnZcOO7e3zyP2uTM7BwSpcjkN4gPAhrEVSFBs3RbVWWHblCVHiqJB?=
 =?iso-8859-1?Q?52txrQdc94xSSuiJSwLX2U1WjncPRlwkQ9fEWUHxDTSO/CmGhNgt1WQ8pI?=
 =?iso-8859-1?Q?Qu5IBpUGncaL/JtysGdzYHyhMJclMvl6ixY4wm0QEyXkshm92YeEiotW7J?=
 =?iso-8859-1?Q?NpZD81n16kaTiLl2TrZbj/OpF1czMKgdUAVU33We1+u51kyB1l6RgTnNqR?=
 =?iso-8859-1?Q?E9FdLkqjVC5fjmaf9vq1M2Xgsr9E920mwdwNEWMjlG0sj2lNQRLfjB0rFl?=
 =?iso-8859-1?Q?mhm6DCt5Fxtiup8BLtKnoPM/mxeUgG8ct+TibJAooBMrK+cElBX+cJNBg+?=
 =?iso-8859-1?Q?uXCFEsTsAaIla7phMVlrScKp/Imhh8pULNvAB+hRkVA9k4cSFFE6eb+4X+?=
 =?iso-8859-1?Q?JoCHdhXqlN9D6NsCjBaYrYCx/FPoOBkXQFcqySvLge14xW9n0aFBLgzDuo?=
 =?iso-8859-1?Q?wM5CydhpLsxPkz6eMizsIt/X12u6L+0kaQGNYmkaia7G2narhVnMBs8m2R?=
 =?iso-8859-1?Q?ITCyFapy9KKxzn1/0GBZY9AxeNIAgm+x8ZS7ckdVWk0KpY+9SkDFabIQKO?=
 =?iso-8859-1?Q?r9Tjp82ZxorFuND7WQo9SA1/kvpscy5NChJ9opwoPwViN8GfR+kzXDfvlD?=
 =?iso-8859-1?Q?yXsyK4d2h5Sn8F+kiKRzJMdrY0pwflAgXpqNszieltLwryXV2T30H2OxN1?=
 =?iso-8859-1?Q?Edp4DZtIy83auweN8q3ZjWutgbqWHWD6epynp115C4l1Qkn8GpVS1vUBaM?=
 =?iso-8859-1?Q?gwhlRNjGeEeNzGM2mdfq/BSkl8Fuo5qZPjRFaBaj2P0iKgDdW6YXxNxDJk?=
 =?iso-8859-1?Q?XAFLoTorxASLTMAvHg1iEHWzr/HLSV4LRHSebXgQuV3iBl8daED4osNXWV?=
 =?iso-8859-1?Q?Xl4ro5QzQtFXboPwG2UFiyIHWUCBFA9aYy6tQi3MFodKR/DpxxhL1Zun/F?=
 =?iso-8859-1?Q?ahhlsqvVmDwb63zyE2XySDz3n6XB4Q03H6JMva2GUyHQGPqO5TQKceiFBT?=
 =?iso-8859-1?Q?wakOPXLY7ZkluN+nqZkmaQiSs82hTS5f8pWCPrC0xlOqlFZ7RMtXNdPSTN?=
 =?iso-8859-1?Q?o7s0BDwH323C5Umzwwx7vdb8Lassay8ZZGWGc/l1PYa7k5g=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3536C68100FD38ABA2925F57F9610@VI1PR0402MB3536.eurprd04.prod.outlook.com>
x-forefront-prvs: 0950706AC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(396003)(376002)(51234002)(199004)(189003)(106356001)(110136005)(54906003)(316002)(478600001)(66066001)(6512007)(186003)(6306002)(2501003)(102836004)(5660300002)(68736007)(256004)(36756003)(14444005)(1076003)(386003)(6506007)(486006)(2906002)(53936002)(4326008)(26005)(97736004)(305945005)(86362001)(7736002)(6436002)(2201001)(14454004)(44832011)(52116002)(71190400001)(71200400001)(8676002)(50226002)(6486002)(3846002)(476003)(6116002)(25786009)(99286004)(2616005)(8936002)(105586002)(81156014)(81166006)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3536;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jvd2YHGU+RKFgtGr+4k4PX6872uLwHbfDhGrp3qu769RxHqRwgOG7S9zNiR6wb4mMDiLvOiyD+KQgJXR6eHCDrfokHTkSyFlDe/2BW0lUztN90I2w7WWzruHfqgdcGbMhv+LjkpnAxvaJJJVNikGTPsNlCvZPYOyNumJFru5BtTL3UEeFfsfdr2DM/J8B7XAss4nd6D8y6iTWC9MLfgWrgFoqyXW4xi/LkmcgJyjlz5tjy461qrrX2gSEhnRyu+ZMcgSw1KKlofSfEhzzmLIa49GrHFESLFWCTOYSdLrMVhI+5O550oREt873igNN2+LJhk3ijhCsMeUGOM2LzFtjXRqcEc4dHDeGPpKxjllPFq25VBVu6wwhhiy4V3g9LC+EyFE5Ds2WfmBoAfUF9cpYYORJdsbzbA9tNbrkUiZ+Pg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4479d1-2dfc-48a8-287e-08d693f6ddc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2019 10:09:40.6577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_child_by_name() takes a reference we'll need to drop
later so when we substitute in top we need to take a reference
as well as just assigning.

Without this patch we hit the following error:

[    1.246852] OF: ERROR: Bad of_node_put() on /sound-wm8524
[    1.262261] Hardware name: NXP i.MX8MQ EVK (DT)
[    1.266807] Workqueue: events deferred_probe_work_func
[    1.271950] Call trace:
[    1.274406]  dump_backtrace+0x0/0x158
[    1.278074]  show_stack+0x14/0x20
[    1.281396]  dump_stack+0xa8/0xcc
[    1.284717]  of_node_release+0xb0/0xc8
[    1.288474]  kobject_put+0x74/0xf0
[    1.291879]  of_node_put+0x14/0x28
[    1.295286]  __of_get_next_child+0x44/0x70
[    1.299387]  of_get_next_child+0x3c/0x60
[    1.303315]  simple_for_each_link+0x1dc/0x230
[    1.307676]  simple_probe+0x80/0x540
[    1.311256]  platform_drv_probe+0x50/0xa0

This patch is based on an earlier version posted by Kuninori Morimoto
and commit message includes explanations from Mark Brown.

https://patchwork.kernel.org/patch/10814255/

Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-car=
d.c
index 08df261024cf..dc18c4492955 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -445,7 +445,7 @@ static int simple_for_each_link(struct simple_priv *pri=
v,
 	/* Check if it has dai-link */
 	node =3D of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
-		node =3D top;
+		node =3D of_node_get(top);
 		is_top =3D 1;
 	}
=20
--=20
2.17.1

