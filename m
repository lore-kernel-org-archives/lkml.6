Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84526C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FE820811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FE820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeLMAdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:33:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbeLMAdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:33:14 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBD04Fju115480
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 19:12:20 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pb9fe8auk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 19:12:19 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 13 Dec 2018 00:12:18 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Dec 2018 00:12:15 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBD0CE8B18415862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 00:12:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04506B206A;
        Thu, 13 Dec 2018 00:12:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFD00B2065;
        Thu, 13 Dec 2018 00:12:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Dec 2018 00:12:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E2E2816C5F33; Wed, 12 Dec 2018 16:12:14 -0800 (PST)
Date:   Wed, 12 Dec 2018 16:12:14 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "He, Bo" <bo.he@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>,
        "Sun, Yi J" <yi.j.sun@intel.com>
Subject: Re: rcu_preempt caused oom
Reply-To: paulmck@linux.ibm.com
References: <20181209195601.GA7854@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A186D0@SHSMSX104.ccr.corp.intel.com>
 <20181211003838.GD4170@linux.ibm.com>
 <20181211044631.GA19942@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A18E53@SHSMSX104.ccr.corp.intel.com>
 <20181212022446.GV4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A192C3@SHSMSX104.ccr.corp.intel.com>
 <20181212154224.GX4170@linux.ibm.com>
 <20181212210316.GA14777@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A193C3@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A193C3@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121300-0052-0000-0000-00000366429B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010216; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130911; UDB=6.00587690; IPR=6.00911045;
 MB=3.00024673; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-13 00:12:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121300-0053-0000-0000-00005F15680F
Message-Id: <20181213001214.GE4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:13:22PM +0000, He, Bo wrote:
> I don't see the rcutree.sysrq_rcu parameter in v4.19 kernel, I also checked the latest kernel and the latest tag v4.20-rc6, not see the sysrq_rcu.
> Please correct me if I have something wrong.

That would be because I sent you the wrong patch, apologies!  :-/

Please instead see the one below, which does add sysrq_rcu.

							Thanx, Paul

> -----Original Message-----
> From: Paul E. McKenney <paulmck@linux.ibm.com> 
> Sent: Thursday, December 13, 2018 5:03 AM
> To: He, Bo <bo.he@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
> Subject: Re: rcu_preempt caused oom
> 
> On Wed, Dec 12, 2018 at 07:42:24AM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 12, 2018 at 01:21:33PM +0000, He, Bo wrote:
> > > we reproduce on two boards, but I still not see the show_rcu_gp_kthreads() dump logs, it seems the patch can't catch the scenario.
> > > I double confirmed the CONFIG_PROVE_RCU=y is enabled in the config as it's extracted from the /proc/config.gz.
> > 
> > Strange.
> > 
> > Are the systems responsive to sysrq keys once failure occurs?  If so, 
> > I will provide you a sysrq-R or some such to dump out the RCU state.
> 
> Or, as it turns out, sysrq-y if booting with rcutree.sysrq_rcu=1 using the patch below.  Only lightly tested.

------------------------------------------------------------------------

commit 04b6245c8458e8725f4169e62912c1fadfdf8141
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Wed Dec 12 16:10:09 2018 -0800

    rcu: Add sysrq rcu_node-dump capability
    
    Backported from v4.21/v5.0
    
    Life is hard if RCU manages to get stuck without triggering RCU CPU
    stall warnings or triggering the rcu_check_gp_start_stall() checks
    for failing to start a grace period.  This commit therefore adds a
    boot-time-selectable sysrq key (commandeering "y") that allows manually
    dumping Tree RCU state.  The new rcutree.sysrq_rcu kernel boot parameter
    must be set for this sysrq to be available.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0b760c1369f7..e9392a9d6291 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -61,6 +61,7 @@
 #include <linux/trace_events.h>
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
+#include <linux/sysrq.h>
 
 #include "tree.h"
 #include "rcu.h"
@@ -128,6 +129,9 @@ int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
 /* panic() on RCU Stall sysctl. */
 int sysctl_panic_on_rcu_stall __read_mostly;
+/* Commandeer a sysrq key to dump RCU's tree. */
+static bool sysrq_rcu;
+module_param(sysrq_rcu, bool, 0444);
 
 /*
  * The rcu_scheduler_active variable is initialized to the value
@@ -662,6 +666,27 @@ void show_rcu_gp_kthreads(void)
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
 
+/* Dump grace-period-request information due to commandeered sysrq. */
+static void sysrq_show_rcu(int key)
+{
+	show_rcu_gp_kthreads();
+}
+
+static struct sysrq_key_op sysrq_rcudump_op = {
+	.handler = sysrq_show_rcu,
+	.help_msg = "show-rcu(y)",
+	.action_msg = "Show RCU tree",
+	.enable_mask = SYSRQ_ENABLE_DUMP,
+};
+
+static int __init rcu_sysrq_init(void)
+{
+	if (sysrq_rcu)
+		return register_sysrq_key('y', &sysrq_rcudump_op);
+	return 0;
+}
+early_initcall(rcu_sysrq_init);
+
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */

