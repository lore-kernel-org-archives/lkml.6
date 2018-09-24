Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87598C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321C92087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PgAUrlkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321C92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeIXVCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:02:13 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:30464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387777AbeIXUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSSvR6NzT1sGIZ7CB7XYnJFv7pAgeK2BVyIrZr9p1v0=;
 b=PgAUrlkvGok6EbdfnN5obW+W7s8y7b9YAAU/93sCMJITXTL55szxH9PYXGJXn/aWocLM0z6BvJ0a+TOeBQzf+YIbHTyh+UeIDGx3JS56gRRdVUuPOaiCCnxnudESGKnSO+KMnJ+AVuL6H0atwW0pbKNVE4dNtv3VJP8erVBWUyM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sara Sharon <sara.sharon@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 10/36] mac80211: avoid kernel panic when building
 AMSDU from non-linear SKB
Thread-Topic: [PATCH AUTOSEL 4.14 10/36] mac80211: avoid kernel panic when
 building AMSDU from non-linear SKB
Thread-Index: AQHUVBW5d23qZjYdFUeY/AR9NO0u2Q==
Date:   Mon, 24 Sep 2018 14:48:59 +0000
Message-ID: <20180924144851.164533-10-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:/qS37a6liLjnN+xvlcwv7U46Esoknf3spo0q76YPFFQwQ17hB6kJktZLO0aYQRLr/5D3wFA+g3yx1WSijsztCW0RXqvjA5joOTMLHGq9iHYXGrjvJ/bnZvR/lF/iK7Tsqxa2br4p1nBXuAcl+2ZoB9Z4iyQsuGY4gJ0icCr7PWMNRiQqTjYGf/AK27voQM7cIj/nkdz883J3+ja3vJ9yHugUcDZqSQGr81K70Yd+j/Qh/YEleA61LSimIkEw0oB0NTlzWBCFprGMdUa771Ganv9JTwmLmD6RT9QtgktmDHjKu3Hdma/3d3hkT5WRIsHGBpn0zBFD5zDSZsZ5vSgE2lAPnyc1jYcCWpMWOKH3hBRheRM2sNlPV1mkBvVSDeG6qyVaWGAysShYDKSAkzb+mtBmWgmfF/9kVpA4FM9/RDPtv11HcBSakbreICI9jRBt3anqAjiaTjuSszFOCRkDYg==;5:VaUpE5jPsKaCy2lwjrogUxgm4kGT+Hy9rrFVtkLfIaV70Q2Wd87ItRCpRDV+rYYgA2cectap34VHq1GX9kGULNWMD2P8Nu7fofK2ZWa+NuzNVPYTDv0F7dAixKMqEhsXJFUB9yfrBi2eRg7HXi3KEajYy8l/MZ2Fl1J5vuSMyuU=;7:7i9dzwQyveAHRUOQ2P6/uM7IHu7ABewDNmZWFXltXXui2jgyQpN59uq/kAHHJb77dRV0x6OJEiY+bWBLUnSbUtV1XfmFGQdQuLi4547fv6GpPs4WtXLhCkpf5IVEHMSNuM/lajqCvH1yY7hwEcufhbYa12D09TnDX0y2L0cVft9BYNBK0hk/Bydl35ACyBjF9vvxL62CqIu8XyxTIWUhXo47IaHbAX8glB4yJRcbl0TK98CKf2kH774yROrTli+B
x-ms-office365-filtering-correlation-id: eaa6958b-cd43-4be3-d26e-08d6222cf653
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181565E4C3AFCF493230761FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GnZAo8zPE2WfnYPtIFgbHdc5GKNt2dSICrdutboJ4kkgTyuCVWPKxV3sX+l3C9NTeQhuT1I0A5NmKrObXpTfpluogSUGVI9VBDiat5kFYq/VSJhHmMcTcXvIxRdavSg/AISLInufeJ3pMAeiuxDJ2jiMbqN58PjZYbOZCejVfVqbsrmi5TKXXBh2sxAsHOVs/h9HdN9hcjrDTZUzF2+TcowPiOKj6NniFGQEp4gK6UKxYzBEV92jMg1GzcZUBNcn5VEoh/sl76U8qDFuDUE49hOIAUXXZHUUJTxuJMDeBfz7L2orxqI3E7sjdPZE10reAhbljYZP5LB29waLdcg2DTY3x9f6JjIwXMMteqMyoCs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa6958b-cd43-4be3-d26e-08d6222cf653
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:59.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 166ac9d55b0ab70b644e429be1f217fe8393cbd7 ]

When building building AMSDU from non-linear SKB, we hit a
kernel panic when trying to push the padding to the tail.
Instead, put the padding at the head of the next subframe.
This also fixes the A-MSDU subframes to not have the padding
accounted in the length field and not have pad at all for
the last subframe, both required by the spec.

Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/tx.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ccb65f18df5d..2064234500cf 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3022,27 +3022,18 @@ void ieee80211_clear_fast_xmit(struct sta_info *sta=
)
 }
=20
 static bool ieee80211_amsdu_realloc_pad(struct ieee80211_local *local,
-					struct sk_buff *skb, int headroom,
-					int *subframe_len)
+					struct sk_buff *skb, int headroom)
 {
-	int amsdu_len =3D *subframe_len + sizeof(struct ethhdr);
-	int padding =3D (4 - amsdu_len) & 3;
-
-	if (skb_headroom(skb) < headroom || skb_tailroom(skb) < padding) {
+	if (skb_headroom(skb) < headroom) {
 		I802_DEBUG_INC(local->tx_expand_skb_head);
=20
-		if (pskb_expand_head(skb, headroom, padding, GFP_ATOMIC)) {
+		if (pskb_expand_head(skb, headroom, 0, GFP_ATOMIC)) {
 			wiphy_debug(local->hw.wiphy,
 				    "failed to reallocate TX buffer\n");
 			return false;
 		}
 	}
=20
-	if (padding) {
-		*subframe_len +=3D padding;
-		skb_put_zero(skb, padding);
-	}
-
 	return true;
 }
=20
@@ -3066,8 +3057,7 @@ static bool ieee80211_amsdu_prepare_head(struct ieee8=
0211_sub_if_data *sdata,
 	if (info->control.flags & IEEE80211_TX_CTRL_AMSDU)
 		return true;
=20
-	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(*amsdu_hdr),
-					 &subframe_len))
+	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(*amsdu_hdr)))
 		return false;
=20
 	data =3D skb_push(skb, sizeof(*amsdu_hdr));
@@ -3133,7 +3123,8 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
1_sub_if_data *sdata,
 	void *data;
 	bool ret =3D false;
 	unsigned int orig_len;
-	int n =3D 1, nfrags;
+	int n =3D 1, nfrags, pad =3D 0;
+	u16 hdrlen;
=20
 	if (!ieee80211_hw_check(&local->hw, TX_AMSDU))
 		return false;
@@ -3184,8 +3175,19 @@ static bool ieee80211_amsdu_aggregate(struct ieee802=
11_sub_if_data *sdata,
 	if (max_frags && nfrags > max_frags)
 		goto out;
=20
-	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(rfc1042_header) + 2,
-					 &subframe_len))
+	/*
+	 * Pad out the previous subframe to a multiple of 4 by adding the
+	 * padding to the next one, that's being added. Note that head->len
+	 * is the length of the full A-MSDU, but that works since each time
+	 * we add a new subframe we pad out the previous one to a multiple
+	 * of 4 and thus it no longer matters in the next round.
+	 */
+	hdrlen =3D fast_tx->hdr_len - sizeof(rfc1042_header);
+	if ((head->len - hdrlen) & 3)
+		pad =3D 4 - ((head->len - hdrlen) & 3);
+
+	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(rfc1042_header) +
+						     2 + pad))
 		goto out;
=20
 	ret =3D true;
@@ -3197,6 +3199,8 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
1_sub_if_data *sdata,
 	memcpy(data, &len, 2);
 	memcpy(data + 2, rfc1042_header, sizeof(rfc1042_header));
=20
+	memset(skb_push(skb, pad), 0, pad);
+
 	head->len +=3D skb->len;
 	head->data_len +=3D skb->len;
 	*frag_tail =3D skb;
--=20
2.17.1
