Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7F2ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02A820866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YiN9vRgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02A820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeIOHCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:02:55 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:54496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728325AbeIOGsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GTpmL07HZ5qvfyx6Hk6XgvkOSRdUpR8KTFfLKgcIW0=;
 b=YiN9vRgE4kwOe31Y/T5XF3Tw3t4QjnxsfriBM0en7Rh7ywsUqviFe8I77O+NAOpHM/fOFxxoI/MYJpqAASOxJcukCZg6ZlNcIM7dfTutJCctfzq5qcZVF5loEoj+nzL8+X4XW4kShz+6s/T5isiGaVCjGRss1VRHZcOFx/r134w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 78/92] arm64: perf: Disable PMU while processing
 counter overflows
Thread-Topic: [PATCH AUTOSEL 4.18 78/92] arm64: perf: Disable PMU while
 processing counter overflows
Thread-Index: AQHUTJO5J3H8StvKVke1H6EmYtuycA==
Date:   Sat, 15 Sep 2018 01:30:45 +0000
Message-ID: <20180915012944.179481-77-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:++NQfwfX5MLFfUFsJKgP4j2qCCuviXx9QWmcYD0KwJBYrMgMgfVtyiG6Jz49BfrdQgCXHCLEd5KfHCDo6Ct0nIdE5XJf9JTQl0iFe15VvQWgZ28vye3rtwN6fDlsSF4Mv5X5rHM847uSKxbQJ2K1+p0Yi6AMo3FRPqE1LuqvuX1itHBCH/4Mt793Qr6C1+bFwsQikCFfHidbHz7EqPzEj2m1M7MmJ/a4odu0HCUqeKc70KoEWgps69xo+Hx7eKfQuYCaW4ssxZDA0sTb/oMh9+Y7wo4g1UJjqeHW7roMaUri8/AYQIQpIkpbmLEjz9HTTIfXprZbxi/SnB6H8sFLY+f4LqVcWJCrE0IH0vl6wY+4/+CTYQohFr0it8zarjKRY79YEFtdkPRTK2NWimmNSSLgww88IyzAU4EBDdTeDt/1zX3H5rKubdNtifyY1MJLSGvXDIIFCEFBeW43OvEaEg==;5:tlYomP/K5heT4rxFsKcn1PyrcZpK7pUNdy0JJBUBBhfgLd4UDQMLAZEqrl+JCEv8HR0ICA3sAEmcZEmwYeFAFitHirp6JX+SHwWFZYy9DsdTmE7ao53S8fcQcQsIUkhnl5giHWgb3N5rQTWSTxDPbhuRhojjmvs6cuCvcubhFjk=;7:bBi8k8iwGT368+x7EVKgRYtI2UsEWFSnIfKfTaha7WOiW37rwGuN+fhzu9CI9NyAmFsFISRxTc/V2AUv1diJ8YRitFripH5HSB7dRSwA5Xgki0u27MejAoYGFyw4nl4nKYWXfmOSLeaR+Qi5gZA2i3ipBWZZsty2NSBoUHtliLcDf4GRqLlZzi68yXgeTIIHxBmn4JD/T11jW+/L4Y8OoP9fucx1A2cnW/S5o/h8Fj7wQe/FuyAMlwVT9gQdSw3e
x-ms-office365-filtering-correlation-id: aa6c7bd0-61ba-486d-e897-08d61aaafafc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470ABB37457548AD3F4E294FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HXYPoT0vHCrCqOLlGHneIAUZhe1TlaF/T1AS7/+M0WpgW9rOIZE52iEjpDX3fLTJ8u0ynT//AEvdrDgE559Zm2i/rl5JHbeqvylvFMhImeFIS7Topsg+1tMXoDqJBrjjEz/TwnzMXaS0qNgrAU9kVlIW12VeftMmUE1J6EvoyWt25e0a3K9LNBVlxlgYXOqOw0c3l3jneW+E1cuIWNGA0UC29/B19HSphrMPDkjbrnTNpfs85P2Ve2qH6eCXExiOHjU1yVaQJlvAgY6Ghp6toUp9lsZ1mux6T2llsOAnDIbXyNqbF0/dbB3I22XcTlJj6FxGxZgZhB4xwzU8NI8NhXUNBf9Lx4WjZ8kidsrYn+Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6c7bd0-61ba-486d-e897-08d61aaafafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:45.1979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 3cce50dfec4a5b0414c974190940f47dd32c6dee ]

The arm64 PMU updates the event counters and reprograms the
counters in the overflow IRQ handler without disabling the
PMU. This could potentially cause skews in for group counters,
where the overflowed counters may potentially loose some event
counts, while they are reprogrammed. To prevent this, disable
the PMU while we process the counter overflows and enable it
right back when we are done.

This patch also moves the PMU stop/start routines to avoid a
forward declaration.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/perf_event.c | 50 +++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.=
c
index 33147aacdafd..dd5b4fab114f 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -670,6 +670,28 @@ static void armv8pmu_disable_event(struct perf_event *=
event)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
=20
+static void armv8pmu_start(struct arm_pmu *cpu_pmu)
+{
+	unsigned long flags;
+	struct pmu_hw_events *events =3D this_cpu_ptr(cpu_pmu->hw_events);
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	/* Enable all counters */
+	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
+{
+	unsigned long flags;
+	struct pmu_hw_events *events =3D this_cpu_ptr(cpu_pmu->hw_events);
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	/* Disable all counters */
+	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	u32 pmovsr;
@@ -694,6 +716,11 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu =
*cpu_pmu)
 	 */
 	regs =3D get_irq_regs();
=20
+	/*
+	 * Stop the PMU while processing the counter overflows
+	 * to prevent skews in group events.
+	 */
+	armv8pmu_stop(cpu_pmu);
 	for (idx =3D 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event =3D cpuc->events[idx];
 		struct hw_perf_event *hwc;
@@ -718,6 +745,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *=
cpu_pmu)
 		if (perf_event_overflow(event, &data, regs))
 			cpu_pmu->disable(event);
 	}
+	armv8pmu_start(cpu_pmu);
=20
 	/*
 	 * Handle the pending perf events.
@@ -731,28 +759,6 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu =
*cpu_pmu)
 	return IRQ_HANDLED;
 }
=20
-static void armv8pmu_start(struct arm_pmu *cpu_pmu)
-{
-	unsigned long flags;
-	struct pmu_hw_events *events =3D this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-	/* Enable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
-{
-	unsigned long flags;
-	struct pmu_hw_events *events =3D this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-	/* Disable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
 static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				  struct perf_event *event)
 {
--=20
2.17.1
