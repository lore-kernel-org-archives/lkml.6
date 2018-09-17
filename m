Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1C12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ALR5SKWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1C12147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeIQIbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:45 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbeIQIbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oH/LMwp5KVo8iZsVWKMXkbZQ87DnMkLuEN8gKdufHw=;
 b=ALR5SKWQu3LTedCdmIKdxrHpK+ksPlje6GEFFYwovQrTfoofsNFPZsFTfJUCYf5LIb2+lcKvicSRd1x/4T8fZJaTn/lZ1KYsU1xCxdbxUHl8BR3/pY1b4S0tvVjiCJtBCxcjeX7H67/yXBtrQY+0qW6hiWU/I8ARgdzEqTbUFKs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 52/57] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Topic: [PATCH AUTOSEL 4.9 52/57] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Index: AQHUTjMeJnEsp0L2FkCKCeTQiBrNGw==
Date:   Mon, 17 Sep 2018 03:04:15 +0000
Message-ID: <20180917030340.378-52-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:/WBn7a/Dui7Ozj94kpZPkKOJNb+uneHESgWV9GYsW6/Wp1scBvc4RYguJpbBKbWg1qHuJeaBEeqFLUpagJoSIflYuoIB5GBrDoDrEqGfhr0oI6r0s4OtP/JHDcDNI7PMMCczsIAznV8YEnNydnIyRVcwjRgh2cQskMe1w4lY391NLE1SNuuTg3urG1rHXglDtyDlHDe4HZnrTw4yTpxaFlqLlAW+x+2bmyR2EmFRq7a49vZQm+FDRW1luhoNkiE7khT0sww8vwHKrmq87zW9/hvhH4u1tNiByRlO87TOyGHUWKKtMuRsTVLWCRJcbI972GNt3jMv2FVPAxnbuX6GL+jFc1c11u19MxF9QYTPliClEydB49Gno18qEnBqDxXQMXvwtVvKQj4u6wnvItNgzW8HtshHV/ImB2tQh08m2QLcyoh/JD4flxctWzeZApIfFLV5ZM/GJSXYluZ+32Js0Q==;5:GHNqiK0gGid2uWxs23lKAli0G7ZNUDAWPwm9jTd4SKqtQCMNQwVzZ1eRBGR2Guzm2kQHR8h2VxH7iZhpRbUMycKZe1MQ5zllafVe6MxwsJbEQ9J/ymmsTCogFuP7bS0WEsuO61z8zXPAKD81ymSX2exhiO47RlpEeWwbVlfiIC8=;7:djaX/DcJeVHIxd0MUGhfE8Vt4NMFZP/nyECi+x6kN5tvNZV2Cfz5AwJfrINwDskzqis2xbHzG3Eopd2/j9ypoZ2RVrdGNDvEkoJMwE7sqnSPLs/KqAtAGnywdN16Mj9JFkBHEvQyBc9Hi6EBUrzQzVAqZI3kgNmPNJjdu6ZjHSx4nEPThTfMcfkmFbXav9n+oRHDSoo58DK53U/IfQMquR5nTI00whQRFMJPcL6qYa5HE/1eo/tbvHlX2lbge5DC
x-ms-office365-filtering-correlation-id: e732e75a-c5d6-4b09-f1dc-08d61c4a8e8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB016654CB5E41DC427076A210FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1QUkKQSwdMzN13mhYrnH+cuEEH83hnsM+OKdiytwsfwAL/+qJzuEvk571iH9ANGcUiPY0QM3b+i3gUJv5ULZV1CokmyuILTmCUVekF9VuhoyEDMHPIQUpm72wPdbbsXjoxz8jZQauTH2HEd27uESqREcXayGFFeQVTJbe9ncvMxDYTxnrdPwbz6PMgIeBCkDXvwb1u9BTIATlMOVJMQFEQNXUwgk5Xb/YZfojvXYoHRKpoCLMQnfBLpT60lu8rCvXmsgNR72pduJ710836PQdo6bWHK0MuJcZh9eYwp6tOeZG1neyv6Yvt7FFjggx++NkXXKj/bm5bnkXceqnvnKGnygDHFw7XnF8NgP75uqbp4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e732e75a-c5d6-4b09-f1dc-08d61c4a8e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:15.7114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

[ Upstream commit e01b4f624278d5efe5fb5da585ca371947b16680 ]

Sometime a component or topology may configure a DAI widget with no
private data leading to a dev_dbg() dereferencne of this data.

Fix this to check for non NULL private data and let users know if widget
is missing DAI.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/soc-dapm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0b5d132bc3dd..8bfc534e3b34 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3913,6 +3913,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_car=
d *card)
 			continue;
 		}
=20
+		/* let users know there is no DAI to link */
+		if (!dai_w->priv) {
+			dev_dbg(card->dev, "dai widget %s has no DAI\n",
+				dai_w->name);
+			continue;
+		}
+
 		dai =3D dai_w->priv;
=20
 		/* ...find all widgets with the same stream and link them */
--=20
2.17.1
