Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56936C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB802087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e5Np7hO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB802087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbeIXUyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:25 -0400
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:27672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732020AbeIXUyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trNFnMrpk1i/+Eb1dXOdrB4UKHvV5U+DognIAMF+Wxw=;
 b=e5Np7hO8SeCRRoaWdCmfoiYZ1rCD41ZqcbV4SrPzH14Ys+UwFCrK23AOBDVAZuLtBOHXjo0wiAFSxmYKeKqsOSodT3KFd4yA0N0Tb1FKk7t3e5kgkHipmfpcB0NbL3Bn835a3badtaPaY1n87rH+go9ke5bWVxiV8kOPjqpjbPk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0136.namprd21.prod.outlook.com (10.173.189.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 10/13] mac80211: Fix station bandwidth setting
 after channel switch
Thread-Topic: [PATCH AUTOSEL 3.18 10/13] mac80211: Fix station bandwidth
 setting after channel switch
Thread-Index: AQHUVBXlUmaeeHKfNEyikjGH73a/vQ==
Date:   Mon, 24 Sep 2018 14:50:12 +0000
Message-ID: <20180924144959.164754-10-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0136;6:noA+gnomTXCNRycN51ioHz8H040YCk6MwEXwFf6fvmcQK5HH4LOkB8dOF7THfJFyrl8jPmM95N2Tqldu9j/CdYKi8ikN3rzfdOsmmhh78Doqts0NyccN9w/B+TyElpgk84P/mq6ERdVsIxsdjMaX1q8M3yysT+VAk+rskGnSQtPrtoNzrUN/lkHqTCw9k5tFmmEUiv5psWBKcPG9qnlk1B5XUycPohVeDhn+4SLYLSXhjSuSJZwMAhTmVjldwZ1ebXUwxqXYKnl4qvaIex9i+blOad7N8EXDU3pHW78uAeELkrja0+6gK5A3ZCMPFMxAz1R/LU2jDqkZu5e6RJAn0rRb/qtM6gwFbayfGEWOFVkr+bx5GXQYqA0Tz5lk5tMJnCDG1AC9TZ9nKxUwHDtN+DOVnV/AhaEyElz7TYG4ztcPQPBPk8OCiXeQQ/w6uQ6ExedvujhpinmqL0wMA+7yRw==;5:s2CNPVgGVCs3MQQ2eSC1A6KDSx8aDb3QC14LD+N+nQwrL6Nuewkvp+scWOyL5wuBHgXnlQ1qL8qSBtgat05pVYNvqWmzlSw26rJV5jX5flG4X1ig87Pudg0XV0z/+fIWw36PZfb1Zlp4z8SQXfi04LQ6yf0gu1vE2MHQ/QCQ9kc=;7:HLNgy+l347JswvVrNVXFR5HkXtVGnkF7jrt/iFB21lh9Ag4Y9X+cIIPbIVKQn4LUjanzr1jYaw+I0AontPu0+cmqqbSbvOkrmosW103Jn/4rSwEh6GfFcwVV6YDR1QOcOiJyDG4G7ApveYmFn3prgWddsSkBWhYMrYFltD/TlByShzmbbRDAZNuLsQZTSjsN+L85xJ5sjL/lW0lm+LeCHVIu2eY/Wi8JImuQRVN0yZndoJHUzJgGhrmR0zaLl+gR
x-ms-office365-filtering-correlation-id: cfb0e28f-eb43-458c-8ab1-08d6222d42e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0136;
x-ms-traffictypediagnostic: CY4PR21MB0136:
x-microsoft-antispam-prvs: <CY4PR21MB0136F24EC4870E103BD6C260FB170@CY4PR21MB0136.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0136;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0136;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(478600001)(6436002)(2900100001)(2501003)(6666003)(5660300001)(102836004)(26005)(6346003)(86612001)(86362001)(97736004)(186003)(71200400001)(305945005)(14454004)(1076002)(7736002)(106356001)(5250100002)(6512007)(72206003)(6116002)(3846002)(10290500003)(6486002)(105586002)(53936002)(25786009)(71190400001)(8936002)(110136005)(99286004)(54906003)(8676002)(316002)(68736007)(81156014)(81166006)(22452003)(2906002)(6506007)(217873002)(4326008)(107886003)(76176011)(486006)(66066001)(256004)(476003)(11346002)(2616005)(14444005)(10090500001)(36756003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0136;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ysicmSYuNYlGWPKxAeH8jq+izWSBVq2mCpCa8eiByVxfb0RKsvktorFJ2Cou9QZGwodEnWe3uIOAwE8ZL/Dt6+HxG4SyvuHJssSG2UFA9yMQMH4bWLsghY81FKupQyO4dR8rpT1ybEzpFeMYvDx1ars/EkuQnF42WUCOVbpLRzrPYC279zIByqeUKEV70cvLTrJIXoe97lFDQ87cKlXmtPs3IrsjPI3V09m6hCpigSPgoKeg6PGjUb+u3q5MjYYY/0Yxzp7igbZtSIQ05Aa0ykKHLn8VSc/v9EVLstFemFyV5cbc6ncc5UlgI8xmvh4C/tBpW3vFX+Dv6TZVLxX+seOHdjIaiOyFcU7F5YYd7wo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb0e28f-eb43-458c-8ab1-08d6222d42e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:12.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0136
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
index 690fbac121d2..56eb7516c7c9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -970,6 +970,10 @@ static void ieee80211_chswitch_work(struct work_struct=
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
@@ -978,6 +982,48 @@ static void ieee80211_chswitch_work(struct work_struct=
 *work)
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
@@ -988,6 +1034,13 @@ static void ieee80211_chswitch_work(struct work_struc=
t *work)
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
