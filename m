Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CACCECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4B320693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TD15uMnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4B320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbeIQIhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:37:36 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730357AbeIQIci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2Rpl/EzdEF+dbYFJrqJlFSHVYtT2ntDGxSGgx/dhr0=;
 b=TD15uMnp2pk62O35/eNahGMMtmX3alS70VPZPnWycWhWtjIONyUJ/S0eQpziq1XjIVKnIjtPKgwUKADJP3lTj6GxgOac4/FfBnzqDY304KVkK0xM7X+314oFxU8qsYmdHjI9CLuAK/nzCPaD6ZCejhfmGejIIkH+ifNXZmUlr1w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 33/43] rndis_wlan: potential buffer overflow in
 rndis_wlan_auth_indication()
Thread-Topic: [PATCH AUTOSEL 4.4 33/43] rndis_wlan: potential buffer overflow
 in rndis_wlan_auth_indication()
Thread-Index: AQHUTjM+VOtuDn5Fn0+2GyDFVUamNA==
Date:   Mon, 17 Sep 2018 03:05:09 +0000
Message-ID: <20180917030445.484-33-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:FetsfOXuhkXMtoo05593Gx9yTE6B5UMi+52nbs/4/KHS810EsuQ9yZDdNn4FriAaJmvPHGLc9yEnLWpUeRTpGMjwnb4dkRf9tDtB6jv3ykH9bXU3ebbM119zR2PFosVRPNVgtb6RCnkAvcwQocEoqubRqFSjC5tfxX+OBDN6yDTUzfdZ8JNkhvz3VLlFO8bXTGS15k+/G0HPJ/vVcerP47cWWnoTfhNvActwOzlOpAbZthU+9S4DCSTukVnvYmoK4p9bXocjxxXQh8q/EU8Uou3hsXZmBgLUKXhfLSjGqV1edYvUaOCzCbwYcojCpgplHpY5s2HB4h55HWG0jJ+Ms+QaD7eHeu8B98zFJDrfSfYlbyXjMobjjYpVegU+HzCNk/b9UDKLeqhwTHT6IoQ75BruihD4hAq/Nj13fvmNjafxLChfj/9bSPYVYpJ3p4XRfdr4K+KRJqetd9Z5aiLvZA==;5:1bvHZ7J61hvsg5OUd1KXmOj51YG5dVCooscsm+QPxp+LFmWxIff+Q0kr55lhDq3+vzh+n4Oxy056EGSbWhUwCz/7bGaOhy7wt+ZPZ9jbI25Ymrb+fnAvYfMg7gJW4nhWUXmj+NvIoT3Tfw7HOgesiO0XxcoXXthx6lRUSnYQL44=;7:ptuDon36Vyi7qPaUQ2No6MB0e20C1qpPq5Q+M4/OaiCW9FvVoRxV8npvJpZ2QxV8N7EEHsGbiHHAg3M6TOHHbL1AuAkl+TE8J8IBY6Nul2Er2mZOWSXyJ1SKFywIBQkohj8aRKIbiJn0hKlgrVL5Ph3v+lv0q8R4HQ50adg+exkBzhkhT3jmkElqQqm89VUV+2Y3fEukQn/hjWaeRQvqt7bttybljUjozfHkF7zhuHOezwoBbY6VNX26paNuk+rW
x-ms-office365-filtering-correlation-id: 63af4c02-26fc-4618-95a2-08d61c4aaae0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759692875C4DD7D690A6500FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(575784001)(97736004)(10090500001)(26005)(54906003)(256004)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7m6SAzV/bXBofXDfok+PlPVXRTaGdN74/E0XeNwcLZsn2Tsi17h3XGf8ku9mUL2YOW79wEVq5BxLcT+a1+jZpcYKr6joOEpJQViiJhWKznc3We1Z+8HYbqbbhpPPnGXIF4jD52im+jjY9ac8VYv+ympT0nK73b1g1vlAgQjDtqoZJ9sVsFHKMxDYZQ+ecKwQFZDb/XHP5BWg6T2W7/++6HyREdVDVq5Xp/ObnqWVWRda6vEL9rEkdIj1L8VQGPrqB6GnxzYB128FAsu/3v6LXapKWQhL+4IIUjMsIKjBhQt36Thu7JX5rfzwK/4AuFJh4He/7GqlO2BqcSxUU9GFt7GCyd3oqcldiiA395jWYDk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63af4c02-26fc-4618-95a2-08d61c4aaae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:09.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index 259590013382..c76e0cfbb8b4 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -2919,6 +2919,8 @@ static void rndis_wlan_auth_indication(struct usbnet =
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
