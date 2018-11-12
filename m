Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226ECC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6613223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6613223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeKMCZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:25:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbeKMCZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:25:48 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACGSPdv110665
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:31:48 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nqc6g364h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:31:48 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 16:31:47 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 16:31:42 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACGVfpQ32440474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 16:31:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43EF1B205F;
        Mon, 12 Nov 2018 16:31:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E353B2064;
        Mon, 12 Nov 2018 16:31:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.198.12])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 16:31:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ACCE216C3FCE; Mon, 12 Nov 2018 08:31:39 -0800 (PST)
Date:   Mon, 12 Nov 2018 08:31:39 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 24/41] modules: Replace synchronize_sched()
 and call_rcu_sched()
Reply-To: paulmck@linux.ibm.com
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-24-paulmck@linux.ibm.com>
 <20181112124852.GA11833@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112124852.GA11833@linux-8ccs>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111216-0064-0000-0000-00000372B5D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010035; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116427; UDB=6.00577118; IPR=6.00896535;
 MB=3.00024128; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 16:31:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111216-0065-0000-0000-00003B4F9871
Message-Id: <20181112163139.GN4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=961 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 01:48:52PM +0100, Jessica Yu wrote:
> +++ Paul E. McKenney [11/11/18 11:43 -0800]:
> >Now that synchronize_rcu() waits for preempt-disable regions of code
> >as well as RCU read-side critical sections, synchronize_sched() can
> >be replaced by synchronize_rcu().  Similarly, call_rcu_sched() can be
> >replaced by call_rcu().  This commit therefore makes these changes.
> >
> >Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> >Cc: Jessica Yu <jeyu@kernel.org>
> 
> Acked-by: Jessica Yu <jeyu@kernel.org>

Applied, thank you!

							Thanx, Paul

> Thanks!
> 
> >---
> >kernel/module.c | 14 +++++++-------
> >1 file changed, 7 insertions(+), 7 deletions(-)
> >
> >diff --git a/kernel/module.c b/kernel/module.c
> >index 49a405891587..99b46c32d579 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -2159,7 +2159,7 @@ static void free_module(struct module *mod)
> >	/* Remove this module from bug list, this uses list_del_rcu */
> >	module_bug_cleanup(mod);
> >	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
> >-	synchronize_sched();
> >+	synchronize_rcu();
> >	mutex_unlock(&module_mutex);
> >
> >	/* This may be empty, but that's OK */
> >@@ -3507,15 +3507,15 @@ static noinline int do_init_module(struct module *mod)
> >	/*
> >	 * We want to free module_init, but be aware that kallsyms may be
> >	 * walking this with preempt disabled.  In all the failure paths, we
> >-	 * call synchronize_sched(), but we don't want to slow down the success
> >+	 * call synchronize_rcu(), but we don't want to slow down the success
> >	 * path, so use actual RCU here.
> >	 * Note that module_alloc() on most architectures creates W+X page
> >	 * mappings which won't be cleaned up until do_free_init() runs.  Any
> >	 * code such as mark_rodata_ro() which depends on those mappings to
> >	 * be cleaned up needs to sync with the queued work - ie
> >-	 * rcu_barrier_sched()
> >+	 * rcu_barrier()
> >	 */
> >-	call_rcu_sched(&freeinit->rcu, do_free_init);
> >+	call_rcu(&freeinit->rcu, do_free_init);
> >	mutex_unlock(&module_mutex);
> >	wake_up_all(&module_wq);
> >
> >@@ -3526,7 +3526,7 @@ static noinline int do_init_module(struct module *mod)
> >fail:
> >	/* Try to protect us from buggy refcounters. */
> >	mod->state = MODULE_STATE_GOING;
> >-	synchronize_sched();
> >+	synchronize_rcu();
> >	module_put(mod);
> >	blocking_notifier_call_chain(&module_notify_list,
> >				     MODULE_STATE_GOING, mod);
> >@@ -3819,7 +3819,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> > ddebug_cleanup:
> >	ftrace_release_mod(mod);
> >	dynamic_debug_remove(mod, info->debug);
> >-	synchronize_sched();
> >+	synchronize_rcu();
> >	kfree(mod->args);
> > free_arch_cleanup:
> >	module_arch_cleanup(mod);
> >@@ -3834,7 +3834,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >	mod_tree_remove(mod);
> >	wake_up_all(&module_wq);
> >	/* Wait for RCU-sched synchronizing before releasing mod->list. */
> >-	synchronize_sched();
> >+	synchronize_rcu();
> >	mutex_unlock(&module_mutex);
> > free_module:
> >	/* Free lock-classes; relies on the preceding sync_rcu() */
> >-- 
> >2.17.1
> >
> 

