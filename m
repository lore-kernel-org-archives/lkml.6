Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31AAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A2820C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NeSNiwMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A2820C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbeIXUyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:04 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389133AbeIXUyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l1ZkJ8F6Z5ijGvSTUXs/eSNokcK39ILg6TyG4w4zbs=;
 b=NeSNiwMnoynlcCUKAr9Qco1Q4QMQ+ivL0EoQ/4LkNflVPApl3R0OoDeZJY3REsCwMp8b6tLS6QGwhRw7nMvYP2B8KafsQK8ciL9W52yQHGN2a9dNIUFhH1ilPO1E0NUX2t4oeh59aYGLN0YN/OJLqh91nwRQZ1m1R3FRzigFD3k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 14/18] mac80211: fix a race between restart and
 CSA flows
Thread-Topic: [PATCH AUTOSEL 4.4 14/18] mac80211: fix a race between restart
 and CSA flows
Thread-Index: AQHUVBXZVuP3V6+vPUahiIglQcjlDw==
Date:   Mon, 24 Sep 2018 14:49:52 +0000
Message-ID: <20180924144942.164688-14-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:747APZUCued+n1HF5fXjC1iqyCJ/t0JJdRBOB8Qk5MVmEXN5ck3rYsrih+00OtuGOZ0MqHQmpGjvmUTisgCl8hZiNeRs5f+hY1ThaSgu/15B5Da+5SQxA6Ub2TjsU9EJlOaD/lIZbHNGv/nmlyKRZiYidFIU8rqS3r9E8wsqkB/pA3TZVfJVfIB1JXNuvCO1R2mkP2YHWLvayf4occiZQ6jO8+boQ/8/fE5UEqIvgDYeDtACqrl9NRCDHBEI+FnAubkTFaHyFp+ZUP/R/UdtNbTRWFS5bSXdht4aFkjokqVt6IAGyd2QPDeS+mABLaq1jrd+Bj3xEX7mK3PkM8d9UGW42jVHxH6qTLl2aASJKTMLs2ZHv6cvFAPg4BgEhEHt8QumLIedzQ+0DllVHMlfa37dW4r92fpqnlaRwNdfDipv0E/5XlBnxcN+BTsrqxBRHrC+O1SkBaZE6SchesfEZg==;5:lx5sPd0gQoNp++BrcK3pcckIDJBx4hH99LtH+pSxMEZE8EZKM9alQFs5ZF5c7FxyYVWWykkz4E+j8M+xus29xW0xdoazPZ/lzu1UXcohs97Z+2hS8r1FHnTuloaoxKFeFzCRfbdrNxecWUvNt8pgP5dCAuUs9ePfP22zRZR9Lp4=;7:7mlLVjn11LmEBMZO0nrlH4TVwvbb7g5IVHc7chD9XLmDSIbheP/pqH6EcKtXtOjSYQxjQcyaWzr1Vc/H32ikNKhsNelpVpgTFgnmzZbYX9TjaiRkaupZZiWmDaNsXyY2dCKGIbwX31eajSVnmX0MU0VfTWg5M0n17s/X6Ycba2uDufWqDJTzq5PTfjxasLNgdDFRU9Pq0f6siK6frqTKaHEOWIkQ04OCpr97wzBknM0f5mj1gu/BIkQ0OjSr+kfq
x-ms-office365-filtering-correlation-id: e602e4b3-7265-4973-174a-08d6222d2d9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821822A0FC5F23796F6249BFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jGF6UFz4CFMhxkfOiTA/ejw1+2dPio0Pyzogio1vqTfL2inHXutUXYflE963hpxFYiumD9+FmXCZcIH7Ndx0+qlTOZ51fdwXR0kN+GrcJdhjC+ZPK0VtkJPr6/xoIx/K7/zzcOLOMEZ8USAgHBfjlOJQEUyUgdKNcosshrlbQ6AGgm9dozEn2+ZBlbfWlQe2n+9Hzu2JSJKaEM3vD6efyh3+LLYzqZNOAGkBAX/RYcqLI3oobWUB/p0XzOUr0678T9KLxmJ565usJlubnP9SXRrtzeA09y0xLixHYvpgFhzX7BkKYLff11Thuijrl0UbeKiXiJFVSwZ7vZCiZEJLJzmk5juTaTV5QKlItNQqhm4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e602e4b3-7265-4973-174a-08d6222d2d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:52.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index d784d29a4fd6..15d23aeea634 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -253,8 +253,27 @@ static void ieee80211_restart_work(struct work_struct =
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
 	ieee80211_reconfig(local);
 	rtnl_unlock();
--=20
2.17.1
