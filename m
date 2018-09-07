Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58FDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791D220861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hOwPztXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791D220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeIGFUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:21 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731173AbeIGFUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OeNJqvhNCoY68WI04JlhIyF6ytJSO+CAPeA9/V3bUM=;
 b=hOwPztXdqw8bycLlBG9cGBGsVXpRDNpD7xe5udZMxMm0ykE0vjA7WY8MT+mC37spPA02xp00KQnLAw7q2RKRAmDY6pSzlDktDNDQFJ+oqnaji3kJh9bnLYJxDh2eu9KaQFNP/ppv7C/pFpmd1/VXqi5QqGI43ATw1AfWcvFmWDk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 24/30] mac80211: restrict delayed tailroom needed
 decrement
Thread-Topic: [PATCH AUTOSEL 4.4 24/30] mac80211: restrict delayed tailroom
 needed decrement
Thread-Index: AQHURkM06eFRlXBIpk6MvtDHi8SbSg==
Date:   Fri, 7 Sep 2018 00:39:15 +0000
Message-ID: <20180907003853.57942-24-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:2LxuYUvSLW+IUqa78sQI0sYgn3cVuzb8E6aTcYLBcB/TIcESmGV2AT3uXb5/aOgZepytlx1kFdtUCk2U6K2SpnqKzRyKZ2DDOx9YP8YK9w3tzNw/QJ19EbjIcn2fPKt6ot5nL/FXPa2ta9M0ROfLPouQvlG1Cm9EtzY8bH0lG1gJOMCucRtmPazXEMLlqKVx/3brBVdGtnTANWFHeyp+Z5Z95LPykq5MUQVqahiBGJDzzBHzW7j7WHL69eAru7d0NBUCWdT8MoxzrUy8RHJmtbTfIk/ApNLSaGAWYjU2EYhYWWs5k7lYfFsL5lzvcmb0epw6e/Zlk5WgYDO3QchleZofqghJcjMH0KVxqXTpEahj8EJnLrJkpc5L2NMjQujFM3F5f6icyty2AFyuetnnivaynpe9RAA+loUqk58LqcryN49nTkMLwfeyIHz0ZIT4miLTl/2ABuVYQEaodvDjuA==;5:K6vz/15D+OW9rjRyb1+xLOoeKc4q6P5KS5U4Gxm5wk3tbi/49iFi4tTOyPnFNpZnyU5C9LtoQL1Qr/IvfquglifUOxELC09f7trlG4+4RX5lkH0c4B8/+wTKX4fEcb1zo0/1eM4TR3dTAM4JWM5o2jlXnBXHsKeWJNKQFYkrTT8=;7:6JR0AClAKX6fjfk1sWhNtTPvSNiYEltCkErmqE+MKC7PP3l1D2IzehZJNs0/MH7chLk9Nic96LNGKzR4ntsUR7EF9TuN0EXdP+mKrGYD8xY3Vr2U1d1Tp7EZp/SfZJ997uv+EPUxzHa1pQdQoG/Tyi2z2gMQYdiyGhu+uALYl32e3q0EaH+BD3ja5xbN0MqogtcGV0TLNc891sIjCxrfpBPPJ8jEPMCKjewj9CgFlyc9pSwxlB4D+MZ8H5eEMfXu
x-ms-office365-filtering-correlation-id: 8d5204e8-1e60-4887-042c-08d6145abbcf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082200E3CCB3A9CF5FD9DFD5FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BhjaCYv+AirdjYpaq1KuW1JO8x/sb6WRPOiJNCbUrAyNbjmPVfYg5maSE3Rny8N5yJ/m6aenW+V4wkQ3dx4ctx9gs8u88lirOfRizKvlBrJOyr6Zq988mzkhrXqD3JQgDjxg3EM68cIO/VTqUOsPZGcschXypcJUKpSyBiv/UBeXVS2c28vcVf7cLNOFBPLdK+BcUjpCMpp/yKv6rcHorpzarwjU8ODgDZj8iERSHiijIyytZbsI9K6MBlSbySn7dsd4InPRLtSeHLHM4B2Smlqir5zP1e6m8kcXJPw+p4NdjnQFpJ8sf3OyUzQgaD4+xnNCx/Sb1Dw+IBm3QbiD2uHSElW0vTIxovYFnnefA1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5204e8-1e60-4887-042c-08d6145abbcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:15.0728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 00a8cc572a22..1f930032253a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -286,7 +286,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struc=
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
index 4a72c0d1e56f..91a4e606edcd 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -647,11 +647,15 @@ int ieee80211_key_link(struct ieee80211_key *key,
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
@@ -679,14 +683,14 @@ int ieee80211_key_link(struct ieee80211_key *key,
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
@@ -874,7 +878,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *lo=
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
@@ -884,7 +889,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *lo=
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
