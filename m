Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A924C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA942087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c8xaxFku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA942087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbeIXU6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:58:06 -0400
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:37225
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388734AbeIXUxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUUc/9vR1BztZE+OtK2NRMFSQoYt6bAHhW5gxwRudj0=;
 b=c8xaxFkugC4gaBQ+FBMUlperCUP8nPTeMJgdB/bPcQNfYURjbZiZ1PogrYIw8j+881oGbmA4J8GsNIdmIcgL42O2Qh8UKrO5srnE79k4rw95Ci5yw5yceR4TGwHsKANPbbnq//kIc/aZ5zTAdNlCFOgvTLKSkwnIMQYfK0Ltnh8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:02 +0000
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
Subject: [PATCH AUTOSEL 4.9 18/23] mac80211: fix a race between restart and
 CSA flows
Thread-Topic: [PATCH AUTOSEL 4.9 18/23] mac80211: fix a race between restart
 and CSA flows
Thread-Index: AQHUVBXO9MCPhAaUm0eCXYr0ErlWyw==
Date:   Mon, 24 Sep 2018 14:49:33 +0000
Message-ID: <20180924144919.164617-18-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:KMPbKcSzyn1IZnQbDudgmY6dHc3XiI3zoE+ar2aSPTNS5CioysoGMKPbHp4C3N5mEesUXcDDlbn1Lu5P7pj2klUZ6OzYnGESgSm3slZW/ubg0pa4kInHMPwr60n05MNYx5yV0nFehMxKVMOJuAYzSI5ebqMyQ7sFQiHeBIScFjuyZ/deN3E+mBPzi4MBSNmd2OWrtLBxDME0mYe9wQztp5V1RGV8OC/ilZhynkkt25SBNnIagW9+p/OH8Rap1Aj3I1oYFw7Jl0VetKeHcq+LFqfoc4JZ0ikJd2BUTsZGggriix3tAJlrgBDTOO1BGdUQbY//aEthTEqfwLW5fiSdG6uO7ZCdlw3/i1ebJ5NtUYzjPBFaK3sqoZyKRzny85cgVEK4dUSVyebGJXi/XTA/f0jPtxcR80cGBHxyB7qpiJ4zVI9QExNUk+PDCB/DobLcR8q6nCAXZURRgF1XFw0xsw==;5:M11BudE2cgjzTBa6+DxrtBJQX80NUqQk6sU3l0bvbCgYkB6bapNtJd1VHqpC0Dw9vHypEDhl1qPb72GbLINsZucYH0Y247Jd/UKecW2NpbVqW8y3NlPH5JWna0FCRpr8OYsM2vkCCIIfsfYax8iMUBL4FAWsR2loBdEu8JST9Wk=;7:8eM60RWyf0E3zNN30vn04/GatseDc+db7kCGnXlH4Opoi3fS7ojtvlUFDmCkA1kJlVQYfvP3YTcFVjd6mSjK2JKthfnyFZHkKjk1fQ5cgc3qz1U0s4kL0pQDmuoV4Wbblu1tH8VkagMlnKO8CPndhvUPu7dGb17A/PkvvFNuf0oh4WzWS8LDeSZEjK4mEIcWVHpxlbOloqi1yzBhmJY8wCM4YJ7v4mQ+7mJqZ5uYjBeTV9S8zE5f7e2eYJAjQqzW
x-ms-office365-filtering-correlation-id: 8c8b126d-c9d8-429c-4b8b-08d6222d25c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0631F28836CB6093B66E204BFB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JYUi4ndkJSm5aisVIqIkOswPbiR9rOLfKun8vx4uAXrx5OoxDqNGSFibs1hQVku8LMmNB2sXTNu3wybKL2pFJAs/ndKLtgIanSSx+wBrfqtwwcad3/jZUOBioMhsN3FvVAUpxdMxW/afNAbw/0rjVv+tPkCvGQKX3u9e/47LBgdvNGgBrM6s5p3s1MxSlRCykl8nny/HhMii8FP5y22WwldIyPcNNptr3HhweC5cxruYvD2R3oIex5g3giqCJ/Co4niE0l4tlcRqhWDBbt3vhkd2aF+kVds6y9Yr5YFXPGtczpekF7ZKcH0TCXGkY65Nqtuld5/iHha/GneKwxbotZy4/yHm1JIZvtzwxhZDwFc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8b126d-c9d8-429c-4b8b-08d6222d25c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:33.9246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit f3ffb6c3a28963657eb8b02a795d75f2ebbd5ef4 ]

We hit a problem with iwlwifi that was caused by a bug in
mac80211. A bug in iwlwifi caused the firwmare to crash in
certain cases in channel switch. Because of that bug,
drv_pre_channel_switch would fail and trigger the restart
flow.
Now we had the hw restart worker which runs on the system's
workqueue and the csa_connection_drop_work worker that runs
on mac80211's workqueue that can run together. This is
obviously problematic since the restart work wants to
reconfigure the connection, while the csa_connection_drop_work
worker does the exact opposite: it tries to disconnect.

Fix this by cancelling the csa_connection_drop_work worker
in the restart worker.

Note that this can sound racy: we could have:

driver   iface_work   CSA_work   restart_work
+++++++++++++++++++++++++++++++++++++++++++++
              |
 <--drv_cs ---|
<FW CRASH!>
-CS FAILED-->
              |                       |
              |                 cancel_work(CSA)
           schedule                   |
           CSA work                   |
                         |            |
                        Race between those 2

But this is not possible because we flush the workqueue
in the restart worker before we cancel the CSA worker.
That would be bullet proof if we could guarantee that
we schedule the CSA worker only from the iface_work
which runs on the workqueue (and not on the system's
workqueue), but unfortunately we do have an instance
in which we schedule the CSA work outside the context
of the workqueue (ieee80211_chswitch_done).

Note also that we should probably cancel other workers
like beacon_connection_loss_work and possibly others
for different types of interfaces, at the very least,
IBSS should suffer from the exact same problem, but for
now, do the minimum to fix the actual bug that was actually
experienced and reproduced.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/main.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4729e1c09bcc..e3bbfb20ae82 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -254,8 +254,27 @@ static void ieee80211_restart_work(struct work_struct =
*work)
 	     "%s called with hardware scan in progress\n", __func__);
=20
 	rtnl_lock();
-	list_for_each_entry(sdata, &local->interfaces, list)
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		/*
+		 * XXX: there may be more work for other vif types and even
+		 * for station mode: a good thing would be to run most of
+		 * the iface type's dependent _stop (ieee80211_mg_stop,
+		 * ieee80211_ibss_stop) etc...
+		 * For now, fix only the specific bug that was seen: race
+		 * between csa_connection_drop_work and us.
+		 */
+		if (sdata->vif.type =3D=3D NL80211_IFTYPE_STATION) {
+			/*
+			 * This worker is scheduled from the iface worker that
+			 * runs on mac80211's workqueue, so we can't be
+			 * scheduling this worker after the cancel right here.
+			 * The exception is ieee80211_chswitch_done.
+			 * Then we can have a race...
+			 */
+			cancel_work_sync(&sdata->u.mgd.csa_connection_drop_work);
+		}
 		flush_delayed_work(&sdata->dec_tailroom_needed_wk);
+	}
 	ieee80211_scan_cancel(local);
=20
 	/* make sure any new ROC will consider local->in_reconfig */
--=20
2.17.1
