Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27B7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2A4208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GYxIHmAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2A4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbeIQIo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:44:58 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730500AbeIQIaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npROwo9bP9y0tjuMorFjjqswNNNtpT9y1/uc6RMUwEY=;
 b=GYxIHmAkd3oUBHboa8gejbHHHIqPtUJW8ADOZyy+ytG3Znt6Kh+fUVU7iO7Q8cMnRfZSx/m09FTk4Pwq0l2uLbTmOZwmqL9e3JCTfOvgDw7mD8eDmfuihwKyt9Qdkf7E/IWXDwQUzO9RXbdgtxfpM44Eq2HvLUewF5Q6WJFC5RU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 78/87] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Topic: [PATCH AUTOSEL 4.14 78/87] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Index: AQHUTjL5sOHH+hyhVkKStWVlkg5L8g==
Date:   Mon, 17 Sep 2018 03:03:14 +0000
Message-ID: <20180917030220.245686-78-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:iy4gCtHYSh9a1kNVh4iKkQm/tFTK3U9QOFK/2iSZTZ8r7wNpY4AZ/vLjgkT8D1mCJtNYFVV1Uanyq50stCTlGQqioBDp8BcSIVzu/RZcRlR7CRecoPo3PLyNY04010R2Opjx4N3dLd2kgpxoFpHNv1QS4dxRSY9Gi0n5WG3o1Scx2TtAZuaX558uJ2/hE3eguVfPl2FQVthSN9dTSamHyTPbaPNN0IukmL5R8sBDKfPabgZF1dakX8NnLtd2ia3eeT5q9/Y1BS1KXrYXy/9oK3IU/iIGROjjeZZGaFk9u8UUj9Tm3JhLy8/Fc6pWPIcwyFnBZxtM41foQM93Bj4qImb3aQreN/NA7iOAVvjJUBhAbZOh5oMgaqfUDCaDjNTt7fkLk85ysqjEzu+dKIl+4mskOmfmQnVUXY4cYZdHui5SBmvJEby4mahEDGx9vtL+g33vEZSZVhC5jY2LO6iH5A==;5:OCHlxEQqLa94zDvpdE/bLlq6Psf5247I/WTk9XByNF3qIKXTgieoKBcq3w6FJoJQBcl1NVmo2mBwYPQ5ZKxcEVskRCs7jhkARS1M7/R5cPS0kbaH1gKVFMWi9Hc8F2Upta5IwcsfZnq2/ajMn0Rzw4dp2UjILi1ZFyjFVR8xALA=;7:U5vOAI/9JXRSEX82QjLBQCb+hbdKyxIgdJC4ztsPXM61qAKTd1af56knE0FhSuIbOyDv4BE6V8xTEleMbq/k9ZVgPINu2euM67BsFI7eIBvH/ZDXeV8GANnYuKrPqFpfIVm6gknIDINfcp/XBWi7a8x/2f1fcDdOS1uyxQk0Uy3f1HTCUy6I5MZDifCYykKDwBm4knQQiUMh9MdME7v2G+7GOMC/VWoPUmapycec0m++YC9EPwtWYDb4T9FuZ0M2
x-ms-office365-filtering-correlation-id: 2a2d8dd5-192c-4e0b-1e40-08d61c4a5c1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01330A283BCF87CC66666043FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HcNNb8dSOCIENfL72reg0ud2v290eoZyW3hVz/dZNFMxp5paq8dhCwNjfw8Y8zIl+cb3YHGYaMlXR8Nl2YWKA5FIEiSO9iAzu9HxRjNClPxHL4tG4xWKngGH24zUm4sBngdDM5X4q9tQ4zzUfezOTtdWOuSIj0r8RCh5ejYRGNB9R1NWAS/2GPbAowQs2a5NXn9SLwdPhhx4fQQVTVQ9/0VFcgRPPwZl08kDLSThVJZRX/Kc1SJDa7AhORkrEV3NdtjTUlEh+t/yLNSrzlhHxVAkkHi4UNUoKvupZa4V0uBnVaBZz3qx6r8vHjdoSaTpka5yarXznRexwimuma2+nKrM/K1jPjM5cRkOPOR5wng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2d8dd5-192c-4e0b-1e40-08d61c4a5c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:14.6340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
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
index 1c9f6a0d234f..53c9d7525639 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4005,6 +4005,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_car=
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
