Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF795ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB46208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CG152MDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB46208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeIOGwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:36 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:18669
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729491AbeIOGwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbAZiNiT0gN9K79+HMXUxZTs7MGFKCxxzAtWKlLJqT0=;
 b=CG152MDZZbzi8EN2wUzehefWazPOfNNRwhryyPjRWGMV92J4pcG33kDLiy3vhWB96mVWsvgiErszicBgjV1ZOLdXB+Kz63j0phmNVblc2t0L0BiSvalRvk1ogF9n+6SfZkGIh5r8y9Q202ZZXJ0Y2cQKk5fS592V5AQd6GoZdEg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:23 +0000
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
Subject: [PATCH AUTOSEL 4.4 17/20] selftest: timers: Tweak raw_skew to SKIP
 when ADJ_OFFSET/other clock adjustments are in progress
Thread-Topic: [PATCH AUTOSEL 4.4 17/20] selftest: timers: Tweak raw_skew to
 SKIP when ADJ_OFFSET/other clock adjustments are in progress
Thread-Index: AQHUTJRaBlc2aw87dEeBJuRewV4hlQ==
Date:   Sat, 15 Sep 2018 01:35:15 +0000
Message-ID: <20180915013502.180110-17-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:4p3unzcnvnabb1l72J+3cXf9hgNb9w9f540+twfumXJ9t6HDQtpOgdlIPziM1wZMd2WD22EvbkCAgMz/8cPAhU9aP680n1lreu2GuwmvwNgChbADPyIn8p+Sr4d+gTalqVIzl84jHOh8ERipAEE7CsXf69Nb8lHSbMMSf6E2LiUWoK+gw72CNiwEZSE3EdLciXpo2pm0hTR8UhfKhPRsobuF/GY7EwZpEIE+zrFvv02RFxNfNWxxu7xg/rxAlgrEmGOPG3hh/qEufU7+p5gM34AIirNGoGsMN9QMIXxUpOE+y+uVBOQcapo313KVERduSWK4fvGMoX9h6Dwnoi4bRl4MuZtOermVOHTh4lh7+bTWhn1OVwR/RgQMDf1FpCSeyoNUaQxZQJ5ETTCR6oHb9HTRdr5BHEGU3vgJM6GV0BQCJPKvPFRXkv1xdQJ71Pq+uGEnMLQL1ATcn/mVWLIuZw==;5:M8op2pwu8tayg3978cSnkg4FNpC9RbDkNPM+IbeU92aLj08tYJjD+Qa3JjtKBvdnia0LNtkOWPPykwtxNc2yiW57PaUYf0k+6JPdzxDy7834VAF7l7/3jrhYvghUla7roISFyqZRVulV2aDvwmSos0zfNrXdxmlH8qxgvRB3Ph8=;7:qxCsoBX1GxDPfeiTzB9fRcb72kH3oDzNfpFUvx0hhI6B5bIWjcg31bH091LR6abXL+O77Ra9bQShp4sllQz3WMpNPGAYOghbJObFm/uREaid5R5QMtWCn1fQpkdItJZesUcDmKOQjBjlVsQD+StQ34pJ+y3O1c85CNxwxwQfMkt4Qrkvq/6fc1BmsJOQdxof8R3Bq6RMFAl/jhZfH0FYt8GG2a0owETzD4Ajx2kwxJnsvMS5W/tnYS3DitIpdshP
x-ms-office365-filtering-correlation-id: b6a3ac50-5bd2-45a6-5181-08d61aab8164
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181AB571F1EC95F0892B6EFFB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(7416002)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(39060400002)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6ziX5Tru9VjRjBD7wnh8Asz7WnU8TdTXj/d9XLwt64dcH0inj+3Nkd/iWpjO5iw95yh0fgthRfWOFIJlw1v1ovVzZE5NCNhjphvbuen7pHBuvjsqDrKypcpKDatZDC1hXb3xye/kIrgb0DNVYEsKb9fD6Hf83oskYNUHVlfbKfEg1OMVvQLWPiMRtnA/M/Ji2IsV0lD+mLE1TX3q+4mM0WPDlF4uwd6EPACAfLkG6ihpRgOSXDmY9QzOA1CFubiVki7XWAMe5cEIdgzq4W+9dWqI6+PDtPru0xW4B4pDuG7KQ7845lbT6I7Rqv8grgXtm4eUcxpBCUCwU8nxBDtqKqT0kRo90jKXldvOePqi9Sk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a3ac50-5bd2-45a6-5181-08d61aab8164
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:15.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
