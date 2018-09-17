Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582F92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T39tJmBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582F92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeIQI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:09 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:15894
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729623AbeIQI2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FfNf9A/8+YZf6j1iLUCJdw8fh1KytR39REc0yRmWG8=;
 b=T39tJmBDm/EwYJbVsh86VQG5G2f5fEbdH87IxsLwxatNk4dLO9y4A7SiSt6Bh+4KD51TJQwpyRGc2uMaWpAJApk+oiGoIKRU3Hyh9kxqd9MJJRTXVbwwdkPAIW5yldRtmFEPKA3LXuP3WxKttC3RLmRt4iPOb2WLMAJOukeT9F0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 118/136] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Topic: [PATCH AUTOSEL 4.18 118/136] ASoC: dapm: Fix potential DAI
 widget pointer deref when linking DAIs
Thread-Index: AQHUTjK5djlHftYYkEyGfbzRCLspWg==
Date:   Mon, 17 Sep 2018 03:01:26 +0000
Message-ID: <20180917030006.245495-118-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:3Jr2axiBIZqaY3C++5GpovV/uKG+hLimD+LG94tBuGaOrnrUAX8vmQhEpiUdao/jG5MQxvNoUrvhYYXx3cf1xwcIUKAyZ5YzuQcgcXNn2DngFmuN/7bGcoQsmzxGwFk/pFUSDtsxvvcjgDeug3GtHuIhKywPiMb6W/5EnguoSX4eAp3zOfA6zgodXLAiTRw2/8cMbEr+J9KaaSwOVGa7/WpatDT55JYnWQodEcdCtZ+bVbUe2l1ZubPJLaEm7W0g6/C4z+77knLS3O9cG+JVHdlS7JZ78d4Q9bKfcQ8l7ZFw1FOnYdZn9R47XPIoc2eUa+9TDPmNzYCmz0vHEnQveUGFOEE3ce4fko52jwKjGUzN4+J9Xjoo6qy7/g5AiYdlQQuXqdBnthfYeocpvPS4ccqF+PtuZO4/XmrCFbmE+KSGmTXEPLSmAI8ZUfZ1bnWfi9yvISRuDKd6GxUdbbK7PA==;5:fB7yOFFPV9Tqnk79OXCPzHC2qT0Mrm2pMmc5mNq4IfjtxX6J9daVT1da0iC51lATv2t505ZMcFG5EwvXLws3Q0FNbGkIZVOgX6lEs+CsZcliMOPootF1q5Wt39UCQLqFoPMDs7HFcWVAusNm4kinZuxF9UzZwuhWbHRJF/sJvEo=;7:qLwfxAaEvPVP0rOvNwMVKvzQD+uMM5ryTXY25eHnw9UDzMfzFuAB1eqHMGpPnzWdSniDth/ybcjoJudV4F21n9STWdoe784YXBZG3R31Q1Ss4aIQxve9EpVZWnc+AUIBu0wNVZ4YTDuN3Sa7SfV/dyOzXmqTbXpy0af/CMGQm3sfxFFMGs9bHvQwdfUpGeQraLTSkcBa8PCHg1KN4bjUb4p2Kh8pw4GjJlINfKF+5A+28uvWp6HCL+0ShXtDBjCw
x-ms-office365-filtering-correlation-id: e7da3a48-6ff0-4a7e-0207-08d61c4a0c56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168B80632F9C3BB9CD857D2FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qcw60SOOmUtdQvMJyA+kVY9rx3EjwAA4K+UY/g6n1ffinqLZUwNE7QYwWfwcCkvLKYCTMfn7Zp1bk34USLCRMyzP/9YkgFDlMcFTg8mPdutTrkp8PamnKj4I2dwAoQY7zFmEfpMfgJ760l8DCT41WdSsm7uY2Fn9+jdNT63N/0ehpI8Mdej79nf7oFqjmUlhp2ja/a0VRz7xq0pCnE5dooba+4yiRruZ0WhPc83sbFvkBbZWigPTuiv7VFYikMS7NGFVkq7EXMv6wcMR7QgXTeCphNG41yGtVgN/GzmBCe2F1oTJ68ejeMbX8/YC/F2Jxehy2/AJVKSvTp2jg5u5bTS81lr5loAr6A31TX1C9sM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7da3a48-6ff0-4a7e-0207-08d61c4a0c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:26.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
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
index 229c12349803..a099c3e45504 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4073,6 +4073,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_car=
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
