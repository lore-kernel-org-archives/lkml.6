Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EBCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7112087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V+9bLYfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7112087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeIXU7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:59:41 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:21344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387685AbeIXUw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MQIuS79XUrAgR7aeOLCY6/BgWhQWJY6z544nJEsPvw=;
 b=V+9bLYfWVTdzw5boZiXgyxE1v5DnoS8IgtsTakBMBF7ymUFvz/rEd1J2vYF/jjrKHBlfEfemJkRFepx9SHV9cmQUrFnaJcWBy2HSYoEZuwl9S4jUgEK+t0ivexCrMK4cOK/ZP5sWYH6iAV+fBuS5OXhXtvCmiXZJp6HllPIeqbA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:50:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 33/36] mac80211: don't Tx a deauth frame if the
 AP forbade Tx
Thread-Topic: [PATCH AUTOSEL 4.14 33/36] mac80211: don't Tx a deauth frame if
 the AP forbade Tx
Thread-Index: AQHUVBXB6LPqpbpE5UyzZD1oQiK4Pg==
Date:   Mon, 24 Sep 2018 14:49:11 +0000
Message-ID: <20180924144851.164533-33-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:YYegujd6E74YPrHClSTOi3qHzf6HU0gX46exHFONi6XRm22CZ2yEnqpfrS51tyfst6eXB5Zn39/Bpylo/DF21LWwFUjUb8CQbZ46nd0V+OavXjAreLuHtWjhdPPx+hmF+OCMrKxq91dAZBxivrof1fipXZNS4TVozdGgX9U8GMRDhO+2ktY87AuBuTlP50jJH0cmI6dBSrKcUL1yaKT4KTPs2yCgl2OE3m2jsybH4B91IxrkRRClZWdz12D6U2vRRf5tENjKf4WUMCEAG1mqP0s1ED4pLr1ThWBwjZz8MbPSSYzLHNIPMt8mw1sabLDoW546Thmsvdkz709o40Ki4aRVQVYySzRv9GCqwUTP1/lCG9BgDuY7N+PMCD7CTv7fa6riEp8EcFcwE/KaoeHEKfx8Fl0zgQOAjOasR+AnKl6K3lhwFV5/m7gx97BYDzRMAUstz/wPTdtQDEXwlsXD0w==;5:GCiqabM5CNkl8rxzQlYeTbRPE35IN9jkMUMPZmMdZXIANVIe+Rqwq2K9vELF0hDHMykyMJXuKexMf4INNa8Dzzyrn6Bcp3WIRk5Rlg9K+4o9PDCLF4k8MPkT8PC8loelMO5D/Y/5koz6ow74d0X6HcWxafT1WjYZ36T38qcIyRY=;7:Mt5CqBnwn0uemNZSUgWnnqjjfbW/1NNz45W7uaXkN77LS4r7GxwzePhK9vZn1Kbq+mnwdxKEuigRmr2/iNPmkDQaAKzPqRvh2j4vmDSBiptwXhqR/76LBareoDcm1l/mTiik1AjNu0mMGMsecehSemCtKr1hrH/PhoKXyqljIqIDOPt9a81nukNg5X6C0d32h7WTDS1CxEyEHymSmfc7jsnssuAeXj2GM67zIyqBv9V0YYmZrwG+/zpARlhjHttp
x-ms-office365-filtering-correlation-id: 8fe26941-978b-45f1-adf7-08d6222d0e06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07449EE3E1F28F60A6889803FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(22813001)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xhJka1sUA/bw7pg8OppgeuvzYJwwgY0cbEFppL1bXujofADkWD1hCd9TWtlxwj7a4Nf/Jv0GV+yO+SP69UdVUXqq8VBuntJtD3IaQz3aNmBXNikfopiP/zZLHjZigY5+WbFtsDDjmU3OT2ZtGOCy4FZ9a/VXWqfdE/dftLvrzdF/3qhq+ktEo1JrmuOg/tsNn7HYgGcz4FX++GP2F8QRWcE45q3FLMqJ0OwfyeV/TOWFrzw60TnQEysEbdM75062+jHwoMEofJKAzYvZyaLnoxDpJmUCOhOiNuQqF4iG3IvOwGijjzwD0vkNHRfyfUxj2u3KtIVjT7oFuTBL3qRP8+qZdgZuZVWwPDtLmAumH7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe26941-978b-45f1-adf7-08d6222d0e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:11.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index a287b3891643..328ac10084e4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1280,6 +1280,16 @@ ieee80211_sta_process_chanswitch(struct ieee80211_su=
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
@@ -2450,6 +2460,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
 	struct ieee80211_local *local =3D sdata->local;
 	struct ieee80211_if_managed *ifmgd =3D &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	bool tx;
=20
 	sdata_lock(sdata);
 	if (!ifmgd->associated) {
@@ -2457,6 +2468,8 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
 		return;
 	}
=20
+	tx =3D !sdata->csa_block_tx;
+
 	/* AP is probably out of range (or not reachable for another reason) so
 	 * remove the bss struct for that AP.
 	 */
@@ -2464,7 +2477,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
=20
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 			       WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-			       true, frame_buf);
+			       tx, frame_buf);
 	mutex_lock(&local->mtx);
 	sdata->vif.csa_active =3D false;
 	ifmgd->csa_waiting_bcn =3D false;
@@ -2475,7 +2488,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
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
