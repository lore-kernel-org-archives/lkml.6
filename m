Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14C2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D2A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M8uVjoo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D2A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbeIGFRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:11 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:26290
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729837AbeIGFRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfbsnoqNqIYS6vUmgvTogG9oASp5fkIBTKHeRAM8ZdA=;
 b=M8uVjoo+xCnd1TygKem5z4+lltBGOih6CZMAbJUL6D5mv96B1kn3fWoNrl8Krm6kjmWhnSFgoPxvCgOcIY/JimJJpGWipdiSZbp15muMgGIQWVysCW7EQwxeWj8QbG3+8c4lx9KdYQNsXb7nzY+EcewfCzlH9kwzV8C8unkd+lE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 18/67] MIPS: ath79: fix system restart
Thread-Topic: [PATCH AUTOSEL 4.14 18/67] MIPS: ath79: fix system restart
Thread-Index: AQHURkL3RXUyrFndn0aVwfGEuqXXcA==
Date:   Fri, 7 Sep 2018 00:37:32 +0000
Message-ID: <20180907003716.57737-18-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:zxCe2xz6mRjVrS0Ghv/Db3ESf544Mrcv7nexHD7XlWwLzFO66ijSovLM7OQ9VDqBgwsi5gv7NVKUQU+ui5N7iEAZgMh1wrs9+fYZlC+zzBcQmMwEbvDOj2MASO8HoIit8JbAGWaReAS7pDJDVWBXWNsM2BXK8427GXWsL8o5VzWyt6GOESNC5AnHnWsLZHVoJ+vxkhD750c0V81ig6AKrc1M+eSSir/HLt+g7OBRT6lbgJSuTN0T4Nyt6aDpQ1C2OhYsRA3ANRdA1HjIpJPTmLjHHPghXqXZ+KH23TCDv53TWCVmrsssocTXFiZAfZK5rwK1uM6OzHmkabk2fj1UCTI4XspoU7pMbU16UVv0Uxn6ewg8A+UaZzCXzIkWOpkOhYg7Dey3GlnpDL21K27zXK68FZz6rmRm9ufPcSATkVnJD8HfDUckUVjsX+t5+UkVR15rTXUyZTVOAB73+u0oZA==;5:XsRhkEyfCJCinOxDL9hUvA9dwqgE/sKhKzUooU8Sx+VnDq/eks5ScU1dSiY1jLm/Rzxya8KO6bStM+Uj07L8ccKsUoT10PuSyULnjAoc1F3ZUOfohu9XZyaS/BcKfhC29+8hn3PbEw5OfM8VZ1j4qfdWx9yx+zFqO+IDjXDR1a4=;7:U9bG+RxNDXMt4ejD7H2Gwp/7jAlYbsQEnP8l2+Wuxk4H7pkg2YDQWv0JGTRiopjopqYfEtMJqJiosNV8q8sTke4411dbSERArujo6i4TuSFlR9ckelBJgWYeUFTJWkpnjGbbjFMosZhmWzYzyCGJ+jiBiQJ3FmwgHJDzP3fXlipP55HrC9ktu/74cLcUp0qALUGcxGmhCM4ivmxURfmdEFkTcFJXStl7jaDfV6viVoYYkYlBSj7mNt5b7burejsi
x-ms-office365-filtering-correlation-id: 960e7b06-cccf-4a78-4525-08d6145a351a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07577421E0B665D9420BEFE0FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(966005)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(6306002)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qLzh+rSTC3NiXQZo2f2b97pXyrrGEPjGzy0lINiWr9t4BQ8lJlA0gPqO7PX0VcFNlny0FoqrG/j7ESfW5lPxJQrYPTbPOazzNYk6XTB5XCsxd+JjX0OyTgb+ARMpzRhCWRjvic4Fea4+FAVTsGJP4eHyfHO9GWRKVXOPA7D8+In/0c/5mlLgZg0QXFbfqLnzRWa4awvD1USedfOa/6om9dhI+2eEFJBpm9X1SSmkh2O0Hl4GX+Q+UgyDZ85xKORBrDokULKdaSjX1mEJGchNsMDBhYSEH1mw581CsZCK9vqm1+7iA3e9CmRY+B1vF31pVbYRUHcqPcXhNr4tgj3QHf+EgCaWvPPP3XBBCg8+uqM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960e7b06-cccf-4a78-4525-08d6145a351a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:32.7779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index f206dafbb0a3..26a058d58d37 100644
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
index 441faa92c3cd..6e6c0fead776 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -134,6 +134,7 @@ static inline u32 ath79_pll_rr(unsigned reg)
 static inline void ath79_reset_wr(unsigned reg, u32 val)
 {
 	__raw_writel(val, ath79_reset_base + reg);
+	(void) __raw_readl(ath79_reset_base + reg); /* flush */
 }
=20
 static inline u32 ath79_reset_rr(unsigned reg)
--=20
2.17.1
