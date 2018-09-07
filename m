Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7257EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256A12083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Moo3r66x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256A12083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbeIGFU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:58 -0400
Received: from mail-bl2nam02on0097.outbound.protection.outlook.com ([104.47.38.97]:7296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeIGFU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9CGqqWxSOifCYH+21liaQoyJcf85/eZGIRM5PIgqRY=;
 b=Moo3r66xnQeph+gdDGvsGbhok8ujj9nCPT9kF7G8fHXrgB6hn9iaoDBTN6GeqXtkQ27WXiWVXjIfgom+fU5Q0c3uOCsaZ1FhGY5EvUjUcwFTEgL0rnR91ESl+L0sVD6qJw19HzWjecdOWU2Bq2bj4RtLTixxOCiXnm60v1k2kXw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:42:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 16/19] mac80211: restrict delayed tailroom needed
 decrement
Thread-Topic: [PATCH AUTOSEL 3.18 16/19] mac80211: restrict delayed tailroom
 needed decrement
Thread-Index: AQHURkNBbgCKQhOw9kS2p4Tz0W68LQ==
Date:   Fri, 7 Sep 2018 00:39:37 +0000
Message-ID: <20180907003923.58019-16-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:pl4qNAmR/paxcImzr5irqjWNyIW2uzq5YlfxFmO2SsDEpZ1KEBMGuJ41WuQtokgEdOmwxxlQAM9mej3BWanhrXnjlL8tUEikV1QceZEc04rAJdfxqyk2toStK9RixJLCRqO77MXf5BkkNMlieBqzmQHaouJGUsV1UJiQ2b+iBU9lhkHBLDC0Di2YDHcj2aJBVrUy1Luom/dDqBnz59PCX+VpfOIqNnUqdsW9Ta2SXAvCNNDgkDern5OJB7Fj1L2Dz9kxNhqDPBMu+M+HsWIQpoJvAEtCMT6mnivF81YIyq594gbiLHyAXELd3Dh+bpNh7OM/UMNA85e2KUBoj7gj3wTQxeboUazpRKrRkJAnNsjmmvANEnzFFwpU9mPJq7KhFSqpkJafSCbGcsro7tQtTF+6Wh4z8+KgNDTko+NlI8v96pPsBejWdRPGzhh3PSD9suonq1FCH+mRq1WPlfeaNw==;5:1VS+8HCjNiuTPL1jfZdzvoCBO1tq20EyyBqFnmsjwt2A0Cb13itGh2r83IdhO+ETi2EkHwUCeZ/buMpwWVn9K1gmkIBjlfV0w9ILEoRfiNIKlzub4CN7Tf+yJZmVjiAnBW0vKozcKoiH+tb/eOq9YbZ/MhILEE1bPaacnfiHsCM=;7:ui4PnrorsiTYBl/3hVYgh61vDsE4kl4RnzbpqKzWAVPXMZ+Rxn/Q7e9WrUXzx90uh++ab29E0JPl9VRpRsSEyrXLnMlV5jAWmKJF89wo0+qPmPc1SwUHnRJlJCw52AOr0tkOdhVCu/ECSWII2HSglMTv7vfuNJC2Hw9YMSoxguiVMDNEg3LVfjjw6OvIi5n1fdyetG1rjEah7bCGU6Jnnuk701ZLuUbmLJzFt713oxC/AOB0VxuJ2AIhFiEEJz9g
x-ms-office365-filtering-correlation-id: 8dba7b56-d5e7-423c-eb30-08d6145ad435
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
x-microsoft-antispam-prvs: <CY4PR21MB0631B474E9AAE587C7EC9287FB000@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(8676002)(72206003)(5660300001)(26005)(66066001)(6486002)(2501003)(14454004)(8936002)(6506007)(81166006)(36756003)(97736004)(10290500003)(81156014)(478600001)(22452003)(6346003)(4326008)(217873002)(10090500001)(102836004)(1076002)(107886003)(6436002)(256004)(68736007)(106356001)(14444005)(110136005)(486006)(11346002)(6666003)(186003)(6512007)(99286004)(2900100001)(105586002)(7736002)(305945005)(6116002)(2616005)(3846002)(316002)(5250100002)(54906003)(2906002)(86612001)(25786009)(476003)(76176011)(446003)(53936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tq9DPeUeYn5UvyZmK6iAhJ8Y3A+sWW0uXDt8/MCOnEiPUMuem0ZEQbu6OOhfNgmrqF5Xp64s2B54qB+87ahJtSDhBd2NlnNwgocbkd1JYDOJvkVXRUnN23amY9TBOk8aPtm4Im/mLzfFBjXYczI8OExJFroW5vItTSB5OuPZv6PIS+6FyyjTQWi/pW2NWTZpS8hOWhx/CcaOBXuxJLheYFrPOx0HJ2fsjYwiFBSh6JYwJbLH464PBAjI3NltKNNGJn3IAD9UKisGhQCr9qEQRRMn7jY9Vlp2ksrnysFwkY0oZL0dwUunWtzuYfTqVZElojNJ6PJ8/QnGmRDyYwCqQoW0KvN1/+j7ridWOM6p0vA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dba7b56-d5e7-423c-eb30-08d6145ad435
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:37.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index d061814d1ae1..9d224151f639 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -276,7 +276,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struc=
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
index 375ff902a142..6bd74d2556ae 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -515,11 +515,15 @@ int ieee80211_key_link(struct ieee80211_key *key,
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
@@ -547,14 +551,14 @@ int ieee80211_key_link(struct ieee80211_key *key,
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
@@ -705,7 +709,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *lo=
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
@@ -715,7 +720,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *lo=
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
