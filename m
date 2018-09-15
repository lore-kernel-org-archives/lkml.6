Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C876ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52EA208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bU9HkzVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52EA208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeIOGry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:54 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728535AbeIOGrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtnnmnvHniB9l0djupNHX9vr5qF2PRq18ASFhUPMTVo=;
 b=bU9HkzVJrbkrQrc+wrrx8gWS2dY+M8HC4DTLgFvjy66CKkcNFik4rANpVtdZhIrv/8gHEqvRN2Xgo/BB9pEkz7lk84GTXkWeRItrbMjO31lxvU0pSy2AjfgNKSGH3rJuDb7I8nXr6yF7iP7f1o3+7T1IkmJnXM5rCoVlwPuTRFQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 48/92] coresight: tpiu: Fix disabling timeouts
Thread-Topic: [PATCH AUTOSEL 4.18 48/92] coresight: tpiu: Fix disabling
 timeouts
Thread-Index: AQHUTJOrWpbXzzR/50+LN7Rz0H2gpA==
Date:   Sat, 15 Sep 2018 01:30:22 +0000
Message-ID: <20180915012944.179481-47-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:r+tj5hytSu/RtvqeRVgUsWPYZeYoI6OxAiNuG434o1fIhVbm523ba/bzCSgRd8cs+UnWOrRXJS0WuD1/Yo30dNj2+BSeBjutEb3UrGCKkXjtyF+UPkY0ze4Dj3E60CqRZR+ZKZ+lTv22CZKvgiz1ISaIaWkSNmzTwh3LmzteGcFFfppuZxdOv55s8bZad+ndwUhv2I5GOMFuHAUCbVHuLL8DnC63wwoduqOV11zPo0WY+Co/vI1EzbCW/h6Q2mLn5G6ix6oLrPThJIWhkxppfVTFMgcgkaHR3Ohd2JbOpR/OszS23MGPm6UW/B1lUFRDjUIIUCovVPili4Das5lzNpj9jZbWOU6ACXQOLs+7Kwst324PtsI4nwF/K1RA+EuJjHOQipZ6DxjLBTucNefD9sHKI4GbCX4xBmKce3t8dB75YgH7ctINt4G9baKPgtwQVr/h6vtSp0yGEIa3cUX30w==;5:GjphCVZ4JEzX/pmNDPTSO0cIhnnNQ6jmtcfcK/f1RbNFPKwsGvljb8+GYCdAQrMdJO5YnWBCbi2W9KQkyt5gW2ctquwnN5b7JMC6O5kBjOC+M9pDSn20mPx2j7jYoa7IlSQ0hI1Sk89dZjveYLTjV7poj58aStkrwle/5i6hkyI=;7:pQFvh7EteKp8eNsJ8fg/pTqBfxBkcZpaGXIk+j9NQzkBlUSM7EDkiL9aqf5X//SZYDlcFVntnZYC9O77DodAliVTgZPo14GbWhDJs6BfXVoD0u1zCbCmlfcPK0UivaRfUhTnKZMwmR3+ZZV3a2aQ2IL9RJJ+sS7ICpIGtY7iUStsuH3aljz9FpCArQW4NzNNSajJghf+rmawbe+lfOq0iW+6VJy5l5VMsW4lfEotonNv/+Tomd2ovOkNbO9M0Yom
x-ms-office365-filtering-correlation-id: c2d3610c-10ff-4c86-169b-08d61aaade6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB08560980C68E6F8AC8B986D6FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(14444005)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: oWrz2qOrzcRw57xurMGp763f/opKtddDRWvPDLoMNV3PRws/LMV/k7jWja5Fz8t+sYFwoZE1TxSHPcyzdh9P47nqU4g6+FySOrohoppth+7LS1AWfqtpgx4okzuUM6ZLb1ELzhX52JBJoPnjVbPG3DeC97kJ5pjYIwllee1QryXQSlMBCR7nWo6Q1oxawT2k+zhNIvrf4yPWi/FkdQO7QBwcrbgOs1rOld4X1IYPMat28Ec+jaywp/TloslZw1LFaP1is3yindwqp8Vk/qdxvIuDrsCp/hxkneyYWL6Z8l/6BX9AP0O8/4cAZtzhOsNcw4LTYPkxwTuaKK2jpSG3RSjRXriX9MFzoUEZ7uX5TQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d3610c-10ff-4c86-169b-08d61aaade6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:22.8856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 01b7457fe8fc..459ef930d98c 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -40,8 +40,9 @@
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
@@ -86,9 +87,9 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
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
