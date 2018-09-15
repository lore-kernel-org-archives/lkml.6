Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26F1ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9067C20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E1deGLND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9067C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeIOGst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:49 -0400
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com ([104.47.41.137]:63496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728812AbeIOGsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8lX7volineGpeseYpXV5+rPflYrSNGn8WIVGeIsIjY=;
 b=E1deGLNDcKg7kqiHkr4WocOQphaC+kD5YfU57KMsiswn1EqHqggoAG6ceYHRug5XPkrrEjhylcBHPyqMBCdq/hUqP0T1ikq4CAyfzvvNo+3GEBXz6GLe7/BcZXuoSyUt+17/X7My4z1EyRkdtdTolrTCTUkPQPg78CqX7FUU2tI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:31:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 90/92] pinctrl: msm: Fix msm_config_group_get()
 to be compliant
Thread-Topic: [PATCH AUTOSEL 4.18 90/92] pinctrl: msm: Fix
 msm_config_group_get() to be compliant
Thread-Index: AQHUTJPAANbIf1mE3ESbdFfDuCpx9w==
Date:   Sat, 15 Sep 2018 01:30:57 +0000
Message-ID: <20180915012944.179481-89-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:5TJBBHoEaDENEEjU7LZFxXmi1uLCvjY9s6nx8d0G+t04lLUtT5TM5re0oo5bI3LnWvIeKXGhM4NyNJ5krCLiOVaZzx2oDVv5ZznfslDDRG1CxkcbcNSjpiz1eePyxnAWk57NP2dqo0K7p4MxCjOYMg0v66rWdfKEfDNOdJUXNM6NlgjvYhpXl4IWUpoz71pMKCH73towAX1liheCJxzq7ivMBSc2I3VZx0ozmqY3f6NxEQh+TwQ01pvLzAkSh4BXJEYcSPFCrX1pHpcjox2j/wfSFd/TftzyUNsM3zd8L1hgWOF1jQL8Xgxjc1B1RDdpio4jpCaRCCd+EUFUXbgIm4Y8IbyDClQQ1S1TY/zRftOA7155puwOxs2W7IMT9YqKgBFX4VEHvJXRj+TuGbw3jOs5i7s6go24LgkpthWH+0wXPMFx1gEw0qh9d7vtAcGRgs3T9OBu3aJFHqt+T885FA==;5:Z6AZezI0slrOjV5F/7he4/NdFRTDt9f9Qav08idufqIPk7U5z1MP52loeeCTNWo1vwJ5bXL0JrRnHHj7NVpeSkbEtrXvC+cqmgu5JSf7VF60n7NF8J5LKID2hxPDPbAUIlZpN6w+NmEEgCaInpPBUZsKF4UE4AQcFvRfx43+sAc=;7:1F5zNcLoGOitPTl0vb/e3f30LBkWda+kPlAfy/fcvN75AnpxyRMqGrSVYfNCE36IK/ViPct22oLVs24lfd4LWB++9f3n0poxKfA0kVXFtDTOQBjFqIkCxOHh9+5Ez4HigC2fHMKcqJ64gHy4F0ufq1+W/ucqi/3gNPye29nlfLmhrDHxTjFE0m5GIwbO8wY9iAq8bL/Zih25xXW5EmynK4C/y+ZCSeIUxUnhP4gnu+plIgV1T2DetyMD3jCazgIc
x-ms-office365-filtering-correlation-id: 9c826100-aac3-4aa8-89ec-08d61aaafde9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011725C25829281D5C49A60DFB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(575784001)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(6666003)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wU1km8jw6AHo3l6um1nxVunc+5bTk82qe6Vk6TvOZAIcekD4QR8gj8W9oRyO5EB88kzLjq8ZmWf4kFKDPRGwM0eRVPjWCI4yHEsCUmJisJIcL6Ty3en3SEZG/EHeIl3kjS7cfT0aagKyDrEiR1UcqnHO1Vhe5fCUHaYtTNx7gOtLL6lyeou8LUsXQpZOoFgOTh642QmWrS3mc2XgC7Qyw4pWVwyYKS0GmnKsgXjVI3zmWPGnZWgiscv/JL+xkd6FDyIxQ4YnP0yapy8XSq9vFpsyaLYELT708SHY4UJKt1fSDRCPAGI4SWStSjEF50y/mECUDjgjp/DQTCkPzNGlpSstp3Pn5DwS5DIimuCZXY4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c826100-aac3-4aa8-89ec-08d61aaafde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:57.9479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 05e0c828955c1cab58dd71a04539442e5375d917 ]

If you do this on an sdm845 board:
  cat /sys/kernel/debug/pinctrl/3400000.pinctrl/pinconf-groups

...it looks like nonsense.  For every pin you see listed:
  input bias bus hold, input bias disabled, input bias pull down, input bia=
s pull up

That's because msm_config_group_get() isn't complying with the rules
that pinconf_generic_dump_one() expects.  Specifically for boolean
parameters (anything with a "struct pin_config_item" where has_arg is
false) the function expects that the function should return its value
not through the "config" parameter but should return "0" if the value
is set and "-EINVAL" if the value isn't set.

Let's fix this.

From a quick sample of other pinctrl drivers, it appears to be
tradition to also return 1 through the config parameter for these
boolean parameters when they exist.  I'm not one to knock tradition,
so I'll follow tradition and return 1 in these cases.  While I'm at
it, I'll also continue searching for four leaf clovers, kocking on
wood three times, and trying not to break mirrors.

Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinc=
trl-msm.c
index 0e22f52b2a19..2155a30c282b 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -250,22 +250,30 @@ static int msm_config_group_get(struct pinctrl_dev *p=
ctldev,
 	/* Convert register value to pinconf value */
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg =3D arg =3D=3D MSM_NO_PULL;
+		if (arg !=3D MSM_NO_PULL)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg =3D arg =3D=3D MSM_PULL_DOWN;
+		if (arg !=3D MSM_PULL_DOWN)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_BUS_HOLD:
 		if (pctrl->soc->pull_no_keeper)
 			return -ENOTSUPP;
=20
-		arg =3D arg =3D=3D MSM_KEEPER;
+		if (arg !=3D MSM_KEEPER)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 		if (pctrl->soc->pull_no_keeper)
 			arg =3D arg =3D=3D MSM_PULL_UP_NO_KEEPER;
 		else
 			arg =3D arg =3D=3D MSM_PULL_UP;
+		if (!arg)
+			return -EINVAL;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		arg =3D msm_regval_to_drive(arg);
--=20
2.17.1
