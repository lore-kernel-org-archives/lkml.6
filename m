Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ACCC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7F7205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Sjlr8okm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7F7205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeIBR3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:29:36 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729218AbeIBRXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDiOlp3/b3GrFJEfXXw92lT3x1RdCvupKFTRUaHqVHk=;
 b=Sjlr8okmVgLm59t3yvEbbJ6NbUNGiNkUwNQcsd0929LXToJUDNBVMXhSE5x3Zi580VzUGWHbiDgIuwnT+n3ejVIkgIV6PLFZgpl4gCJOpX4Eb+wLxbrtG5UG/mglXLJXR5PGvkLipY4OMmYlEXVsPBo1ena5XOOUHv3x0F0M/pY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 35/89] ath9k: report tx status on EOSP
Thread-Topic: [PATCH AUTOSEL 4.14 35/89] ath9k: report tx status on EOSP
Thread-Index: AQHUQr3Pvxw2qcT2+UqjrkQtpfSItg==
Date:   Sun, 2 Sep 2018 13:06:50 +0000
Message-ID: <20180902064918.183387-35-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:JSS5s6W6ejZ2L8vRWEyOG6+M9nxQnhiy0L1GOmg72ArCWwIo54q6ic28asoWFDEMHsHT60wj4GsS5wPMF2ZcOSQSh9QsuugH/Kh6a4HkWTtqdXYkOXVHKhPlY6BsD20iBo1XeEUufzgwgE4R/jp6HT1NiYoq0P4vkFa+Xy/ICY8RqsuXExn06AWnoab1X8zROkWU1+NoBAjpQ4lXiwipc4YDoqpflxW92g8VjgROAvflyBwPapgwF4/boZfM1KyS3Tl9NculrFQuEEPO4wLSZ9A3a/xYqysb3dg8a4OtR20hd3fnBeosKejUjRHNU9ovQpmjPlEiHQyx4qQkgX8GzBSqIkJqIIjnfy6kqvEA6ZjiV+gHu53E4igcHRZhw4wYsLo1RZdLhRAo89/FbV71oZ2x+YKxd+qSbW6anwyAh6wxXG2EFmhyDlONO24UB3cQIcsgqMUvurMzVvGNUjL3rw==;5:TI0Mp05nDWh44tlwI1RZDweAcPjWgejJOxgBVHXdZbYgJrduGdvljJRmDP3mUj/SD0nKIUFeYHWWB20NSUcu2VpDlJyfpUkQf3qWQr82JQvee6lCRTr6t7pPgdRkCRy0AT3PZ5z3QsHb84K/zOapf60cswlMFYNj4jDw5bfcRw8=;7:rT0TTuUGh2wjbjgjdlG/rJ383VFLmwlCQ4z71zGwO+OxvDv1ndOWpFbjfCzY4WLK8rU3tP3sq8YJ8oEbwj/BvJOvLn7RbskInJ/C7Cdm6YAaS0zMhwTlqMyop2roJ7sUeVQmUxM0/nFh901GehR1BkB5T6Q4/PjIZx9aiOU5TxnLWoB0KTbE4bMurCrqu2YG7BEKPwL9imhhVp8N8SuPFoCq8p61HOWmTUDL5uVSMpN7m62vN2ze3fEtbMvWQZjy
x-ms-office365-filtering-correlation-id: f257d180-0be0-4a27-7591-08d610d4fd5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08562C20AB40FA63B064D821FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(575784001)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rwOdp3J4EPHUXqF1inuGb1C2qaOPks+QKRvRA3LX6urPFhhCrlmK1CEG5xyAESHfQyBHRRXkWej/lN8pYje7/RNaMWTXCGmG9mXkaiatFiiwlaW0Up/BTeljZNmoEqsbIECUNaGO9cwWfz8U2FEQnnq47f3g0c+iJnX/ILYYDroJoNPyO82ml/c5bvgKQnCkMZ4h2nGfBWm6COcby8FoJ8jC9WnqErIInikeFglIc9O3RkiQa48q1FoxvbK5budWMfnuRzi5TrVI2C3rAzoDw/HWscR5EyYL0+BIQJfECxJM2Bc2V/CCClOMQiijUpJjNhSXLAgWB5OxWNVk+6xRduL0wKuTYuExnA42Pc+t1y4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f257d180-0be0-4a27-7591-08d610d4fd5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:50.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 36e14a787dd0b459760de3622e9709edb745a6af ]

Fixes missed indications of end of U-APSD service period to mac80211

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/a=
th/ath9k/xmit.c
index d8b041f48ca8..fa64c1cc94ae 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -86,7 +86,8 @@ static void ath_tx_status(struct ieee80211_hw *hw, struct=
 sk_buff *skb)
 	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
 	struct ieee80211_sta *sta =3D info->status.status_driver_data[0];
=20
-	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+	if (info->flags & (IEEE80211_TX_CTL_REQ_TX_STATUS |
+			   IEEE80211_TX_STATUS_EOSP)) {
 		ieee80211_tx_status(hw, skb);
 		return;
 	}
--=20
2.17.1
