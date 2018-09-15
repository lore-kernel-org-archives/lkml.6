Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B25ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4895B208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DHEa0x5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4895B208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbeIOGuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:35 -0400
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:42981
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729464AbeIOGue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sueif/pPx8V+tRejy0PNkPB8LXBoIiVBVjBFHwYOFz4=;
 b=DHEa0x5gBzK6gMLyTohdiWgwg/J7W6vDnPeNlWQaKhNkL9MHUdpiSDCHnJvRWGOG3nDPwfz8dOK293iQICF+gmbuJjv3iKmqeuMqee3Qjx+cBgH8tIB10qkEpk/YXoB21aE7cQRA8hoj4pfl4z7v8eKGf9YaEPKqoSJcMRTBctU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:24 +0000
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
Subject: [PATCH AUTOSEL 4.14 47/57] selftest: timers: Tweak raw_skew to SKIP
 when ADJ_OFFSET/other clock adjustments are in progress
Thread-Topic: [PATCH AUTOSEL 4.14 47/57] selftest: timers: Tweak raw_skew to
 SKIP when ADJ_OFFSET/other clock adjustments are in progress
Thread-Index: AQHUTJQIccxy9zzms0uLg4GDlrOaAg==
Date:   Sat, 15 Sep 2018 01:32:58 +0000
Message-ID: <20180915013223.179909-47-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:zxjK46ENT8ROMqKvdSEX9lZkW1zXL3lbxZeN5SWgS0eWnNWFDD8qIPo1w45uK2ykAQv44eAwJSGMg1Ert8peN/Xofij9QjdFs3y5f8V9HEHe4D4zZ0FP7eXjLgm45Qx7BK8qr3KNLmbB8/DLf+3EWdy//6Uepv2FoK4pPrArS330UlnpuldOx2HTK64famUyfkkH++DVTxytbeFVn9Z3ddSdJKIiToqIcqFWjisiHyoPDVfpmGLBzsyYBzMU/JwgGK3l6NhO3M0FICBntcZWluKxbdBU6jJ8SuB92vmWxXVZOIof1poTOpDvjCnmO22Uyb/VIne+jFJjfq7nMkhHK2zLJYFnbU+VYumAPlI9XTB++Yiv/PBbGEURhQ3Dw71spwnLvOlHmNdu6Ozjz/aRDoonVlAIkkYDajSQDLe9eW5xcBjj0QTuZyEzgG5SVe3WYAn55wJovz1xbaO/C6BcOw==;5:XH+UjQiTtzwqc2ZBd/0EANqu8o2J8uiT6s0X7TiIiraJzKOmJjiBGx9iP7aieBf6rmi5xs4Mv5DxOe1HHftdz/pY637JanfKlT0QrYt/pPAawbVtx+pihWkDjBvovuRkjd3mQMs/vNK+FNVURgigNXZ8rhyOnaCYIaRG3TAvCos=;7:TUG2yIsjYQSstCpBpUurtM8m2ptst5afhlBWLHrqgUdcj59V3iKc9aDrkoqUbVP/8lL0G/VijfMvVOtqH3cawxRwYZR7La2/u6XFtfJ30kREerOFfJcF0AC3MBngunfxcgDzsnaomE+4IGdSKGQVssHGL0J/8GRDyZr2/4UWOxKz3zye551FB7EANgzmw/vyhMihlF/zgnHZiM6KBQcQG74fP6R2QbpfCskocINI5qseC13oK+g4ZBpikaoLtnix
x-ms-office365-filtering-correlation-id: 5deb6749-db1a-4727-6fed-08d61aab3abe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB047192898C945330B57177BBFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(7416002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(39060400002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: N6VcWDw8TuCSWPJKDfFZilHV2qb+OKCeebUdp8RMWiML1R/+c/CZC4Z0gAgGFDemnbTRSAUjtNDlQ4uBkgp+uMu4ZG3v14hI7EifiH6LY5zbr8+Y+fv3A1HMbJloGLgqlQpT5p+a8/OM0R31rqKvR1poGR0Z88DDmJEv7/TIcan4R5G9IKlj3MUmkbng1jmmeugOpGZJHV5pYMHcyjMt7RjjW8Ffmo/pycSzMwrgZVE+jleAWGgHzcGDYl9TFpbrm/LPj4elL9N9kwm0vlTdIx/e9hJXY13KUOtVWK4f3pvOnXfM+QY4dqDQs7Hodm7Yq4xPdLneS2ll8RllgrBv9EYkxFHaa2PhDVsGG5IekuQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deb6749-db1a-4727-6fed-08d61aab3abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:58.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
