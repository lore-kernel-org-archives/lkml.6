Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3B8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5F420841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hQdDm79q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5F420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeIBRSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:18:47 -0400
Received: from mail-eopbgr720097.outbound.protection.outlook.com ([40.107.72.97]:28208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbeIBRSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVZFUSA2qSjxqfHZ+h20RBGuyxbBEPQKxnM+Y8l4n+I=;
 b=hQdDm79qsYsEEvAplGbou1GBote7tLqwtPt8Q+cjRXQjTC1w3mJ+jr9WiCkU9VnheLjCVr5jDkWOIwjhk5AWyXl+5/S4Jk6DP3lgIK4pvvO6n8Wx+fhUDEVbT5WUfhwaCCCXmxCQli0vqVKEkDearvQcygkmN9ARI8vQkhYBO5c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:02:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:02:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vlad Buslov <vladbu@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 001/131] tc-testing: flush gact actions on test
 teardown
Thread-Topic: [PATCH AUTOSEL 4.18 001/131] tc-testing: flush gact actions on
 test teardown
Thread-Index: AQHUQr1FhJFDZPfy6Ee6QGdZ0XtHmQ==
Date:   Sun, 2 Sep 2018 13:02:58 +0000
Message-ID: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:Qr5xZzLPdloETO3WTBxp4NBiQlc6Ovcj3mhCXd5lyxILBMl9prsfmXy0cTfcGdAK3RH0t1Kp6vYC8EPzvebwdPQA1ct8YEzm+Nlh4CDNtU86RF4Y4HBhwq8V6zBOaiNc3tqVU+HmnPsv+My4BbdOMBaUvz375VX/5Ha9sfu8gDEj24s+UZgQNKg57vHSrIPIWd3SQQrUTz0kfxAvAkuFcPa7rCgnSE7arq3tMUutISegGg4RXIVMtt6bxkM24/TZ9eW/cX7RYZSrLw3Vwc5mylX4Rv00hWEUpAx5hcSPH5KLs3NrgmOqaqyaA+RkEOjJP9RdwEwTa5MyQ7d0QJNA5ej4KU3WMsgOqAyZg8FefNNEotMsDLuQWcoGLhycR7r5cNP6G3W+IelDJDZv8EM1Ql0m/QKVp/ep8acDPaJ0g6u6UO19JOAJRixnU81IDevK0wYHgtx47pl4qDB3zX1xAw==;5:tZUxkXDf+hxCjlM0Jxvv1ap+tOlJJ2D8fBbmOARNEZVeAxAv7YI+GItKJgpEEMFxb0dNd0BG969/lq5KL/k1ssCbtzJhQacf5YCm9lnHYB5Mel62bl6sx+LvWrpM0RXongYpHVJ5ibliYCVcliVYaqFZIVCxpXxUy5NR5Rto1rw=;7:73MxnhVtEwb6PRq2ga65ijwEvF5x/BPPakWI/HVTVaOvP9Fsy3HJX+cxtaVXk+mRD90CF3eSG93g/QGJV7Sa1HgfsrZeF7QkGkT/BL/F0rs6OvyTSpL/XEwKu+tpu+BiL0I/k/2GU+UH9KjV9icwHz5EyXUo+wVlrK0MCIaKmuoLfUFrejMwfuPHHoNl5J7hfyAw8t5GZyrIbKvyO/kFCqyWSUadq36yG/RT5/1vEbjUF1ghXl1i5gH86c+qdjbF
x-ms-office365-filtering-correlation-id: 05ec44c1-b3a1-4bcf-46d6-08d610d46862
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0837A11F4E8DB287A6CA6E9DFB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(10090500001)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(575784001)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n1TYGQ4XT9ERUeKLiCrYYwBodeNSC3hI0Q3WefaJaEUOnsAlDyquQ50QGsN0eTV9g3rv2ArQNrPOSwz8htDsaC6Xn5kAe8Kw818S3rAaswTkri89rLRbY9yfWvuFn3wEcaCs4y2LEC1TlSHfLd1GRaI4ENY89BF09vlixGVweBwSp3gbfHTMMKs/ugvDs0cAStfLqppNs9HAl4li1kOHPYrZhEvLTIfX4YTvEbPQSccMIdGv2PdWsCLRjoRrW2FTbrhDWpAwDS5K5Qr+WKGM/8cRidVqyHaCQM/7AsDpwCwZAB1EfVusjRx+HZn6CB1NXvcWXIpUDptGR6W3z0z9PPNQjpZPmGEoYDwpI7eJidM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ec44c1-b3a1-4bcf-46d6-08d610d46862
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:02:58.8695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlad Buslov <vladbu@mellanox.com>

[ Upstream commit 0c62f8a820b7fdeacf5ad9f9e24b53043d372c97 ]

Test 6fb4 creates one mirred and one pipe action, but only flushes mirred
on teardown. Leaking pipe action causes failures in other tests.

Add additional teardown command to also flush gact actions.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../testing/selftests/tc-testing/tc-tests/actions/mirred.json  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.jso=
n b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index 6e4edfae1799..db49fd0f8445 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -44,7 +44,8 @@
         "matchPattern": "action order [0-9]*: mirred \\(Egress Redirect to=
 device lo\\).*index 2 ref",
         "matchCount": "1",
         "teardown": [
-            "$TC actions flush action mirred"
+            "$TC actions flush action mirred",
+            "$TC actions flush action gact"
         ]
     },
     {
--=20
2.17.1
