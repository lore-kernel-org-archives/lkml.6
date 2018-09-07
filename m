Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E8EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36582083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZWFsENSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36582083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeIGFVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:21:38 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728422AbeIGFU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPVP98MbPfT64pz0jmnYxnUy+2+wEQpRxrxrg3ZbkaQ=;
 b=ZWFsENSNl1BiC5E4FqXJP+gZPaUWhN0KCQlKL6WHyn+k/XUQO1ThP7aMoVzBOc2jrUfOgZ1+F/4rV9AIzXH+TahaZEAE91Z5cQ3OlBlWCQsdMxbSsMWJCxSgq+fA8exPHrpYOesw9T7diHIHjNy5PWXd+KQaCzpTINdniz4O4DM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 05/19] MIPS: ath79: fix system restart
Thread-Topic: [PATCH AUTOSEL 3.18 05/19] MIPS: ath79: fix system restart
Thread-Index: AQHURkM8vG9y2VLay0aIMelgSNE9fQ==
Date:   Fri, 7 Sep 2018 00:39:29 +0000
Message-ID: <20180907003923.58019-5-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:Hbon4EwV0ulQNUPdrHFbQmCiVISWVHgpy0nrbnMf4rd8rsL0h37taXXEoBjcHvwXc3XJLe8wouQBllyK8Di8IHhQuBKxYzXtFuvbiQDck4zsndi5+VqL1Le7EkE04TxAfDUj6tiXcy6Cz9fKSc16sQIgLjW87Wz0v0/ApyHZ28Xqivt3Pzee2GI4GkvjVChLR8VMak/gFKChVB5XXEXXp+DPSitkHTeogMa7GXFRyG1zCXqQg4fhVhmUHBgM/Gu0GduBNSYgKi22Vc3l+AqhEEnpTgwcJl8FI1V4lffoI/6jnFdYuLyVt0vzKmfbB7DPlgPz56eRYvYC+PYDGFq1U1VCUlhWDZ8agBK+eCe+OMXrn9NhwxM9FdFnswZKZiBqhmL9rDlriWUHrVhBfajMkAlrO+8Lqf8wg2Hk1mIIfsqz/pu+PjAndBNBlqRXLCp516rwf3P0zXwofX9nMpOqKQ==;5:2GRwrxZWjdx3wjGvm8j7soZmCvxQseQcPY984AgWYrULUle5w+D0RnFYi9YlybtZgeMjFnbfJmYZpVqQxhiozqqeshnWlYbrrFpSC5pIeK2bBwebCLPIHyHFXN61j2RRlNOg+NP8vf6OlwU0MuBr2fiSw7zHFvx7uQvkpcwHAvA=;7:eqnNmNseM5qq9O7VkXOMVWu99vWKbTf94UXOxgtsZ9uDiN1JCI1hu3DKCclxo7RyerBomJDTJ9X6tt0v9euQLJlljRwqUhsdOps8VFTJ9AWj58ET+gdTSOs5pp/6fCovB1odKl4ZIkM+0zU9KCbvODF7YAM2zHQ61dwky+hbsoCOt6Iz0cKU2gvBiEj2jDB/JGtrbv3IahhK8uMbISbrsR/HVtkb85aU6ahUq6GM5Rp79aDXrnyfW5+ui1wncyHT
x-ms-office365-filtering-correlation-id: f43386a8-78f2-41d4-b6a1-08d6145abf5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822124DB037B5CEF3D72A38FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(966005)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(6306002)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VweuQF+17tgsfk9ZAQkz9ATwAM9kleHGrMIzl0w7ljWEzhSazlFVkPw5BejF31vE2TQAiIdeRk3lJIpSAY0AmbEQpftkIExEjz3XbGixpxleWU+FUhMz4yKfYZVa317CrZOoYr4qn8u9H+xiL9UfRTNZ8vBQHEFm97+EeRqvZZukIxHSUOml5qCPLIdotK0a74bgVWCiL9vsIfMgcF3ujoIleLeYibdw7/dx+NAV/dd8sgGmgeY3TGG3OQVQhEutFkjqhrgVMOcMjV1tzUlDKk0WfbRTvPrLSYC3MQt9wesYDVftx7VgUF7z/bE0iIDnkO4ECg+CV0Y+NnnGl+h1dyyxxiOvZq7Xk0dq4vmUwz0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43386a8-78f2-41d4-b6a1-08d6145abf5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:29.6804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit f8a7bfe1cb2c1ebfa07775c9c8ac0ad3ba8e5ff5 ]

This patch disables irq on reboot to fix hang issues that were observed
due to pending interrupts.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19913/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/ath79/setup.c                  | 1 +
 arch/mips/include/asm/mach-ath79/ath79.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 64807a4809d0..2b3b66780152 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -40,6 +40,7 @@ static char ath79_sys_type[ATH79_SYS_TYPE_LEN];
=20
 static void ath79_restart(char *command)
 {
+	local_irq_disable();
 	ath79_device_reset_set(AR71XX_RESET_FULL_CHIP);
 	for (;;)
 		if (cpu_wait)
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/a=
sm/mach-ath79/ath79.h
index 1557934aaca9..39a10a136f53 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -132,6 +132,7 @@ static inline u32 ath79_pll_rr(unsigned reg)
 static inline void ath79_reset_wr(unsigned reg, u32 val)
 {
 	__raw_writel(val, ath79_reset_base + reg);
+	(void) __raw_readl(ath79_reset_base + reg); /* flush */
 }
=20
 static inline u32 ath79_reset_rr(unsigned reg)
--=20
2.17.1
