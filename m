Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3889C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEBB20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c339tSuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEBB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeIBRaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:22 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729068AbeIBRaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqoJIQZDvwsnJbbXfRiECe2WlXAqQuUzNxA8Naw4FXg=;
 b=c339tSuR0XCMySITxDDOlPQSmR1w/vDEFbYKua5ohJ83DBcky6YQTh5S91lULkqcFXalnNd3ONZkUc+DlvyCIZV4/p1jypLwWodwqM6tAGuyEwP6og54STQof3yLUwMDcSml+WyEfEdk6SOA6V47MC+SCGZ6qACsTq8sLu3PIqc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 23/62] ata: libahci: Correct setting of DEVSLP
 register
Thread-Topic: [PATCH AUTOSEL 4.9 23/62] ata: libahci: Correct setting of
 DEVSLP register
Thread-Index: AQHUQr7hJ6oFiZZcjkSJ0Jw5EibKEQ==
Date:   Sun, 2 Sep 2018 13:14:29 +0000
Message-ID: <20180902131411.183978-13-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:G+lr8Mc6b2aqtSfj9Ce6xjZL56Za9tgABrH+RBUKH2R22MS1DfsprE8BY3pcjydQa1+260CGIlhMnbbPCR9eIYYeqPKIP22kbG/n5kIhbwECSN6ClLkvwcgig4T4Uep6v1+l7XrjsmddV8X1kYjwMl1v+y022ZZLiyWvMXM1YDH/Ykxbz81f0I4+v3MeWT/b4Lx19YPyD6PjUm6dGQr4Kt2XUpK0gViVph3cMB23lXlD3I0NoX7A+E2tvL1o2rdHrn0GDPK6IzQz1HErkwm2w2wCPFrblXGRksfXzuLOLslAq5XsJvSTnKJqF1zaHJ4ka1xS6HyR3wAdtUImqc2b2rlG5X/GWXA24K9P+bmxzc0vZpdC9bZevB2u1d/IQddjdlS82Jjx2lHNu5PGbUbn9uqpDxH6XhPJEL03Ex2TNgryR3ARbL9o1RUjBMzDRBlniNAQrXJviOYKBpO2FAKz9Q==;5:PhwitR37veSCR9mAZ6F981/UtM3J6gESSI0dgqKK/9UmIUj1xM1yLt6BM8+T0s7KLhKm8qA/HFeJyVXvcKv+0wbvoGkRbeRoN1fVhUmFxzYPoCDaPKtqbKo1x5FZPQeD5qF02YtFtEyQt05Y8DqNOUMavaAtlQQVS6hhrgypULQ=;7:J/pm7CpPRrj8X05vf8RupISitR8SN9lvJeEkif23csWYn5HcUyItOSs2zPeNL4A2gnqZ0ke8dMaqC10wke4/sN8GRwabtWboF91pRPQeFxSfTnqmsEuqmH98eNrjVSacoUYxl3e3RnyJ+W7FH1x8JRKM+yTj/olp40c2jyelL6Id8aXP/b0PZfumt4HqDpMDtfRtqKrkDCKdRwiD6BOzYTYs4/M9vSpCpzBD8jmUpfTmydxPxzOEJfvZEOlurA2L
x-ms-office365-filtering-correlation-id: 33eac829-dd9b-49ba-1843-08d610d603d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01207C0B418B0015C2FA70FDFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(270512070085399)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(966005)(5250100002)(22452003)(97736004)(6306002)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Px9jMRP7KkyWtVIYAe+wlaTOVutG+EhWEqya4LMQmb/hx+xC7Y7fBan119ca9RUyO4vv8BWDeQ/sP6yDQZqylXQbc8Unn0NhNt8l+IKsP2bwqTBL95iIccWmBqn2q7RsWo6P5R52sVmv973eMqy7HJgz5+mBKs+QbVamP9Le4kfHf3lD4pN7sI60AWnG6aijY8aCco8d4V4FfUhVSGWqfl+beY6jxjkcoDsY4VhXi1a0hgQHpvfXLXT9g1HF5L/jCTuI6rwjA5MZszwBjq2EhO61vEva31Gzoux7wLhx7j7KmAn2DBE7y4g6tCnoq2RRDdgZZZt+WY4zmj2tfuE14CDwz3hjiRhv38qq5rYC/4g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33eac829-dd9b-49ba-1843-08d610d603d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:29.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 2dbb3ec29a6c069035857a2fc4c24e80e5dfe3cc ]

We have seen that on some platforms, SATA device never show any DEVSLP
residency. This prevent power gating of SATA IP, which prevent system
to transition to low power mode in systems with SLP_S0 aka modern
standby systems. The PHY logic is off only in DEVSLP not in slumber.
Reference:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets
/332995-skylake-i-o-platform-datasheet-volume-1.pdf
Section 28.7.6.1

Here driver is trying to do read-modify-write the devslp register. But
not resetting the bits for which this driver will modify values (DITO,
MDAT and DETO). So simply reset those bits before updating to new values.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/libahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index d81b984b72e4..f233ce60a678 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2132,6 +2132,8 @@ static void ahci_set_aggressive_devslp(struct ata_por=
t *ap, bool sleep)
 		deto =3D 20;
 	}
=20
+	/* Make dito, mdat, deto bits to 0s */
+	devslp &=3D ~GENMASK_ULL(24, 2);
 	devslp |=3D ((dito << PORT_DEVSLP_DITO_OFFSET) |
 		   (mdat << PORT_DEVSLP_MDAT_OFFSET) |
 		   (deto << PORT_DEVSLP_DETO_OFFSET) |
--=20
2.17.1
