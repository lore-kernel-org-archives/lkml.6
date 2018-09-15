Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98720ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453CD208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JB9e7M0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453CD208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeIOGyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:54:22 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:18669
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729895AbeIOGw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy1kMa/n1Fqlfd+mUgNK5/x1oEKC+vUyje0I30iLYvk=;
 b=JB9e7M0BtzlB11eStriIrnAnGeqdrGGQCY1oZV8YJ4EcqhIXCNLmBJ3oCrFvr9SLdLJTfU0ynlCdz6o5EEsiEzuYOvTKaOFcjiMiI0axZbs680kovBiouyq26t9V8pTcuEylfmhheLAExM1lVnm+D0s4D399+G7/NukcPigiUco=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 12/20] coresight: tpiu: Fix disabling timeouts
Thread-Topic: [PATCH AUTOSEL 4.4 12/20] coresight: tpiu: Fix disabling
 timeouts
Thread-Index: AQHUTJRYBwN5CcU9lEa10xv6kLn9rQ==
Date:   Sat, 15 Sep 2018 01:35:12 +0000
Message-ID: <20180915013502.180110-12-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:4UBx3SGfEb3anz86ZrHmvtQB3Jqohl1nZ5dO51juKMQBOT7GMTBDlEAjvj3djO6s8qGCuxfk3tg/1utv7ouVE9j4fXupH1AmbvKu1hwyFMfGAWQpt9GhXVUtl13yURwECUYUI07Vet9MvwCVHHCYAdT06d2zBEptB+xOWwShUiapPHQ7tiCOGzNCwisjRAqO9dgO9cpD3aOcE5wAK9okhe9UH4LaqyBLnhFEO0jR8zWzaPTxhy/r5yAv10gos3rrPCfHKcEGEgkpPTijY2L+YgDxo7okiVXU0k7l04Ng2wsL8iCGgDqEFKKVL4KeUYKaYgh+Egv3cYAWIm8PNiw33otEOzVpCBshOUqgZUQAmb1GcRIaY/h1HVokUFxyBANpWXci1fXULvAKx+RCJEOFEkDqduewcnNfBMbGl3Nxt3tCUjPhN2crjuUbJnG1OjNrsh5Vx+5MyTBnTfw3mCVwLQ==;5:0VD5hYoath8I93CRmEZrfdy+AWbT4mfxbW9deiDnDHeqt8lYD5yRHQO7jh7gqg2a0wn4IclGoSBMf2gbQ+3nMgeHAuQLd7V6qOi1BVjWTUstlgX9wxP04ZglnkQPXi/L5M5dDJxVyuPeBpOSPWI/NYgWMVGhPkUJsA38EnpEgDo=;7:qAbhl6rtvnsz59U+lTq1yx1RdNOjTy/hzJOeCBykP3w3qbmd1Qi7UDwsAdUnuKP2R7PCr+drA6Bh+gKm+3/3cnIRObJBa0X5dZ0vnUP/F4M/NkD0cR8IJ65DpOWHYVL1vQBrDr5I5f9roZWBUsTwxBCVNt3PJUTvo9Y/OJIEzzqrHAASXRaur5PrumpAFkexA+d6NIOTV4Incd7bc8vZDXXgwLfzER9Kbz7hP6egmddIZqfG7sD47aez05qY7zMj
x-ms-office365-filtering-correlation-id: 6cf9bb05-d38e-4834-24ec-08d61aab8052
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB01819064D6A9B4A58FDEF50AFB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7WOVZC67QSc36uFTwdst/VISJ1VJsqejGrD2a3AQ5+1EJCjHSiDmurRaYVmb1vDSlD5FRAgRU3izzA2oQJo3pFylL8DFx7b2mPsKc94jvUIBZrc4KHd3hhIc0jjYwrSasjGbw58WTW0JA2ehUU5NW8D48NSX96/t+hyrcM9JLaboc5cU/uqb+EMjoB3zwOIdNjOLmRDT68EH3o695yU37OnIymaNKNHvvsGuYp2s2nIUz5F0ntCZEzjiKZrSWjZYxMW8GJPpTzqVGEv76E0lvoZYxIsD60c8wx4K/YPrMiuZnq0ZXz3OJowYERljDOnbSAgskRwAc3bW688AvhF9iQJAQ9nyjgD0SHnhSfge+Wo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf9bb05-d38e-4834-24ec-08d61aab8052
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:12.5196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit ccff2dfaceaca4517432f5c149594215fe9098cc ]

Probing the TPIU driver under UBSan triggers an out-of-bounds shift
warning in coresight_timeout():

...
[    5.677530] UBSAN: Undefined behaviour in drivers/hwtracing/coresight/co=
resight.c:929:16
[    5.685542] shift exponent 64 is too large for 64-bit type 'long unsigne=
d int'
...

On closer inspection things are exponentially out of whack because we're
passing a bitmask where a bit number should be. Amusingly, it seems that
both calls will find their expected values by sheer luck and appear to
succeed: 1 << FFCR_FON_MAN ends up at bit 64 which whilst undefined
evaluates as zero in practice, while 1 << FFSR_FT_STOPPED finds bit 2
(TCPresent) which apparently is usually tied high.

Following the examples of other drivers, define separate FOO and FOO_BIT
macros for masks vs. indices, and put things right.

CC: Robert Walker <robert.walker@arm.com>
CC: Mike Leach <mike.leach@linaro.org>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>
Fixes: 11595db8e17f ("coresight: Fix disabling of CoreSight TPIU")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtraci=
ng/coresight/coresight-tpiu.c
index 22e10b7d505d..fe3a2b19a5db 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -46,8 +46,9 @@
=20
 /** register definition **/
 /* FFSR - 0x300 */
-#define FFSR_FT_STOPPED		BIT(1)
+#define FFSR_FT_STOPPED_BIT	1
 /* FFCR - 0x304 */
+#define FFCR_FON_MAN_BIT	6
 #define FFCR_FON_MAN		BIT(6)
 #define FFCR_STOP_FI		BIT(12)
=20
@@ -93,9 +94,9 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
 	/* Generate manual flush */
 	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
+	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
+	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
=20
 	CS_LOCK(drvdata->base);
 }
--=20
2.17.1
