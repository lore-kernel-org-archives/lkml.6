Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB44ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1AC21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fJujcDJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1AC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeIOGu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:29 -0400
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:42981
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725753AbeIOGu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB4d4ZFKPHi10++RCBiKfGpXWGiMJR5B9zZDBXeY3fM=;
 b=fJujcDJdc6DJMfQRwG1eL8zX99xiHB10sGiX17kMxehUWy9GOTzPlP649TaGkxtIqma9Lok6l0VrM8b3FXVI8jUiWtwlylAO/s4NvR7hhCtyZO4hUCC9AzR6nC/Tf7OnrpN5RkMvOh2ikjK+rXO+sfk0OJmWkXeHRz7mLN/jCKU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 35/57] coresight: tpiu: Fix disabling timeouts
Thread-Topic: [PATCH AUTOSEL 4.14 35/57] coresight: tpiu: Fix disabling
 timeouts
Thread-Index: AQHUTJQEL3j+4mNbZUS4IkUuSN+j8Q==
Date:   Sat, 15 Sep 2018 01:32:52 +0000
Message-ID: <20180915013223.179909-35-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:mpa/uiHg8Hjg1ZNzckCdFbji8GyJHk40a9/jfEBuXrQiZP8A1hRt1HuJQ1KxWt/wSf19AtlrHn9pVnq5uJrrj2kM48rpz00Pco6F+t0P4Hy7A/T9Ls0AGUepAq41OWMO8YWiPUyzattdSsDwDCj5JW9PufVIGP5mOleKfbiJLtHNZUWjUM0ICmzmy6+y6BrfArdUkVAgQdFdKQfqfeUrvjOAW31HcdQFbp33ibyeLLymxRb4dJSd5NMra6oAb2KfWG+5vfNqZT0mzAaiVm6gD+kqadOBMAolSee1untQG2wTp7Z68pDb9iXl9Q+/UFFaSBCVsWKN4/AR5J0auRRgPOalD1vr9QOiAxvHin0x2Fgg0WIdvqyCD8GAxd6tSg4Bnuex1f2o/lclwupvinkCTJ7Uf2C45sk8p3X5D5gGV1lZ+cDkCgTU9qbP3Cb4IyLQSYbr9ZL6/+ex/TQ2cXQiaA==;5:ExI6RlqSXo6Ym/u9faZu+zQYDw1bj6m3DMryBM4+kmMHo63uolrLwnaGTOqp+dOR4JZb9qtzoIAHn4aclUY5+6ygp/XG3kMpkwJA5yLMtGsHI7jOFnvq2kI9z3dinLLbRuHTeJd9mJYGsbz89n3YKT9r3sFtC/6bBhywUdjdihY=;7:jud0jt4tSKqlWgbxAb4nEb6oEPEWzWSX9LX0GhWFhjnCrfqRjw0ANhz2+y0qCH4qe4T+PXDT4zlbAu/mVMZYF64uA+vEGJDDIgA0Li9/k6p6BxUhd+WEBDdeJI7P919mvBP/zemau7/E6gurxORp44a/T7vxSP0V7DMRmrS4CVhppAgEoOpE15ASSV6h11EsJdLnizpNH5z03+Ex1q1vSchwXQ742+Vz89RXBnOig0z0EryjemtBi53kRUfaWRyz
x-ms-office365-filtering-correlation-id: 4b8beca6-9798-4bb4-e260-08d61aab3841
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471A8C725201995B4F2E698FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dgCBDe3HuaU68tjbHu4LrQBDqSNrgKVMFpUVMvXF7CKzhYCEyYbylJxHP28Vj8cHTPLSBTigOX4Xarz0cjdDsESKXk10CArQnUO/2Tu9G1Vor9cTvf2U0zBQ+sx847JUn1wwS89+3IYnq7azGrT6VBxAMRhqjMtuoPcEX9WNnK8JUWZmyPUTco5wjPh4Lg3qKuQsm885FPGjO2o4o/0tOngXn0RLKsPUE+VW7PRZI2FkY3XJl864agN6AZOuVQoUbJ7a0/AmFn/UmiLTzANFYNWLisSWrACq2Plsb22qCSAmk5JvOQ404WhvTWD1I9A+Ocf9eiTK1G02dhOAZU4PX9Drl7Cl49kGjmdUjuysCmw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8beca6-9798-4bb4-e260-08d61aab3841
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:52.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 735dca089389..15dd01f8c197 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -47,8 +47,9 @@
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
