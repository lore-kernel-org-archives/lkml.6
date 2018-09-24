Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81990C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DA6214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gSbR3d+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DA6214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbeIXUyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:06 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730582AbeIXUyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2S/Rgt1aQ43u5i7AdbVNNWrnI+dOnTNfi9lcHXkz18=;
 b=gSbR3d+J3e8avSS/cxC8vUI5uDy1iXMuBmhQakT0FLTJD/M/SxJdNSXL8H/5si6HTUjXAb0C0CDmbvOzAdQYHwy6po2sXEutVl1PSPlVmWGYf1PaETNzY0w/2Vn9p4vSmpUBl/s+GppCqhphxdFXXUiMeeYOqdRxDKyPZMZBHcM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 15/18] mac80211: Fix station bandwidth setting
 after channel switch
Thread-Topic: [PATCH AUTOSEL 4.4 15/18] mac80211: Fix station bandwidth
 setting after channel switch
Thread-Index: AQHUVBXaQq07i8HAiUiGQ0us9cvfEg==
Date:   Mon, 24 Sep 2018 14:49:53 +0000
Message-ID: <20180924144942.164688-15-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:EOfGd1xv8Q9boeddO5LoXs+OuqZZWEWQqF8QdbeANqCsGSfDKkQkp8OGD+VPsXyta+gW+bd+kEgkMwe6knj4IM7Eg3gV4E1ioptCy/v9vZ/Ynp+MEaEvl5ta0ku6kmimS1TMO8S6NiqxYOkq+olAGOvLqswTDi//1RLki0yXcZU2Bqb7Ng2i1O+enXlaWvkUDghwWL8Ra1m+ZJubQgR1XGS5sI/qy3fZv1fJLcMbIQOWDofEiIRYhQiTB/JRN1TeqDSmhnnOU19RDvp6LIOcYo0gDhHDYlsNnsjf7ZMr1y8y4SwUsVRR4NdXAroVe5qesPVahNPN0AwuSd6RKm/PUeISP8tcZnDD3+wCjOU6Ui3lntw/NNlZfgtkmtR8M2kAdz7Po74Bi6lS/KWYNfTMbK7adXkqpGgxuHMTJe8D1hgfJt/Z7aZjIGX16Dgjx0U1Gjj+H6t0WWgBep1iGXH0PA==;5:jJbWzt8qFfU8JEXjZ510j9YYYpX/YNVBrR1rexSpvQbWAwPDZ5WgXLELHlNwrxV7rfVDIlvGl7X1Oz28ZC+BQbvko2FLXk5G7pQlB5vNnPxgv09olMFsIzRJ222DAV+PTaEkWwgsRn/TNy6bK+80z86IirheGJJgwajTV9YoDnQ=;7:tvT0nAu+IaYRZR4H9KXLYl5WnL/yQFxeU1nMPr/IE/HDEkkAgnZ8pPw6KqeZn2IKDoNXpHPUGbocOzdFSdbXn0eHF7xrQk6cl6lix1jwUJZ7vbhEj1NeGuSChHCrY4/3e+w2oBN0GAj8gPA0sfqCs0XzC4YEN14ILh2mhgqom5a5hPlt37MHM3SUx6r8VzZ5iV4mEIUQnrpnmWFlVkniDlwYGI4RLJOIGpqKyM/ky9PxrRacvwZNZ8JBF6u06fOb
x-ms-office365-filtering-correlation-id: e6018c03-d940-4d5a-dc9f-08d6222d2df0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08214D7912CF30F20A625C3BFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bEUbkTwWNvQnq4ZzyhN1GmwCG4+VOD+8MVWDaW/fsS+Mv5sUwUlSbe+zkvRL1Vcj4ytKxubYXnfLFIMSHZZq/lJs2ACMPAeUnzvVju8CD8bop6rUNUQxO2s1jXNb/LVtD6Kk7rcKHdFoZQgsnNJ7RQfGzjlPEtp+l0qKub6nACxrad5BF8q9Z6WaSmxeb2JP+M04SHpCm7Dce+tCVQZkuEmvMy/Y5jSXKU/TwGd4P1awPz0+Rhewd5eX8W2SJ6lYHgcMzjXyR+5c0FcDXvgLg5d+jg2pir4I+6FgsuM0dMTSqtm7DZeVpUyfF/CAoh31S0LO7ZhJKft3IcG8PfzS/IBQweW5x8FfQE0IOETpLQw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6018c03-d940-4d5a-dc9f-08d6222d2df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:53.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index 005cd8796505..a5e11280f405 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1021,6 +1021,10 @@ static void ieee80211_chswitch_work(struct work_stru=
ct *work)
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
@@ -1029,6 +1033,48 @@ static void ieee80211_chswitch_work(struct work_stru=
ct *work)
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
@@ -1039,6 +1085,13 @@ static void ieee80211_chswitch_work(struct work_stru=
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
