Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757012098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QIC94SF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757012098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbeIXUxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:01 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:21344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388446AbeIXUw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS9vRRd6uSMOIFNVh7/W86xWJeeQDyqLuNXcsz+ENJ4=;
 b=QIC94SF19RzkquINJRkEkEJ0nay9Ks8NIjut31b5hOl0YF1/zcpWPrJEI8q3sR3u0Z0G3/3qtu6/2IFbOKuth4p3VJNyTHmcHygfRu8fe9aDGJ6rTyW59PeSKFELNV1GWfgfXfCEq7oiZhv2O59NK2d4JRSk5x2om63GXEC6jgI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:50:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 32/36] mac80211: Fix station bandwidth setting
 after channel switch
Thread-Topic: [PATCH AUTOSEL 4.14 32/36] mac80211: Fix station bandwidth
 setting after channel switch
Thread-Index: AQHUVBXB0Wb/1wgTJUW6uN9P9SMPUA==
Date:   Mon, 24 Sep 2018 14:49:11 +0000
Message-ID: <20180924144851.164533-32-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:BRbInIDnhmHv61vmJfXd5QB4VIveGtskSSqXypMpW/Wb6hkWCw8nFKtmTXqephjOrJKHL9PE6Gj5/5JSL+z1VdVaoZdMBFCWhwTrf2zHtABC5a6tyW7Tyt6NTC3NfLu1OmE2jVgz47lgSHEJYsKI2lBzDZEgP7+Fd8pWwtniUrm7fZtPlT129qsNt7Hb+WNdbYqA6dYqkx13QS8bsSis7cJxS1OUtFvUuPt0d204FN2bVP+la5BOvbokEc9BeZ7pTNS2yAIaqolIOiQtNlkulm3W0KQTX9bEsEKLFzr3Xx6omK5UfHbO5ICyi/7Ovq4rPktZLRj+GuatdfLFkUp6rt2XXNfqaGKVdAASgS7m7FQy9Vg8uwY4ubu/JVj6SUOFLwWDfQHUM+ViMYRYm6H37fippD+r6v3hYHzDzl//sbGd2aDOrs+oINQ2P9jTUWOBaMy/Srj5qQwhQPvbslH8fA==;5:4cSGxJwCg5whAm+AAzh6YtMsu62KeO97D4wtrIFh21Fk6rlU+MferHoL2SndGvVVLVMIyBCxbCNd0hn5LDJ5Ydka1Gla3KWULkoX3xl3ulZf3gsFnTQMMhxfw5wrQ70KTgFY8QI95d6f/X3+OYbydXydeP8cFHFBf7SUPVbNrRo=;7:D8f7ri5oaRNIAolY69R2PJR2JBR+N1NLVkBXnaR6WlB6UPvtR5MELyoz7oo19UPmXNipe4YCkWwqluaNy5cGbQa0MVv8wDatNK6vkiPb/j7FLdulrO+S/g4/2oV8bHboZj2BWEAnKaXQCM6Cq2YyzhKEV6MUXz7S+wHiHQDAqzEhs1CEoRqco9eKgL8aqJWWjiFVD5NXOedAEjeEhXk0TgO6AhqtRObzb1TmgHh6E7L33kdRwl5GwJ4gBMkYDF+c
x-ms-office365-filtering-correlation-id: 6b221b3d-754d-4bed-6978-08d6222d0dcd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07448392419BBE0E6E039689FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BaM+eXoL9YSF6Y4QfAxlZGO+kCkUYH3Uppdkjby6AHEq8RV0x8sUTCLRW16Qo1MfMNOZ5pclzj8OpKDv7NlolNeC781z2FbYuXLedwcZFKxK3uYEOxXc2kNm54WCK8COdtbkSh3sqts97fFZWtmk/3wd0mK9P/D2tXUXKRDRzH149ZvLZ4KwpihrngcPzu5m/8oamI0zoBw8haxnbWcmQy1Yo0EDf9tGz1ue4S/0ZrZUScvgLoH5qMqYi0byjF+tG8GPNntsVXFdke4u36/4WvMgl5e5lNLiT89mBB6YY8t4X4+h4XtIm3vF2+QPu5QKdJNlT9NPy+0Jfiyzcto7ZuJMrp5WSPaCRNAYB05VZvI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b221b3d-754d-4bed-6978-08d6222d0dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:11.4931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index 052dbd4fa366..a287b3891643 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -988,6 +988,10 @@ static void ieee80211_chswitch_work(struct work_struct=
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
@@ -996,6 +1000,48 @@ static void ieee80211_chswitch_work(struct work_struc=
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
@@ -1006,6 +1052,13 @@ static void ieee80211_chswitch_work(struct work_stru=
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
