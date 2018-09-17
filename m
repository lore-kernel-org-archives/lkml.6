Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B70ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740C1208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XBRCgIc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740C1208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbeIQIqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:46:14 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:30720
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730393AbeIQIaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWS7IOJRoYn4h3CMN+3v6Cz2andk+HjCw1TTLXZ0Q4g=;
 b=XBRCgIc6X6ahNKHNsNKakz1nAUwtHxmf0X4S21lh8DH8/98kDMrz6LtcDyj9UctakrDUXEHjtbqIfKwbtJY6FC8ESq0FpJNEuJb9BaFznjpRNa7WwIH69Z4eZIPzwGGa1mzfs5nabaqu4k+fnbV08csphbDH6BcxHh0kD/EJWlM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 65/87] rndis_wlan: potential buffer overflow in
 rndis_wlan_auth_indication()
Thread-Topic: [PATCH AUTOSEL 4.14 65/87] rndis_wlan: potential buffer overflow
 in rndis_wlan_auth_indication()
Thread-Index: AQHUTjL07zj+he/DY0SURVThR7SIoA==
Date:   Mon, 17 Sep 2018 03:03:06 +0000
Message-ID: <20180917030220.245686-65-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:a/KvbkvDt9vHx8uRlloKqHvmjco0zWbRbN/ExdCODk44z9KpyyncFxrlLhfuk0Zds8AoHNMWL/87SGPqHYrzRluI7v0fnqTKQdWd+DY9du58B60zj0yTcI1g5HdTvUUl34yVVIWc6oREQTBUx5WSQdFqVsj3zVhQxCluVOe2UaJyLW2bn8L/vac9fLSoXaPt7zhOFGSIivXjZ6yOJn3DCK/AYv4WWdX1R9zOMpZBkYUTumPNhAqiYjZQzNBhqPCSIsAo0aDUwLEa5Lmcx9jrZrM8wrgGFXAzmn+ArnyhPcvSC9RMlT2E+/FhfsMfoZcRrsN4NnCdgtBKonnNfWZDN3Zbq2jgxFMFGI6RzwFzM9VCeNHzrJ7G7c0XG5vsfd6FYsOmKHXimyFA9pYgBV0KXRCzfTgVHpcbeyy6Q8OLrGzfnyng+MT/lILJRKI45YCO7RmcJ9jLHMhWB/B4YiSoFg==;5:FLRF/JAaS9H3nChT1SjC93OVZDnBFoFQ9dtVyoWyq19rndHdAzWmS33PQ2G1A76tQM2pKCwS+CpkV4OUmrqmdPjcldF+A971gAsRRzfIxNH2d2sxUdHwwEAKC+vxa3c9eImmaNHuHCFBl8360999XT7Q8RR8Q0uKkeu+ZYUtCXw=;7:Gdgiv9ghEH3hPaHn8I++VnHlcWgSJMDIv42HbCCydMMahiB/13/aDcRBq46SQJdu6O82H3tHr814bEOW4akdW+BqUWXJqVsTmVkAvi1hGqhYRv9jSBSTEb1WF66xINFP722L6GBLV3S1dRNB1xbnympAn+3AcYjNvzu5hZ4aj3IVC8vYDTk76YCGb7FbmkOOsQW3uW0Si7sOfaxhi26UO3PhXd39PcuTbKliAdmEbnPZOZEtLUIb4MXrRd3ssDfQ
x-ms-office365-filtering-correlation-id: a199efba-2574-45c9-9a09-08d61c4a588b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB07742067A142970EF27568B6FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HKZtjUMvieamDETxvOdq3Kywbvh2VXpxS0DNc25ZQ7gAKVtVYMi4bJLaglNpiSoBoR5TV3YroumTl+cnvqMnY6WcZGXmXPYMYDiAOryXNb7+KtgkNvKvDib9S8B8fSrt5NSpWdsIHugfTlJAdioStzDZk79At3c7hFwOiioovhpDnjEf/IfOPcFDa3cvb087SohANbOjXiJ//JmIfNAINdZTT44bLrd7abenHWluydM/xxPXK0RvAeW2FNBvF5qolVot/sjt9sryt59x4R1bSQnA6EmsTuKmsfDwj2a+hf/VDsvTDmD7+rDVCnvQTKrJXH2poCD2xF3QXxiuspCo3HO+W2eiLWh77u+kSEZ1HZ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a199efba-2574-45c9-9a09-08d61c4a588b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:06.1653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ae636fb1554833ee5133ca47bf4b2791b6739c52 ]

This is a static checker fix, not something I have tested.  The issue
is that on the second iteration through the loop, we jump forward by
le32_to_cpu(auth_req->length) bytes.  The problem is that if the length
is more than "buflen" then we end up with a negative "buflen".  A
negative buflen is type promoted to a high positive value and the loop
continues but it's accessing beyond the end of the buffer.

I believe the "auth_req->length" comes from the firmware and if the
firmware is malicious or buggy, you're already toasted so the impact of
this bug is probably not very severe.

Fixes: 030645aceb3d ("rndis_wlan: handle 802.11 indications from device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/rndis_wlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis=
_wlan.c
index 9935bd09db1f..d4947e3a909e 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -2928,6 +2928,8 @@ static void rndis_wlan_auth_indication(struct usbnet =
*usbdev,
=20
 	while (buflen >=3D sizeof(*auth_req)) {
 		auth_req =3D (void *)buf;
+		if (buflen < le32_to_cpu(auth_req->length))
+			return;
 		type =3D "unknown";
 		flags =3D le32_to_cpu(auth_req->flags);
 		pairwise_error =3D false;
--=20
2.17.1
