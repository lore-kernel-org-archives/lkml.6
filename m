Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D7AECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E63721476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kxDj9k4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E63721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeIOGth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:37 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729092AbeIOGtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8nkG/dZohYkfEHGtgYPWKD4C308A/C33SCyaXhA4f8=;
 b=kxDj9k4z2IUueJJCb+tNG46mwU+hXQ+dHFmmx0EEYnIkpT1lUhVuWe+hDSIACCs/JKou4cmfMyMLMSS7ZZ15zC2SnaFVAY+44bi1h12nInbbeHWeT5i9brzNJSeu74bna7TnM7KGn6OHU5iLzApixASwst+8mzbKEwcb8jAHu4c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Biggers <ebiggers@google.com>,
        James Morris <James.Morris@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 11/57] security: check for kstrdup() failure in
 lsm_append()
Thread-Topic: [PATCH AUTOSEL 4.14 11/57] security: check for kstrdup() failure
 in lsm_append()
Thread-Index: AQHUTJP60xzBCLIAWUKmXgkGui+71A==
Date:   Sat, 15 Sep 2018 01:32:35 +0000
Message-ID: <20180915013223.179909-11-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:cbV0ZVLPcB+6XpH7Mbf4Z5vnEwo8S1jFi1chgKe4H0t6jro/y7fokTk2MGjttFudM/4PKqmkflW3ARULWGNAP0q9UD5GFi03sj9gjO9PmUhVyUoWAIfa6tNXU9vuz9dq3ktctnhzzC8n+f4fwy2oik/O/4Sh1LrYuxASDIL2++9iPNoOgiWYNnzwgCVAXxOMRbHUMhBTMfiRmI49h6p+FYcbVkdDvUkM8y0NUub5FNC5qGWXZWXywL14vzZEmW92NF6rppP8DUZxPRX5ZQmYucn1N9NbH2g6T+74kPsGEM5z8pM3iUSXrGoUZjKF4vS8QTh0iLZDFHT6rOxh/GSy7+Ow+R9zNAAk3lQnCxj7VLtkPQwasAHRzt+Y32l82TkJAM9DDkxNrbtXF9+8f3Hy94gEtDA1lIvVcifB9rDgnGZlwRHHMoG+2RWkmKoNAII5DfDaSRiS8xRux6xGJMJbpg==;5:UbN9v3+fXOtFIKAflLWG+mjffV0Go25yiqOcHe5FgPhD8h0LBSDYtgzQcPcFMnR7d044FO6SAXbRVFK3IpNSZFHZkuOPoPzg6+SP49NsAp4mXhlOdrdsCL3q7ZgEBNscOolSK96swTWYSR+o/vxBozMxxX90W2xW0WgijGzckhk=;7:UbNa8Za5/TG1Hcu/gtPS/k8dTiBu6oaVd6/Mhb8ut/qzhUYSZfUxPfpyjMjLpt4JvkNSlZ1LlyVEG0YVmc+LCWRaTR/g7gekPb5xINVUmgCYlnXwg7IhLxzpp3wg7eK44T+ep1DZxVV0pgYa1PXKpHywa98j4+EeNVRmzvt492b0U+wGsQ1nVd+1QpdyfJpMn9l1optUyhxaQrF97KVAosEwHVrkw3ep4Gd3ZBuPpN0NIAMO1oKn8JKlbDbi8WSn
x-ms-office365-filtering-correlation-id: 4ac694ca-1754-4022-b4a4-08d61aab1d50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822C4749F91279926338AC2FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(15650500001)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(575784001)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HF7hhksQCTToxOWxGM2Ompjdnbuk09/B8xcxGyW/EYpqPgGbPFanOYCcIFZ9Gsof2ZA3Y0v9kjPDoOPLx7CVXoxI+NX9yed9DtTTH7Q1UzpzSAcWnXBSiC0ykdA+bMNR2vWK8o4VEbRVO8bjX55d+paSsxJJ2ZfOETKadB+/dBfYKIMcQ9Gyhmdl0IjJT6xn36+M6WgiUkDk5Zi1bUW6bZtZ+FelBM4V6Ndjcr0sgveujfolJ9kyGj/kFf8AwYaU+E/0HPzVr/ExUORqJCow4Qgiayd/93BN3bKGrX1mIoAG5PJmWzsWqyunQUVR/MdpKkikOpyFQpbw6ZEuLhMNsKGu9XzTcGzPJ/mAthAJTXU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac694ca-1754-4022-b4a4-08d61aab1d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:35.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6 ]

lsm_append() should return -ENOMEM if memory allocation failed.

Fixes: d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 security/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/security.c b/security/security.c
index 4bf0f571b4ef..95a1a0f52880 100644
--- a/security/security.c
+++ b/security/security.c
@@ -111,6 +111,8 @@ static int lsm_append(char *new, char **result)
=20
 	if (*result =3D=3D NULL) {
 		*result =3D kstrdup(new, GFP_KERNEL);
+		if (*result =3D=3D NULL)
+			return -ENOMEM;
 	} else {
 		/* Check if it is the last registered name */
 		if (match_last_lsm(*result, new))
--=20
2.17.1
