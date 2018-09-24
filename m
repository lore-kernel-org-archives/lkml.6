Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C13C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0316D20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EhL+LTkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0316D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbeIXVC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:02:28 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:31232
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729831AbeIXUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwGVrh9qkuBmbK6FyFW4h2qTIBpxg/dQ/LWYRFqFhVU=;
 b=EhL+LTkRoexeigoNOdNWLYQXZFCpLdiROkYedQ1337evqTxq2Z+RqKB/lwT5rX/RYeq7z9dwjljmYwz5nSFenTKNRwexmjD3K+7/b0zs6ONUAAxW0I4mdPT2Eb9CaFBaXMakOqNo+4oiJd9eH497ayPYz/8+wB3A+YTWUw81t4k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 75/76] firmware: arm_scmi: fix divide by zero
 when sustained_perf_level is zero
Thread-Topic: [PATCH AUTOSEL 4.18 75/76] firmware: arm_scmi: fix divide by
 zero when sustained_perf_level is zero
Thread-Index: AQHUVBWxxj/1Tc0wbUqAvH40eMEv/A==
Date:   Mon, 24 Sep 2018 14:48:45 +0000
Message-ID: <20180924144751.164410-74-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:ZOFNTguzKhG/oDq6kFkx921lBvnKnL0Rou04x62lVAkK0gKG0TwHqQbsGf3EJ5IxCxNy8c/X7X38t26ngtsERsbYBRifYAQJA0uwzIePc/JU4M32dT5bwBqkukQSc1nNi4d6b+1pYi/TZwCFobBi8HVqU/i3ZgLQXIeWR9D2H1MnPjzmyb/yHu2wKu1BZZAXcvVkGEo7f2ee1MpKu+AB4FlS++asIeofk3z54n0aqQlnFseJAXuEXQPdse7kc7+OHFgs2N+8QJJhzRrX0XTV3Kv76JUVV8uKK/7zhRx1YwwIWEOatR7XOoEwge3ciDWQhVCohYWtgeH/Xu2r8Zc8HOdDzReFyHF9IXNd23VJtq/l97QtJRYpUkAGSGAY3cYqIM1UZ4Ac+EhWrPj1bWUNitA8SRATQ0oMnL+HzclJwN/sW3BbHhgEyNf9bEiZN1I4S2DKFBqafE6nUu/IgUn5eg==;5:ab1JGpMLnxjR6hgUQY4MiqZQ/NTGplc7Fc8uWHFruLgvMmWVlVk1s4BghxXZJncvv33UZpcgQwpjl8UKCDAOqtB1T3lsWh3taEvjv6N6EXGWWyuh2veF8L9TSGLRqEE2pmOedyxyHIV3PDjRWMklK3vQelpeL4BXU6ZK/nxcxz4=;7:jIofWPs42bcFIfiKWZMOFXAzvKcF1a7zJGT0O7YMCTGkNDhlkXxDQmkqzGNKo8i3m2ZeYCZG6ITKx33p2suajuYNFGiOi66q1bMNY7GjR+ZVk3v9XZUDFaDw5odiRgn1a05vlKNRTVFaLVZd2P8OObKCJqHdq9nZORMECqhlCO8E2q1zmadSCSxLt4tTDxd+jlzyEXlxSdEnlH4DqcRrMmG4mmq6e8cEjg0XxFKmuM3SsFa4lEyqYpz0VJ9lV7rR
x-ms-office365-filtering-correlation-id: 534cc8b2-90ad-4f74-ad32-08d6222cf3ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0470FAFC65C19E934A021898FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IObgCkzcHYVzAxLpIvWfsQaeNK+3x2BdZ3SPhfrPFEWVR1jN4Nc82YSFr5vF+3qsRdL+qxzE0jRy4pOY7PWDFu18fauzsuE/pDiSXfor8H+Nngo+tMjJLJSjftoQxpW3Ky6zCtGQ1coNftFxSF+XGXzvnPeocaPVgyarpyCPv1mK8Bplhjc2V70/2y2oelR5jAJ5zZ4lC+Fudb7yXFUTyOghJzBAoZXhd1L2JLufUx09H6i90ca2Iakf6B7eN3xo3sQ1timzt3+TuhZpN9hOfT40Kbu5/kO0tWSq5YCRWSZcty5EOeSZF904TT7gEXEP55DSEm/eisB/gAlTHCV4TWEZ0Y2ANJK74DJZRU7cKQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534cc8b2-90ad-4f74-ad32-08d6222cf3ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:45.3005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 96d529bac562574600eda85726fcfa3eef6dde8e ]

Firmware can provide zero as values for sustained performance level and
corresponding sustained frequency in kHz in order to hide the actual
frequencies and provide only abstract values. It may endup with divide
by zero scenario resulting in kernel panic.

Let's set the multiplication factor to one if either one or both of them
(sustained_perf_level and sustained_freq) are set to zero.

Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performan=
ce protocol")
Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/arm_scmi/perf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/p=
erf.c
index 2a219b1261b1..49cb74f54a10 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -166,7 +166,13 @@ scmi_perf_domain_attributes_get(const struct scmi_hand=
le *handle, u32 domain,
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =3D
 					le32_to_cpu(attr->sustained_perf_level);
-		dom_info->mult_factor =3D	(dom_info->sustained_freq_khz * 1000) /
+		if (!dom_info->sustained_freq_khz ||
+		    !dom_info->sustained_perf_level)
+			/* CPUFreq converts to kHz, hence default 1000 */
+			dom_info->mult_factor =3D	1000;
+		else
+			dom_info->mult_factor =3D
+					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
 		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
--=20
2.17.1
