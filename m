Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03436ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9913D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gWW80rXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9913D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeIXU57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:57:59 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388789AbeIXUxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mctw+lUijxCdNCjwyZ1NiNTIpFd86vXZ/j5+bRDeXtQ=;
 b=gWW80rXmHbLtZu062+B9U076PBIjHNUZhuw2umX0eA50qiHL1+Eaqifi+MrYIfrw3/fzGBFYCPpMNmm/3bO5K40faTrN++AnXdyMh6QBnX/EYMNYu+U93W6lBBO1BQI8EXC8DgICSWg0zLK00Yt57L2wwnX6zk1dOoUuOz/TUgk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 20/23] mac80211: don't Tx a deauth frame if the AP
 forbade Tx
Thread-Topic: [PATCH AUTOSEL 4.9 20/23] mac80211: don't Tx a deauth frame if
 the AP forbade Tx
Thread-Index: AQHUVBXPILXTR6IitUq1Zte4mwUxJQ==
Date:   Mon, 24 Sep 2018 14:49:35 +0000
Message-ID: <20180924144919.164617-20-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:/nykxlAtcaEZndOWT+VQFLaAp30GmBN6Pa82MNxUWy4jIU7QJQasEqUZrSrl72DwwB86xwIRxFjQK8Pt1uvrHeu+h0v4h+FmsIOEae9jIWW6LH/0Tz/NSeDYCowTluHe+ERECWEW6dn9yxpGGjvQGcm7B4+o0WMzegjkQDSw69eoqCLixRVZjC5UhjTS8MWYIi8gcA4ZsnRjCohVjz5RdCgyuoEUS0KwxV9MJx3ZvtzBbd4rtHQDC6267NqaxzrQlpdiIvf6Oskx/gXFtRS81Lu8UbuLDPL9aWunLl+H7jzqN9MvDhgiFrQEeaX3JuiEO7qJ1BgvWNFRoLYUZuxgwzVWgVruq9Cj/wjeudNG2u9qsOS6BT/S7ld3UAv5fupVJ0T1w5sQGCOaVvpRw9OaUmt6SE7PJaiXJus+87n1SZb0MpWBow07TEx9ouhGottWxrMTnpUbDMMSOzs1IIqG3g==;5:NII3hwD3DIInfBfRyUX1ezXh20syotiZQMKtPkwKoO4JWJSGfAIZ64k70rcfRiF7AqE+ejqp3XSqsHA5iILrE5IBcrprqz5AAQnvM8wgRsHpFQFwdGAzyFmDmoUut/r8ImX1skPeoyw93Jzd/y80HVDivuuYf8c2Qg8TV/66YMk=;7:/8IFWhPVcYOYpik2+fUwj48Uqe2LvSOtY6JOTCWv/R1dFpG6F6RNznbjvQZdAGvGLNLK7sYWJI+3on+1FI/MylInKImY4ZgWkqACuC4Gqm6J9GJ+gASQXAYcj9NI6It0Fea3rM11ru2aBj4iwsuVG+8a7j19ZuoTNYgyyGn+hAhNcOc0w29DMM3iIjrkVOGvq5unCxyCO7p8BmOufxrWoHBkkyMk+CPmiLol8mYxA12qiNttsgl8UZfuHde68Joh
x-ms-office365-filtering-correlation-id: a2e4a2fa-e6bf-4ecc-8a22-08d6222d2635
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08213856AE0CCDF65D1B52C9FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(22813001)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hnYwMKll3Gxaig8icHaLod2HeN098vto5aversZOwECNXee/GdneRPwpEraqkNK9h4CMpDJimAU7moJTMd2XTv8NdbRt8XKzey8es1+pvpatmV7G3Cz4s8uWDfP9qa7WNNuePoJISx7aGWRlnlCzbV/GU96BqZo/ZdHCN2SZmKPS1ZcGbVoLRocCcmChnrmbRrtVfMbHgu2HfihYJhJmIb69MHTLazJY+PRTsnRHOIoMTiU/n1j0PVdzfftHQKFqif/HtMACvi1ARxWBxqpyxVC0XKlcelC1MfzBjcq4zbQIyuAwpl4k36r1wKY5gkuDFJ/DiqWq/Kv7nkFopM3vc4+D+ypijK5UNNkIdyE6uu0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e4a2fa-e6bf-4ecc-8a22-08d6222d2635
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:35.0675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 6c18b27d6e5c6a7206364eae2b47bc8d8b2fa68f ]

If the driver fails to properly prepare for the channel
switch, mac80211 will disconnect. If the CSA IE had mode
set to 1, it means that the clients are not allowed to send
any Tx on the current channel, and that includes the
deauthentication frame.

Make sure that we don't send the deauthentication frame in
this case.

In iwlwifi, this caused a failure to flush queues since the
firmware already closed the queues after having parsed the
CSA IE. Then mac80211 would wait until the deauthentication
frame would go out (drv_flush(drop=3Dfalse)) and that would
never happen.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/mlme.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 04e6280f4819..39451c84c785 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1282,6 +1282,16 @@ ieee80211_sta_process_chanswitch(struct ieee80211_su=
b_if_data *sdata,
 					 cbss->beacon_interval));
 	return;
  drop_connection:
+	/*
+	 * This is just so that the disconnect flow will know that
+	 * we were trying to switch channel and failed. In case the
+	 * mode is 1 (we are not allowed to Tx), we will know not to
+	 * send a deauthentication frame. Those two fields will be
+	 * reset when the disconnection worker runs.
+	 */
+	sdata->vif.csa_active =3D true;
+	sdata->csa_block_tx =3D csa_ie.mode;
+
 	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
 	mutex_unlock(&local->chanctx_mtx);
 	mutex_unlock(&local->mtx);
@@ -2454,6 +2464,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
 	struct ieee80211_local *local =3D sdata->local;
 	struct ieee80211_if_managed *ifmgd =3D &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	bool tx;
=20
 	sdata_lock(sdata);
 	if (!ifmgd->associated) {
@@ -2461,6 +2472,8 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
 		return;
 	}
=20
+	tx =3D !sdata->csa_block_tx;
+
 	/* AP is probably out of range (or not reachable for another reason) so
 	 * remove the bss struct for that AP.
 	 */
@@ -2468,7 +2481,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
=20
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 			       WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-			       true, frame_buf);
+			       tx, frame_buf);
 	mutex_lock(&local->mtx);
 	sdata->vif.csa_active =3D false;
 	ifmgd->csa_waiting_bcn =3D false;
@@ -2479,7 +2492,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
 	}
 	mutex_unlock(&local->mtx);
=20
-	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
+	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
 				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY);
=20
 	sdata_unlock(sdata);
--=20
2.17.1
