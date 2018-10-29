Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054FCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9E52084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="FTSOrMy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9E52084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeJ2XJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:09:47 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:21405
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbeJ2XJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1wqUoitqe5H3yCfLsg8y06j4SAqd1sA8i/NDyfAzPw=;
 b=FTSOrMy+4QDe/KaHHA6KjLJEsi96nRO87G1dAT4JaE+v/pdaBAI7CksoF7hgsUejO6GUuyi7HAsfZuq9fr4nsVga1BmurPvTzMxgLxItbCtieNYYTnHq0EtT2+gOs8+hyv3/iLTSw9+/s0RpL9+ejqJw9SJyg+CIOZZGxPspiOY=
Received: from HE1PR0702MB3756.eurprd07.prod.outlook.com (52.133.7.10) by
 HE1PR0702MB3579.eurprd07.prod.outlook.com (52.133.6.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.17; Mon, 29 Oct 2018 14:20:52 +0000
Received: from HE1PR0702MB3756.eurprd07.prod.outlook.com
 ([fe80::4c9:7fe3:973e:77ed]) by HE1PR0702MB3756.eurprd07.prod.outlook.com
 ([fe80::4c9:7fe3:973e:77ed%4]) with mapi id 15.20.1294.018; Mon, 29 Oct 2018
 14:20:52 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tony@atomide.com" <tony@atomide.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: mm: fault: check ADFSR in case of abort
Thread-Topic: [PATCH] arm: mm: fault: check ADFSR in case of abort
Thread-Index: AdRvkeVP3Te0gsIRSvm4gC5lSIqMig==
Date:   Mon, 29 Oct 2018 14:20:51 +0000
Message-ID: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-originating-ip: [131.228.32.178]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0702MB3579;6:aEaTnpx5RXQOumdaWJWgcywbX6G+rpRUeYwzHz42OFpfA69PiQaxpKdqEGO2y/JdghV+rkKl4Q1ccHFZlkZ+ajQ+V5MiYRcWkVwPvDHPMZ6wOsklUZy1Ht6H3ytmzRv8ABTX2ZAwK2i6M1MEFMWGYkNnj9PVaB1acs0uFhbW0+4StSePaNIo5dZRdxWq8DQLIYXMytNUdLN025C9muW+4LVrRt8nbnlDY8FsxZgSfpTRropGC8+usbkrYTU7S3XRvDG6v5x5Fz7mFxWsi45BryE0fAvfu6Jre2OvZmPUilk9G5BuK0Asdis/kksncs53SB3/VjsFRBzbQ4MwB3N0hdFOE0XLYKEmi5r/9E1xxiFyvrjv7gRgHbvhdPafmxOrhuvYhaomRXvv5yI5NvUIQQSFiLtmN7ZP+7E5S5hHy8OXD73OsJ5BrVIvoX6yTo+5XOmoiFvphiu7VT3CPJqDkQ==;5:aZYkaeQ8I56i/123veiUY45r7JVRrES3Nv4+Tuflx+50lksLBb6Ew4/4oe7pZqCdggOpgywSl2zHAZ8w9aQyvR69B9hnm7CVCxqRh3r6lUEbVNZ0dvfl0V22wWAaaCJ9O2o5UHDIic85SPQQL9TVxWnXyy9r7Al9fzXiC5uBtOI=;7:pS9PcwUtm7UUsFGfdR7fgtnW91K21JwGkh0jKu0b1lHdvZN2ZKpiLN2rIR/qsUFrTezMkJHopoWv5JxkH/gvvxSUOZpfbyuETxOqUDAK+X1u4uB8uj9OLBM2+n5uInmUAngHiA/qsjFSOPWHRaJUBA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 02957ae0-2b32-4079-9ef4-08d63da9bb4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3579;
x-ms-traffictypediagnostic: HE1PR0702MB3579:
x-microsoft-antispam-prvs: <HE1PR0702MB3579F810964112D706952A44FAF30@HE1PR0702MB3579.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(82608151540597)(109105607167333)(195916259791689);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(11241501184)(806099)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0702MB3579;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0702MB3579;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(110136005)(55016002)(6436002)(6506007)(9686003)(316002)(105586002)(14454004)(2900100001)(2201001)(102836004)(68736007)(86362001)(53936002)(106356001)(478600001)(3846002)(6116002)(26005)(256004)(186003)(39060400002)(5250100002)(7736002)(305945005)(74316002)(2501003)(66066001)(7696005)(25786009)(4326008)(1857600001)(71200400001)(71190400001)(99286004)(97736004)(8936002)(5660300001)(2906002)(486006)(81166006)(81156014)(33656002)(476003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3579;H:HE1PR0702MB3756.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B8craZCEp6XmBHyvAm7VouiA5NBIrffT3EsffLW4cwydOiq0gtKKFqzjO0yxOtb/pY9QN5FRusJMZdJ7bJvsOwvjF7pUnu4PPXKPj0rAbI8qdKYeRpaMokWVWsJxBhnl/IdSlabome6ABuVPSzblHdB8EmGCUpNhPG8ihvuEbcak9u1T0O1t0Jhq6WYI07SHyvJ5+KHX18cWl7X1DPvRu9gyq7vEgh/U9adf/bUl7fsvHpgll5CI70S03/WHuQnc2F1Dqk81VTVeKaevtoLG7gI6AbgnmrpvIQ9xXS5M7vhxntV5jj2ZYdXoFnPPe74m6MIhBZ/xxdQNJJs7E353MzU6Ixk1K4e3Ea9wFsJUYKN/0nADK2Cz+0xRmze8tbF0ZJQv3TeIwqum2rTC6YA7Og==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02957ae0-2b32-4079-9ef4-08d63da9bb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 14:20:51.9891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running into situations like:
"Unhandled fault: synchronous external abort (0x210) at 0xXXX"
or
"Unhandled prefetch abort: synchronous external abort (0x210) at 0xXXX"
it is useful to know the content of ADFSR (Auxiliary Data Fault Status
Register) to indicate an ECC double-bit error in L1 or L2 cache.

Refer to:
Cortex-A15 Technical Reference Manual, Revision: r2p1
[6.4.8. Error Correction Code]

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
 arch/arm/mm/fault.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 3232afb6fdc0..5e240deb6ed6 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -547,6 +547,22 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsig=
ned int, struct pt_regs *)
 	fsr_info[nr].name =3D name;
 }
=20
+/*
+ * Check for ECC double-bit errors in Auxiliary Data Fault Status Register
+ */
+static void check_adfsr_for_ecc(void)
+{
+	u32 adfsr =3D 0;
+
+	asm("mrc p15, 0, %0, c5, c1, 0" : "=3Dr" (adfsr));
+
+	if (adfsr & (BIT(31) | BIT(23))) {
+		pr_alert("ADFSR status 0x%x indicates that an L1 or L2 cache\n"
+			 "ECC double-bit error occurred at some time.\n",
+			  adfsr);
+	}
+}
+
 /*
  * Dispatch a data abort to the relevant handler.
  */
@@ -559,6 +575,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, stru=
ct pt_regs *regs)
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
=20
+	check_adfsr_for_ecc();
 	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 		inf->name, fsr, addr);
 	show_pte(current->mm, addr);
@@ -593,6 +610,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr,=
 struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
=20
+	check_adfsr_for_ecc();
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
=20
--=20
2.16.1
