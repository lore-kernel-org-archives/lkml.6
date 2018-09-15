Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8EBECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4D2208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I85TED/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4D2208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeIOG4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:56:01 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729736AbeIOGvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3SpLSE+YDl61vOlImK2pMuyVi1HcZjS5oCd4Y4eJPo=;
 b=I85TED/0IIhuRoixfm/KawJgaOV48AhGC62iZJ9wf9DMfJI8in5pDOvHczJW6YfaVeNYRvS/M5sKRJz1oDPTPBargxBja0HHEXbWuX1/Cz+9vLQ1BDimTZafhN7j32SEBid5V3zWMeoI2BozcBcD478zfoTcZ5dMK8stZ2u+s1o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 24/34] rcu: Fix grace-period hangs due to race
 with CPU offline
Thread-Topic: [PATCH AUTOSEL 4.9 24/34] rcu: Fix grace-period hangs due to
 race with CPU offline
Thread-Index: AQHUTJRF3ADB+OHAZkyqsXII3SkOiw==
Date:   Sat, 15 Sep 2018 01:34:40 +0000
Message-ID: <20180915013422.180023-24-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:CruSbAR+kT2h1N6PnKPw1LSA55Ta/FcFC9E1C7ZN2hSDRW/dG0EB5kMyxLiYwz0PYz3HvarSPt2UNr2mzuLDa8aZ7PQa3moNxecQKsskMesobJ5rBGoZu0lSnPRPVDsGJ+5FKlErlmj4nZycLb15YVpoBkN0YOob0lA8TAIw23LF3692MvFCZ5IseUquLQ5eY2EB6TZMr2pVcGJ7mPzUUHvOskKqErbi84U3cLHxFs6MS8fWbwW4GobD7zcIK3z638h3xGZ5mRUT61w5odkIbx6hGqavi+g2rbvdrxBE/owZ2OUC+Opq1e4HOlWaw0gm+iLUNzxa4HSZm/gg9gVyh9Mg3samv7a/5MFBv6UJQ2hsguTUX79CndmnEUjZXujLAx5ZwuEiot+WaBIheMFXbAmONmoPcHkmiDXBI1JG1KaF1zjvakDENNb1aYklokgZEnZjZA6TyLRfk1hwb//wNA==;5:3nMJsAiWsP4NMqxyhg0nBOhRrQhjlx3nFKjEnpUfXxhRbEK8WKl8NBFexV3M0kIycwYR9DForwS55M4AQrEPK9OHK5Mg+kBong1EOwmry6yFiy5bRHI7y9XztQg0AGJLyZTpP4NWKiUOXgEyng56HFuLKsRhfI2wIUzrbNctUGQ=;7:iBQhr3ohkLP4CYHiSyHFrqJb0r6HFsicz3eAIb69HOmt/ZOjtSpaukCl1eDVbQ9yWIYsYeo0A9t5PvFJ0Ph07WaP+ZjsIerkE+EmZ/Sjoul2cx4sOuyugsjfwfZSx1cVj2vi3rsDh3CJLtm+GOxClv49odlUV2jaiUPeceY+dysligxCrWde3Z+IFJStv/s2LIWMR/tOCiEvsAVhpquKpBukQpfFsRB5yQ579NaONdoQ7sofmhJTBiIXhnJK3DiV
x-ms-office365-filtering-correlation-id: a461c605-d1c5-41a1-f730-08d61aab6805
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB0823182A7DB345898EBD69E6FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(66574006)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: SGldg58XyqI1VXMUWvH4+stl6AT3xu+QofzQrCEL30aCICYB9lSNEbsBYK0AybNu4lVu5jLC0V/tZpX2Wd5xmbpl9Jk8oIOljkCNCTmtEuslgIN5kulfAadAWUvSQTQnCMGxG5YHyF25IK/gQJqGG6grqhFDCotMpVJn/6t5306n3C+NiJtvuqqcQG4N2Y5+HYA2JNqYpFdIMbnlZI64/JpRMn1cqAM+6g5TOTS1d+vlnXOD3WOB4mm8ZLVLPiZP6h5ckHmTL70IlTxT9l80irzfADLAdZRV+7AYYsKV+8rvv4jp6GpI4XbkJBzCMY2XvCgp45RIw3H0N4SOS6JyZ7riq6xbbQhTob0U2xeANd8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a461c605-d1c5-41a1-f730-08d61aab6805
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:40.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

[ Upstream commit 1e64b15a4b102e1cd059d4d798b7a78f93341333 ]

Without special fail-safe quiescent-state-propagation checks, grace-period
hangs can result from the following scenario:

1.	CPU 1 goes offline.

2.	Because CPU 1 is the only CPU in the system blocking the current
	grace period, the grace period ends as soon as
	rcu_cleanup_dying_idle_cpu()'s call to rcu_report_qs_rnp()
	returns.

3.	At this point, the leaf rcu_node structure's ->lock is no longer
	held: rcu_report_qs_rnp() has released it, as it must in order
	to awaken the RCU grace-period kthread.

4.	At this point, that same leaf rcu_node structure's ->qsmaskinitnext
	field still records CPU 1 as being online.  This is absolutely
	necessary because the scheduler uses RCU (in this case on the
	wake-up path while awakening RCU's grace-period kthread), and
	->qsmaskinitnext contains RCU's idea as to which CPUs are online.
	Therefore, invoking rcu_report_qs_rnp() after clearing CPU 1's
	bit from ->qsmaskinitnext would result in a lockdep-RCU splat
	due to RCU being used from an offline CPU.

5.	RCU's grace-period kthread awakens, sees that the old grace period
	has completed and that a new one is needed.  It therefore starts
	a new grace period, but because CPU 1's leaf rcu_node structure's
	->qsmaskinitnext field still shows CPU 1 as being online, this new
	grace period is initialized to wait for a quiescent state from the
	now-offline CPU 1.

6.	Without the fail-safe force-quiescent-state checks, there would
	be no quiescent state from the now-offline CPU 1, which would
	eventually result in RCU CPU stall warnings and memory exhaustion.

It would be good to get rid of the special fail-safe quiescent-state
propagation checks, and thus it would be good to fix things so that
the above scenario cannot happen.  This commit therefore adds a new
->ofl_lock to the rcu_state structure.  This lock is held by rcu_gp_init()
across the applying of buffered online and offline operations to the
rcu_node tree, and it is also held by rcu_cleanup_dying_idle_cpu()
when buffering a new offline operation.  This prevents rcu_gp_init()
from acquiring the leaf rcu_node structure's lock during the interval
between when rcu_cleanup_dying_idle_cpu() invokes rcu_report_qs_rnp(),
which releases ->lock and the re-acquisition of that same lock.
This in turn prevents the failure scenario outlined above, and will
hopefully eventually allow removal of the offline-CPU checks from the
force-quiescent-state code path.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/rcu/tree.c | 6 ++++++
 kernel/rcu/tree.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d1a02877a42c..d88338ef244f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -102,6 +102,7 @@ struct rcu_state sname##_state =3D { \
 	.abbr =3D sabbr, \
 	.exp_mutex =3D __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
 	.exp_wake_mutex =3D __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
+	.ofl_lock =3D __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
 }
=20
 RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
@@ -1966,11 +1967,13 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	 */
 	rcu_for_each_leaf_node(rsp, rnp) {
 		rcu_gp_slow(rsp, gp_preinit_delay);
+		spin_lock(&rsp->ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit =3D=3D rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
 			raw_spin_unlock_irq_rcu_node(rnp);
+			spin_unlock(&rsp->ofl_lock);
 			continue;
 		}
=20
@@ -2005,6 +2008,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		}
=20
 		raw_spin_unlock_irq_rcu_node(rnp);
+		spin_unlock(&rsp->ofl_lock);
 	}
=20
 	/*
@@ -3915,9 +3919,11 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, stru=
ct rcu_state *rsp)
=20
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask =3D rdp->grpmask;
+	spin_lock(&rsp->ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order gu=
arantee. */
 	rnp->qsmaskinitnext &=3D ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	spin_unlock(&rsp->ofl_lock);
 }
=20
 void rcu_report_dead(unsigned int cpu)
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e99a5234d9ed..d5a12e21cc1e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -550,6 +550,10 @@ struct rcu_state {
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 	struct list_head flavors;		/* List of RCU flavors. */
+
+	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
+						/* Synchronize offline with */
+						/*  GP pre-initialization. */
 };
=20
 /* Values for rcu_state structure's gp_flags field. */
--=20
2.17.1
