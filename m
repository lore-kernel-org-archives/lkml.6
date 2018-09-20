Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22333ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E3721522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HcJpG3uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E3721522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbeITI3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:18 -0400
Received: from mail-eopbgr700125.outbound.protection.outlook.com ([40.107.70.125]:48832
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387539AbeITI3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDmFpfaboUeA3ZO83ntuSoBqhM3mnBHW4Bj2udnc4XA=;
 b=HcJpG3ujTTdlLacKE/Qu25KwK1di2DbTYSFrF7VKwWFmh0N1nn/V4cvGlLQ1nVPXCpJefE8HYJoRgYXLuCofRpv0u9e+xgsoSRKrCp9HDMMCzyuexooL0fixYqle7iQFPcUdf6OOED0Pte+qaImMxU7Ve75Y7PIRVfRJntjsfaA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 10/56] mmc: atmel-mci: fix bad logic of
 sg_copy_{from,to}_buffer conversion
Thread-Topic: [PATCH AUTOSEL 4.18 10/56] mmc: atmel-mci: fix bad logic of
 sg_copy_{from,to}_buffer conversion
Thread-Index: AQHUUIxIWHjhE5wtrk6TWbXxBEYF7w==
Date:   Thu, 20 Sep 2018 02:47:33 +0000
Message-ID: <20180920024716.58490-10-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:cwfNAnlaaGTU6yAX6xr4DrkDgjKfTo0pRu16cTPOq3tmnGSdU4wR73rKW12W67Ac3Y/g/6HQPzE9Oh9QVhBYZEv5le0AfAQirgjpgQPC/X5ZHBCbF0c4AuhdlAWwojaoR1dyJWYbeavAPyIKVdiqsHrTt+9MRU4wlPKLnX8DrW5QII5+6c0RSxOF+XuA4NKaU6f+eWsbQRsUwscZRFah+h00UJf8qU+3AtJ1vd1CR9T3S1piXdkOccmDhgj+O5cghK6BQN5TrJwItPOPPBFzjBKKrPHPn5gO8YgrdT6ksPgnzSDEHfhYEKCSdEh7jhPPPSGF6XvuWzpuvk1dqVgvOGEEa8j6+dc9ogKPlpadpNjAb24HOWvADTwK6mSGNpMX+kCHqkWjs8yQrnIX5dxNQ5X4USi5V/FgoFY6B6a+dJ4M8sotPNaf3C2rlV+y6tnSg98XlBxGTTUx37eF2TaFUA==;5:QKK4NpIMQaJDJsh3idAnBKCQihh3tb6g8lTl2gFdbRIM8x0/3Fpwf3TDbv+FLy1lC1CpxEzk78xMu9gmrLSpb+HeHLziYErdVU4EtS877vT1g1cyKKDYI1ttvolKme09X37l0Qs+JfeBXk8JqFKsA3erjLJEfBM7NabLDOVGZS0=;7:ph9FZ8CY+IbE5L0IKyT/z3/WVRXkLcaYIfCgEGxINhBZ4vCzY5U879ypu+RrRO/28nWWu+HJzKvxBWvzW1cgni2LMGh5Ujz4/yHcpi/euZYJJfxb6IXkwL0IJw8ZSX4g7OWs/mvGnthMdVEo65it867/Ts2RenYWS4EnHGLuhrZnWzdbm8YjltFDKwD235LBW+SE2CsiOfjQ031r+G5S9Oy3oOKEU7tHLVdDNfzSLes1TyFbgeLHXv7B37gf4zbp
x-ms-office365-filtering-correlation-id: 57e87ea4-9d02-4836-ad64-08d61ea36ac9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822FA0B3A29E0919C2161D6FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(12401385986421)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(2280148)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002)(60540400001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EaGlPzDcuAIehYH49RxrC028rLdMadqX9tkxOK0btqzoStUTYD2ULtBGnqEIYWUSSowhW0z+2kxYgL+xvlSpGaNCX9XD0Uifch0w42EMXNuixhOrVCw1c9SEMlUNn8BN7jZm1liQnqZJG0uSI5J5Sj5Eq9Hhy5PACIkzzwvfcOiBcfwu7PFQBbOqu88CS4gza6uJkQ9D2SHL6dpjx4Y4yh3gT1jT16S3rvHLw7P5KuV0Ek6JY9zBTdzQ0muhonhAeOqvCMmoX0SD5NNjcJjDIRwfCYl3kUqsjd3xi86uShZwoRSsJMaGmZu5uEgQO21KJgqKtjhmvcjqB2kPyZz7QM0gXVBxp5Llz7C3ISRir0r/uThNzpialz06IQcIkrsTrLKzVsbYQizASSzPu8dyuMI5TTKUEqjFrC0h1IVYWBobHYdCGxjAMrZFqr5WWcuqeWXs6v+bKR+9Mv8rA34ZIgi7f3ult3BA5Y/b2eROID7t3UwU/8JP9Khy+4TfnyCscozqsEd7M/Bjmxe9gwL1fb5MwK39Z7EKKBtT8tzYVtN8Y0ZSGZt3QFf5B+dsOY2C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e87ea4-9d02-4836-ad64-08d61ea36ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:33.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

[ Upstream commit 19f5e9e015675fcdbf2c20e804b2e84e80201454 ]

The conversion to sg_copy_{from,to}_buffer has been done in the wrong
way. sg_copy_to_buffer is a copy from an SG list to a linear buffer so
it can't replace memcpy(buf + offset, &value, remaining) where buf is
the virtual address of the SG. Same for sg_copy_to_buffer but in the
opposite way.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 5b4277814e3f ("mmc: atmel-mci: use sg_copy_{from,to}_buffer")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/atmel-mci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 5aa2c9404e92..be53044086c7 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1976,7 +1976,7 @@ static void atmci_read_data_pio(struct atmel_mci *hos=
t)
 	do {
 		value =3D atmci_readl(host, ATMCI_RDR);
 		if (likely(offset + 4 <=3D sg->length)) {
-			sg_pcopy_to_buffer(sg, 1, &value, sizeof(u32), offset);
+			sg_pcopy_from_buffer(sg, 1, &value, sizeof(u32), offset);
=20
 			offset +=3D 4;
 			nbytes +=3D 4;
@@ -1993,7 +1993,7 @@ static void atmci_read_data_pio(struct atmel_mci *hos=
t)
 		} else {
 			unsigned int remaining =3D sg->length - offset;
=20
-			sg_pcopy_to_buffer(sg, 1, &value, remaining, offset);
+			sg_pcopy_from_buffer(sg, 1, &value, remaining, offset);
 			nbytes +=3D remaining;
=20
 			flush_dcache_page(sg_page(sg));
@@ -2003,7 +2003,7 @@ static void atmci_read_data_pio(struct atmel_mci *hos=
t)
 				goto done;
=20
 			offset =3D 4 - remaining;
-			sg_pcopy_to_buffer(sg, 1, (u8 *)&value + remaining,
+			sg_pcopy_from_buffer(sg, 1, (u8 *)&value + remaining,
 					offset, 0);
 			nbytes +=3D offset;
 		}
@@ -2042,7 +2042,7 @@ static void atmci_write_data_pio(struct atmel_mci *ho=
st)
=20
 	do {
 		if (likely(offset + 4 <=3D sg->length)) {
-			sg_pcopy_from_buffer(sg, 1, &value, sizeof(u32), offset);
+			sg_pcopy_to_buffer(sg, 1, &value, sizeof(u32), offset);
 			atmci_writel(host, ATMCI_TDR, value);
=20
 			offset +=3D 4;
@@ -2059,7 +2059,7 @@ static void atmci_write_data_pio(struct atmel_mci *ho=
st)
 			unsigned int remaining =3D sg->length - offset;
=20
 			value =3D 0;
-			sg_pcopy_from_buffer(sg, 1, &value, remaining, offset);
+			sg_pcopy_to_buffer(sg, 1, &value, remaining, offset);
 			nbytes +=3D remaining;
=20
 			host->sg =3D sg =3D sg_next(sg);
@@ -2070,7 +2070,7 @@ static void atmci_write_data_pio(struct atmel_mci *ho=
st)
 			}
=20
 			offset =3D 4 - remaining;
-			sg_pcopy_from_buffer(sg, 1, (u8 *)&value + remaining,
+			sg_pcopy_to_buffer(sg, 1, (u8 *)&value + remaining,
 					offset, 0);
 			atmci_writel(host, ATMCI_TDR, value);
 			nbytes +=3D offset;
--=20
2.17.1
