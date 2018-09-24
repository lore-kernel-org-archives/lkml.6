Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CDFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E51C2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kyL6qVYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E51C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbeIXUwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:06 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:2846
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730027AbeIXUwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkbj1upGzb0QIU0B5+NDhzVr5nnJfE41QIHb4zBbw+I=;
 b=kyL6qVYjzS/bN4QzZhN0xu9EfkXrmj9PQ+16nouCQRe4pWhfi0CmZS+V2u4zv7tNur4iuk8kwem0xEy26MZoiHJuBvwuLAddCLUXd038IuOc5DFxbjuPeJR0qJBmMCCfYP1NF7oIcerKVYnH/gGWHIXxLVqqC4n93PX4Mk7dr4s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 62/76] mac80211: don't Tx a deauth frame if the
 AP forbade Tx
Thread-Topic: [PATCH AUTOSEL 4.18 62/76] mac80211: don't Tx a deauth frame if
 the AP forbade Tx
Thread-Index: AQHUVBWt41XXgRLFN02Rk6U6x/Dvdg==
Date:   Mon, 24 Sep 2018 14:48:38 +0000
Message-ID: <20180924144751.164410-61-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:pGR/MeVb12oTw0hZ4fNPOglpt7YWWE8XCZyJcuEpMde9E4JnotmiNhq4yOVe2Cr1OYFN6lQeOdfWRgw28jpdj3V8xRqGFaJkjztBHXdVOCHh+tPFWMQb6UEA8oA6aXiK/1i+das4Z03kN2rF6RIw09ywfBLElBP39Wcf7yJXsFNdQPTKgr/XxvELbbUYPX5iigclXwQyCYBxvFqKhWaHQkfyzfO8Bm6qtTdBRis3QVEN4G3YNyAyXjBqYT5NmRwQG/3jPp2jOvoJ7tfk5JFBiJ9RnpKz8DBoTML/8fR7FhsRmgOsjXVocfPYGeDqtM0bKpcc5zb3JIX/2RPa8ExAYTxrIVWo8eeu6vm2dFko+8xLv2fO5jFZqQDsFVaHdx6MHd9ltpbq2eDEvoVGP+aKUvsFfysWpCHoWpByxPkMOcPL7XXFuisSEf1sIDeJ6ze/Z8KzszH5SJMBVcVAx6y+ag==;5:yIxfdTOsm85bniPKPb3iaEPyc0pS+rpb5GFe+q20J8/C+viNQHUeeCWwjPkIWA7q43VvBShpGa+yGrRP4yK7ZbrfKLzMdqlbVxaZZTHXHTIUZ65tsG7x9rBCJuyigfSsPS5PgFEYgfoDlpK+HH5faEsWtA075F9yfstPcS/sm8g=;7:lrRSKV6IAM4NgPRHO9w4Hghjy/2EpSQD+ub4qfxFkzmfBFQs92NSj+wQ7NtSSaG71tIU+v40FJpDbVPjGcP+qAFgRTNgDt5TophlQP9BQMnRAYVfscbIOkYdVhCMY24ZTQ0//++3kVLJlFmMLNSeqqFEwWc/gY3NIOTRo0LQszDAyzZQZY0hPzEYAbnQ/Stu159OMugJ1fnV0DjXYgJHRM0H3SVmYZQlD/EsrXM/fZVB84xh+RC9diHnK/+fwa0u
x-ms-office365-filtering-correlation-id: 45442d29-8d08-43fc-20da-08d6222cf105
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0471613A5BD1E8155F36A121FB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(22813001)(199004)(189003)(6512007)(105586002)(256004)(53936002)(14444005)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(2900100001)(186003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4uJU66egevRXLxz/CJei5e8LZV+7s/wlLEglplZF9HKgdVUKDB5O8WDiZqF9muAFxWLajByfe8orzR0WRTbaOFNz3widTNG1GgPXnLP3htP5Wak83gn5gidTpr1C8HDKK5MwseFtBB7ZJLdPmaz0/hx70NdCp/5MB22rVyqObOtFp1PLodDIQomD1cDwJsoRshEa6c8RGFh46gcKYn8du+dmq3sIubBwnOu0UXLnCWOy7Kifc1zrHqNrf2YWT+moYchvrwp6118ThUjLGT7VTWjSjrQ9HYqvkuH1Vms+7INlsO+H45yjrSSJEiSU16OY/Rk9YIycaLf5b1E10jkOuDEfmy4MA0crUhPUNaCFDl4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45442d29-8d08-43fc-20da-08d6222cf105
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:38.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 22b699460176..b046bf95eb3c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1270,6 +1270,16 @@ ieee80211_sta_process_chanswitch(struct ieee80211_su=
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
@@ -2453,6 +2463,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
 	struct ieee80211_local *local =3D sdata->local;
 	struct ieee80211_if_managed *ifmgd =3D &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	bool tx;
=20
 	sdata_lock(sdata);
 	if (!ifmgd->associated) {
@@ -2460,6 +2471,8 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
 		return;
 	}
=20
+	tx =3D !sdata->csa_block_tx;
+
 	/* AP is probably out of range (or not reachable for another reason) so
 	 * remove the bss struct for that AP.
 	 */
@@ -2467,7 +2480,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
ub_if_data *sdata)
=20
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 			       WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-			       true, frame_buf);
+			       tx, frame_buf);
 	mutex_lock(&local->mtx);
 	sdata->vif.csa_active =3D false;
 	ifmgd->csa_waiting_bcn =3D false;
@@ -2478,7 +2491,7 @@ static void __ieee80211_disconnect(struct ieee80211_s=
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
