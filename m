Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF36ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D53214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mgg8rBGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D53214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbeIQIeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:34:05 -0400
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:35136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730845AbeIQIeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GFu5XUxYwRJyEkAZfsSAgvoIJRQECHTWBvG8AiCWlE=;
 b=mgg8rBGPKHFfERyamCg8qUNlqE+oe7ZWDC+odSM4RIG7MXIr7VWL+ER0H4Y2LjKzaiREafQCZrghYvoMCf9bDq0a3fghR9EjFv8c0J2Ihq3bbOeNEjHLuWdKgDIDntvHBpdcxtk4cjMbWdbuU1pllnwp1zLX5rxVNFNEDmcMgp0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:08:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:08:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 27/29] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Topic: [PATCH AUTOSEL 3.18 27/29] ASoC: dapm: Fix potential DAI widget
 pointer deref when linking DAIs
Thread-Index: AQHUTjNYeoQDrM2ZMUeuXmX2nHlMpA==
Date:   Mon, 17 Sep 2018 03:05:53 +0000
Message-ID: <20180917030533.592-27-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:IF9H7M/R9FSXcJQxUeXjSu3yfvzp3gQWB3zDD1r2aWOyefL8ndOC8qZdsN5rAcz68ENFHDhR52QtLTD0Gsx45B7x31z/gQbrLBFdMwTUUJNUL6O+NZQ44pc40eINNVg38Pux4K04C5Gfl7HRwON5tA9YhMX2ncNcoc6RbMzSBwfRICMao9xS7jWi9xdkP3ctl6RDWwuOz6Wt1dzZBx5uRyJsrRGKVTOFJCaq/8Yv3mgz4sioJ8KobhFPUuGB7qIOYJX0BR/qy+EPyeCTXKHj++Ozk/KSdrPfYRKPYhbfFDhL2GRSlPCVFlpuOFZWAFsJIOA2mF0lkglSVhlfsYogp9KGqgBp3KvopzUtYDDdvXlFmXyYw4YttKtmNtyT/iGffmj5/Q7Ty2JWn72NTImWVGhsLFlRIpfCwvaHBp6eYjYNBe4RZJljI80e59IXmu2k6RnVC+6wOrg/FsrWjCSF8Q==;5:t5kdvJNeU9leZ4JEmhHd9FkPBUpaNUvauZX0SNWqh7w3kckfYuCmPRxyyNDFLFS+qBGbLJV8L9CSLeaL3soIlv20L4gBvseyF6etTxYidndiST0rflznl9VvaW/3XORLd/s8LFlvmYnffuQ8jyP2N40FLHqjCH25fC/rkksCz7Q=;7:OzyDQ2MgQE3BvcM6RKh4lppzteWzmSXuPWANY5E6k86y2TvghlMMblhHbJE1cnqA+pu6HZ7BV+zJz4nPxCegJ79u1P54iLaKVHtUgeyv7P2J6gjOT9FjS9gEESaWVzIsD/EXkugRI9fCY6UrS/f5Xt43Urm6os3s12aofRMZSKvPVCaSDoAwkdMQtKulYBjaV0m6YlU0MrxVcdCywqcQ67mTN4lAqDEEl1vz9JY9V7ahewu0WbAh5F6nKEppWdTG
x-ms-office365-filtering-correlation-id: d7359a3b-64cc-4de8-41d3-08d61c4ad735
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082100B3343B4EB1796F2599FB1E0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5250100002)(53936002)(14454004)(10090500001)(6436002)(97736004)(68736007)(7736002)(8936002)(305945005)(105586002)(106356001)(36756003)(10290500003)(81166006)(81156014)(72206003)(6486002)(8676002)(99286004)(6512007)(478600001)(2501003)(2906002)(446003)(217873002)(256004)(2616005)(66066001)(6666003)(2900100001)(4326008)(107886003)(86612001)(5660300001)(3846002)(86362001)(110136005)(54906003)(186003)(316002)(22452003)(102836004)(6506007)(25786009)(26005)(11346002)(476003)(76176011)(486006)(6116002)(6346003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AAatJotgQd/0mQRaV1J5awKrb975YZQC2jDEbgpgIxR5i8XmVDn451SWLAUXBKIyPlUOqTDBcLW2NLNDbeofFmV2jlknKxG1JPMtSHQc+0NMPv/C94zui1+KOnNqX7ztwlRxbL7djQ3/Egwpn8S7GHmBHG2jff7wyTF3kbBW43Ibl3dmSkT0T0Kqqz0MiRSyjJHpa6gottYMNOumxFfTXEN+okHuakM3+3XfNrsXOTr5Y1ABdBKIeG7YMMYLq2dEOnILOwOLt+/1VUzEkdGyzYySjmJoJdf7dA598bTjg+tvnf6Xe1eQ0f/jEH4E39OjG/K1LBlyslYlf2NujyjmJhDOCkFFec1ldwlXU9C9aM0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7359a3b-64cc-4de8-41d3-08d61c4ad735
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:53.9670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index 5c6ac0692fa3..d8ac9e5e2c00 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3400,6 +3400,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_car=
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
