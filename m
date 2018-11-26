Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD95BC04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7458120865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SbKRspB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7458120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeKZNwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:52:33 -0500
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:57305
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbeKZNwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoS+ArSWKFpL2V8lboAdBPoM+ykF0YoAVkybo2JbD+Y=;
 b=SbKRspB60AX6YrGe3CfLpQ5WO+sdh+MiHSKyRpayLzClH7j7Nrz4WdEPxatGwwUwV9H/cxn4ObQCid6GUg1OdchdOtBhr624gCXjwSJVnUANNhNBKjBB0n07cKxlRonwvgqPrfQ25kh7qpN1HV2sZJFYz9qGEilXnqRzIXmUQpo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3769.eurprd04.prod.outlook.com (52.134.71.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 02:59:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 02:59:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] cpufreq: imx6q: save one condition block for normal case
 of nvmem read
Thread-Topic: [PATCH 2/2] cpufreq: imx6q: save one condition block for normal
 case of nvmem read
Thread-Index: AQHUhTQXZn3eaYnau0ao9J26clzIJw==
Date:   Mon, 26 Nov 2018 02:59:48 +0000
Message-ID: <1543200853-10029-2-git-send-email-Anson.Huang@nxp.com>
References: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3769;6:tO8spQ7MYGXfvBDSZRfIsjtBxHaCwPRK4uUv1q0gclZXI87nUQLIWBFFp3WHTJdW4C6cuogtCGCA+Av+uUITM++mQOyAmGrZINstkbMqaO564KBs7WOaJjNg6jQtTFsYt+Oy9wcseE1jZl3NWDHQaOJ228auBl0EdNtB8xBU4e3NZJT1dPUueXNe/R/y01OWKQJqiZ7tgPRC9xshyquGGCBMw2KPkUjv7vtnK8xZ0zBUws08Qv/DU6rgCQFb45EvZtHlb+cuSyXkQrpLbR2ZyzIbCBLlUKic9XR9magCVDqx0rzY90VHOyVWZtkbGzH6zmuApJpmLoKKDibyhz4LhHHwiBK+xZIzjj0Ts+FeIgvzkUm6rj0zNJRipsUsFZ5mxJaRJkz2utUiqP8cvPeN3jxiFsVc81gH2DUmfJVSh5HQ9st0zqvVktsSlR7DbM79B5wbyFPwRjjYdBHanQD+Jw==;5:pTgkyOslXXzOdUw10V8T/uJ6Klwz4+meGZX2f9bF+7Nr6Z38Vka+F1e/6z4Xgw9FbBilwAzbUEYcgl+DWlVtakkcqTCy/nLpi1BqOHowpx+UE4lJoWFzFNDtGuwzRNOxXJWxHLPXN5sHJZ4j/Es1+IISPuQ/rXHpRwDQwaQ/SA0=;7:k3ZQllyKvCXjnlp08MfXf3DrbJCqqndfT5cCHu4wPHOjN7ahEYvnVUK/NenryeysuErebYgGD6OoxMM/T4XDJ/4LKOEcHjyAo4MXCPrGOZCDtOhJN1a/spsFMmv1mxOnwmASIMLBaamCcmAc48w/SA==
x-ms-office365-filtering-correlation-id: 01646419-7c8a-4db5-8658-08d6534b3a00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3769;
x-ms-traffictypediagnostic: DB3PR0402MB3769:
x-microsoft-antispam-prvs: <DB3PR0402MB3769AABA2188C1FCA858A9F6F5D70@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3769;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3769;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39860400002)(136003)(189003)(199004)(110136005)(316002)(25786009)(2501003)(6116002)(3846002)(14454004)(36756003)(478600001)(97736004)(81166006)(81156014)(8676002)(486006)(66066001)(2616005)(476003)(50226002)(6436002)(71190400001)(76176011)(102836004)(53936002)(26005)(186003)(5660300001)(6486002)(68736007)(4326008)(11346002)(446003)(2906002)(71200400001)(106356001)(99286004)(105586002)(52116002)(6512007)(8936002)(7736002)(86362001)(6506007)(386003)(256004)(2201001)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3769;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ww5WTM90Cj4wWi0s+t33qp1RMHINffQvsIb9+HOl/2kc5eUsSimMZOnd/SQ0pd7kIC3NVIg5mq9gG4bz49Qqy15u57ssyBWnTBHsAMkU1EPny7He8dnylsisHciPMYLPngozRZa2GBZctPp/+7+m/hpYrWpR0f6LRovcklhka6YrRoQE/wEepeO08pDZKjHnQTwc7PCilrVRqjFh7X8x3gKUR6VU5hbB37tq9tIOke5/KsekT37/9VwsqXmB5sp2PQRIQJoM3iu2+a3juMjspLW9sthRP3O8T8vj/ChWHW0D38Z+MJh94CaTxYT153vClnrCrBKA2Z0t5id8lw6qUBs4RSEOKpHQl3u2Ny+WkVk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01646419-7c8a-4db5-8658-08d6534b3a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 02:59:48.4175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put return value checks of calling imx6ul_opp_check_speed_grading()
into one block to save one condition block for normal case.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufre=
q.c
index 8cb9683..9fedf62 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -405,9 +405,10 @@ static int imx6q_cpufreq_probe(struct platform_device =
*pdev)
 	if (of_machine_is_compatible("fsl,imx6ul") ||
 	    of_machine_is_compatible("fsl,imx6ull")) {
 		ret =3D imx6ul_opp_check_speed_grading(cpu_dev);
-		if (ret =3D=3D -EPROBE_DEFER)
-			return ret;
 		if (ret) {
+			if (ret =3D=3D -EPROBE_DEFER)
+				return ret;
+
 			dev_err(cpu_dev, "failed to read ocotp: %d\n",
 				ret);
 			return ret;
--=20
2.7.4

