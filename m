Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F311EC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F70820861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M6qasF92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F70820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeIGFOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:19 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:21288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728631AbeIGFOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfbsnoqNqIYS6vUmgvTogG9oASp5fkIBTKHeRAM8ZdA=;
 b=M6qasF92ZAwEBwlYbK7GL/JpCHF3J3H4zML93MF7Zr93CYYXpXqJRdJaz5J8HTqzT8Jo4Zf5tzBzkRt006gilNVj8PEP+JbSG6q3TOctVfLwwP/1GCJCu7tchMrZZY1gBQ76vDZnu1fKi4D/JXX64rY3kXQo/hcK/8d3A5yuf1c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 26/88] MIPS: ath79: fix system restart
Thread-Topic: [PATCH AUTOSEL 4.18 26/88] MIPS: ath79: fix system restart
Thread-Index: AQHURkLGVhbUtghsRkKFroQGQUHNIA==
Date:   Fri, 7 Sep 2018 00:36:10 +0000
Message-ID: <20180907003547.57567-26-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:r8BVJGA/+GCu1vB1sGQfgjtib54OkX++FspiVdZef/JvnWurxXIxDB20ySky5cbTMgiBu1PUvuAuLlS4aLbRTvzVJi4bbLOtpEGnfFFb/YRIUFRG5VdGJejTMn25hZVCGkna19spvrVfh02IxJQJeEjZJKOCFTinjcddrrnOFg+D1Sj0nV5o9vEcejImQbepR4ELGCZbCC81u1WaZjpE7mCqYr6bp74rtFvp/8AjFfZbXfaQOy3jLMmzA4v2I/bJvJKa3AxywlCxcogi36wAFcUyLPASu0yVQwSAIRodPpsSndMC8iKVKJHu9GWAK9JLxPZxerzwInahoKSZf24RNG6L2Cb7+WFB1UkJw+bPnP42gNqVOLmOgSTIQnPd77vJuBfWLIXT3UCTgWfvdnQyDAV5Oh5CfmSjkYZXByIWSKR0gEz6bpfwXH47DSKP5O/swtiqUpEs7Xjid57HRaRz2w==;5:KStOmLU2pX7UK+MfvofBINrEslxErY8WvGQQ0rV4YhgDgYdA7/o2sNrKbcpUVsUwTuaqz6PpLLRbaSe9B0uEEAM8C8MuC/1X8tkwZ4bEF2vhXt4jgXAykcJrBzgLyhQdlEaRdF0tkmVHMUEJPTQnWqEXYuXhfpyKXXZa7ddcZio=;7:bW3aZ02xniRjTvDP5WsD8YhZBcT/TpFgulhkPv2ciinqOvD/NQJxPAxZg8aK9YiYpNldKwRS/9j6JkOM+UpOr3ffTU9yF1k/I/mrfoEPJsODtebhRUOTw4L8VW6uwJ6D6j5MWZcQo+TIe3eXyqP+7zKmEEPlKTnbLiP0M8huyFEe9KBsbaqd+YOCKM2reZTGoIRJTAELTuh7QxrFiuKEGIBBh7UkAxVDXJODw0pZiqdvssa2e0GrDiyzVSVeXWys
x-ms-office365-filtering-correlation-id: 8bb08c57-e02c-478b-22f8-08d61459e8af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824B7CE64DBF278C7BB3A27FB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(14444005)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(966005)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(575784001)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(6306002)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZVRlJF6SoHUDdoHnSL0r6i1s0rs6K70D7GnnJyvBYdOlR/Bv90VMhmQ1Sj6SMwBc0fgPJrjsPqiLplwG1gLcWif7chyA5xoeHgZxmssXev/7uCh2gPNsvbTNsUxsOsOqiUYDQopwMUW8mpAZd9WvDTAiYqBv8boV1DwPLTi0/GAwgR3AFwycS4hZQTQoDp5YqnIv7dTPtNNLXflpVrjiOLGkiBuGH1I0FoF5zIEqzxh1es1jnNB6ioIFIw0M50e2Xo5LS/hAUC3D1xKL/HkwNYYvXF9Ihvofs1KQMNnhXzJzRny+wdbdZAJl4919OnuV3M03KaK1lZf76AF2fJDynlyePN9sq2Z9uvhfk2du45A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb08c57-e02c-478b-22f8-08d61459e8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:10.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
