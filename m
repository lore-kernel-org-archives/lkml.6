Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E68C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A9420857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VU1pMkD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A9420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeIGFPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:38 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeIGFPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8X2M/FAHjsqJDOv7ooho7mjuFPqeZhTCyDdTeKunMo=;
 b=VU1pMkD0XjfeXN0Bk4C8fuiJPynCSKdbuaiShO6Woc/4KlXKDgBM1aUJ+SOeCV0nNn9zamuMjl0MqoND6FklRZYzwSpSUzM3OJivWKTdjv/RJ21KPwgBu2OJRDYvP+uageD2nuoUuBFl2XKQl1uoC16I3l1IYjKiptGmFWm/YPM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 61/88] mac80211: restrict delayed tailroom needed
 decrement
Thread-Topic: [PATCH AUTOSEL 4.18 61/88] mac80211: restrict delayed tailroom
 needed decrement
Thread-Index: AQHURkLVsE14J5Aju0GH3v3dZY6V3w==
Date:   Fri, 7 Sep 2018 00:36:36 +0000
Message-ID: <20180907003547.57567-61-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:McT5GQx9nt+JAohl37zMtjfm0W0QXTPlbzdDtQTRGcmPvcwI3SK6u90YGeS1HtBIAyEjjDp2nU5wnGvj+JIZU2Nhfxigw14Os5XXCZMMqAZP1isvcoXEgNEl9w/n0nlbXm9F7ohj9NRF7srbo7q/n89U4uHObPw4hbg9LLMqtA0jklUKHY1s5dRLcPzzPcpsnp1EKdxYMUWGGOmxZ1W7mxn9mH5eMbJ7aAoMk7kWmt1L0qx8AMdvaz4DcfJyKieZIgiBDJ4OzdYV0LlGtYYoCsOb54FJqpQEYi9AXe9fKDDv6Jm2hgxiFFmeVPgVuz2FEUPlf7QOCgg7sKRl3Ku170sMVJUfu84xIpdnOd8mFdozrXn6RskGDEmGZDRqXQYDtVFxB/whRSrczZvqNj9CE7oMf+Fdcfk6w8slt9UVoMCdHN7lUfi7jsoXP9Pn2cSQgI0aO8N4vabCV21vKuYquw==;5:o4X9o6mZzR0A1x21Nv17Dek2WAAuqKzF3wfboKSMwdw3CV9FYmd9+KnaW1LOOkhFrcr0ulautBVKaMEPs/xUvmEfSumsyDwwSXEflAh0nxoxKpDxWlr1ok8SoiSrcJDLCRDSBxhg3F1dJmVKKWJjtb5i9HC1JiSRN6N/oDs5K9c=;7:9wtBKsDFeF925iZ+hj8o3GYBmMZDhWPy6ZiNiNdFsYa18v2/4qydb6/PVhhXvd4Xzbp0M2Sxms40/q4KAhQy1bkUg5b8omK0At9DTdgXMz7kC4a0TncJRnZv6JMS4Y5Xl6g/+htTbrac3rj1hDYEnVxOr44zlCUNKpQNR1fS80ECppc2NdZzlSpDhqL30LuypSJW9Bdu5pugHSXlTde+mMVjpfGKQJAJsDMv+rRZRvs0Zg+PAjXDYN8TfFOiy/OT
x-ms-office365-filtering-correlation-id: 625c10bb-de66-43ad-89f5-08d6145a1817
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01181DFD7DFFCF456DB59434FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V2odYj/RAG6kAtSTCCZpqcnmlrqI7SipoeECv2sheDOKpIvYOL16KlDak0lmll0yiRJeXeZF9Sig6V9I+8PJhr/7Ksl7goMpCpjwlySwPu9acpVpmlqlGjK6Yc5Q+OGdESIqlwNF2XpGiqyiqZaeQCmmGRmItNksTiVxLDZ7sYsuKIT+lo15UYsbqBX7gpagx7WpcbZkJ/Iv2MTwyAtz3ydyxTjg3sPtAVgU6FFkojqrWGmIP+VMRyCnueucLYgoHVxdV1pjhiTOLbzB5cZbYS5/bbQxAZTJ/Sd6cb1I7GOSezCL/dUYCKPd1fu71Jx+l/L8QizzJcd8zcSjBbW+IYPpt+4YNSxgWf2MqHe4iBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625c10bb-de66-43ad-89f5-08d6145a1817
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:36.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manikanta Pubbisetty <mpubbise@codeaurora.org>

[ Upstream commit 133bf90dbb8b873286f8ec2e81ba26e863114b8c ]

As explained in ieee80211_delayed_tailroom_dec(), during roam,
keys of the old AP will be destroyed and new keys will be
installed. Deletion of the old key causes
crypto_tx_tailroom_needed_cnt to go from 1 to 0 and the new key
installation causes a transition from 0 to 1.

Whenever crypto_tx_tailroom_needed_cnt transitions from 0 to 1,
we invoke synchronize_net(); the reason for doing this is to avoid
a race in the TX path as explained in increment_tailroom_need_count().
This synchronize_net() operation can be slow and can affect the station
roam time. To avoid this, decrementing the crypto_tx_tailroom_needed_cnt
is delayed for a while so that upon installation of new key the
transition would be from 1 to 2 instead of 0 to 1 and thereby
improving the roam time.

This is all correct for a STA iftype, but deferring the tailroom_needed
decrement for other iftypes may be unnecessary.

For example, let's consider the case of a 4-addr client connecting to
an AP for which AP_VLAN interface is also created, let the initial
value for tailroom_needed on the AP be 1.

* 4-addr client connects to the AP (AP: tailroom_needed =3D 1)
* AP will clear old keys, delay decrement of tailroom_needed count
* AP_VLAN is created, it takes the tailroom count from master
  (AP_VLAN: tailroom_needed =3D 1, AP: tailroom_needed =3D 1)
* Install new key for the station, assume key is plumbed in the HW,
  there won't be any change in tailroom_needed count on AP iface
* Delayed decrement of tailroom_needed count on AP
  (AP: tailroom_needed =3D 0, AP_VLAN: tailroom_needed =3D 1)

Because of the delayed decrement on AP iface, tailroom_needed count goes
out of sync between AP(master iface) and AP_VLAN(slave iface) and
there would be unnecessary tailroom created for the packets going
through AP_VLAN iface.

Also, WARN_ONs were observed while trying to bring down the AP_VLAN
interface:
(warn_slowpath_common) (warn_slowpath_null+0x18/0x20)
(warn_slowpath_null) (ieee80211_free_keys+0x114/0x1e4)
(ieee80211_free_keys) (ieee80211_del_virtual_monitor+0x51c/0x850)
(ieee80211_del_virtual_monitor) (ieee80211_stop+0x30/0x3c)
(ieee80211_stop) (__dev_close_many+0x94/0xb8)
(__dev_close_many) (dev_close_many+0x5c/0xc8)

Restricting delayed decrement to station interface alone fixes the problem
and it makes sense to do so because delayed decrement is done to improve
roam time which is applicable only for client devices.

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/cfg.c |  2 +-
 net/mac80211/key.c | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index bdf6fa78d0d2..aa082b71d2e4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -495,7 +495,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struc=
t net_device *dev,
 		goto out_unlock;
 	}
=20
-	ieee80211_key_free(key, true);
+	ieee80211_key_free(key, sdata->vif.type =3D=3D NL80211_IFTYPE_STATION);
=20
 	ret =3D 0;
  out_unlock:
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index ee0d0cc8dc3b..c054ac85793c 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -656,11 +656,15 @@ int ieee80211_key_link(struct ieee80211_key *key,
 {
 	struct ieee80211_local *local =3D sdata->local;
 	struct ieee80211_key *old_key;
-	int idx, ret;
-	bool pairwise;
-
-	pairwise =3D key->conf.flags & IEEE80211_KEY_FLAG_PAIRWISE;
-	idx =3D key->conf.keyidx;
+	int idx =3D key->conf.keyidx;
+	bool pairwise =3D key->conf.flags & IEEE80211_KEY_FLAG_PAIRWISE;
+	/*
+	 * We want to delay tailroom updates only for station - in that
+	 * case it helps roaming speed, but in other cases it hurts and
+	 * can cause warnings to appear.
+	 */
+	bool delay_tailroom =3D sdata->vif.type =3D=3D NL80211_IFTYPE_STATION;
+	int ret;
=20
 	mutex_lock(&sdata->local->key_mtx);
=20
@@ -688,14 +692,14 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	increment_tailroom_need_count(sdata);
=20
 	ieee80211_key_replace(sdata, sta, pairwise, old_key, key);
-	ieee80211_key_destroy(old_key, true);
+	ieee80211_key_destroy(old_key, delay_tailroom);
=20
 	ieee80211_debugfs_key_add(key);
=20
 	if (!local->wowlan) {
 		ret =3D ieee80211_key_enable_hw_accel(key);
 		if (ret)
-			ieee80211_key_free(key, true);
+			ieee80211_key_free(key, delay_tailroom);
 	} else {
 		ret =3D 0;
 	}
@@ -930,7 +934,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *lo=
cal,
 		ieee80211_key_replace(key->sdata, key->sta,
 				key->conf.flags & IEEE80211_KEY_FLAG_PAIRWISE,
 				key, NULL);
-		__ieee80211_key_destroy(key, true);
+		__ieee80211_key_destroy(key, key->sdata->vif.type =3D=3D
+					NL80211_IFTYPE_STATION);
 	}
=20
 	for (i =3D 0; i < NUM_DEFAULT_KEYS; i++) {
@@ -940,7 +945,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *lo=
cal,
 		ieee80211_key_replace(key->sdata, key->sta,
 				key->conf.flags & IEEE80211_KEY_FLAG_PAIRWISE,
 				key, NULL);
-		__ieee80211_key_destroy(key, true);
+		__ieee80211_key_destroy(key, key->sdata->vif.type =3D=3D
+					NL80211_IFTYPE_STATION);
 	}
=20
 	mutex_unlock(&local->key_mtx);
--=20
2.17.1
