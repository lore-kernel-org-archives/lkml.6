Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B16ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D76208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gq1im3XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D76208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeIOGsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:32 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbeIOGsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYvGxGL1JdVEHfaxn0J+WiRHdnK7Jpi0XRxwRx4lf4s=;
 b=Gq1im3XGdCJsyrfu+T/BckWhA/iaVbQM4MJ/c89J9Rpt6xeXMkLukyT0+7Qo8w5pWQn/RcXfUZlVj1yKyeLY3SFtqUrhz8xaARqE7lxEnjW8tRN0fTWeJOW4fSwMpN15tl8NxWiWVGLUcNtERkCmRBM88WN9QmYJFphY2iSdUh0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 64/92] rcu: Fix grace-period hangs due to race
 with CPU offline
Thread-Topic: [PATCH AUTOSEL 4.18 64/92] rcu: Fix grace-period hangs due to
 race with CPU offline
Thread-Index: AQHUTJOyj3KQK0YdeEa+/vOtp4MZYQ==
Date:   Sat, 15 Sep 2018 01:30:34 +0000
Message-ID: <20180915012944.179481-63-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:4RbJaojO8OFTVDLTq49d3nBLhHkrPdihTsTdRrEFasPumimhkhFk1THEDbNh0HL+yNxbQWcBRzoduUZhTmNpBxUCOKWkUQLWDmpd5Xg0TKylpWw3sqHDGbUNKKHlOPN9se+rup+ts6YIjVqPPE4CcIK46D8vhiHF5WGNzwKs7qEIyoKpTAq9AeiAWuZYSOMtv8jfck0I3Cek8YWpwoka4E4fjBr0h+YQ3Sdpi1hH1o0YlgFnMdXnVFWg9EyYMVrO7is06cnsDSKxVY2bTaWiMf5C0YchZXtp/gODMzCm10UpCdT0M6xaG1jByO55c2Oa23tb0MO/r7BEGL+v4ThYfnSDb1m7zOwHxO6lay8WGMQHSW2D6Is3oy5ErNnUqtfBnQgLG9tqU0MaZNJ+130x2mBDd4LdzCbyF6Ps5qy81r+UjXkc1POnkUF6vaibIu9k/5ZYsMrNdsvyA+7LTGj/Dg==;5:XAjODqqhu95hhmUS5hP6rmDuxxY5WTj4BTVIkjYTx89MU24rsqiHb06yl8sdm5esACua2MqR1KL0Mfg9PENbktl7jddQA4O+acUA7vSSRYX/4wlv40Be81Ud+0Q+W2GYXjQuMB1IuxHDb7jgpAZLs995MygoJxq6aRR0Te25jA8=;7:bjUiedGJhbGcN1BoTHPqduZzorKBjV4OHGgTso7YwqXvLcX0tvAloFFDUh3UUPyk9z6c9fGmqb2W+yQk8m41jRwopuUEG5wpPWnmPCQiAC/wsLKIgOjKqDwpP3AdPzWoUtlTCNmyK3HWdR+Lsx06hQ9gCGVwFdYyJro39SbWZxjZA8ftnQgPFpDwZOZHUG65XvUuWKmSENfd6EBsQTG5VBgGCe2Eh5sPUic1Z1tKX6iyx7T05HQJv2MCzcSvsnG+
x-ms-office365-filtering-correlation-id: b7b0129d-600b-4282-8cf4-08d61aaaf732
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470D6547C5EF87A978E0A63FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(66574006)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MF1FqHKiU13S77zPInd7qtU5csc40pR63he8Sv8YC70+wKNWntYitpNcI6ls3Qni4u+qEvMF9QcD5aKK3W51lDsgp3o+aPu7s7xVU0yd6A6OZYbcQpn+nC6DW61699+LHXfQoElBCpzDl2FEtD9777Svo/x4gQltFPw9g2PnbPXxaFktt0+20YSV9jFmIggu6w+azgNSwG1vBwEq1zrKvcesANKOaWarev6SaWPpdq5y1XyBuC/uXlv7srHCvMrxGrz1e4LCrKcAnG0blvRFsCEFMtERucYkV5jPSh9avDMv8fOwMVygG4yx2eCJwdmysuM/9FCEAhQk8pfDgcyPMXBjshOf3qLg4dDmqYIlPCk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b0129d-600b-4282-8cf4-08d61aaaf732
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:34.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index aa7cade1b9f3..9279939b9914 100644
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
@@ -1925,11 +1926,13 @@ static bool rcu_gp_init(struct rcu_state *rsp)
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
@@ -1964,6 +1967,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		}
=20
 		raw_spin_unlock_irq_rcu_node(rnp);
+		spin_unlock(&rsp->ofl_lock);
 	}
=20
 	/*
@@ -3725,9 +3729,11 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, stru=
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
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 78e051dffc5b..032fc1d1efd5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -384,6 +384,10 @@ struct rcu_state {
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
