Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEEDC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA9720856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oLU3uNez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA9720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbeIBRfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:35:34 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728716AbeIBRcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCbASZUWZvGbBVmOu/RONBbuHc3to0iBvhxqZsyetEE=;
 b=oLU3uNezHakBIU2lbXEt9Ti+Z//H9o69kGKuWlvlxhegEPMgoFFc3ngYhf/M6/+gqejiI2wAQHbGKo7BBibw1dMUCx5cH5XWn7aYz/xm5ZYnwTwOHAaFvqXHRkjssp+eC0aCDUyl6deJjlLpcFAKpwg2vxH+xgsAmLriW00GmPs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 18/47] ata: libahci: Correct setting of DEVSLP
 register
Thread-Topic: [PATCH AUTOSEL 4.4 18/47] ata: libahci: Correct setting of
 DEVSLP register
Thread-Index: AQHUQr8VtxPYRQJaHU+/RK0h/pyQGQ==
Date:   Sun, 2 Sep 2018 13:15:57 +0000
Message-ID: <20180902131533.184092-18-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:VDWPZoPsfYZjycsozGtlWZSklXPtFJ3s8HmsWrkfcQSg1ooVU+kWIowSGaiZy2EC+ncLEj2b84QNWHP9VTHzFxNOQ5uslWS5x2DJJkU64I2fQ2mpDYbGnmI+HbNPFcSrGXloFjrlyCD/MMCkYh9BpsvCy+g2Y04R7oABK5NpzW+a0xjNVC30T3xno25XsJKsqcqxCtj/+e31LafdYTHe4yI1/Erc1Tjo2GJtszTrB3vnM/eVu0GwaXr/ZiY6C9HZclbAX4tz5rIZ+LDZtzhNUIVl5DANwrTEu6O5sjpLsm0JSi//xl5GIqvhE0HbvzKi1fZegFVg4vufb4XZum6952Z2CpuA7ij+nBr6YiPc6AYZsdwcQTk8aNInFm5kSpqTzja2eq6M8ZmELLkeCe/yUmBOarYnXuUv3R2jBHj4HnnklMmI24H8M8SJ61XfKyyglkngczGHGuXK+EsVu2Ks7A==;5:qTGbpnpn/VJK1V7RqEKqzhrJYYQKcXg9QA8pLojydA93bSawtmPx5C5sE7Wv6yAq6uXaLCGLV/zXtsT+ve7h/peqx4QIqG2qT7hda3ahNWNmAV/iB/4vZfLww9FG+rL7Gj7S0TCYLqjgAHQD9I2BX9tbSTBqgdI2nzGyqc98B8s=;7:vBL3OhNW2g56n5vvGPo3EE2RsCfmlZO+GzifrhqUjguX4yl/Q85TL9vGVNLPpueIlIghBp0oCvSb76vsWyVmLInnocp8s4cSCgQnxVPZIImHm+USLLN56OYvrGEhGg1weGcd2HO97ThzXkB90rjKBuQit96IdM6uAIv12D6jloIQNNffZjWDQKDct0RicaphoxAFJktjeCdDeUDI0WKWhf2rD90sAko2TIgjmqssFzmxfH6P9o7h1ol5XHb2hSm+
x-ms-office365-filtering-correlation-id: 4c0b8c5f-19cf-4967-1b42-08d610d64755
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062918E1475A0792A2538D72FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(270512070085399)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(966005)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6306002)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: W3q/lf9kKj3FmQDfB1TO4wJzb3Sx1CmKPEH26/UpuhsU5QgyAPzEuDEH1BpxqSItJKK8wnXvutrG0NCoVhABgkoZ6MWtQc4N2I35GEbQ1LCdf2Q/On2XtnxLmyROOe8jkxJv/M6sEqXtK4usWy7e/SvSLkZk/FT+pRdYCjU/0CwooGAzOQyHHQkBQLUCh7G/tDVj4GpAo3MF6lTcGfw1YhXaGJ1gdiFDM0G1e0eh6HDoGi0VV7F6Oafy1zv6fQS0UHqtFLTpW6Up0A/6jBw+WWCeRUpmHkzeunmcwfMuvZpUFO1UwjxSWOOA3gCqKul1DoZsa+7FDMHYBfO+2dQl9FzQ1/JdDKdrzJwmdhwOwBA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0b8c5f-19cf-4967-1b42-08d610d64755
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:57.3612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 9628fa131757..8116cb2fef2d 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2113,6 +2113,8 @@ static void ahci_set_aggressive_devslp(struct ata_por=
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
