Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF368C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E52820652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dichzLtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E52820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbeIBRc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:27 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730263AbeIBRcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5DQidjNziAdrdvymu0+m/vXrGd+MRIBC7Fv2dDMZR8=;
 b=dichzLtZrBsK4M62JdqaFoH49NZ1BO0ldiQXyxnVHKRvLSPjT5tqjl1uLXlpJnE+xYTAArw+d6+I7KzZsLA5rwYiLeGpJXrVVAUHxQK1yqihiWSOOwOeiH/rc7JjqL4fi8/Fjp1m0I0/wDugysQFkt+2UtOBovuNFx1zY+8czRI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 26/47] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.4 26/47] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUQr8ewLrCSs/t2UOfuD/CU5+x5Q==
Date:   Sun, 2 Sep 2018 13:16:11 +0000
Message-ID: <20180902131533.184092-26-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:k4iojx6GTad4PbscFJ2sQfEiiaBJIOwVACCTCgHxV92E/M3FtIJiMHCi8Ce1rfirRfr1bQTKeFc+TxN2x1moJP+93A4wMaI7lxarLBCXFfW2Gbw0iq9SQlqyFjp5gE9fPOQnP1DtJj3hLBFZrz3Yx5ecgadwfBeIlfPgVKScKoW+1T9TIj4Nf8KjZqaDqCMA+g+fFTvw9YPWERZTVxzOSJdp4YMt8AR+1Odub7KbPx5aLp39HpBHLAsxFmASxTq5ehtq38L5HbWxskAFmaDbtFAghMoiakjqwTrL0U0S3YcJ29F4+/imkJPJMnE0r4pZ7z51/ixcKvajG9p36pMhTYOmMt3MsBT/WL+sSTHEFFY4LajKJ5Hv7KEJFwtaZGQmBEDblFFbiyX3peFJRvlqY23xe1eWsQCn54B2G5YYRltxhV5QNm0plj84QxZtix3uXrnthftEKKb8vUOerZJqhQ==;5:AK0ennLIzUJ9OIA7JNP87+BpVGlqwd2q/X3ApAgB0FkyY0zitpkNpcc0htvTv7xzF9AjrK450bM+lBGz1Fw1Zkzw3DdK6CUjxxS4dEP7JLLiLUfQml/Bn6gcVxabpfrv13q9tDkwy0msSywXLqYo3tXroQoa4aKEKaDKPtFwqMs=;7:ZiZOpEW2YOkpgDpaw2i0UZqz8S6di0fgjQPbn2e+ufZjyUQysQJw/U+C5+Gsr0dUSHmC36PnSu807i7g70Vupisp952rFuLp/bq0IxD0wz7B4GyAOqVd/iFrOiUyi8AA8hicLa1QTvnMtc9fkbIOTuJEbMVO97+o+T0F7y5J/96cP607xsCRiM5sfbC8Ljd7xDdnbKPwsZ465kyehg7r/IJPqriLoEl4ccsqMyuxNPj5c0c618jPJLatMaGm51Qh
x-ms-office365-filtering-correlation-id: ede0c57f-765f-4627-78d6-08d610d6493f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629C0460C2540883E9C413BFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(43544003)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(575784001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(15760500003)(486006)(107886003)(76176011)(70780200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jMxdDAXX+MLxZ8qwvd8mjDHAGTCpSTB9+yexOMeQ8HqV+3Jtj8MTLc2Yky2hXMl/8HJ2OhXu20Bmskc6CE6QnB4JT4Pqu+bQ/kbRRm3ddr21Hy0L3s2oo0/YpfaNf9G2+EADY8AxQbL+GJXl16XHaAq/asodHVy/NH9iLSKO9ErJXJvsiZ2ZGB8sS3p4WPnPgQ+pQ4A4ywqlONvWZ9wGhfPLsMS14xpwlduRz9LXJ8nnkh4LEIwn+H/JBCcBAM1yTIUzteD9zsArIrZRKpBBu2VdnTB1uj7xoIQrEIgkgmcBtbevnVbvUR5tFMob6W9g7g5MrFVb7RLOzQ90IN7SB6PjihdEInTePVxgPwChkj0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede0c57f-765f-4627-78d6-08d610d6493f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:11.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit bb853aac2c478ce78116128263801189408ad2a8 ]

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/tpm/tpm_i2c_infineon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c=
_infineon.c
index 9f12ad74a09b..3b8e0ca12115 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -114,7 +114,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len=
)
 	/* Lock the adapter for the duration of the whole sequence. */
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
=20
 	if (tpm_dev.chip_type =3D=3D SLB9645) {
 		/* use a combined read for newer chips
@@ -155,7 +155,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len=
)
 	}
=20
 out:
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
=20
@@ -187,7 +187,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, s=
ize_t len,
=20
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
=20
 	/* prepend the 'register address' to the buffer */
 	tpm_dev.buf[0] =3D addr;
@@ -206,7 +206,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, s=
ize_t len,
 		usleep_range(sleep_low, sleep_hi);
 	}
=20
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
=20
--=20
2.17.1
