Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232D1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84F520835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TeDvuete"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84F520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeIBRUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:02 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:31968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727414AbeIBRUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3YP9Cm7y6WKXp8TBFE9Ff0NLIHzeOAkj1CLe9sIB9Q=;
 b=TeDvueteiPB+1GtrMcTdzq21uDxQOgssUwQX7k+B0sFCtoAC+I7w5H5EWaBtRJ6HRgCXWGYfDisuns4+jidq4OMGx1Rr0SX0f8cy1P4bxZw2KSHJE0pC9Wm36NOufTBm0/eQvg1KeL6Jx+qK8ZtFdBiV3JLNDiSAbk6fu+6vRRM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 053/131] ath9k: report tx status on EOSP
Thread-Topic: [PATCH AUTOSEL 4.18 053/131] ath9k: report tx status on EOSP
Thread-Index: AQHUQr1vAt3Q8hZhbk6+eOUOSYq5UA==
Date:   Sun, 2 Sep 2018 13:04:08 +0000
Message-ID: <20180902064601.183036-53-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:zhEYCtiXWBRbeIJ/r6lrAn8nxc4Rk8C+OG+1PhgmHRFbdQdTyyiDK59S+teMn7sWO5Xg2kPeZFckmZeCEh+Evbsg9xo2/vmMv9pSgls95GBedIPHdtPdXBmNqlZVUSF4c5XIrESsvx9di+NX3AdkfMnm3U5inQde3+LhmTbLlg+C9i5bPKGpdifMVVDk7lpIs4vF9YYulp9q7Gqob4yyS/5eaQoHmRbtnnKlMT0hMYT9VYq17Zs2fdQ0hEzeV3w6pUH7tqxjo+jvAijtWHzAIArQlunUhOlRLSq28mnpsJdB0ayPqDyeYtv7ltQAt6gnlO3xJxhlSoVO8DB8INajZmZE2DjGSqy5CfkbuffkcyQ5Mq5/ossYuKPCven9AGJ20tF2/zlMK7hbL2Dsey55mBWQWZyDAD8I9fm4fgYMTv7qoecvY/p9LyBYJO2X2rm/LM0yBtHhyGnKM6UtrSUpWQ==;5:9+/y+u4mbvZ3ueozD3PyD012HdjHNTM647OuW0Nt0mX26rpCIcDanR/gisBYEMPrVlMbBQIYY0XpWewWz4Y486QqOF6X9HRsEGZChqkwyo54ziliHtAvg85Nsp6yDlW6dOymKpfYsp53adDT9lsXwvBpfEKDpCGdRpnYpcldS/8=;7:9/caYIUU1s9X0ZWMy/dotIgjgt7hfU5g0XEX2lbZFTlTU75Pp5RpYWKpktV/+Wir9KpQ0PSzZgtspqzlaN32lRO7Od6Q7UxbmhZoPCdqBz2Y84gvCcJGwaOyTnvCRNeVRlwT2MoFM0Sj+nrSTscdilqyV5FG0exwzI328Nll79u+QsZhm3kbX+lGWz+qxGCO4Wrx2MMOg2oiJnZGnHNX/mcZAtxLjv4dgXkk6/ck51IsZ5DVXMGU2kfedzTv3bsg
x-ms-office365-filtering-correlation-id: 1311cd26-0930-4e88-0abd-08d610d49622
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01204D19FE2771DD26A23E20FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8ElToTvUQFfzT7E90LvRW5zkjOTmWB/ISwHSUq0d6nWAHzGDmZ2058/qEfocTN0EaSs3lHRxD7EMFx4Yg0nHD+tW9vniMdXmYIkHVfin5ddp4IkYv9TRcxbb1j1WVgaHx4Sjp3jGb6c9DduYrS4JVzVtcR6eU46HtqbCYyqJSS+9Nwc+gccipzI3RwAFNPIxTmwWgXOqlq+5zAjHu8PxXXxydrEOLOuCWu9P/cduMiTnzsz4Kmz6EyxQ32UHaOlLUA5NvUwI2sl6aQ3D7GreQ30DNmg5uwNChnY3EVyyAPNlfLiuZU9fUrNpnU7jth4/VxuCdsojCu71600raOkB5SYwvBdZGgaM8jlYSUbnunk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1311cd26-0930-4e88-0abd-08d610d49622
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:08.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 7fdb152be0bb..a249ee747dc9 100644
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
