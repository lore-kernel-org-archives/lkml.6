Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0246DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A470B20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gFCxrWbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A470B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeIBRag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:36 -0400
Received: from mail-eopbgr680125.outbound.protection.outlook.com ([40.107.68.125]:33856
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728758AbeIBRaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0ogWI8uQujzj/2bxJCzR1HhPn3ePFOhTFXDVS3HhPo=;
 b=gFCxrWbmCCmYw5HkUGACmqSszSoGhAUo5PQ/DGXzxAowF93J2gGuEK88l3qQDll7pLM2h9367Sp8dIxuFuq/W9d9XT4cyqDhT0Zq1ialKWJqdRQ3RLuA9Rpp7nYHamCNdG8JcJZAYcmipb33KO9MhcoAL+BIkLdl3Xv7nH9DQgE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 34/62] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.9 34/62] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUQr7rskxPIOW4/0yRrXeOeZ21kw==
Date:   Sun, 2 Sep 2018 13:14:46 +0000
Message-ID: <20180902131411.183978-24-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:u7DQhBv02KwdUB3oyENmWzQNf8jTwbL5wvYI2TV2UUUaLOzSmtgXTXbrWeuM5CqUaAetdCe9r3M1Am9E5ptsOlGnKkEXU+bT+W0CUvVxRHmnaJhFnZfiLfnJ9L+KzovG+cgWt70zAxJz2v84pcA2w88kxFhHAMJFK2+HtzeqG2tGzz3K2wd7IZIwkoCq8cdPOTS6ZjZESlWtnOR56hKS/ZiejKnjq0VH5qA1BEz2nCVghZkrg5z65YAIbgvKVE50r6beNxASeiGRdC/QxRNz53/kwNOKEmAjjD0wIV8RbZLJ4RFwwH0E9iYHghCqjuWEnkLCmJOI5Ux3zXjDAvSex1dYDkrkFC7PnJVEIXfJFjs3cuhopKYGIPA4w1xIx1eMQ/RbVkWqep8VNTU1kFrAYNbnfK8RtCQjl25qRoF2V2YhdWHwoJCamxdSZrQsj9h6SmpRKFHUlLIzj6FPbD36XQ==;5:A2CZ6h36lRnq+ZIBbzupVFsvPFjV2YwcSJCOM5fb63pRy87bK414+a2e5hTHezuHO3hlJRE5mVYCu5A8JJeeAIivoE8mDd1j3KJoBgUQtD7x1n4Lf8faLtDSD1VM3jlzjihfHK6XEf0EGB+bxXQX8M64jTXPBFxSiWfiABkt+P8=;7:IXCTnv2AphiUWdz3lFqIn/45oVI8NxOaIGh90SNwaJyom7gr0iHx3HzhCv8VarL2nw1NznSeLCkKLbLZygStVc3CUNmOp0eRNljgdwMFWCyZS3hLc9veFSy2tnI1VogzjDCkqLqj39LWtmCiq5cAuTTW1Fg6ISM4tFW4/DCldGn/RSQAu99VgC5R8WVSXEWN4HRFM08z510wQPCD+uANv0YB3NPZWbRSqOd+xGsMtfOCKZa7/nfWkB2hKG5uA8b9
x-ms-office365-filtering-correlation-id: 001ca7ed-887c-430d-b286-08d610d60e40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074120F19C7ADC05F2274E59FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(43544003)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(15760500003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003)(70780200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +aB/jK3hQ4AaUyv/BzvPTiG86G4mFSdb+ocrX0/Tanh8dpTERB6HcoY5U9ew0EcMJDg38vLwPE9kUoOQpvm4OgUtvUpQAKW54zUzzjFof9QkcPlOvv6VYlqWp4fvs8E7oZbJUz9WOgmJ934KusUXGp1F6k3Okwwh0ZM3OllWBjst5d+O5AONt0luY4/fdolvtWEdanlfH2qf8PWqRqTGp1alln0C3N90LvFI1UvYWBzfuagQu1jvmfpHi7fPaaU2Y1ZseRAdhVf+qAAUSyWau2tLYIe9XS6CecQdObui4Y2UwBLniGGSbh60AtaCiSuXMDklu916QHhyMJGgT8etstAd7Vd6XnbhqejdgviYbEY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001ca7ed-887c-430d-b286-08d610d60e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:46.5889
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
index da69ddea56cf..b15479ac0f90 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -115,7 +115,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len=
)
 	/* Lock the adapter for the duration of the whole sequence. */
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
=20
 	if (tpm_dev.chip_type =3D=3D SLB9645) {
 		/* use a combined read for newer chips
@@ -156,7 +156,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len=
)
 	}
=20
 out:
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
=20
@@ -188,7 +188,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, s=
ize_t len,
=20
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
=20
 	/* prepend the 'register address' to the buffer */
 	tpm_dev.buf[0] =3D addr;
@@ -207,7 +207,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, s=
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
