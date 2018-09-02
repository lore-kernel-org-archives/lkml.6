Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663FBC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1801620855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oJ6xRZzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1801620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeIBRXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:17 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729234AbeIBRXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsVWFqsvDuRLg1kIArNsly7dC62eDboJlmZ3rEQlw4Y=;
 b=oJ6xRZzRKCbRU+TsJxRFjJuH3TjSSMdjL7QuPmxO3+nHYaRG9ZHw5BUhS2YTqBUKBOpV5gm7D0wh9Q6ByVg1UU4EXnDU9Ahqki0in8ZNS3XLHKsXni6Cq/Ur7cwqMt3AlYrIys+EcFvoqsL8+l1rRZJxIhPz16atcNK7B1j8RFw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 36/89] ath9k_hw: fix channel maximum power level
 test
Thread-Topic: [PATCH AUTOSEL 4.14 36/89] ath9k_hw: fix channel maximum power
 level test
Thread-Index: AQHUQr3QscJi4h4OnUinV1CMLwPt4A==
Date:   Sun, 2 Sep 2018 13:06:51 +0000
Message-ID: <20180902064918.183387-36-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:nw+XdUhtMkz4/6r2iTTIHfVx+IUwrRXLs9z6ZMqy+TjQ0RigYy9rBA/6HwUtSmYigwkpM/A/ZR6jcEvfIscE4HkBySY26D6kVbDBwy2ES05gvWbXsM5S39v/zUrQkToO0ZZVSUsE/6efGGP9Yqtzdqpxj/4fduMc/qeXoAiZIqvFo0+qgmsUJ7R7RadiJdSVrE0hDU+P18dix70JPJ4d1wGaC1gL5EsoqJuEVX1lHgk4LzI3j0BNf0ZmyVxDum/QRfdIOh3swuPGYoufQV6p61pCdahgwQywGgVYi/zBzw+dbKKARnma0ubitPPq2Xwc8JveKBARVWOUu7yQpE2+z38GdYGW2BBu3sOxZV1qnGmu17JhoNTwRXIo4jwFC/v/GL7bQxvEgSUkCmSJOvN5q54KX6Tfgsi+0S3FQjlKg6F4OHGERZqb9g0IWB/HsC2u6qIe/JJRHm5Fia2AoUgrdw==;5:K4qmYS3UVS9D2RTxFzr68XspEEUG7J/A1yKWJJ/kfQSs6SlUWlVK/c8p7YmuxGRmbNvR9BIDVaTjTiaMx/92gRZcfqSlSONZjibnGtCZQv1PkOq+yLhFPLvlvjgnMNks2epiO6obejZFVFi/YN/C5rL1KJkHLf5Ihpdqj4AApdU=;7:lf+1GL8UbVmkW6mkbzZUUV6mc5/c6w/nxKKwNN/OyKRJiRDiTudiHrBGR0tDadtx7GZB8x3he4oCLctP5M6c+FcGOA7Ilgiv97Im87NM+kfCb2XrrF8xUYSp8X2LH8cdm8FCTKf8D7sQIdlNaXa76KNtS5DIUHf3JyKSxNiaXvQ6oXal0/yLjAOeJ1eTJl1rZkuy7tqeNYyYQ5KZ+D86CCRukfd68LLjaS1cO8v7Np8uqgDFbcOqnd2Lx1Qw52xg
x-ms-office365-filtering-correlation-id: 491d8c69-fcbc-48bd-4c70-08d610d4fd92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08567FCFB197E9E1D39101EBFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(575784001)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rIRcgAKkd1nSXV9QoSet9jx4JD4nwSzLYAWZfovHXptgq7U3FijmyZ6p7+iH2K2hi8BQLHbT4su/wTr67x406RvjYR7XVLXD90hCNwONlyFqP9+qGQOCEtd85FY9W/5X+ChTNogqsDDoFFmQdzTZ6Cxys+/1NA3u+OLLbeua9jmOp//Hr2YBbWBid7+yrme0kUSnsuIOcH6QE7iB80iLOIxBm2UTTtzMhOu8MV7ZLz6emXXpm52qks2/UqoPKnGDvhXmavKlTAz/Zgt7/aP6yqGpppF2Do/gkj+I55RNapl3UYGolc7fGEpkZNmb2RPbaBbv8LQXf5rledrMfxYKY7axtMrDihsmYnifIaPidNA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491d8c69-fcbc-48bd-4c70-08d610d4fd92
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:51.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 8c5c2dd8fa7f..a7f506eb7b36 100644
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
