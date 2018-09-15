Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C4ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F1721477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AQqcEAFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F1721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeIOHEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:04:53 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:36480
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728717AbeIOGsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNE79+Qa99z9sjLnrEGpzJMbu6BFZOqWvQDKIh1Mzxo=;
 b=AQqcEAFXa1mgIZt7px5oSKHkofYJyWULV8ljQmYXBnfZUGTQLUXxweNq16PHDMzFdJ+OcgrvmHXlHNw6DQoCIR7gnxITP7/LXKSl4dg11toNjyOUhwWnA21pwAgqD1BdcqFuFaZi78d6xAqWstooznRTncghJw6WidVviSd8ZgI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:31:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 63/92] input: rohm_bu21023: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.18 63/92] input: rohm_bu21023: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUTJOyqFWtdnL3Eki7YLWkAjprTQ==
Date:   Sat, 15 Sep 2018 01:30:33 +0000
Message-ID: <20180915012944.179481-62-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:q9mF+WcLLpXQsYSzAw8880jx2PptFacf2CfV97Tlf+CW4XnSvvAERZMDgUT2Zxz599y6DuNC7LK54mlRs0gXW7OR8rGBlo4HYwKMafeFYOh5cffplJbCf4SNPzDwzPb9fdwZuFLaH4q9FjD3uAMqhH/spZAqRophvk1vDTC04dCwwvoP83h1YUXZywRVQWcB3qw5gV039708fVioQBQYZs20E8igNw0PO3jJMiKDVFYbktL7SyXGW4pFNqDOHhxg6m4Utc/uEnD6kqTIp3prKBQ0CB+DnhUEuVvWoFHhPhexq/3r2htdBe02F4LOBcKvJqC+u6IUT0tf2r9WvKIHPLF9rgC6bRlZ4/9l26gW3SJZIGPuyH/sgRqJ50srcw8enC5xDT8oun65akctltWvDjG6cPSKvd6u7kJcCWhmBNYKQS28YHvmm7nuFHF9965WGNEf/CYWTTK6Kowo649l0Q==;5:LBXukx4mrrAbp567Dr+ydbrF+uHrvgQE6lazMzt64a/xjvAzHVHg8QZLBko8fHi93GKz8MaPvc2GdmBgKq8/6kFrzW9rvKM3/OEFDsJGc4sZa29vRxt/U+eSRoQ7gYPpejaL4gmiYGuyEM252+aJgercpUQWfcBtyycjRtFu2+U=;7:jO3Pp8TTtIIGLVdGeSuSKBniBnfAMKIqziaCGErZN37JoAACba4vehHjgN5/MvizEOvlT1AW/TgSfVQ64musjm2d+AwXXc88ddIqbgnz/HrZ+43AQIkVKHWsNaXA7uLfnqyke3R0zgnPsfpX9qFYkI38N60BKyw9wn6KOthUZMzkI6e0bnomyYPCvNhfNUaKN3vtnf1cggaU0QFjd1ua1M6wBiMA4YxsthgX8BGKpYgq6lRwslwqmSpXPHDsPAhU
x-ms-office365-filtering-correlation-id: 6a3d6855-a007-430d-7ba8-08d61aaaf700
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB07415CA46D9ABB4F5B70FC30FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(15760500003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vAaI7KHO3uSoz/h4aMCr8YSAu1ESdkvcahMENL+PjjwBn0RE+sdaicZlLCON1CT20Y0rNPdmmATPofYew56HCfi4EiHMYgl+mkDSJGJqXpqTmIYyVgZMHwcltMmEveWiWjRSws1Ujl+Jha2ewAsoQKNjZqrC9l5jpTIpjjMMjSkTdJIvuGwxS1KLVVIiwdAUqvzNrczybLErFZ/j7Ly3MGHSgG+5VIVWQqrifiiJyxO7qy1M6z/m/M8f3WUSdQRDpFhCAqKtDw3ZirYYgGuOCtXVomOGpbcXE+sBmt8AbPaAQBQMMD5vTdk211EOpqH+/A4oIubG8qHHlmaezNq2rckxJSmbM3NJyZ5QPrjpb2E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3d6855-a007-430d-7ba8-08d61aaaf700
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:33.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index bda0500c9b57..714affdd742f 100644
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
