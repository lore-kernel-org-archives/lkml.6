Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E561ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04C820693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E/V96GDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04C820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeIQIby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:54 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:42432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731031AbeIQIby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqqRA3jF4jiIg72TZP+IoEyos8uihOfP92MbkgBXu2k=;
 b=E/V96GDCw5yOh9Ve/0VLzkxFM8k9zB7mUO36M1efa7uQ9Neagh7oeHsD/Da2dTiVt+vzwmENmokfYgj/bpS1f55ciV8GzUB4q6UjVTslSPGJiwf7fFf8enbnb2bdoCmHmy03gW34CwQZ20ajxNWLHppvtj14u89mfObTd/oZn+4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:06:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 43/57] rndis_wlan: potential buffer overflow in
 rndis_wlan_auth_indication()
Thread-Topic: [PATCH AUTOSEL 4.9 43/57] rndis_wlan: potential buffer overflow
 in rndis_wlan_auth_indication()
Thread-Index: AQHUTjMaS77QrGsj2kCaoglMyCoEdA==
Date:   Mon, 17 Sep 2018 03:04:09 +0000
Message-ID: <20180917030340.378-43-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:m2NV3zmTXj+DM14/zxCWghlW1sAjTtL0nHawARthK6xj2V6+/86U7UmIItXmQFKLh7HdOOVhj/s2ILgQcjBBryGDbNpTdfvAshexxwWBzYuh09/fwrYsW0blCHaPDF3AP5KnS6/NZORGpDQUPaOiYyA5kkQnvW64G4G6OsdJ0rm2Xp0Qzz+qDYBU2cmcNnYUviQOiOuGNM4xZv5Ui1ObUv+59aVdCN6qQgFnNaiB9OLzeqwQUQUXRefkVBxslGECwta5XoJaZBt38OBCdjO1clGGaK59l0uUZlp9cCLgVeSAvxWgVc1iHucsJyCEumH5evheEL4wE0V6j7a6tOzvyX9sa9QkobiQDaglpRZNAQKRWxcAWOvXmEyfOc2KmjFuoZlL3f94vcro1jpYffmven9otIR5qMJphhth8iwqapruvm7NxfrAJ7D0pFivcfwnhm8qNtr8P6gN+8/jfFdvZw==;5:fpIHROJzeFK9t2wuYjH0WBzoV8f91bl/uozFUNECaVZIWpZziZD0BBjFF8HEYaC9ygzD1K0wRH3ZeXpj4chhTtnQz6q49QiawyOU6gpYArNHNC1QFEZiU2dUoj44WABp3NZbFdpNcbPjdyRJqCBN2m9eZpErbAsIvvB8iv20EUc=;7:nTp62r+TLeUkAZfkeu66SurSc2Lkhpah1NdeYAaWcLT6NfFC0ZVS1s8piqBlL9PhizK6BIlRH6RnQm4U4H2iEKi0axMOie9WEOB8h4kVyhqY5QZSSQODnue1oxxlDbqkrl1sugNXO0Im0Il/JC74GwYvSVYhL3iOWcnOr5O/uikPBUbrs/tmLEw2bKr2TcEJGa3Qqr0+e2Q4zxNy4Kz94zpeFAsQrbqLjcTKuHlbfW9YSOV7uVpJG5yWEEGsZuzu
x-ms-office365-filtering-correlation-id: a935f311-97fa-4ead-ec5e-08d61c4a8bda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB07427426D41A7256A0BA34B2FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OK2dC8wELPcJiP4Be/PT9Jtw5Yp+Djw8Zj3GlHKQT7weRpTqzl/w1JHs6BRZvVqwQcJ4opp4V9VZ7DA0vf9lV/flyfLRrOMNd7ofHEYpSfS1+Fan5Tg3UgO8uoyU29oaxlAhlQK0KWg3l9aczGxHXyYTZ/dVIB+z8Xa8FfEql6cyf2jT5W2HSfpv4pbLjxOllwHNwcBbQZ1DzQ11ibY4x+XmpKgy0FZxt5qRSXK+Q7eUdsVzqbWcWOE0kCU6SuMzB91E1EgijL72IgFlH2vo0DdgqReASkSZrKuja7ELV5WTT5npC3fDyzvGD+g6MfDKUH2QFyEV+14/LOZ1368aVkf3MozqFjr0tpWWpI2CW/w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a935f311-97fa-4ead-ec5e-08d61c4a8bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:09.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
index 15b2350d9f45..c9f8847dc123 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -2921,6 +2921,8 @@ static void rndis_wlan_auth_indication(struct usbnet =
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
