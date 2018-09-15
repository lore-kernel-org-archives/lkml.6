Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ABEECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAF821476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A6S2rl6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAF821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeIOG4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:56:12 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729730AbeIOGvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYEsRPe3k0j8G4x048k21dH1jPqw+x9aLES72+XWtAM=;
 b=A6S2rl6lXFJC2ZhZvfBckPxm4I94V9NLPuWUzVOhZCKFSjG2ErkPLaGqwtS3eVK/I50eDzn37bJXx601RxuOyhwnQ6rOo1MffCY38YjxCrnduVT2I2xy7tlJOKty2shVhk7t0Mb3irsryzc1GTTn9VqoFKuNto5GfTroY4JCkjw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 23/34] input: rohm_bu21023: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.9 23/34] input: rohm_bu21023: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUTJRFBQ+GW1/MqEGm0sOo7vI/VA==
Date:   Sat, 15 Sep 2018 01:34:40 +0000
Message-ID: <20180915013422.180023-23-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:xXi94s+qKo9yCxzjxw4JwkadQ6kbPRavBxR2LMcubApAYIFMtXlK/E7zoWRQ0hMzAHoBbAOGv/PtkzLVeBKl9gaCMBqNvQD20CDXDjJYhB2OX4aPamnAyuumwM4IwQ0Juc63J8GevL6OhGNfessqd06pDGFFn324Zlvrf6U9PdotjTojdQQFFlXtaGCYMuzWbhRlud/F0OOvPSOJuu7nGDKysqLWabeFwMMaxWsfpxSZP/LDiVHNIgO14G8HV6yzA5/1lZ9OSsiArafva/XbBbmgBTaoK2NDb/DrMc5+OAttXZ4O1xXBVVXDZGXqCRPJoHmIuWaIWsP3nU4y4Zmrp/ouOJrxixXcgO9Ulva/Oc6GBQAts0XUUu9YHOJMHwLKb8gWlfV2t//8RNJWptBMtxbaN1YfghyXtwZ0jSTjYBjxlwzI4aKRtzWZ725ExIcDQgjdh81fGmHRWapDsfvCiQ==;5:Y+xJh2JsF51hWkHiZBRZZ1wQBNv4C8wxJy0tosqDSyYQLjwUS7WjlEbnRRb2WnWUOqFEigu3fkOLCfNbFAWnDHBygyt1tR4zdDanthzBOyhKPffWLj/1RT5u/2+/1pVbbKLzH2tRC4NfhHJWs2erm+AwaebR7YIxMvU8OlXjkc8=;7:Mhq/Yo/KSEeiKsEg2G/5unE2RkMi/LgMo/G5tfEfPlgusWrWtwojj3ZuOUuzZi2ShjIMvqOAabeWTu6t52omDcIGSRxJXGCz9WOjFOO0IhSruqJJT9xLsC0UxpdrdGvm+s83reytbcSLT8O0IZX5WgtP9xtquhwmHOQvHScV7rLZZNbFqlMmTjabGKqnqP8DcELHPNSxuwszh9TA4GmaQoqcMEs4X9O7lXuCWvnJNxNX8jbAr+m7QrQ/d7X8pLRY
x-ms-office365-filtering-correlation-id: 530fd270-47be-4c31-ac6e-08d61aab67b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB082371EA630598699AA33528FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(15760500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(575784001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2W63aHsrXfJusTLCHWuDugRnUImnVZEyiFeLlSSCsmZXYaNz5EYaBibmUf1qFp4o2hUUqUuBeh7rp6NEX74Ll1Hgo2nOJ+D67oxu0gQiHidighKBPoWW0M5auYgXCaSWMnGDEK5QFJ/p9H8vatCjDIqiSvkvKAECW9DtsEndAegWP0YJJyTRJOBjxVcq3ZHNj7jWlCS6lA7GmWYL5a07t1Jwun8fQDWeF6Yac6+2ajZQv9zQIn56YAok/QiT+BfPhJ0nQ9sY4GIAA2K0VPpugcKF4EHwj+0hKDoScvUYr3n4MXKYobVbCvinhHBzbVjXwUndi9qu4ULKQGzctfhM0LPMZt6wXlB6Y7nEI4Da9m4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530fd270-47be-4c31-ac6e-08d61aab67b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:40.0517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 193c2a07cfaacb9249ab0e3d34bce32490879355 ]

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/rohm_bu21023.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touch=
screen/rohm_bu21023.c
index 611156a2ef80..be29984c0e4c 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -304,7 +304,7 @@ static int rohm_i2c_burst_read(struct i2c_client *clien=
t, u8 start, void *buf,
 	msg[1].len =3D len;
 	msg[1].buf =3D buf;
=20
-	i2c_lock_adapter(adap);
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
=20
 	for (i =3D 0; i < 2; i++) {
 		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
@@ -313,7 +313,7 @@ static int rohm_i2c_burst_read(struct i2c_client *clien=
t, u8 start, void *buf,
 		}
 	}
=20
-	i2c_unlock_adapter(adap);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
=20
 	return ret;
 }
--=20
2.17.1
