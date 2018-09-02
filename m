Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E95C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829D420835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MXX3mz/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829D420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeIBRUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:54 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com ([40.107.68.117]:50363
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728335AbeIBRUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvUs/pz4fYOa8KmZEVYgSIgg7T/F/rpqhTL3kONKt1Y=;
 b=MXX3mz/UWwjZiD96iycb/ypEyEWsTP8BfwS1kvlizOlOS7ygDDVmSYcKZfLNQaKLg3eoTKCwsvlw1oa0fjV7SMJ8fK6USvhb750SFEb70wW6SvVbsJiTd6/TywzRq459cJDuQYuuseP2kYlrrk75hXTAVvNhJCOmYqlZlLvLstQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 085/131] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.18 085/131] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUQr2ISDfoXTMMsEeDt++jixhOHw==
Date:   Sun, 2 Sep 2018 13:04:51 +0000
Message-ID: <20180902064601.183036-85-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:77ye9CR9SedFOSvYLKUtmQmkIWeni1NvUqlS/LuS5bdMi0kTXYMgTH26RsoAp4A2WTWgCql6Oxt9hHn50lZvwtvlN6Ui3X6XF0DEAWEYby1lbLt5Z/0fBiuHOTx8LLLeu767i3J6Zr+QIl9Y0e89UFaVPXp+qaZYQIF51/9rJX8aGhhQPomk3t1JKrpYJykgr30jvMD8MkqjYZfsSbCIxUW/XcXHcw7L1EKEZkIXhihK9e2xjwQ29TBeKLTjjx5gKL/VEiFcFq61fJzIWcqUQtiWBIPZsB8nICrEUlRvrYE9dk+FOIOcm7Rb9NdF2qgD26UbJMSOJrzh8/M5xHykrjH4KE8qo8iQFwDOvhTn2+oNSAwJG39KxfSfILk092SfQwUOjVpjdWeyxo3QzPmREoaIND9w5Uy4VRWV9o9TaX0mkCdwle45H8bPPjx929PWb1MDhFyJB5oGCqHz5AXHHw==;5:IcTVIxvCrCCaCkaEdPsiwenf9KSPoFaoNtWholkbTfK68Kfxp3DtBsTQX65E0+A459fCvxMi20XWhUjGWCCmHm/XTDk8jZhO3X9LiTDb+ad1WyZ7YOnB6Q7G02RSPKwIDY4Ue28TzkOKf80yx+esKqoWJ6i9Pbqj+NRWOO6JJCk=;7:NQ4dvkRVFnnyCVAmujYpwSpXawvkIfKFgMENh7dKX5bMHP/8amd/64oj8pgaoci2zJS+Ao/3s8Y8WsGh9d4hzcb8+YoKb/J3ku5OmatzuFWvBP5bvXMP6PwB5w6Ip04lkSnourvzRGQvSYkdv5tPqKhuAnp4hbUwN4568hfLA5rIvIKk0dsJTFJ8i+zL4z1P+s7dOh9mZaqvHp3RM15IEKUF9FgBFlZ3OBRVnFyMYBwA9lx3cprQpngk1j7WRo7f
x-ms-office365-filtering-correlation-id: c14ee241-ddfd-4952-152c-08d610d4af9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07411400729EBBD2E94B7C24FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(43544003)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(15760500003)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003)(70780200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wjSVP9z1l8fb8UiXkTgw1pC11FQm79/cVG7MdW3RfP1f7we9po3Anx0XZjVa4ODa84eMEDpjzaUQ+t+7V5/MGCCED3YmJQtULxzAcabcoqMtN5I/brOpxx/0jtkU39ouDhHhR1ox4d01Wk11s6xqr4d7Q5EWfMvNv6bkNNpow0PL8Tqgs2pLcteK7HKa6rY87pQWfoASu7yvfNSzcaDTvFE47E4luxSgYhPfqBFiZlDVfcuMJlwdFOCz3Ccn2fI2PcaVntdE8Wj98Tq4HdxgCrdx9uYXkPnBboG/5AZ2lBzTt5nusEx0kMT/58vkxxKEckYOAmVYxdYl9vXEpNiFWtKngilmUR/H3ZaYDBMsc7U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14ee241-ddfd-4952-152c-08d610d4af9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:51.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index 6116cd05e228..9086edc9066b 100644
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
