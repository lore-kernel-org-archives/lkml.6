Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D93ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A02C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dQFu8sxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A02C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeIQJDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:03:46 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728034AbeIQIZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx2i8Ujjrtc8vebNcWTAluwsA2WWiEA7UHFcfN2A+Ek=;
 b=dQFu8sxna590VrsPgm8t1xPck7YTDHFnZ/cbxxPtYSJmxqzNr9tKc8SajNSJrTkR0/QO0+WEYXrrbEjxg9/kC2WluH7IKMRxP+iaYXXfxuOyak0lQz+OUO4tpjCY37147jzrHFf16PnJQ0pzMJ6UQBsQiC5vheXskUG9og9AoCM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 003/136] tsl2550: fix lux1_input error in low
 light
Thread-Topic: [PATCH AUTOSEL 4.18 003/136] tsl2550: fix lux1_input error in
 low light
Thread-Index: AQHUTjKN4bIUEC4nxU+e07p7BBEoSQ==
Date:   Mon, 17 Sep 2018 03:00:12 +0000
Message-ID: <20180917030006.245495-3-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:uraxB5nXypKHwzQFipUZUe/ZPwskYqLsuLfDEAJqCRsqm4pMPPMb87tJpoa2dwGVI7Umkl08OV5sfOF8dI0V+ZWO1xkIFC34q1q6C3+/5DE91eJyE3rmI3S9YDJ2UTuOOkWf1DJ2O/7Q/rVe2XG/n3KKepwQNCzWbwlRO/9nQs1sLWM/beFqMbMZcLt7MGdew4eC6oDCPM8lJ5jMs0+4qTKhdnWijCnumZpRfQRjDZos3F+VZrHMYpGfYN3UIAWk0mq6KdMdhPVxp4GPWmw6cCcVdl1vG0dgIUzY0gadoHYubgl7z0T6eKd6wn0+P4NFhJLl51hbidmG9FbReb0PA313yw5CePFqqLpw6gk8Aed9IXlB1RI5RgdBitK912TRI+sJSsRiavI6ut3GSrLg0MdOm8ioAwtjzOB8kSXz9MYX5Yu3Q/2uDo1JCUBZ6PJmiqhR5bqlj7gITWQRhjoBGg==;5:sfTztaG4AWzFnKxnmJmSTvxItxPE7BDvCF64pE0GJIKfYqFadXBACJjl6sCcmZK+Xvoi4BKx7XuDyxqvM+H3Zb1jnLXWdTM9vDHqX3U4HkhcOo4pS1kwYlkGhkkCAqO5n6sWRL4nJW7kdWKf2chbdzs8jmsbFCX0G8vLJCCQfLw=;7:HIXieALVnvqhWRuWtstjMhLbc6FNkDkAQJ7QU6LIrI6Re32v65HjIl6jdqQgSSRz+BJjfsacS7Yp0l99adD5ZEBido9WTWlYpEwBlAz5Uv9kSpyN1VdQgz+WroK8sIbYgd19S7j6hX+armBl2SSNaOJ2qBJdNQHPTJzmhmNGttU35sMaaXXFntGyCP35ZcZS1PrlHgGnOPPMZ2wb3Fe/EukZ2ZCPqYvoSFowb+NPiLMAuLnP9BBpv9FXev6W7Lzo
x-ms-office365-filtering-correlation-id: 0c731ec8-193d-4407-7c17-08d61c49afc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0134B1DA1047C7B870B65FB9FB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(76176011)(68736007)(6512007)(4326008)(25786009)(217873002)(107886003)(72206003)(22452003)(256004)(14444005)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(11346002)(26005)(7736002)(86612001)(5660300001)(86362001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(446003)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pO2XQzINBf1NP9IK/ZryNcp1h8wfEGRex2AslsKSAgYJitfseFk+U4p/lpYkc+Q1xyxOqriW0O/cgaVJXrTIWVVxds96pdQInT0M1dzC/ao/u3U24mPOesYP7AlrtqE6GOlv264sEn6XDqsg43PH3xzY1K3wo+FHsRHoyyZ4Fn4uuJeGHbjy7vbpYzuq/X62TLzPbinvuAdDeJjj1rHQG/HKmiUkVLstMAgKsZSPm3pmxs6WIaY/xyiE4Q0OM/2t5p1S0SGml1eQzWbc8C5gmvf+mxAVHibPr8jpU80xOUqilOOosZ1Xx9YhN3ZrAgICvKfH1S3B0/ZR9529XGwfVdpIrX9EnDsxrShx0J0JlWc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c731ec8-193d-4407-7c17-08d61c49afc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:12.5893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit ce054546cc2c26891cefa2f284d90d93b52205de ]

ADC channel 0 photodiode detects both infrared + visible light,
but ADC channel 1 just detects infrared. However, the latter is a bit
more sensitive in that range so complete darkness or low light causes
a error condition in which the chan0 - chan1 is negative that
results in a -EAGAIN.

This patch changes the resulting lux1_input sysfs attribute message from
"Resource temporarily unavailable" to a user-grokable lux value of 0.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/tsl2550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index adf46072cb37..3fce3b6a3624 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -177,7 +177,7 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
 		} else
 			lux =3D 0;
 	else
-		return -EAGAIN;
+		return 0;
=20
 	/* LUX range check */
 	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;
--=20
2.17.1
