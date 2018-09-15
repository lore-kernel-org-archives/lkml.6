Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C0ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD10F21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hvy1j1BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD10F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeIOGud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:33 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727246AbeIOGua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VavTcr9wFRrlnUMB9C6munnht1BvdQ9LCBXVjzvfdG0=;
 b=Hvy1j1BEBen8FTubDs17g8r8jgDYV+O/t/dl2K8zuig0EsLeamt6QVDjkAnSBP6rnLSqck77xxCAqVP4/HPcIV8suq/AcN0QsMco39F8aPn/g1cavJKpE+ML5IPIxPjD1iw+vIs0rZHxdIpTYN48faf41kdogPXEBKxqZ6QcUXc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 42/57] rcu: Fix grace-period hangs due to race
 with CPU offline
Thread-Topic: [PATCH AUTOSEL 4.14 42/57] rcu: Fix grace-period hangs due to
 race with CPU offline
Thread-Index: AQHUTJQH0OZUSwFYGEKon4wb1tBfVQ==
Date:   Sat, 15 Sep 2018 01:32:55 +0000
Message-ID: <20180915013223.179909-42-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:b9/viGn0kYz8vceY6cqkcTE5qB1+sWucRAscEXlkP1ASN+CuFcvsO60R89WjS8gmyIM7bwcA+V/KihRcXIJaFFA29v8NtR7L+0HrRRcwfLj22LKqhwSmpg0KzHy6PJGTAz2boYmcIdgEp4YcJuqWnrYoxJomFaaOe0bLcTL3mW/quMGQzaEFlfvf0bczLJ+0mM0mLrsexVjUPTKV6DXdSgREYElzlgFPuSw+SRBCijA24wFtI/5vNQn6MdcTMMq8qyIzSVKc1MOXMV7nTtmptixAY/fWuhlwwZXg8nbhBSV7ar9i95mCxxw4bMZMXpknDJkU34mDpVT0pLk4BjGf2O9azXaG0BbAC+9IOwFDavfMj5925V4E51xBhxlNTunIPhkw6Kj7PXtwfJdhglQWp3r/ljxJRoacuZOfoe+z7yI0XEYrzU2AEqK21FTvEa3ypRc3C1rVBbwBxVWmIQoNVw==;5:QkLTBqJYAr5MQ9uDukjQVo+ZbDiY2uwamiKOitxAZIBaMuSvFSCuokwANr1KQM/iM43c0UriaGNFA6QYi4Rvbpyd71b7WUfP9dJ2OndRAlAoYETTqCAK7ML78bOkpne1ENReuImjfIbZ5UWPlXdg7KWmHF8Y337HfHwG5JZ7uqc=;7:TWqeiCnjQHvjXFdGsZCufIz3raCQi9suebphuTJUxne7u/TZP3kVWi1gIBRaE8TyuuC5yxB4e9dvJfzO98AG83OXEpuA76duIP/loHbD2fSs18nfiwd+QOON6iepRUUNYtesPjKq1RYZp90WMvSvGI2fKZtF/41v/YhBrW8GQFEq2aVmXrBJye8hB1/mDZYBXxyFQMO5qaiFDuhD+nBKzl2kC/G6QGaBAwua3qrjl2m3hz3bFeAOJITd1NIaluak
x-ms-office365-filtering-correlation-id: 61f8bb5c-ce9c-42d8-cd89-08d61aab39b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB04713DDC46A2231CA97AE980FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(66574006)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /mmWabqhmkJxWhfloOWZHRAQwSSlz7I9hoeQWyrMWHY4khz0nN3Zms22cEaNQrjSRCNhjCGOHNyaQO54I+I3vCLZbXswEe4nmjJ3kEw2Dlg9dHntz3ss5iRgAKAMkMdOqdAs3tTGJDHwOSILHVpu3PEU2O0f+vOljU2eVrNv299LoC1PeKVx8w5JpILcBvV+j3ypLyGiTTiRtyRiZrSLMfuNwDMauyCnvDmNVixwKLarhqnNvRt9Zfkhc7grF4xNHjM0KC80RK/t3G4Z/tuQxwb8/163w5UTHWcqdrzUg8PYYXUgrb/eAtNIGtiLlbNEpNbGThCJeAti/wYfOKh9HPWH/k8xtbLKT9XwBT9mlK4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f8bb5c-ce9c-42d8-cd89-08d61aab39b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:55.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 3e3650e94ae6..930edad27cbf 100644
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
@@ -1996,11 +1997,13 @@ static bool rcu_gp_init(struct rcu_state *rsp)
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
@@ -2035,6 +2038,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		}
=20
 		raw_spin_unlock_irq_rcu_node(rnp);
+		spin_unlock(&rsp->ofl_lock);
 	}
=20
 	/*
@@ -3837,9 +3841,11 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, stru=
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
index 8e1f285f0a70..46fa50dbeb82 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -389,6 +389,10 @@ struct rcu_state {
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
