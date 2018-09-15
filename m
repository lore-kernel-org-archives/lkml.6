Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD68ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5B121476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e9mE/4KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5B121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbeIOGvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:03 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:58848
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728462AbeIOGvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hwvMG7YsmN+ZUU4Uo+JcdQlWnKFeIatPfZ10IXN/9w=;
 b=e9mE/4KZ5yGgZt7j462sT4Wj6JO1nrkdb1rNrX6ilCpRnxL+hSVt1Z3gDwuUTVvtEy+lZ84k7lsZQZfjsSlQCAs7jCInR2dol4cRDr9tG+KOEmzTxfnziQM8oCek2DmrFh+lmiwrlhHQsXXzoL4AGF3fWiwZUG06QchthxddeBw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:33:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 55/57] pinctrl: msm: Fix msm_config_group_get()
 to be compliant
Thread-Topic: [PATCH AUTOSEL 4.14 55/57] pinctrl: msm: Fix
 msm_config_group_get() to be compliant
Thread-Index: AQHUTJQLnnxgZJawqUWWTW1C3MX1Sg==
Date:   Sat, 15 Sep 2018 01:33:03 +0000
Message-ID: <20180915013223.179909-55-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:7mWPTrrPfjWhnc4s9v542GSHEqzHPyD/roRZhkXWnKBMMiA205p7LWLsXPYHQZ31Cp11pdq9YnyUZwadiuPZBwhN9EpJO2bjDU2zS2lVQqatR5TraeSxLFTan4xJqgHavpeckbDqa+YTAr4nX2JH/YPww4LUtx1L6BTBXtub1lf99bWHDb538TWeYpjKYJNDpHa8opqM+7/cbB0PaXct+CYdl+LxJ+8L8G1l2p0OcoLXQws1FFq2GrcrQBhWiZZKK0RYuNnKxbJ0Qh1I1xlTqFtfeCO01NpRMPLybrTHvzgeARedGh0s3O+2CHSHOROPgBVxwzC/AtOKdTr/Pozs91XZhe68mcEeWpsXgJtjRXrsGCn4GGUcKd0s+MVmvdE31mNp621ZSRY5RWI18auJ3m2VHv7wJAA4Ok8C2eVwLGKlVXsqwe5E5J60WeNH2NHXrqZ/duoJVsNZfDq1pvhnKw==;5:8LJECMBkT4YZHAtLGr92jRJXHmmjBipwTFZlTVii2B9ll07q3Okt5w9CKQ+bNBGvesauzyFswBFu+SWWaGzlNhO+PVnUZHUA6v+0LzMd1c9hYa3ecdpo5l22k5XADKQ9KSMx0sDGpUkadd6d6BFW89RDLFHKG4HYDnlysaWas38=;7:lPXiwrxaqmKmgdJhy/U+mMjH9jglljh2nPhBO9lXMgiW/el0lqt5dnOhBjKTnjZ0P7RQfP2AvVll2YPOllhyKtW+Uqy76TGTf22gBK6k5NnjOy3bgmJmsUyKsjnV9rPCU/Cam2OqZu6G0l2yYBkUZmcBPC0at+VpxUEFKU+W48wndiJj+XVjx/wFBQ+82T17DQRIUJdZlVI9Q81H9gy8qI7OEicdO3WQ7L/CNs5i3l/ql+xPPpLIwxyA/j63KhOr
x-ms-office365-filtering-correlation-id: a15167d0-8798-46fa-433b-08d61aab3c7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08553B2133477203FC5B6187FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(6666003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 19oNkejeCsszRSJ6weAmZ7yqkfpQhXbM5MM9VROFVvzbWQ4GAj2UL7/xTY2mVrt+QlY6APyzR6+wZHYJVj8CuZ5HZ+gg5thMx1Xgxy4BtpeDmEJh37HbDs+RhAErBXe08WvXV9+rvUkViEb/IQ/Ejth6efQV/Hoqv4S41E7dWCd8yGwWUhRoTp80WdyFIEKcfVsuNkx9P2XDqfkhTMYr+SPEV59juBnqrS8iZLQNwmStaM/+jL0KlXBrKsjAqx1HIo87H7PjzfVSVj/CRejwXXHKbtzvyelawdbzHN9NNOHVJtFEo8RtkVHT3R8ZokbW6Ne9EAtost59Q7Je4cmLVmRSOL2sAsNTX0bTElzARuo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15167d0-8798-46fa-433b-08d61aab3c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:03.5394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index ff491da64dab..31632c087504 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -238,22 +238,30 @@ static int msm_config_group_get(struct pinctrl_dev *p=
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
