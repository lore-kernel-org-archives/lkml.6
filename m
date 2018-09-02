Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A0DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C99205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nXyGhufH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C99205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeIBRaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:19 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728725AbeIBRaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnH2SBo4tiK7TUVkOGRr8pfxAePS+NpHPkYy7oNJA9o=;
 b=nXyGhufH1gmdg/v8FGu/mz3hkEc/KY3L4ao1I+Nb5KCsi3iA7lQdeA3oSRb01gkYo7cekIH9PHxnj5jrDyiow2wI7t0ydR0fpYEOdz4lA8RwB4HbTe4WBeUmBYMJcYclULhXNSjXh2qm3PH+S9wAhyxK2h5pXzVPHmGFG/aN088=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 19/62] ath9k_hw: fix channel maximum power level
 test
Thread-Topic: [PATCH AUTOSEL 4.9 19/62] ath9k_hw: fix channel maximum power
 level test
Thread-Index: AQHUQr7ebKCGYi5uXUS7m2sq4ZIWpA==
Date:   Sun, 2 Sep 2018 13:14:24 +0000
Message-ID: <20180902131411.183978-9-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:7uQHyx1AtLcWnR2qKSNcIZe+FheO1nNnhkSjNuJwBXjVWj3L44UrGeZUKvCnvbZtfOpHpCcRHHpWuZ9MrcH4e9KG1Yq0RP1bDS/Kf5oqB0Wlb5tid5AaAWbXC6T+CMGdmmZ1ZpvXeH9MM7o+niYD4Nz8xIqo6GksB+gOKNH8uxa7Ti9qa3Y5k84uWaxzLno0zw3Q+AO9FwOwAhik51Pha6MBcty0+C1/AEbAmXrHSaBMxqcLVvHoU1V/SOw/HP8huhVVjHfLD2V5FYd1Weq2OPC8v7KWjBAn/jx5uml/SP1b8sIR6Zl1jHRLKlN+PALzKnT34vzIJiaTEEuvhfiXr+20bwiX1DtUrNOsulZgogUJKuoj6iY/wCIDckc0KOTFJcSU4K7+Y57z1NZXFvgA2gNe0hEUEN6VAxnQRdSNWGCoo805bZ/SHW5sKS60+8HApL2PP2wbd1084HC7tgVC0A==;5:ckJN6KztRizjsiaTVicGx7D9+bqOVE7HzYnz6CjcYcMPvGHaoZr2HP7ji/q8QmAuSUvAdxXKZ5IEy6PIt17DKEofngI6KVdbgXnvXp3iV9kL3MmzVYPZ4O6Ila2LMyh2GmpGrlH0mU8ZOPFPONMgQakyBb2JdU05EHAzvxCJ4ds=;7:DKujXAGABblWcRDt3mDXOf/irolBec+SnjrYN4wC5ruyGiIiFZtxTFTDCKjLG4r+RjQBLcN10nwHBQB2sqSaWOrLUu1RYmUrGi/mZc4IZWFyXc6zSewMuoRieDTveUeF3oH7niH0ivqXFTeZEN37oJ9+Ja+i2a0gG6nJ8gnX9iUQm5d+AiXX2RUO9vgsXXsfuYX5SsGB1VUdfcTbtFAN8xgIB7TKAPSpeSeki93patnR44x2ax9+Rv3AIPQPm5Wd
x-ms-office365-filtering-correlation-id: 2b26c16e-64d9-4a6f-604e-08d610d60136
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120EEC9C1091966059BFE00FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(575784001)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YicUWoI571hy6DEFzfCBSsptT1FY1tJFBrBhEvvbe3b0vtvxE/APWzMR3614ZKSoRNOXqdl83BPX8OvFYUNhWkVqKzr60kp/bIDnmbjWlGHcbqwy/FlVDRntYkFeisDoFdPgkpVo0zYyqCBGkg1L4JymiROMzq57IcoMZQDcSG82CLUb1TjYy8n8xyONDIJDOTcIWy64lVHIG3DA067IbvQaxHJvE7jwe66XEbc1WYQjkCYssIh8bajqoNdHDw/0ZNPr8gmJgWJp3AoC+jCkMcjwFJ8XFx8YSmAweksjjKZYWW2X0Ikd1WQN2HRR5vYj2P2IauyKfnLaQ7y6A8KwGZNMDzXU/U+t1/JZ/sHfV6o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b26c16e-64d9-4a6f-604e-08d610d60136
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:24.7279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 461d8a6bb9879b0e619752d040292e67aa06f1d2 ]

The tx power applied by set_txpower is limited by the CTL (conformance
test limit) entries in the EEPROM. These can change based on the user
configured regulatory domain.
Depending on the EEPROM data this can cause the tx power to become too
limited, if the original regdomain CTLs impose lower limits than the CTLs
of the user configured regdomain.

To fix this issue, set the initial channel limits without any CTL
restrictions and only apply the CTL at run time when setting the channel
and the real tx power.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath9k/hw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath=
/ath9k/hw.c
index acef4ec928c1..951bac2caf12 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2915,16 +2915,19 @@ void ath9k_hw_apply_txpower(struct ath_hw *ah, stru=
ct ath9k_channel *chan,
 	struct ath_regulatory *reg =3D ath9k_hw_regulatory(ah);
 	struct ieee80211_channel *channel;
 	int chan_pwr, new_pwr;
+	u16 ctl =3D NO_CTL;
=20
 	if (!chan)
 		return;
=20
+	if (!test)
+		ctl =3D ath9k_regd_get_ctl(reg, chan);
+
 	channel =3D chan->chan;
 	chan_pwr =3D min_t(int, channel->max_power * 2, MAX_RATE_POWER);
 	new_pwr =3D min_t(int, chan_pwr, reg->power_limit);
=20
-	ah->eep_ops->set_txpower(ah, chan,
-				 ath9k_regd_get_ctl(reg, chan),
+	ah->eep_ops->set_txpower(ah, chan, ctl,
 				 get_antenna_gain(ah, chan), new_pwr, test);
 }
=20
--=20
2.17.1
