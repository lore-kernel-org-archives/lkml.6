Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78849ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280CC20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="byRzE+xP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280CC20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbeIXUyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:49 -0400
Received: from mail-eopbgr680104.outbound.protection.outlook.com ([40.107.68.104]:38589
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389315AbeIXUys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU7xcVgjgIiYlR7DHlbUgaxmftbTThW1QohpB9bUwO0=;
 b=byRzE+xPRlyT0G8Jy7+2Rbj613h8DKmUW5ZQLifnIvGzvZ+rbfPB0VbkCgYEKWuVQbIfW/Ng5INxvBtAo3MYpilSIK+S+qMmDViglqaT6eCj1ZMPRHieyH9fTkZoCnGZoA8o55TH6SLoWI4cXLEyxez67RE6q1xDUCoWhpNkoh4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 09/13] mac80211: fix a race between restart and
 CSA flows
Thread-Topic: [PATCH AUTOSEL 3.18 09/13] mac80211: fix a race between restart
 and CSA flows
Thread-Index: AQHUVBXlqpMl7gIdxE24zUToFnz/Pg==
Date:   Mon, 24 Sep 2018 14:50:12 +0000
Message-ID: <20180924144959.164754-9-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:AOFoY2hZEyLEKz+8o/HxInT9YklkvY2C6rCgOftxJ+sbA7aFSN1m7JrcuBgHf5wjOL0a0xj8fxIstpwgFrlWedsTK6/+xdb/nJ/SYz5+/xP0WlDg7WqyFd02iU+xvrSw+IIestFc2eAwEaksygw8vEGimv0aAx4ePMjgYpfFLm05ZfoHTlgNevI4iN+vc1MiKBKJQmzWF7lt8gJnRDe3Carx7dPXQhKFCHC2ZfDFSsSMVfCu+VnoebaXlc/SBzAqddWBiCJwPJ9oOu5Tdgpkr4MJ7WsTTK2FFh/Z8HQxMLuGOBQpM19mR8/njK1NPJ9y/msIOb4zD/4rekEN2GVoVjWqXSIsonbY4zKsrtA+kCoeDyBB1ZXi/d3J+Gt3RpfB3LbS/fdE9H2aR4lB4pvRDRSnGGrVzaira6xzutkaaT8RRRUZRziTR7H1ZwsFi2gxQjPxbd+JT6SXuhiM3LZZaA==;5:tlOFQP5M4LTNYI04tw+mOwyIu4ZB8X8EHhp3OyusdO4Ibpk/X3R5RwXJJvkHZh4kGMe4Uwa6KgaoI3gvCc3vSqGwaftMEXuPM/SNRR30S7PPMX0WTSITjktbNw5sX4i57i+ZDcByWnXfBvN67MsHBpFW6KEhCoKnSG9Ai8/brJE=;7:xLSsed1Jv/588sO/whuhLv27QayKypdcSUxsfhbxOjlzPSFFPCl+/StQqMAbAPzaCHqQCoNEGAzsWP1AD9iSNmY34FhnLGlzwptcZiKcJNf2uafesSkq0/iNxwsTilX4yNE/7d55r4rGNOZtUIN1RKXwqWFbb8IiCMbhcmYe7AfhJ4HpPbalHESLw+SSaTyk37bwuzcUe5ER6FRp4yxy8cVr1wnr9DapeX9tUdEzjrO97Ff1T90D4dECZRfJFQqH
x-ms-office365-filtering-correlation-id: 19af2094-8993-4b35-ce53-08d6222d42a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06312C6A4528D998CBE915F7FB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CwcISPlfrrsoYIrbyMiPVjMtMRXRMy6RlApj9nsje2SCcD+Jf0SRYFFVGw0al50bXAt5FH8Z0737egf4eO1mNF0YY+zFO8GnXcryPOnKAg2IjJMSecHl7pPKJm/W7EeuT/neTCMamIb7isKwGm2GGSfn5ym820oEZib+BRAfq6Isj+5BbraQHXcaOIly4s7LvX/57j11ac763gKRNd3aUxeRoj1LBd6qofspnhukAHWMHsblps2A5oLh+qIVp3wQuz0GfNrvPI+6Vk+ID2QHQfPXxiJ3m77gKbTireuKpDWxmTZOaGKsyi2nhWrECQbLzd40OLNMqzri2bZhT897NrWLAzSK6vckE4vGk+rIvXk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19af2094-8993-4b35-ce53-08d6222d42a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:12.3923
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
index 9db06f642556..749b8e755d47 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -258,8 +258,27 @@ static void ieee80211_restart_work(struct work_struct =
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
