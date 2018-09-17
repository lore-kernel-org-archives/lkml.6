Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF43ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBD82147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZhFcvIpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBD82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbeIQIdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:08 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728731AbeIQIdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZlVdXACHbzUdGg5aflCvIY151DvxYKQZdATt1BAXRA=;
 b=ZhFcvIpmskArBZbRlS9yYr9xNLllalB1IhIc9sxUx6LWYnwnIBX9tSszX6r6YsyFf2/BTET30pxeAeYNaTbXgNEiobITl0IErRAWia6SETD1D/HOGdfO+UUYUOJRXrcweED9lThHJImdzdYNjq0EZ+EbZNpuybBISPFR9+AjEs0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 40/43] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Topic: [PATCH AUTOSEL 4.4 40/43] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Index: AQHUTjNACMNWtlYpX0aLsp9FTZj6pQ==
Date:   Mon, 17 Sep 2018 03:05:13 +0000
Message-ID: <20180917030445.484-40-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:WooZs8XbWKlUEUsBm/ukhGR/DpzAmWoNTSOkoqnpLeuSeCNRxEqsTpqKOXbyXxxkLCLx9Oke2BLRZtYPFppVxaQ+O9WWxA8CpsOGL4x4MXCXGSwWRdpjA8ll2PcPVBMG6uvdmc0dbAdCokFttEiTAxbkno6u3PJUxcheuroCol8Hnm7PA9IEltp6rq2aqsV+wK5Bus0JcIaAXaM+TgnCOpwVSverj/zZtKvYrNzFh7GXpzcoC8Nz5Y2e6ShoLKPhiDCumKq4vKxEJDtekwxFh7uhIQh1UfRNcYIvuyeHcah7UKfXaJy+wncvEnk2tjyT8XTxQLvgL+g5Ne0UBQLR1NvhkgSR8HY8KyB5o1XirHV6Ol/kofxAhT5kvNfKytMm6ssMk69eSzG2eveq5VCERStG69oNlOirA9HbkWMlembESxp13gUh03iRy6LQbwYDyld84og5cwkko3Y/dJ9cSg==;5:bY5W8gVGXh6SGC/1lSDxL2lwcNxUtb8IVDnUtYUC+Hlq0AoF+3asBw0YksPKtcxKwb0hJR6zdohtwDJRXA44ik4/x/80fkyzDl9RBKIXm2cWERJLRMQpp3jrQQFBuKuo1eaUhotpFJrEGNSHhSKW1BS2y5IYLhCczkEtVZFuzcg=;7:L3CWjnX/xEAFRfodAmmc0bG9Hqd4y5xsdEuEcjs+YVYaYrODwKBwL2lcR3KTS6oiehelU7yaf1YJSOJU1c9gV4QDFS+vEC9yd7u4+0ZzHdUa8KhbjvUSSXkCjvZIB2lou58U7z9qk8Qc61EIWBpSNa5e/Q+bksXcD/9sdR4bC5LxDxpOz8mnKiYIbmeZiMwtUCvKO803Z3teU4l17qr5nftLtorI18NfThF/2JSvvaLu6YPg5Mt64dFjk8dJyV4l
x-ms-office365-filtering-correlation-id: b33a16ba-ce6a-4158-0d4b-08d61c4abe42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08396A68B6464E255755175AFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: SLs/BZgILFvyVa3x4wxiObRkaHNeKOuxQAcNDlLGaRUDfnDF6sPP6XeXCorXkNZubSNiR9wLTElLLETpp5O8sLtzQnwrqpG1MgYkWbMAftA5OzqKUWQMXonKq1yEYXc4Vlyhmfxie66x24lGI83h6asje2LvpKTxNBHiHJ4xUFyZOdDruGcNY428snJ+7dbSVY/v2IuPy5JbV0yb7E+EyW8Y6lwy5RncjvcsF8B5ffuHbyIBY4CeUQKi+ykU70dVXjZTTcf5h4xmXRnXKFt8B/jrvW4QLTYh5YsoN3O3kpS9cbhhPdbrwbLxCatgWs4Mz5OL4s/VT9ylv70uQn+rABAcC12grGUWwgl+f3YAEfA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33a16ba-ce6a-4158-0d4b-08d61c4abe42
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:13.8828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 9e784cc3e5d2..0aefed8ab0cf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3864,6 +3864,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_car=
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
