Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BC1C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6B620666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DqXxJnnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6B620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeJAHNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:32 -0400
Received: from mail-by2nam01on0138.outbound.protection.outlook.com ([104.47.34.138]:39861
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728730AbeJAHNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seVhXL3ybbW16t6/h4zyvlIdNwpy+YJlvlv4HtAM000=;
 b=DqXxJnnFO7/q4OfgjzUg6EaLo278jRWNle6x5hGCXVye3R1Oro72uzF13USoYMNJsvItrXkGmCWLaXhU4ocspdLYMItxfCJJkKYRZjr7lQHAPhv0fcejQXv818/b7DLipIEUm1bHPUDTRnj5t5Uin8yXB61en7rforDdUNynp28=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 28/65] HID: i2c-hid: Don't reset device upon
 system resume
Thread-Topic: [PATCH AUTOSEL 4.18 28/65] HID: i2c-hid: Don't reset device upon
 system resume
Thread-Index: AQHUWR8NXynYOwTdXEuWIJKGH5hbEg==
Date:   Mon, 1 Oct 2018 00:38:20 +0000
Message-ID: <20181001003754.146961-28-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:WR8AM1tFdSJY313kK1Y3q1v+J/ZnSRGMU9UOEm4o/JJSU0m81Bm4vr7ipIa03RrjwnkO+o+scbBCREBYu47p5ztkF6KiBaGLi7dOnav/7MY89ZK2HNctUpD9MXXJ/zapNG+h3E/imxlH7VbGKAq8DZlU+NkQjuSGbhBu6gjBUhuHbgqMq4wWDvCC2M/xSq0il0XNXVihrIoVKP3hv3dZkSkb/lZ3XaqbMgPYCrCdjdw0r3XLZP9GeHn5KzBBydGl0g7ZZmuaOZ4qDaWVizCUSfEw3LnsDi6PMS0CBuwAC2zKEcD5ZsYk5m630wE3b04PQ/MHuF/vZYEFZ1iYKZMZKP3eZSnQLFwUWhmDhFsdLA4NpgFSpk5qU/Lkdyc20XIq9SYL9Kgr3AHWDtauMzq8Sw9kl/FZozymNUh4IsauNS8EyNRcDgSacdcvskzpyU5FgH6tdOi026J1+NtH/5UX+A==;5:PL7CrNK5IApYsEzTH3+gyqCOx7Mm1AS8aCNxiGFVp4vwVVIvmopFypMAK9725T0Ee+/g4eTR3VDyAF4qS7N0F2tculoq9CngB7Xskaw7d8CyyvFEflfL51t9EGkYh2r/UmUUmROKRy9R+6jn6pCQ9tLSeFJQY+xlfQv1ES8QnA0=;7:CMvfCgqxwpNbtfj8xIAC+GdeEmXIhqrdzpyQ5dVZHAxEDd4gkwuN5K2+t1qDiHPI9HwboONsMRt9UZC4IWKN49DjZDT3ezKVlIkwlNXzXGZOCVNuk7HyS44QCO8R+OZ4tGSGgjvTxmqRi7T/973eSyGiJc4VzvKe9Tu5dEX2xy6/pY3yfseBZ1pSrumD4Cvvr1LEy5PWTOCCk82nJTYebz5lC3gNp02nNBGMeUKizssGyaRirWuE/F5/e90olqA7
x-ms-office365-filtering-correlation-id: 140b32a8-a59b-4941-357f-08d627362fd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181AE0222752F9ADF7CF1CEFBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(198206253151910)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YSCisSrA/V7Afmo8sRg9QjoqUFtG9+CZH4G7oSonNmr/jRKKpZEmMhMiq9f+k3Mxa90v2G8YB2Bj/tOrB8T3E35lT7f/5gvGmklXjOfW9zr4aZxeP06Cagmd3FV3SP3R6pm0pmBpvmkvMLvr6AE2Cy0MwDk8IlMMCOKgfIPClhgyPpjWe/ag1SzGg6IT3qTLn44zzCQSGylxQizffixdkcJXozbe6Y1V3E04+yhgg5gPsEWsWaKeiKJhQnQyiwoWFWkABLzwSdKMnBytDPh9J2gd7FEa3C1M59YvmCfhTytsNytYMuF3MC5EJBWdEjtCExwfQX3+DHAig9u9KICl48w4JCN9qzmSq6+M0/t7VnE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140b32a8-a59b-4941-357f-08d627362fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:20.1869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 52cf93e63ee672a92f349edc6ddad86ec8808fd8 ]

Raydium touchscreen triggers interrupt storm after system-wide suspend:

	[ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete repor=
t (58/65535)

According to Raydium, Windows driver does not reset the device after system
resume.

The HID over I2C spec does specify a reset should be used at intialization,=
 but
it doesn't specify if reset is required for system suspend.

Tested this patch on other i2c-hid touchpanels I have and those touchpanels=
 do
work after S3 without doing reset. If any regression happens to other
touchpanel vendors, we can use quirk for Raydium devices.

There's still one device uses I2C_HID_QUIRK_RESEND_REPORT_DESCR so keep it
there.

Cc: Aaron Ma <aaron.ma@canonical.com>
Cc: AceLan Kao <acelan.kao@canonical.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-ids.h         |  4 ----
 drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6046150373ab..eee6b79fb131 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -528,10 +528,6 @@
 #define I2C_VENDOR_ID_HANTICK		0x0911
 #define I2C_PRODUCT_ID_HANTICK_5288	0x5288
=20
-#define I2C_VENDOR_ID_RAYD		0x2386
-#define I2C_PRODUCT_ID_RAYD_3118	0x3118
-#define I2C_PRODUCT_ID_RAYD_4B33	0x4B33
-
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
 #define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 5fd1159fc095..2c15ad217b5c 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -170,12 +170,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
-	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
-		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
 		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
-	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
-		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ 0, 0 }
 };
=20
@@ -1240,11 +1236,16 @@ static int i2c_hid_resume(struct device *dev)
 	pm_runtime_enable(dev);
=20
 	enable_irq(client->irq);
-	ret =3D i2c_hid_hwreset(client);
+
+	/* Instead of resetting device, simply powers the device on. This
+	 * solves "incomplete reports" on Raydium devices 2386:3118 and
+	 * 2386:4B33
+	 */
+	ret =3D i2c_hid_set_power(client, I2C_HID_PWR_ON);
 	if (ret)
 		return ret;
=20
-	/* RAYDIUM device (2386:3118) need to re-send report descr cmd
+	/* Some devices need to re-send report descr cmd
 	 * after resume, after this it will be back normal.
 	 * otherwise it issues too many incomplete reports.
 	 */
--=20
2.17.1
