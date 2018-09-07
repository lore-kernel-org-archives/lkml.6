Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C31C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A9C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CmPOx3BZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A9C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbeIGFSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:54 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com ([40.107.70.105]:7696
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729305AbeIGFSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfbsnoqNqIYS6vUmgvTogG9oASp5fkIBTKHeRAM8ZdA=;
 b=CmPOx3BZcYfz1GY1LIrfBKClU8gp+c4uYQrGt4G/7REIfazrqcWfCbIoex9HiaIm/2hGWihtqjnG7eAibQA+D6UzG2UYNtFFqbkAYCoh6i8uTxOf62QjC4ioYClWfVnxU1J2fKmhGiThZWZgOmNcAACFkQGrUW2Z4FA459q2ONo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 12/43] MIPS: ath79: fix system restart
Thread-Topic: [PATCH AUTOSEL 4.9 12/43] MIPS: ath79: fix system restart
Thread-Index: AQHURkMX97zoh9n0qUyJNMMrHCPe2Q==
Date:   Fri, 7 Sep 2018 00:38:27 +0000
Message-ID: <20180907003816.57852-12-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:CLhkQtrP0e8PW9t1bk98RPvWlCqpk2+ioAvFbUQlb9DdpBfuYRJgB/v7I1Yt3z1hN5YlDe56gRP3maBhn7fn9gzvLPTwwQhsqjBHGYjEEKHTUrD9R1WKLuJ8A2l3dcbh/BC1hzQk2RtyOEghMvlPOVuu+jT/WSJRh+l29gm1mhNFScNymHDaaljh6v+aQ6F/+NspT0uqGltCZFF+9XxhiBJSn1C35SUpmyRH1y4eQrtxsgrMnmzWSusncYvZWacd+R+tjSN+FkHVEzt3MOnHpLvsqli/3qXD2PpmltAO1UWSbt9UZ2gDn6CcxKmb+duYdP3sJgtO4o3d5aF0x7Yz15NeDqqd4XAD8K4NrXdzJxuNXUErLfduR7uIJ1vURfy87xFqI2bgW07oAGnMZfLAYVGXpjRTFjuOSfCWAbLT6NZfqECkAAImwXTrLNZxAsTW4qcylX2Ufbq2vEZYRpeBTA==;5:vCwNmu2AoOGrLCcQF40QPk9+JcjohBIhGjEeQfWqVIP/eD4t3jqhxOQn2yvLubD174CeO0WivOmJCTORr47i8nKgEIw/WF5gaH7zbz0ZciNbXWFnz5bgPl+jSu5YWiuhYC0bS/+h58BiA+KCJy5LoId6eQSqkgsu0CpH3xbk+mg=;7:pux88ZpT7hVBuHsQbwj5Lyr8Kesr8/Dx6EsfxdzjtxHsFDzNsnPm37IzHOeam2fJCIspNQoL/172PcqQAX40HM2XERsP8Jb88HjOhVfD06Z1P1frPyXmQq4K4Yjalr+NxReHm8eL61jWfW4oq3CABHwG1yfVFTyoe8MMSkNu+jeR2pErHzhGv2FM4SGykvVg/SF+uzgTvc20EXv9FVG9ULs5rNTsvRjxc6bhqZq+YJGxMa2U55bcVwSUmoYbKgFT
x-ms-office365-filtering-correlation-id: f98541f8-479a-47f8-175e-08d6145a89f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB01498616510A4253C22D3979FB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(575784001)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(6306002)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(966005)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vFXmxB6hw4Bnye2QlxcGnYp2sijnmb7/OrbWQUdfIJ4fvBcSFwQpnpXTVa6Az2Fl3qPiUP73izeDGvkfwrQ3FWWlUzzrSGnHptDSuzP/r4p+4GYCrhPIBkWRsx0pGG4NfOEJFD7vqecWqJvCHtepq9TO+ttXFHmnm1hqSUaQ27jhSXWwNmTQw7Opg0qT/5NjbBZhn1nO/WSRd56p7fC5ctBuCiUXYWXRHoCClE+WnFPnLMVGIFGPrit0aFJgCM5MSqEQXPCS8geivjZeeNpKT2H/MqrMjPUWmeQwD47p8SgAtc2/HBuz417EDROpNrNdlwwLrGY10/9gu4lcNQWUlN554SoKUnq7BowDgsCR/NY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98541f8-479a-47f8-175e-08d6145a89f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:27.3994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
