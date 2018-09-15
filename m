Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F35ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC82208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NeLvFYdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC82208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbeIOGv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:58 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728970AbeIOGvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbAZiNiT0gN9K79+HMXUxZTs7MGFKCxxzAtWKlLJqT0=;
 b=NeLvFYdLoIqh8/7aOys/BYy96EJ3MlGHso0KPfdz2fGqZpHtGImfnD/RK1e0npxXG3drW152F3idDrTnhbGdN8Z3YqSOqxbMDMnzIu2ioVBAcum98QjsDWQsOJgo9+IsjCGkGPPkXpk7LP4/cOfzVCrSLSEsQ6KYlAJ+fTz6f5s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 28/34] selftest: timers: Tweak raw_skew to SKIP
 when ADJ_OFFSET/other clock adjustments are in progress
Thread-Topic: [PATCH AUTOSEL 4.9 28/34] selftest: timers: Tweak raw_skew to
 SKIP when ADJ_OFFSET/other clock adjustments are in progress
Thread-Index: AQHUTJRH2JRWu2IX0k+2OewdTBXJeA==
Date:   Sat, 15 Sep 2018 01:34:43 +0000
Message-ID: <20180915013422.180023-28-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:vyR7EDLLvu8mHc6jjonXLyyJWdzYmxqW00Io2PrpumWH7aIaclKx686t9mjiFlJ6xnKFf3wNUNzY64ARPkBw2aIGRX7hMuVZSlBRDlxPP/oX+ndibjWWGc/+Tdp5+uX+vDs36JhIkev/FX3yUdqxjce/GULA2TOV1nD7Dk/3hqLqFU67LguK0BF9FFuTN67DzWflcM5gHSHbSxsHKlOYqiT8of8Nl9p8OKGFaJvo7Y9WtJiliXWDSWiz6q8VlsnXiDqkwlMmrDxs3zLM9n7u1Y4F3ZXh+E5hvVkfmEoxC4bbbj0xfYuhCVvoN8usHOdBMNKxpgGp9kE4nwJaAunqw9UO9ATsCJnYy+BvQ4as1QIDwjX8RiIqxHfbDCDuUEw+4m/5iEJTa0aO97KslmI1z8wl/nBninNaPVERurLs4J/iPTwSh92wcqqGc7H6uO+sG6oH3UYlMlHasuROw9BFyg==;5:eC7Tf3c7tljxGHwhEJSeegwAUTZaJatvm+DY4q+cYJpmPi2xSWaDqG9M2ZparXNfo34BC4hGTyBgjeWilVFN8nTcCWqH1Xm5KNW9g64etnSMP5vZ73hMWmf+uvPEiYX7unPQ3vnEM2BKnWv3s+td9FS8Er5i+S5iewmpnH2k+a0=;7:0wbulZb74yvB2ZyjFnF5hhetu/HuOXMrrCl4SZF311DDI4Y4+EzNvIPzF5s8e9dWYfCDdgG8qYa452IGDDQ9PMWOmY4jiVog/z7To8hBLtqPbhyDXkAJ7L1CznIqwHWA+ZQLplkOQltuJMauTuthJz59WD/hlHi3Y+6LXfxWb/QlwRP2DKa1H+WrfGFzZW+c5JrVh/sW2bB4/4H6dd+TnWMc7s6zzdszWf51Q1rNyN53lM8b9GnuvPNrDkqyMkHg
x-ms-office365-filtering-correlation-id: f9599d52-45f9-44c8-a1ad-08d61aab69fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB082385A9D1BAEECA18D659B7FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(7416002)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(39060400002)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: r+S2AHZ3GZR12CLgXlVsXZ0RPeTQ+sj1Y2f6DskPk7sMgT6hyDSFAxCqc2bTU0bcubggiMk0vWZCDS8RYmaNdJND4mAQRPx8P8rPERTXxsVY52dPar6x9MVhIE3x9McWUQcO4eCUtx9qLiN1DhA7nSSg/VAE+N84EFaD1B7ot2+SN6hFLKzwE55nTQ/ICQpI9f9coE64Gp3+1e6SrKfiDoNpWgIwurNtaJZQTQZ1Gc/liw2xafA3YeftBg2hg+nlyaB5wheyMKonaLbYdNmTAHrbi5KnINo2LFdPIbfU6DYDCmlxOVFEhGsB/1A8CY/54t/FPkk5HR+0miKTQp6UEY51DZb9p3ytzEnJYBskkSg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9599d52-45f9-44c8-a1ad-08d61aab69fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:43.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

[ Upstream commit 1416270f4a1ae83ea84156ceba19a66a8f88be1f ]

In the past we've warned when ADJ_OFFSET was in progress, usually
caused by ntpd or some other time adjusting daemon running in non
steady sate, which can cause the skew calculations to be
incorrect.

Thus, this patch checks to see if the clock was being adjusted
when we fail so that we don't cause false negatives.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Suggested-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Widened the checks to look for other clock adjustments that
    could happen, as suggested by Miroslav
v3: Fixed up commit message
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/timers/raw_skew.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/self=
tests/timers/raw_skew.c
index 30906bfd9c1b..0ab937a17ebb 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -146,6 +146,11 @@ int main(int argv, char **argc)
 	printf(" %lld.%i(act)", ppm/1000, abs((int)(ppm%1000)));
=20
 	if (llabs(eppm - ppm) > 1000) {
+		if (tx1.offset || tx2.offset ||
+		    tx1.freq !=3D tx2.freq || tx1.tick !=3D tx2.tick) {
+			printf("	[SKIP]\n");
+			return ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd=
 or other time sync daemons\n");
+		}
 		printf("	[FAILED]\n");
 		return ksft_exit_fail();
 	}
--=20
2.17.1
