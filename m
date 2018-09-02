Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC8C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0416420837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lv+OMuwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0416420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeIBRac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:32 -0400
Received: from mail-eopbgr680125.outbound.protection.outlook.com ([40.107.68.125]:33856
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbeIBRac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP1A424XNj0DVAqDA96ozfWqcjjupiEwAsTe8cVqOIU=;
 b=Lv+OMuwVsat9/5SrkmYRm6FR1A4a+4nRsaFdyd/Cy6GFAto07LpLedqeK+8Mh0uYa3LofZuSk7t2kPklicmPP2HeQegaOjIEhEnabhw+0ppiu0H/HoSInph2RiP6tXhLmGPDSHV5rFsLiOBClhgI+orQTYcHazWCN61IA5rDyP4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 31/62] f2fs: try grabbing node page lock
 aggressively in sync scenario
Thread-Topic: [PATCH AUTOSEL 4.9 31/62] f2fs: try grabbing node page lock
 aggressively in sync scenario
Thread-Index: AQHUQr7p0K2O8LOm4UaHhFXgJ3qhXg==
Date:   Sun, 2 Sep 2018 13:14:43 +0000
Message-ID: <20180902131411.183978-21-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:ODQatkl0da2klBND+3rOtjPP173szBHA4FgOsmODCBDyiQkwRQJO42kLKpAqx3ggsaCQHcqdWi2dbxW3od5h8FexACNYfjrqjPwHAnDvG9DlPyJd5JP0gXwaHcvTzZQ5ZwgBfSoXWcrhhaXe3+NyO2iftjNa4QH2RWu5t/W4MTOSsBiRSteoMerLVnId25jsXNxZ+cYc9AKjdnuz7pSe/ICRBWn6kdNwSXKeJDqafL4jauF9KmjVLHt8QEVkK94qn7fi3v53ozOF0a6rBu2QHO5alC3dBsWI1wX6Uw7AmxtuM7z5TkOAAas6YSIW7Kw63U7sy4QJUHSaY3lqn4e0RzxgHdZ847CL8GdlqsvKnoGBh+4iNlkTbUOcxGPrlfLqJmsg5s7n7JHctUBsT2JbQ3c41/GtC1HaJCyPbEtKjvU0jXkmQdCehXZ2vH0kap+lXvvag2l2ZU6r4VarZ74o7Q==;5:TQR1bzhPJbVo9d+NgUAKLLKYqK8s0PVOolux2mrbS/x/7l6eRfjouaFI7ZEORWtjdyeFRS/ZupE+t0WeLYSvuMA8/LMAtvfrBSDClWd4ihUgOOZVZkMd1FXmFnnZVvvxJu2Tvztfzx1OMN0cOgOVZc3QFBEG5Fv2nTClEaSthJU=;7:dAphevDvgBqJAX1dEgIS6tEabdZUCZhahVRRpSqhRoMuSm2vl+lSruUvoRr/ilXvp6aor14QkXm6uEDKV+RbKXZf1bOA1vDkXQIwdLLO8VQhQptS26Y17p51pHzpe7J0erRb6LLHUuLFyKuEOUbALW8kOaZmcGQsoFhYp53Bngj15myxcPyGahX0m/MBxPj5LUpJc0e3CITiB+qXvgTsh8xDt4fZADiC6GEv5AZuuvDNgcEfJ07+V5XDBT8wk4NC
x-ms-office365-filtering-correlation-id: 9ec451ca-a074-47f5-7357-08d610d60c27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741ED0C5202B3AF75CC4FD6FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rD/qBqsWjM0WFVwZHxnPQIv/eSLbwQDBZkV1ZwJylnk/OJaL9d//iQNLoNNSSv+Ld/LcWcG5O2tNisngt7Xu/2BqtQoMqezQri9BDbJ2Pxaibovy1u7OoN9u/ZHiw2EgOxJ11I2K+RvYlcgkCTOiT/Z+7bkxQrct91LlzvdSQ74srxiSJnCGOQ3WoP2xL7CY3YXV1YOhGjSfK55eCA7v7/QqkxZgu356KP506DxX6vg/AMFNjsFrPHxGcorOS3tpu01kogt5BBTMfcO8fktGjY4OCTPSnshpLMsoEEFOu99IiMqDlkf26cTueUdYEjjPXD3RoE2r4zw+m+hk4i1kM51Or5HzyK6ZnjYhEK2W5Zs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec451ca-a074-47f5-7357-08d610d60c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:43.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 4b270a8cc5047682f0a3f3f9af3b498408dbd2bc ]

In synchronous scenario, like in checkpoint(), we are going to flush
dirty node pages to device synchronously, we can easily failed
writebacking node page due to trylock_page() failure, especially in
condition of intensive lock competition, which can cause long latency
of checkpoint(). So let's use lock_page() in synchronous scenario to
avoid this issue.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 01177ecdeab8..addff6a3b176 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1463,7 +1463,9 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct =
writeback_control *wbc)
 						!is_cold_node(page)))
 				continue;
 lock_node:
-			if (!trylock_page(page))
+			if (wbc->sync_mode =3D=3D WB_SYNC_ALL)
+				lock_page(page);
+			else if (!trylock_page(page))
 				continue;
=20
 			if (unlikely(page->mapping !=3D NODE_MAPPING(sbi))) {
--=20
2.17.1
