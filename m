Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1101FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF51620861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cGcNHmMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF51620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeIGFTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:41 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:11972
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731018AbeIGFTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+DocuaE6sEZMuiHg4ekpEyw1NGtIDMpuBm9O4F+t4M=;
 b=cGcNHmMeilE4ilXtKKa6y8krkRjRLjkfrgq3D2vmX/S8/tlNXxF8+APxqZKGN/pID+u5qH67kQ9cxt+kyFsElWd6J0h503Mys9MjlomecKUhNnAZ1H9weu1rCBXmpNNQYom2THiVO1PKqsaFGb/BpdbfaDA0yz866CWGaO7DCL8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 10/30] MIPS: ath79: fix system restart
Thread-Topic: [PATCH AUTOSEL 4.4 10/30] MIPS: ath79: fix system restart
Thread-Index: AQHURkMsi7elNnMyj0yCsK+JG288zw==
Date:   Fri, 7 Sep 2018 00:39:02 +0000
Message-ID: <20180907003853.57942-10-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:EeUQaklRLobIHMY/hNpIkCXXLV8+KjZ/bqpFRMtjzMlU9wwjDwoeCBxNhx/j44sA3nF+3UhnDvf51PKmseLFnNgq7FShLB69eV0mkbbV+ZUA6NI+o3qwKaiQk6mMfqMV6AGWdABs4CpaFwaA5+FpYKjhQVu24RlgWe35IbZeh7zllSBEC81YQ7HK24NGQddAlcySjWJ8YBitqFqFTNr53O1WqSYShKu4YL2TbMFqYvHmjU5FAo36IVp/ooKRpFK/bt37bETCR0SxoUATHq6WSLM6TbquO/zeLlc+WTpmtgNJC74HUo77QYJZIxHdeqWb5f4b/TGxM4tQkQUNjxxwudO1viV9hsZ8jwcN5iTE0Qo/8G8TQYpQ27J6Kme3g7QLczVpLzTopHr7sfvu3liGswfxgf60bjEQ6WsCh5eGIxrvx+DXtJI1ZAD+iS/kh0dJ1ljVQFHVxRzBd4+epaiXsw==;5:cY5CHvGaYAn7O1X/vEoOaFqJe9jnwp1g93E3uUmeJKsXqpAdIJH96fvkhxiUfkk/vkXaypAVWFvZz6DJVD8IPb6VoK3eZXRZw76O1XvLlnImpAabSz6bMw1PGasJKsDcT6U4yNeF7UY8nB5IIzhTyRrOALecxTX+4tCHmsDDGCg=;7:5LJr540AUkwQcO0qejTfZ382jXhBRPQOC/wDUoYwuxrbbtxJRgiay9t0fmgjBQgG62uQeOxHc6UJVrF+U/545vyK+ndZX4G+HbMS7z7EZj3eolIqVWrpNxtxuk8eZfZ7GinMs9Gbbat0XwBOeVho55bRz0NgIfiyKotCDDDBEBrA/Sx8B+k2ALM9UDYz7sRzkw6A4cHGQ6HtW/NU8PDHTtLjirub6lrCEvuO+MoTFLSu7ZC8z1lHSG+hdFauG6CK
x-ms-office365-filtering-correlation-id: f3a9e7e2-bc47-4e4e-e2cf-08d6145aa656
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075718A02DDDBC8BA1D2744EFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(966005)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(6306002)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rBnlVA+Ls5YQ7B6wKUqmigKwR7NgElNUyQSsi9t4XsTXZIoQ1uakMVKPbnFHZbP2ho1LPtQXwjaPnimYYkhxAMhIIwU3TLsak/GaftuYEmiQA3rJBptkTypdUsHJ04G/0qFH7NXxw7NH9oQIKOo6gyYsSxlJNLVTqgAYo2+kYhtOc+cIGDYm01Kbx2BCmunlrAzf5L2VYb5ScRmgDdvAChvNQBGO3/oO5Xun9brI2jQaqry4ELSdJa1tmqtL7FuHQ9f3nGaENkxjyW+OapLK4Y3s2/7/Yxr/Km9N4dFcYtf1h3hiRvrgfskW4mnydxJAYhcH4/oe456CXicZmXQlNqj6SfxcJFb+ixrqjp79b1g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a9e7e2-bc47-4e4e-e2cf-08d6145aa656
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:02.9142
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
index 8755d618e116..961c393c0f55 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -44,6 +44,7 @@ static char ath79_sys_type[ATH79_SYS_TYPE_LEN];
=20
 static void ath79_restart(char *command)
 {
+	local_irq_disable();
 	ath79_device_reset_set(AR71XX_RESET_FULL_CHIP);
 	for (;;)
 		if (cpu_wait)
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/a=
sm/mach-ath79/ath79.h
index 4eee221b0cf0..d2be8e4f7a35 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -133,6 +133,7 @@ static inline u32 ath79_pll_rr(unsigned reg)
 static inline void ath79_reset_wr(unsigned reg, u32 val)
 {
 	__raw_writel(val, ath79_reset_base + reg);
+	(void) __raw_readl(ath79_reset_base + reg); /* flush */
 }
=20
 static inline u32 ath79_reset_rr(unsigned reg)
--=20
2.17.1
