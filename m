Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A44EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1154320844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lXkSr5wB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1154320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeIGF3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:29:53 -0400
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:45789
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729240AbeIGFRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nbvutwqQDwc5rF+Vzhttbi2bNYoXb37ivFjN3feTQs=;
 b=lXkSr5wBQDs4pWoVAwty906m1kpfB8sWq/zcpQyHbA/DKYlRWem9eS3WcQo6bUtmJDMXKU078P/yA9QA/zqLIQGoLpigoRgS5p1naUJus3d89HoOqO+37EAjOAwUjQlQbFd15bFiSFIpLhXD3C8OsYs9kOc6QHr/F0q1wEKdo0I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:39:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 47/67] mac80211: restrict delayed tailroom needed
 decrement
Thread-Topic: [PATCH AUTOSEL 4.14 47/67] mac80211: restrict delayed tailroom
 needed decrement
Thread-Index: AQHURkMF3rRAA6qbDUK1JQW2aDGGYg==
Date:   Fri, 7 Sep 2018 00:37:56 +0000
Message-ID: <20180907003716.57737-47-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:L7sVm7bqU4N4+SfYumUuwr4Fx6/Sv+s0mTOqQAL+QsUo1T6wR9SWJooiHQcl42loNJk/+tFNyX8UnEkJSMml8AIlFHGYFQCybtC2DR6goUFG2h7u1IUIpdijDwsUDjHcznpx/HIO41bmr6i/06WWC4GZ3StDbpXfn72fh8Jc9iYI3M4rq5rhS/K44rQ31Dwxc4/0SRnSCIEvO06L5KfU6mN0OkW3U0iB2tl+melFi8D+uNnmtrMiaSR3wUbuBaSozAf+muZNUbUahRezDFG/x9fY8WgGEMhVfYCAyToskaN+eF4d6sRMj1M72zUmreFYVBiYBubNUhIEm5LgmrZL+aQq2zUMXCF2XPi/uhTHe61sjsBb7ETKE6gH5tXo36s5Cuds9+VquV4thy/o9AIknVRFQwiweGvTdbUeViNh6zFXq9eQZgLe0uJUGbXuQV/djTWSAZZKLfrOhdGz55t5Dg==;5:DyVS6JEqUJxe8eiQ4XUC9zi/GALKsVcEhn3MjhGa2B70AF2h8e+xOvgkJPRxU/BkPNYfipaux2QLBS1Oer0qt/edPzGIk4UiQiG2mgdlGHueE6g03XUvEL1e/Svnbr3MbfIqvDXIrQqAgB7Z6loakHIwAQv9UxrEBcXHVeVwy7I=;7:pgCSyurndik8Tk+CKKiPKjBAKEVyW4GB64jOgXE8WkpuvFHfKmcvjzN+aYz7QnS0+qla89po7gce9M2/unRs4SRX0p49Cj01/LtxkIZKfVRsXdGhfxFVpkrBDQhRzFqSQBlzKhGCJYZIsj1CQnAaULCVIhSPJJJD0yki5ctPfHGNlWAN7PyLFxsXyFl+zsff9teFu6MaWUCJtJ0sfwSZQHiM7TIo/bFAPd/ASCKmVoFQdBvSfh2SMpFq43A8hfwa
x-ms-office365-filtering-correlation-id: 66963228-9084-4cbd-5bf9-08d6145a4f3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839994AA3CEF436F6873FA5FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1UvhPtO8pmASJ4Nxd6719rQ2O9bHEpwHg617Y2YBzPv9Lw1Mgwmei8IMcgePYLRSNpG9JBegFe6Jiz0Dr9SiEIMkmt9x7Zir5+TCdke5LNxM/psRrSwlGZ0wooV0JwuH92BC+HawZEjq5KYMUiMIjuXKetwE19ZgZAwttuEv0T5XUcezVnbVETOWA9czXVBBxbeHbWlmQqraYrYN2e5hk/HSO3s15YRCZSuwum8lQ6l+IYTMufv/yyU9e8Bf/0hGa/HotvBen+EZ1GqtPhZ1kQpZpZ3EODNI3yNjSF9omSPXgbrzYK24aAUSqKqXwL4jAxmntftPQZhBG6i4xP8DMhpqtE17P2ZgkGxojKVOVtE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66963228-9084-4cbd-5bf9-08d6145a4f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:56.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 288640471c2f..b456b882a6ea 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -494,7 +494,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struc=
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
index 938049395f90..fa10c6142244 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -649,11 +649,15 @@ int ieee80211_key_link(struct ieee80211_key *key,
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
@@ -681,14 +685,14 @@ int ieee80211_key_link(struct ieee80211_key *key,
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
@@ -923,7 +927,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *lo=
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
@@ -933,7 +938,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *lo=
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
