Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F076EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBC92087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="giAwktzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBC92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeIXUw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:56 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:21344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730069AbeIXUwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys2vXEqAPIctmUN4JG7BZyPGO9D7cf3UXmmUlQLHvRQ=;
 b=giAwktzCScleV5heAEwUjSX7OXYX3O9RB3Erm+3bHiM1vbNNJKfSFO65Z3JRe9UtKzSwrCRCLoviz1aYs7oI2W2uUmZ8jQua1Ik6fYS2kvRvF9V2GuQRHEwO/t3sk668ZyJNPBi1hju3RLRkgqQgx21V/4pCQhkMu3+JJD1pOuo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:50:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 31/36] mac80211: fix a race between restart and
 CSA flows
Thread-Topic: [PATCH AUTOSEL 4.14 31/36] mac80211: fix a race between restart
 and CSA flows
Thread-Index: AQHUVBXBgLOI+ShVdUudAQpCbOrm4g==
Date:   Mon, 24 Sep 2018 14:49:10 +0000
Message-ID: <20180924144851.164533-31-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:iwZn6fWZg9/8Py+w9/2hzYq7yPfgEX+tunV2Ogw1wSONt3Dk60v4F7s85k9doU/TU9SKBcbQcUOwtli4OXU7w8V/x+o3AiqzywzDWAMxcd6O7LSy+8dTe2+H4KMoXG9nT6j2w6hm/xRFyYcQc9xVr91lqGqzhQ/YgPPHW58hLyS5E9BoyjF/SdM8tq77XZ3wAuSvnjDGhskpgTFoU0IcWLdglbuULsfUT8XhDX9Rd8e3asMoO8kBnQtzCGZvlQ9YKppZ9DV+4pQt5h4K2WWSr3mqNc/n5A/QPkvARZxZyjGdleSioXPYdX7fNzC3H0f19eXLJoySzEZzAVWYsqpcFEWCuNfkGj9lO6+PVXZNKS4sKguV3Ht8pUqnT/wG1gfgTxjicyWavj//LW7Rn5w/pONpZMJse6qlGrzpnjGsPd25N2c6w0J9D80OVEecyLGfVE7ONtqtwZ7V9PMZM3GIHQ==;5:XYZdT0pjco1DphA4Hlg946lkuniDM6x3xhct67amrIABjlx4IfG+FbVIr5Fp2LEuVFXySlC0YjhsEWePyl/EP3rikSg4wlRTkAr8ZqdbbQ2hOswVASX0A0pWLwl2ZJvr8v41YZgJ/yaeA5ZYwmHdJTHmByxW71OLZC7WNiTUmTE=;7:xnNfdSEMKIxVNA0HNb3whZRkm9UVqqt+v5bShQLNZa2iGaSQAOB4tBVK++AyB/kzT08DB6w8d8P5N/mabr9I1rytXmCZG9Gue/4vYWHInovHd2IzUfoLaE3og9Wq9lea9qOYDLZhV5ZQWPcNM99V/BPKElh8DAPYJDX6T3czp9gVc6KN6IxUh0nhSPBkf47udXJ/EGlFr6oaGdQM6qn+xo6f6hzj82TiDnosRd6W2IZqjSVeubUXZjaPs1WVMybc
x-ms-office365-filtering-correlation-id: e439533e-05da-4910-a090-08d6222d0d9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744F49C8B1178905D3B09E6FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HYxNyH9orsm5lUZk+Deead8N0jqsQteYv0tPF01JbVrCyuKS5mIaauZ67iDcDomrOVT8b4u7/xm8vPXmSVQZnhn2EO8j7W6aL5Hd2al5kbxsml5gcVeHCXImpqHQ30hCDqYE+/Z+ExNDVdbuDuALPf5lcwHZXGbI9+cvTEdW9RtIFySwg8BwCnKCvvHofsAsuR/uJv2DKNRa8wA2MSA/XvK2hjs8tDOCYJgiPGOfSxlEB17SwTffOGwv62NCtaJuTTN9V2nHlh2byoQZkqv9oKsqnTNj3hj1duZoYOu6OVwsp3BW0CMgeHNroTFbkv8v/COtjVVAWIccEAXlZi4sfNBmQXcUHBkQcqMSddJZw10=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e439533e-05da-4910-a090-08d6222d0d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:10.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index 9a3dd1467e24..8a51f94ec1ce 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -255,8 +255,27 @@ static void ieee80211_restart_work(struct work_struct =
*work)
=20
 	flush_work(&local->radar_detected_work);
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
