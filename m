Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24851C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CE4208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WotyvarE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CE4208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeJAHQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:28 -0400
Received: from mail-by2nam03on0106.outbound.protection.outlook.com ([104.47.42.106]:29000
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729766AbeJAHQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxAfIJv/8X1zfkpkM8DoAR0i2JvyPAOqS6Fwx1xvq18=;
 b=WotyvarEO438/Nv4bbcS6oEGtx/MXpcJSdOrnQYke4bxzlvVyhbkkpW3iXetyoV+4AMzq/+SHH2KYPPHxFUiyOlSP1UuxgUrfpCfx6XrJFlV4s4TNTNkbETo9gxwYQuhP38N4DUmqBcVWjqyqpk9/v79T1KRzy+ouymfxKQzEl8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jacek Tomaka <jacek.tomaka@poczta.fm>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 15/26] perf/x86/intel: Add support/quirk for the
 MISPREDICT bit on Knights Landing CPUs
Thread-Topic: [PATCH AUTOSEL 4.9 15/26] perf/x86/intel: Add support/quirk for
 the MISPREDICT bit on Knights Landing CPUs
Thread-Index: AQHUWR9fKfF6G1gjUkiv8DP+zMDRVA==
Date:   Mon, 1 Oct 2018 00:40:38 +0000
Message-ID: <20181001004026.147201-15-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:keRpKw74XnQ3Wovn0FTFKnPbzMkAUijcf3pb2M1MNaltyE/sgsQ8+AqVHoiVKEyaUKY5vgpFjedSSHxkn5sU2OFNNSL5lTCeN34VEfw+ophHkYPwtDm4P5wPfS9Itfbe9U7npo+v3qMUT3v1wD+9hFN94dAASxg75ABcsQ6rb3ZNzs2mS/Ya5YJ0tUspcqQhOkWj51+cxk5fzzkPNqNBJ4F0flHgVzPPspr/gAV1/tPnYA6yh3lrJWrsNAaAMBYk1lQbGWwxHwlUE1Ha13PhwAmCns1nXxPwIwZpfx+2vaIACIuheWSWmjqoMMBOZk8bVjFiK2dX1HamCQRoiTWFwKUi9bpmpUhYjj+/g0KnyL2HmfqFGmDUQg9Q/EhQfI/FTu0ngNiekvSevFKHQl48Ng2oBJ1rfcnTQ6xWbzMj4O0P7RDv0mRuYd30DkEnoNnxRp1H0nwRdPCNiLlz5dQghA==;5:IPg7r/VK7VwKUTP7NBIyySKobD4kBIQCLg9zeBmo0VihI6a5Lot0whi91vwImBCjCIra3cLTAcKskSejeO/ckxcMq5EIDqGsiFpEwnRDShDpgyJFHOOoH5oDMpS3Wzpyjmd83RaIPidATQusJQPMiFWmaiMYsVdC0L+80Un7pnc=;7:Sz4mLOOHqBxYpsaWEIQjf4ITmWkVQlQAi/JVcMRGN5x26IftmwGjuO7WbfkxdV0gjTtAhMYzEbIqAvQ2yZ31VO7lVak85Eq+cGHPJJJR8mQEknGYaXj+zXUQD8EFpg0mo+fQt4gU6vCzy++okufLdY2T+k+4YIj6oqQ3ETZrXAEhW1i3cD1v1F3DmZHJhqMvSDygdf3hYYt2X6gj6hZ9L6tUX1N/KhozD/KOwmCOvEdKS+fFgtHLQPBUKPIWiFjt
x-ms-office365-filtering-correlation-id: 56e802c5-f69f-4864-27fb-08d6273681fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165F752E14772CBBDC07427FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6306002)(6346003)(4326008)(966005)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YO1Q8Ck+L4y1BCxizhWjEqb0B/42mkfgxfyPWTCRz3de6p016GwrihJjZNeiAUze/YUAEIuxzZS0JpDuB1Sw33etOTbVp3rN0pbkqM3A0deAybQ3AGWX8gJrMZkZr4j6RTkKbhIrEatOKvsDDcSXRAh6hGX/EUqJSBjZJTg/Bvv7OJ+WqhcvFnz60YXYFHs8XZ4jDnHp6HRlGerq1Uanj0fevtWRl1LymoemURF1jI6q+qA96AUZ/Yn8KStvh0dYVnoINaauq7J76UMTiFEvMYIWjnfWZgayBXc/U7KONnv1uDoSTtjh+aBCMoR+JVfI08ynykyzBfOVlOTdfCgKx6Zsd2Oy6kydEG38uHmDEZU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e802c5-f69f-4864-27fb-08d6273681fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:38.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index 5d103a87e984..be0ad713ad5e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1175,4 +1175,8 @@ void intel_pmu_lbr_init_knl(void)
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
