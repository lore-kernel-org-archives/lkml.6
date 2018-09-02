Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9119C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8942B205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PNx0ir6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8942B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeIBRXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:43 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbeIBRXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAV+ScnGfeR4+eW+xJxozyxZincS4dQRxICKXMsHUHM=;
 b=PNx0ir6Xac7CKXHoCxaTTF7uBiP38F53MhL046rkXFKw3oI3xYFI8r0PsN1gKtljhR+jK5g+sxnJe7X85exMr71OJXF/Gic+++CvuHthEaLVkNaZ1v6TmmuJmXEtbPEymfXKSIMvJcyihcrfwaLlpPg0gKUIvAi6hyCbmaCRAPA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 58/89] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.14 58/89] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUQr3iHruMVUFGmEetTxF34HswGg==
Date:   Sun, 2 Sep 2018 13:07:20 +0000
Message-ID: <20180902064918.183387-58-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:hMzzdafo52vDM8NqjRp8LVOujEOzvvb27qa132O8ASDUOVbTyQcL9NxpBcSprz0DRFShg9l/fSBWuRf7gs0AscFghZu2uAKDb1i0p/UMzEFp9rilo2RFLFCQbTKYkn0SoPgrphfy/rJRuueGWmMJIGQ69v9LhoQKbLAI23nERgk0YCQ/VOQQoLSqDRaGKEi873/aQcUxvOpHVPw9v38KNvQcrDHutZu3D+e34QmgW3lEaXW4OtokQXBcPdAP65NVmEcoVvQDWKlu+n7iTOJn3QYCYnTDN9Xy+FJRIbOiiiMcWPn4MQrOShOQ5T3tE9Ome8ApZyy9DjGEusjBgfOlIHiJec4GM7ULonsglykHuQLs6Wspwqv9hMPeA7Jvn7ruDs2RU2IMnAPUZG6Q7xsrN34gCiAqsBpm9IQptabuWApdQjbjDIKkpfPLqch75cZ0yHH0KKQVjbtZKa3bBMzMSw==;5:scz3845CamJ1BGDZkvt1BfKiftdSP4I5lMC9nLAbAJ29JzaiG0dXr7edacUoexOznSBCTb/Ew3OvboJu6rYLEGiFY4eMwKCoXTPR8XihYyg8toawoGUU5LWuqUtjebhoITTNwOM4R9V+TNrauoqTowQDHXRJiN+3L1FWV7puJkw=;7:xzIkjmwqLpSiBLlW3Bpy0XIzg0aKHVo7BnaF0uEmJzP7e7cCKOgJonh6/oTmDpn/aWzr8vZcR0833UqpM2k8LacUyCTEIaWHsZeROpfms9e4AYppRObyGmUiSZmKakQEwGnR8A90jnXe4oZvMXwNMhscw4w/cD0W61xWVpv48lE1a7Cc3Le6Y+n6erkmmTbB/yxaxkFCIpB6WSVMrC4bKpRc7pbVzi5Bis8YtwT8yS4OFrj98s75gWgk+TVz6vB5
x-ms-office365-filtering-correlation-id: e99f88ff-4ee1-4eee-5d83-08d610d5147e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB050318C73A5C97257EE5483AFB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(43544003)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(15760500003)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002)(70780200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: COACtyEhbuWwTJlOruwt/CUPQ1dScFAIZ40qjaxeM1eby2dUXZatCFtaUgg4lhkD+H1vB9M/E0U5V0lglLLbOHB9fX1WId34d2AmMcPKQFFjh3qPtoSt64D4IVYlKkokC5mTV0LtREHjN40FtABO1fA0aAdUu86gnD1P1OWepwvZlGOfINyA1WsqIH6u6VCUtiLX4Q9mEzli4fhXltQHrvd/01G9RuA+/C/7FyD2cYRxW2HSvPYQ54HNzNrp2GQSGGlBQHp/mivuE5Ut21FLIDiIY83DU1+LB7IORww/xBKiXcZk2syMzXWe7/HyIppPPz/9C36HPdyuTNzOaVnqC0JipP/fimArC8p88o6C6XE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99f88ff-4ee1-4eee-5d83-08d610d5147e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:20.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
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
index d5b44cadac56..c619e76ce827 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -117,7 +117,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len=
)
 	/* Lock the adapter for the duration of the whole sequence. */
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
=20
 	if (tpm_dev.chip_type =3D=3D SLB9645) {
 		/* use a combined read for newer chips
@@ -192,7 +192,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len=
)
 	}
=20
 out:
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
=20
@@ -224,7 +224,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, s=
ize_t len,
=20
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
=20
 	/* prepend the 'register address' to the buffer */
 	tpm_dev.buf[0] =3D addr;
@@ -243,7 +243,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, s=
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
