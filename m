Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C810ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB35A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ammPIPbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB35A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbeIXVNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:13:33 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731100AbeIXUuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi9lgdZkqK7HSPkKrSztc5vuQdT58OgUhLpSFltf3d4=;
 b=ammPIPbfn1J22iogHlNx+zVChx9RRIyOCUW/WfeZeOxbhTAVgrpD2wxPKDu2ohHIezrg9SumpoPm+cOKXMRdDqzvTe29FxovPBRXGpfGAT31IzO+AC//cBxfQG8MjTT1Rl0DF5gAzVXabTteVfGCg3nmNFwr4lEedpJcwq3aS/0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sara Sharon <sara.sharon@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 23/76] mac80211: avoid kernel panic when building
 AMSDU from non-linear SKB
Thread-Topic: [PATCH AUTOSEL 4.18 23/76] mac80211: avoid kernel panic when
 building AMSDU from non-linear SKB
Thread-Index: AQHUVBWfPq8BFTYUNkyyVPp4KcvNLw==
Date:   Mon, 24 Sep 2018 14:48:14 +0000
Message-ID: <20180924144751.164410-23-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:7a/gJhAIOaUb4BmyAbdz0dcHNTu+YcqrqVwJf3rwsmncUHMoMah9P2Ra6/BAQFrGalGfrK4TW6DQXLSLbpRzNq1fjV8uMr/qYu0PO3SaANxPlboFc66QAlMxQ3QzzjoklRz3DOEigIurnEmZaC3e0Pg5pnfBIupnhPeu0jfMea33XUD0Ib24+CfGgZcrxQWI0D/LbnWGO89UfwszJYM1PBnmgNtTq/abZ9oV9vD8+1opxvPDEX12tBlNGfWS/UNeP5FQwrkGoViDHVsbIERarL2nYxsFX131P+rOrIBqmCXAexFNS3Z82Ayzfn8U0CoWlTsHFhTjuA8E2N1AP14fUzefVPZz5P0+gRpc1UBRzjP0taoUn1GBlW2Rhe9Z3+rmPkgaXaAv1nhuBdq9I0F5uK6I1XSt+ei7KIboxbaPynq+tGTjwvjgtxvsJa0gLM4c2gCQgksqimfugHeDYoLSvQ==;5:3nCJCmxPWoluLuoROQMRRAcCiEx/uJI27vvET5HOoeME8V5RK3kJORwbbs1SwdF73s8BN9P8F3H46C5bvYP3FbuKKUT3Y8uaLujI63CfjHL8S2QuUXwL9ft/cxbiQdWb4UpujKPRdTdc+UcjN15vCl1d6wereFGwOPoAfcqcGyU=;7:QjfNNGPu1fmMK4RXXUsJtBsSklXXSkgmmv2yTdPM/zcPZQ5haRiaHiNNI5HqMKiVoH1tQtSwwgLUBY2OUPTkTaM2p7aE0OkbuAvF0Bl5LxMrKjav6hYZn95MxnLlXAYtCcZt5G2kq29HaPjwoIS/8IGW5OUEBNVXqaUl0lZ5iueL9nXUMJaqEZU4Fx4EOCf0r4VZwSNpTLbVSl3LwzmCTotPtJyMogV4LTv5glk6WP/+g2kWCMyygb4u1xmQYSZw
x-ms-office365-filtering-correlation-id: a521439f-6077-4088-f47b-08d6222cc225
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821BB277D2CA07ED2833EBEFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(575784001)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: QqyNRYDsRL1mBZMYcGEOAMwGfCd44H9mZsQCSBvSNCyy8Fki2iAYAmZNWBlzZwOJVEEC/mbdMK/QMp2qtWyrxz2kUPZcTouG4mghAyHdGH/MXZJ3Cnnc5y/YmaMkw3OECPcJkH/L1ygNjl5ggPOiB2kddCc82lLWz/uiKvjRso5j6kGrOWlocYQHe3E+IInHz106IOfXETni8Zkwx76TFm3zerSjY9z30JTAvynXEukBcX0RKnxqnxVHn+MUJiaYJ3zY5mFXNapVfb+4qKYmhP1UsXsG6oJtS2WXXHnLGx/1Ohwe6rKIMXth/zRhy8n7lC/YQJ9hcOSGHkAKollWO7M4d+UEd5xFzta/+18eJA4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a521439f-6077-4088-f47b-08d6222cc225
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:14.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index fa1f1e63a264..667a73d6eb5c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3073,27 +3073,18 @@ void ieee80211_clear_fast_xmit(struct sta_info *sta=
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
@@ -3117,8 +3108,7 @@ static bool ieee80211_amsdu_prepare_head(struct ieee8=
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
@@ -3184,7 +3174,8 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
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
@@ -3235,8 +3226,19 @@ static bool ieee80211_amsdu_aggregate(struct ieee802=
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
@@ -3248,6 +3250,8 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
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
