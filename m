Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB422ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433AF21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HyCG+s3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433AF21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeIOGsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:52 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:54496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728900AbeIOGsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sueif/pPx8V+tRejy0PNkPB8LXBoIiVBVjBFHwYOFz4=;
 b=HyCG+s3LNBJ/VRq4TGGXbujF7gPAWHAPYeA+HT3AyPlTGN+UQamkVEo/DlZMIuLM925SQ1A9hGlwvTHBuo5s1LCQ56zbcssqmBcslBxIHqZQkSDWdX+IgFHqExiLuwyIqfetBxpl/9iD/ekPv6A6PdTEdM2hWlrv9VE34kFk3Gw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:36 +0000
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
Subject: [PATCH AUTOSEL 4.18 75/92] selftest: timers: Tweak raw_skew to SKIP
 when ADJ_OFFSET/other clock adjustments are in progress
Thread-Topic: [PATCH AUTOSEL 4.18 75/92] selftest: timers: Tweak raw_skew to
 SKIP when ADJ_OFFSET/other clock adjustments are in progress
Thread-Index: AQHUTJO3P6hK+RWZ+kO9xo9VBMkWtg==
Date:   Sat, 15 Sep 2018 01:30:42 +0000
Message-ID: <20180915012944.179481-74-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:Blt0cJj4yDHHnsaNDIbvvOBENm4zF/Rf084iiXbU6HjNZ3dCk+qfZttXbJpSWw1+TQluKA4OssdMmwW8wYEDrPe+YKCu8WTiA93soWzjOwWapctwlQCJ0ZdC9hAB+FaDcKtjzqzmm+RocIDjhT3Bd+lt+qI0ynF/fWQ/WusSMu2M1e2XQLe9+OS/N2ezx+ju8pl5DQMil8rsgSNFBaQx2qrjOfSKvGURKQZyUJZiuuIsA7xlDcEOA+zB/RPIXl5SC6sU98M53AvO8XvNa1vGcsMyHxkm4T8MXCA1K0DQpQ1U/GglMNN8PBPin7p2SNoijYh7dHuuaDYYkqlVRi9ivrEkGShJ5fYaNlDE8qU8JTu+eToFQKKVMKXwSPYb+qtRH5aRJw3+S/K4JIKeJetOYUf98e2/9k3Wivfq+FIG8Sj8bzqSV1Xng6yHABfDB1onaHFRiuYxD3vPR8fKsV+EUg==;5:z3tUMiT3jurZKUf8jC1yAh6PuIH5tpkJeYv58O611/pVPo3N6fIRTSD19X40eG1DMP9DfegRyZKrnDr1LVbsAZ2mRitKJ/NM2aUQYhXq1tPCQ54bQpkEN6Pb3SGksLeI6YBEW0rz1Qs6kvSOOE2RuSR7njeo24zZjFCq73VlM0w=;7:Wss3Q6kw+BbsM0Z9kniTqsqlZuNKzYwhVzNU6CkHYGu2OIDy0t/SdKW+ZM/tj0GY4EKAwKg1O49Ru95Z6a5CjpPh1cuFePTMFOuePdO6V/pRsS+/VFr+ZLLU0ASuWGA9c9vw7+Eoszr/F8SIlJTS/evtx4dYwE7ISHsjTGaeSap4AovGMBoOW5tYtWhIv8T6VC9sKb44K9bw3WZGGf05qqCZfyQkTlKpa6ueeEeukMtp33UXBTD74RwvfiWC5vAb
x-ms-office365-filtering-correlation-id: 2c6aa5d2-094f-4162-b631-08d61aaafa47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB04709B213E91591F3EF2C8FBFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(39060400002)(7416002)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: epwlNa9Cxff4LPw20vkmRl42cqSa7W9xsTM20k0qrokI0DBvZ7wEjAUUEY47NPJVPVaewI49t1Ei3GogqklWupx5LK2ZHS7x5jBzzu6gDYgHu4dRiNfART0LG8K7anwHd3G5dV53Ybus2yzaIVqS62Nmp/8tILyKMql11Vw3IdcfGlBZ6CcDBDZ8+ofPr3jm1LZmU0ObSMbZU9UYO+7Q9JHmOObIkogawbbAl2Pywj+/B0q/sW+K0UNDvERJtQGYILHU0J9k78+OEVpUULSv1a3YNxxGVGFqnrrtAFZrPuw4R/s3xeXCNKWO6uw+CZgJyaBhrTq3WC0dLVSPWZ7Zy7c7aQyZLSWmyGCkElNRd5Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6aa5d2-094f-4162-b631-08d61aaafa47
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:42.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index ca6cd146aafe..dcf73c5dab6e 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -134,6 +134,11 @@ int main(int argv, char **argc)
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
