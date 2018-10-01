Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB68C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E1A2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XfLy7OtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E1A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeJAHPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:09 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:18560
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728834AbeJAHPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAUwgiMQlIXfB1w1f0YbajFLGdvZOsbEjGvtty4XIvo=;
 b=XfLy7OtIk4J6faHsXbQPN7LdDSRsgUieZxWmvqFUEetX1xuXY40XtrqTxajNQaWEFSBAKZga12wECq3y8XuQ1FopbmvlaOXXcZWgbBTWg1vwh1+M8+X/F5wahWOORA3PTLlSo/IJRKrxlxNb01hNxaZlgOHsFFvKPph7BTGsonE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jacek Tomaka <jacek.tomaka@poczta.fm>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 24/37] perf/x86/intel: Add support/quirk for the
 MISPREDICT bit on Knights Landing CPUs
Thread-Topic: [PATCH AUTOSEL 4.14 24/37] perf/x86/intel: Add support/quirk for
 the MISPREDICT bit on Knights Landing CPUs
Thread-Index: AQHUWR8pJLWw67eU3EuTGvMFrVM+Og==
Date:   Mon, 1 Oct 2018 00:39:08 +0000
Message-ID: <20181001003850.147107-24-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:xx5dlEuUTH7E/KBcOupFd0vSU+z26vB6f83s2OEhMSawrGJ7DQvrMWKGH/vIPAivdmSdHWJzUY1CLepnH6NrEtALBd9pEwXhsUMHRaPiT8r2duag11aLztUdjfvU0zLV0OCrpvLtRclc3UDsvuCzUS7FlgaoL5ledoOCkx8aAXMHClrYillgn9HVbmBgNkPErSHwKPEsPbzVk/h1KtgiQKq7naBlHjos0XueFfEgzfraVuvh1pKVSre+xmv8FTJgBUZc0ezG+GW2xOFwnjlGUxqPBhBlmcl8ccO2ttuyoG/6oL/MAqEO8iut7Kb6pRB5H8UxKvauZ3cxAgXRMg80EMNbPmF9i4RZHmQ9HYYF4bMHy6NsfyFDHaWqvHd7PivXqd5XYz1TrMo/lV79XP2+sKsAbAVeARHpSCvZfo86AhVxPKFpnAoT9oD7Q+KmUEu/8V4r6WBR7Zi06o9z4Eykmw==;5:OBPGg8iBWkJD2EKvYOUS86shczPffGMHn59EVaZXs/7HUV5Oqu2Acnv5+HNb6ngeWwlLxE4wLa91eyutKff3aFsoHIbt9JHQR69MsSTzYA6glH0L1a8cJqxAvemfQGagpoRVVUFfyiGgC9BpbOcXAfOVk3dIiwoblBEGO4PiGFw=;7:7swBFREF1foYEtHt0jQnSgjOzfoXLJXa7ZuYaCLWKe0fhUTKRKjJlqD3zKn/GgqC8l16A5vApVfDnM2KoRhVMo2qcjFScFFV7YlpwZOvlDrcYTrIGk0aVn8fCIgAlB0pA3aMkkvDeorTZgCYLX9EKUvVMmBXJ11d0onKLkC7gknhAPxIHAVQHT+820mDnaLWtD/cTevIySWweFCccP1pPk0hr3zvP9055euT/JFqC64ArAm6zFdUfoMGv8sOxSjQ
x-ms-office365-filtering-correlation-id: 7b0df779-222a-4929-d914-08d627366302
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854D0825BB2FDAAB2F3A581FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(4982022)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(966005)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(6306002)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ubfuyCvmLRNCd8qrd8UENsDeaRl/6dLVDVDkDLxU8mJhEkTji1E3fNsnU5hhnyUV49DQYiV1Z8S8RekrIwtHM3h6bN4YW010VaJDBPNduFww4vjwSkSxxhW3VptQAB6/1tmpayWLp0lqZz6hPXqrgo+EzTlpewCtTV3EqL7XhEFyuhd9cBn5L1lRleSMPvp+8YW0SDt7hEBHrsr8JPjgPvR4fXby8ICCyfgPfbbXFhKHd6lFSMplFihQ5WaUkvAQRMlDuBz+VfSQRzMILCYi/EiCdXRfoGU6hgnQYXCPMEJoNsRfFIl3PnYaLKv27CUXrXUlNF+r4lNuiXYeiHNSbYKtXmS39WX9x4xcsVkoStw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0df779-222a-4929-d914-08d627366302
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:08.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Tomaka <jacek.tomaka@poczta.fm>

[ Upstream commit 16160c1946b702dcfa95ef63389a56deb2f1c7cb ]

Problem: perf did not show branch predicted/mispredicted bit in brstack.

Output of perf -F brstack for profile collected

Before:

 0x4fdbcd/0x4fdc03/-/-/-/0
 0x45f4c1/0x4fdba0/-/-/-/0
 0x45f544/0x45f4bb/-/-/-/0
 0x45f555/0x45f53c/-/-/-/0
 0x7f66901cc24b/0x45f555/-/-/-/0
 0x7f66901cc22e/0x7f66901cc23d/-/-/-/0
 0x7f66901cc1ff/0x7f66901cc20f/-/-/-/0
 0x7f66901cc1e8/0x7f66901cc1fc/-/-/-/0

After:

 0x4fdbcd/0x4fdc03/P/-/-/0
 0x45f4c1/0x4fdba0/P/-/-/0
 0x45f544/0x45f4bb/P/-/-/0
 0x45f555/0x45f53c/P/-/-/0
 0x7f66901cc24b/0x45f555/P/-/-/0
 0x7f66901cc22e/0x7f66901cc23d/P/-/-/0
 0x7f66901cc1ff/0x7f66901cc20f/P/-/-/0
 0x7f66901cc1e8/0x7f66901cc1fc/P/-/-/0

Cause:

As mentioned in Software Development Manual vol 3, 17.4.8.1,
IA32_PERF_CAPABILITIES[5:0] indicates the format of the address that is
stored in the LBR stack. Knights Landing reports 1 (LBR_FORMAT_LIP) as
its format. Despite that, registers containing FROM address of the branch,
do have MISPREDICT bit but because of the format indicated in
IA32_PERF_CAPABILITIES[5:0], LBR did not read MISPREDICT bit.

Solution:

Teach LBR about above Knights Landing quirk and make it read MISPREDICT bit=
.

Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180802013830.10600-1-jacekt@dugeo.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/events/intel/lbr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index cf372b90557e..81fe5047c699 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1230,4 +1230,8 @@ void intel_pmu_lbr_init_knl(void)
=20
 	x86_pmu.lbr_sel_mask =3D LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  =3D snb_lbr_sel_map;
+
+	/* Knights Landing does have MISPREDICT bit */
+	if (x86_pmu.intel_cap.lbr_format =3D=3D LBR_FORMAT_LIP)
+		x86_pmu.intel_cap.lbr_format =3D LBR_FORMAT_EIP_FLAGS;
 }
--=20
2.17.1
