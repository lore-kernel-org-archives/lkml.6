Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A61BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34A820835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gHE0Gcez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34A820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeIBRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:47:16 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:31968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727959AbeIBRUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFx2QOdRpdxBdDOuT0LQVCslHTWb9eM56pGlCGGDWfY=;
 b=gHE0GcezTvOQo7vtYO+wtfx9FGzuhAugq7h1jpPk5w1zqGpORFy0V9+NciPlKzpuhhxe1OTLsPZHlBebDRO0XwCVCZ7Zvb3bSMtJTPcA0ioeHzcP27FFo3KzsUsjjrNGhJn8PK3wQ7Yn4sxJ8Bm3+FrQ0h9GWUJbBOVbLacLFb8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 054/131] ath9k_hw: fix channel maximum power
 level test
Thread-Topic: [PATCH AUTOSEL 4.18 054/131] ath9k_hw: fix channel maximum power
 level test
Thread-Index: AQHUQr1vSXkRVsY8LUuSHrGZLT0VXg==
Date:   Sun, 2 Sep 2018 13:04:09 +0000
Message-ID: <20180902064601.183036-54-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:ZajBZB3Vz47MysIpz3Wg1i4ZwZ7c3JS0gB9yc0d88YyDqb0IDzQgdmHVAUqmrNiKUipDVsxzGA2ypQ292hb4GpQpjaSe5j6/QVHhpv5I5TL6dNO1vziQ1x5lbmqFYEV04bPchXDtXPI9jbeKDHVuNfVseROdBDwggzQ+wykZYvAjsyVLayxWQ3nk7CWyFlcH1rPJjUzXT4kDRGa0A8OI3GsRrgl4YeZrgHwIXDvHObCBSEfY+OmE+2uEv9twHP9foHcVxzGnH3Nz8QonOtR/ArHnvgwgXuML6bpsGth9FdcpDYfHy72eNaDPn3z0c7W9El06HE5+ezFbV+k0qyu8plSPHB+y3EVvTCKesXfYTqKdUJZUF7hCFTS23fJzrBV0OmySW42karUyD18L2zwdmR7wrYR1htaUdw44xeyrsxvtGqBOuc7Uhh81USemhi7vRitjhgCps8Vj7pPvi+FJiQ==;5:w3WbYgB3naBjdFcBmNHBBOOSK2Sn+SNlhKsnI1P/gZYCiK+JRNGxJAiXJgW0zVtjLI8pJA8yKWw7VOJ63pQryuoBIH22j9o9fBlSZ+9OzNCkxgJsD5B5cii2fJlv8QjsTLC29LG1tdPbSKPmjFGdfxnmwvG797l2unUie26rRR4=;7:LY/CTCOwel6NtmKdtb3xkIVd7lNqIF9mCiDIO0WxEfPiXUgmzo1TReaccvumNL0qLnu2kfIeSrLlOoK00bHwK46Sr7jpYU9YFKDMjkRbl2vA+Rmvd+z3d5GYkD6kVfMioGe7Q06AwCUapjp0TBZcTtcvbt2N6gPrqAdL+3S2SDm+59aIYII4o1onhJiAqjgsfZHjkSjaoINWY35oy28BUCH32l/7kT5WC1k+00F14bazzdKleKX43ZlIoHYp/gKE
x-ms-office365-filtering-correlation-id: baaf7b7d-d523-49af-c357-08d610d49666
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01202ADFA50DEC81C213092DFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g99JQSwIhZMnT3vInvZj5yd9uDd8gzV1kmnEFVuiGRC2YKFM5uBZByMiMu8TY4JuaijIhSSb/jodnlTfZvMSB3yurIMI5kRGb7ct0qUKXcb/OqgMG4rIN1IsySoCJxiEj67l459T988YaJC+5l5F3Xtp/yJozAAQhYBtLOu2B3+MOFwivaYCyDtRO82tWwYEmGU+KMnNi+G2oHnuN1kxp6c66/Yba5pKOW5iNSu7mJ/uvD9JhV0tZ+x8Z7DMZp+CIrXpbnyELjW0g3faEXO0dUQcs3+1qC7nmpKXSqn23nTlXlSpiJfclwqa2iaQcWrUlnkOmepZRAZmMGPjPGwAgCOMGe3nV8QpJYJIUN9fj8s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baaf7b7d-d523-49af-c357-08d610d49666
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:09.5577
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
index e60bea4604e4..fcd9d5eeae72 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2942,16 +2942,19 @@ void ath9k_hw_apply_txpower(struct ath_hw *ah, stru=
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
