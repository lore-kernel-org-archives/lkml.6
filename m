Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E812C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3249520666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E8hHQxpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3249520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeJAHOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:32 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:63837
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729229AbeJAHOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAUwgiMQlIXfB1w1f0YbajFLGdvZOsbEjGvtty4XIvo=;
 b=E8hHQxpzMFwA1Tv4vwrTWPEKvVVYa8FZPu/i6nO1TlMuD+4vCGB6vH+Ya1UykmO6PnnQGMvsu4rPspq6PIe21kNGC184UVelfceOgnSa7pnfUM1o8m31omZXCtMX+GIiRXps5TlF0c9sEACi+p6p8mSujSRpWHS4cR28NsqH+g4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jacek Tomaka <jacek.tomaka@poczta.fm>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 46/65] perf/x86/intel: Add support/quirk for the
 MISPREDICT bit on Knights Landing CPUs
Thread-Topic: [PATCH AUTOSEL 4.18 46/65] perf/x86/intel: Add support/quirk for
 the MISPREDICT bit on Knights Landing CPUs
Thread-Index: AQHUWR8TfRWyM/c4j0CcZuWiY+ZJIQ==
Date:   Mon, 1 Oct 2018 00:38:30 +0000
Message-ID: <20181001003754.146961-46-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:E2mfChwcPYDW+Sv057A/OmIzaI5lLtFIkZESSIX3ydWvHC6VRbkokVQpqNoJ1nGu/CsW4pTmP/ZDV0Atg4U7CBLKhbD2yFJmetVQeWpHUX5N4lnLz8tkSiOI3JRsozIs/Y3a44QokYDe5mu7+B/AHJm5jmPaeCaAD9H1Qfq1ovEYyrsuz304QF8Yhm9fG3iTwX164xEjr020PGbsQzfWX+qnjqYJgpiGVFQNqIlgVwROgQ6UZOthPUM97LgY3kWFr2Xh27AxgDJv/UxiKz2aMmYn6WQbyzpxUVxiHUEaBcms/KVxiTazb0nYRoHWgi3jyhWFsk/yNq7FQF97TPCpMpKYR0uF3hKBKhqkNXlq6plpFO+bavcJB5hXVmLf8PlzxSKCqTf49u6JTBv79iauzZyhQGpgj5PAB4gO6+w/d61j7HzG2vkie9LCJQi/zJOXNdNnGJRKo4+51vh7pO5jxw==;5:KiqbNnF9l3iUVfJwd4QiZH5HeakFQeTPzekGJEdwTEF1m5OE3yTT7sFT3VdXxBo7THaaRdm/gCjqFbZ2WmxpGbEotNNEXCEPfP5ZfxYtEPA3cW5xDhyoJAwCR1rZfPUZcrBIvf+wHRoU9SxYza/9eq++G+68ukWT3FnC4ReX4ng=;7:RAK5HHVKdhbjFNtMK/x7cltp73lcXQxyrQD+aC3fELKK/2C79npG/zmoMiMfiFFciSb94sKxfDIbXi9nfUdKNSrC5/iHf1CttfEjPIwKZWbCa7ICnvRUP5BjYaU4ja2MF32NjpPILnWOYypYYwbKl+obosRRa4KE2iFYr6G3zwiQMzyhErg7P0IoVKE0OLDkvMchR9+PhnlZ2YxV8IeHz39iWcgm9DIiJgAp2TdiOwQbjdZrUPGB2L0VS1EQdfxt
x-ms-office365-filtering-correlation-id: 3db990ca-c4fd-40ec-3452-08d6273647c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08247579EB26B7255CBB1B28FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(4982022)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(966005)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6306002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZZYUAfL/T2kBeJ7J7vGBibspX9/1k6ytUCySgHn69UgXmihA3mCW9mHWb/IkbDIrVu6OfAGxTeVYAh00GguGftk5H+AGFjmnEJBz78z1en91bWdrV2G+3qZN9SXQL+MDBG1tDekyxFeQdq697ZiUPEe05x5/MoamWsAmPPYP1WoHgWqNaoALoixYLUp4wU0aFkU8WZqCJqNCjlJ4UG4w6iZnk5pCvx52a/LWv1BtL/mux9jOONNOAComvU5m+GASd9XPbk00tsY10OKzUrgub+e/JHmFXcIZ6OZ6ny7Mi0fhm+sOPX5aciW8pXWTvFlsQnm60PahmjqFLlP6N5x7pZTDRyT2CBCqrC6bNgitkVg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db990ca-c4fd-40ec-3452-08d6273647c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:30.9939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
