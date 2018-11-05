Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358BBC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BDD2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hjFluxV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BDD2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeKEKQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:16:33 -0500
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:49760
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbeKEKQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eenDSWtrXF88pDBfgRGkDvrsallO17HOuuSlKOc/L6E=;
 b=hjFluxV900uoRKO5+lV4ZKvPMlpc5ss0Cta9Lsh10n5CBgG9G/+zdC9O8YFMAN72ebG2rTdYUGGKwX2M/7LKTh/lyPwdiwcH6WWwaSKDqlARMlOjVaFUwrY3ocZakWIuIC0J91+RmszXLNTy8JsWwayEq5YHpSwahljmtVo8Spw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 00:59:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 00:59:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] cpufreq: imx6q: add return value check for voltage scale
Thread-Topic: [PATCH] cpufreq: imx6q: add return value check for voltage scale
Thread-Index: AQHUdKLNQW/nTu0ih0G26q2Hu756MQ==
Date:   Mon, 5 Nov 2018 00:59:28 +0000
Message-ID: <1541379270-30149-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3772;6:wuJczrUdc6tQbqs3nFQD69QFdcm5lVEsUb4ZFvVHIzOL8H6uYBMreRPc4vVPLPPZKmrUxbFgx65IK96QXRIRTgM5TGIbRzhQ9DIymrDASPR6q3a9InyF2htjdBvl4aQuehLeHRusa6W+smxz1W+89qQDEeKa9bs0pxfEmr6KywuPdoGKtVqmOaZJ5nTyJYl804YftH9Ym88B3JyiOd8sfNVHHvaA7LWTByVcuqwTzB7Z65LgDQG+0fLL6EL0bgAAg2eFKjrdY2k3AzH0aa2mLD3HGIQFPcmZX7Zez4p9JeQnUQFGSepbj/GP8HyRVKcJJdVJu1558KYs3cldrTzVfPvssQ/P1k5csh3NSQlrBlUD8mpRNjuXAj6cvuOzueFo6ClDn1gBvF4bRFpPklN/StNf/gLEzW9jY1pK0MEV4jr4lR3/Cs7tns2p0J6co7HiWVIhQbaF1tpDKQ5daetVoA==;5:PGJI83V6J9T2ERF5TCuyeifmQveA0ppAIYbGR6SP0yI+Gra/m51JDJaV4UtZVjATLMFwoWrwMRg+1ShXx98lcGgf/rV2FSKDSheNCtJNhlCLNWwX3n7EamL+s8j8YUJJZNF2j855xCFQR2CFtHq1ZSXK+xoUTU10hygEwFyS3i0=;7:EqdSzUBAUagAeNZ7Y3/rnINqMVLJag6otVbOyF1gdQv0trcHrJFOgBouOUHFhhlH0LioeRV9z/kdoygREu5F13m8GEJMszIBlc9TFGRshQkz1IdZyxE6BDyG+3fdeTANvhDDTiTdSOZqTceVNMLerQ==
x-ms-office365-filtering-correlation-id: bdd3aa73-7e13-40b5-bb57-08d642b9f026
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB37723D08B5AF9FFE6CF31BAFF5CA0@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3772;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3772;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(26005)(53936002)(14444005)(2900100001)(256004)(386003)(6436002)(6486002)(6512007)(4326008)(2616005)(7736002)(66066001)(2201001)(476003)(305945005)(575784001)(102836004)(86362001)(486006)(52116002)(71200400001)(71190400001)(2501003)(14454004)(6116002)(3846002)(50226002)(316002)(5660300001)(186003)(2906002)(97736004)(68736007)(6506007)(478600001)(110136005)(81166006)(8936002)(106356001)(8676002)(99286004)(81156014)(1857600001)(105586002)(25786009)(36756003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1g7vvxo/PkUprRFQliOe4AdT9WxRIVZkwm4+7q6MtJSywY0lEH7aB+jzyZgyUXmCA3/nnyr0Y6qXqNBl2JtZkkbthZY6EHjZverumRSgu0k8Kl4LRfhatBr02eQ9xnRqpw8QiIfqDa3RCmPEXMAJj1Gh7Dpo7tbyrFi4xVjZh8m1B7f4cqtZbUkInwz1N+9h6pkvSUpHxQ4prPyGUm2N27TtBw8StwmqzWP0XWAXx6o86VQ+6TQQZn+YV5BLJQCq1CnyU+csprqvgJwPDL63W0fp4CUvT3B+z7kCAy9RauIzMusUa333w1YD7srX/gRNp3v78SefGQk3NbVtQi5dhrNNiH8CeF3DeglHEhYKwGY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd3aa73-7e13-40b5-bb57-08d642b9f026
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 00:59:29.2457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add return value check for voltage scale when ARM clock
rate change fail.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufre=
q.c
index 8cfee0a..d8c3595 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -160,8 +160,13 @@ static int imx6q_set_target(struct cpufreq_policy *pol=
icy, unsigned int index)
 	/* Ensure the arm clock divider is what we expect */
 	ret =3D clk_set_rate(clks[ARM].clk, new_freq * 1000);
 	if (ret) {
+		int ret1;
+
 		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
-		regulator_set_voltage_tol(arm_reg, volt_old, 0);
+		ret1 =3D regulator_set_voltage_tol(arm_reg, volt_old, 0);
+		if (ret1)
+			dev_warn(cpu_dev,
+				 "failed to restore vddarm voltage: %d\n", ret1);
 		return ret;
 	}
=20
--=20
2.7.4

