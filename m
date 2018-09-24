Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3618ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9391B2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EgnHE+p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9391B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbeIXUxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:39 -0400
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:37225
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730084AbeIXUxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i5XdM7Bn3hINGZqBA8zwenc2sFBhKCqaTfLtGKVP9Y=;
 b=EgnHE+p20btOJ3cnv+s80BdBM5Xdka9SxbqLtyl6S+oa2delUj9GHQsYFUZpyr0U0UnTs5mZ0+nopY8JaCKvZ2WSutgQR83/q/SRfXbmK91GvwDb/TDRac7OvuIoMkEW6qMkNnIbt58nghvGlUF1XGFPaWxetsmUgVrcZRr88LA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 19/23] mac80211: Fix station bandwidth setting
 after channel switch
Thread-Topic: [PATCH AUTOSEL 4.9 19/23] mac80211: Fix station bandwidth
 setting after channel switch
Thread-Index: AQHUVBXPRlaHinF2/k68nh2Q3jyyXw==
Date:   Mon, 24 Sep 2018 14:49:34 +0000
Message-ID: <20180924144919.164617-19-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:4uVzfBag4D8pQHrLCu3FnoYqwHM/qp/yi3idx5nrgdgZu2ytpQRk/xouqU08AHq4mmb2DFL3H4Dyxac6d6fL44/xtHMt0ZFLs4UWWODOnct6nvvU2h97oL2E+kt+HVA0HoSxEVjVFZhdhuQPFThIQRBFee+oLpR/ZhypOKYDbP9k/sLbyx2bbvV+D1z7rp6tklgP3WbbtOg705nzgOHmyXdWFkcKeULxJEK1+VYIcedcifIc/x6Nsj01xc7lTTNZknqnbaElLMZb0mmyYHUQ4gnCYb1eMjpnsGP5bt+zrjhpc9SycurzVtyLmR+6pq9FDXFfS4YYlOJ7V2fVg4ac5WJ0H+Oon8ZwpyevCZmq87vOEl5Whg3gCAiMlW6ILsC4wI4DStEhTByKOM9+WnGUxyu+BFNEGIWIyqW2t/0OsWklvMxD2/lAk+rTXuqFbVAUBEB8qyncdcf88AiCid4iuQ==;5:0gG4qUD4SLAmIPWwHkiMZKHP+3ti9S6H5p3K+zu6dFPoGjjE8pEA8cecdq1jdet+mJEV2pJK9+I06A+1rT0lC1Qifw1zjm1MUpCDC2i5bfDJPxtpeISvNVr3ch4yUB1pkbZz9uV5JJGtON5O45P58BK/FaP6bkm7varBUYgEG/A=;7:KZfmpRwwqM+m37J1Ce0jRj4lui2FVTBnpDFH0oHoGF7VHjQf/daDSBvf5YY5Fbz0+A3E6/+O+VNeLtHwep3zzqoeYTFcuTA3WcfuIvLL4kTIHyjviQ/4FDw84meqBw163XYtTQ4azTOeDRlzKNBYtdfIpkHD450M5c+y9cT8tG0B5Eng85cLzrPzO0APIxawQpANZQ/TAuOJ0yb335Mj0BSRUWxZuYNkkpt8bG906MH8Vwi1TfDuyKbMUVUgwgjB
x-ms-office365-filtering-correlation-id: 57d6fe57-966a-4fc2-84c5-08d6222d2604
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0631187F4C38F627D62B1D29FB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2z9nDrOULWTAVsVPLilg/6DihV3/kDQzZGnutSm4pymSQgz3K1UDv4/t6TDCgLnoSgJkIUjdD0IsCXfbWF/cMNEvmq1XPnMnvrqYc94eDAg3WA3lPux7Hf1ewV/0RtMdBI8uZvMOrxUGcGGCZ43ndz4q7b11WQZv2FjMEgAEnTFG6k3BkwKwEjnNWmcLLJ2chVAw0fFKA3vqmFI95h66+9nKeMHNR5L5HnNrdbs6A8lvwPtxFhb/Rfy8xn1KG2czalHxYKxTMYcrVQMTuh0eXWjlXH0A7TKVyRuUATt/YGbWWclC4iu+7pPV803bA1bH0mt+c85FdZ45k+m1IgLPIoKfGrOAfx1IRscwISAPrmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d6fe57-966a-4fc2-84c5-08d6222d2604
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:34.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 0007e94355fdb71a1cf5dba0754155cba08f0666 ]

When performing a channel switch flow for a managed interface, the
flow did not update the bandwidth of the AP station and the rate
scale algorithm. In case of a channel width downgrade, this would
result with the rate scale algorithm using a bandwidth that does not
match the interface channel configuration.

Fix this by updating the AP station bandwidth and rate scaling algorithm
before the actual channel change in case of a bandwidth downgrade, or
after the actual channel change in case of a bandwidth upgrade.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/mlme.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e6f42d12222e..04e6280f4819 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -989,6 +989,10 @@ static void ieee80211_chswitch_work(struct work_struct=
 *work)
 	 */
=20
 	if (sdata->reserved_chanctx) {
+		struct ieee80211_supported_band *sband =3D NULL;
+		struct sta_info *mgd_sta =3D NULL;
+		enum ieee80211_sta_rx_bandwidth bw =3D IEEE80211_STA_RX_BW_20;
+
 		/*
 		 * with multi-vif csa driver may call ieee80211_csa_finish()
 		 * many times while waiting for other interfaces to use their
@@ -997,6 +1001,48 @@ static void ieee80211_chswitch_work(struct work_struc=
t *work)
 		if (sdata->reserved_ready)
 			goto out;
=20
+		if (sdata->vif.bss_conf.chandef.width !=3D
+		    sdata->csa_chandef.width) {
+			/*
+			 * For managed interface, we need to also update the AP
+			 * station bandwidth and align the rate scale algorithm
+			 * on the bandwidth change. Here we only consider the
+			 * bandwidth of the new channel definition (as channel
+			 * switch flow does not have the full HT/VHT/HE
+			 * information), assuming that if additional changes are
+			 * required they would be done as part of the processing
+			 * of the next beacon from the AP.
+			 */
+			switch (sdata->csa_chandef.width) {
+			case NL80211_CHAN_WIDTH_20_NOHT:
+			case NL80211_CHAN_WIDTH_20:
+			default:
+				bw =3D IEEE80211_STA_RX_BW_20;
+				break;
+			case NL80211_CHAN_WIDTH_40:
+				bw =3D IEEE80211_STA_RX_BW_40;
+				break;
+			case NL80211_CHAN_WIDTH_80:
+				bw =3D IEEE80211_STA_RX_BW_80;
+				break;
+			case NL80211_CHAN_WIDTH_80P80:
+			case NL80211_CHAN_WIDTH_160:
+				bw =3D IEEE80211_STA_RX_BW_160;
+				break;
+			}
+
+			mgd_sta =3D sta_info_get(sdata, ifmgd->bssid);
+			sband =3D
+				local->hw.wiphy->bands[sdata->csa_chandef.chan->band];
+		}
+
+		if (sdata->vif.bss_conf.chandef.width >
+		    sdata->csa_chandef.width) {
+			mgd_sta->sta.bandwidth =3D bw;
+			rate_control_rate_update(local, sband, mgd_sta,
+						 IEEE80211_RC_BW_CHANGED);
+		}
+
 		ret =3D ieee80211_vif_use_reserved_context(sdata);
 		if (ret) {
 			sdata_info(sdata,
@@ -1007,6 +1053,13 @@ static void ieee80211_chswitch_work(struct work_stru=
ct *work)
 			goto out;
 		}
=20
+		if (sdata->vif.bss_conf.chandef.width <
+		    sdata->csa_chandef.width) {
+			mgd_sta->sta.bandwidth =3D bw;
+			rate_control_rate_update(local, sband, mgd_sta,
+						 IEEE80211_RC_BW_CHANGED);
+		}
+
 		goto out;
 	}
=20
--=20
2.17.1
