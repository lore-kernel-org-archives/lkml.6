Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeBAGyw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 01:54:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:14040 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeBAGyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 01:54:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,443,1511856000";
   d="gz'50?scan'50,208,50";a="14628615"
Date: Thu, 1 Feb 2018 14:53:52 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [rcu:rcu/dev 48/48] kernel/rcu/tree_exp.h:407:3: warning: format
 '%ld' expects argument of type 'long int', but argument 6 has type 'int'
Message-ID: <201802011450.h5mTj1Sg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/dev
head:   32860a6da7c75039afea229ba396aeac3b708d6b
commit: 32860a6da7c75039afea229ba396aeac3b708d6b [48/48] EXP rcu: Add trace_printk()s to probe expedited CPU selection
config: i386-randconfig-a0-201804 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 32860a6da7c75039afea229ba396aeac3b708d6b
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4199:0:
   kernel/rcu/tree_exp.h: In function 'sync_rcu_exp_select_cpus':
>> kernel/rcu/tree_exp.h:407:3: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'int' [-Wformat=]
      trace_printk("%s rnp %d:%d first pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!rnp->exp_tasks);
      ^
   kernel/rcu/tree_exp.h:407:3: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'int' [-Wformat=]
   In file included from include/linux/kernel.h:10:0,
                    from kernel/rcu/tree.c:31:
   include/linux/compiler.h:246:8: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'int' [-Wformat=]
     union { typeof(x) __val; char __c[1]; } __u;   \
           ^
   include/linux/compiler.h:254:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
   include/linux/kernel.h:634:40: note: in expansion of macro 'READ_ONCE'
      ____trace_printk_check_format(fmt, ##args);  \
                                           ^
   include/linux/kernel.h:682:2: note: in expansion of macro '__trace_printk_check_format'
     __trace_printk_check_format(fmt, ##args);   \
     ^
   include/linux/kernel.h:671:3: note: in expansion of macro 'do_trace_printk'
      do_trace_printk(fmt, ##__VA_ARGS__); \
      ^
   kernel/rcu/tree_exp.h:446:3: note: in expansion of macro 'trace_printk'
      trace_printk("%s rnp %d:%d second pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!READ_ONCE(rnp->exp_tasks));
      ^
   include/linux/compiler.h:246:8: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'int' [-Wformat=]
     union { typeof(x) __val; char __c[1]; } __u;   \
           ^
   include/linux/compiler.h:254:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
   include/linux/kernel.h:687:36: note: in expansion of macro 'READ_ONCE'
      __trace_printk(_THIS_IP_, fmt, ##args);   \
                                       ^
   include/linux/kernel.h:671:3: note: in expansion of macro 'do_trace_printk'
      do_trace_printk(fmt, ##__VA_ARGS__); \
      ^
   kernel/rcu/tree_exp.h:446:3: note: in expansion of macro 'trace_printk'
      trace_printk("%s rnp %d:%d second pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!READ_ONCE(rnp->exp_tasks));
      ^

vim +407 kernel/rcu/tree_exp.h

   363	
   364	/*
   365	 * Select the nodes that the upcoming expedited grace period needs
   366	 * to wait for.
   367	 */
   368	static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
   369					     smp_call_func_t func)
   370	{
   371		int cpu;
   372		unsigned long flags;
   373		unsigned long mask_ofl_test;
   374		unsigned long mask_ofl_ipi;
   375		int ret;
   376		struct rcu_node *rnp;
   377	
   378		trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
   379		sync_exp_reset_tree(rsp);
   380		trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
   381		rcu_for_each_leaf_node(rsp, rnp) {
   382			raw_spin_lock_irqsave_rcu_node(rnp, flags);
   383	
   384			/* Each pass checks a CPU for identity, offline, and idle. */
   385			mask_ofl_test = 0;
   386			for_each_leaf_node_possible_cpu(rnp, cpu) {
   387				struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
   388	
   389				rdp->exp_dynticks_snap =
   390					rcu_dynticks_snap(rdp->dynticks);
   391				if (raw_smp_processor_id() == cpu ||
   392				    rcu_dynticks_in_eqs(rdp->exp_dynticks_snap) ||
   393				    !(rnp->qsmaskinitnext & rdp->grpmask))
   394					mask_ofl_test |= rdp->grpmask;
   395				trace_printk("%s rnp %d:%d first pass CPU %d\n", __func__, rnp->grplo, rnp->grphi, cpu);
   396			}
   397			mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
   398	
   399			/*
   400			 * Need to wait for any blocked tasks as well.  Note that
   401			 * additional blocking tasks will also block the expedited
   402			 * GP until such time as the ->expmask bits are cleared.
   403			 */
   404			if (rcu_preempt_has_tasks(rnp))
   405				rnp->exp_tasks = rnp->blkd_tasks.next;
   406			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 > 407			trace_printk("%s rnp %d:%d first pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!rnp->exp_tasks);
   408	
   409			/* IPI the remaining CPUs for expedited quiescent state. */
   410			for_each_leaf_node_possible_cpu(rnp, cpu) {
   411				unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
   412				struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
   413	
   414				if (!(mask_ofl_ipi & mask))
   415					continue;
   416	retry_ipi:
   417				if (rcu_dynticks_in_eqs_since(rdp->dynticks,
   418							      rdp->exp_dynticks_snap)) {
   419					mask_ofl_test |= mask;
   420					continue;
   421				}
   422				ret = smp_call_function_single(cpu, func, rsp, 0);
   423				if (!ret) {
   424					mask_ofl_ipi &= ~mask;
   425					continue;
   426				}
   427				/* Failed, raced with CPU hotplug operation. */
   428				raw_spin_lock_irqsave_rcu_node(rnp, flags);
   429				if ((rnp->qsmaskinitnext & mask) &&
   430				    (rnp->expmask & mask)) {
   431					/* Online, so delay for a bit and try again. */
   432					raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
   433					trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("selectofl"));
   434					schedule_timeout_uninterruptible(1);
   435					goto retry_ipi;
   436				}
   437				/* CPU really is offline, so we can ignore it. */
   438				if (!(rnp->expmask & mask))
   439					mask_ofl_ipi &= ~mask;
   440				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
   441			}
   442			/* Report quiescent states for those that went offline. */
   443			mask_ofl_test |= mask_ofl_ipi;
   444			if (mask_ofl_test)
   445				rcu_report_exp_cpu_mult(rsp, rnp, mask_ofl_test, false);
   446			trace_printk("%s rnp %d:%d second pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!READ_ONCE(rnp->exp_tasks));
   447		}
   448	}
   449	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--uAKRQypu60I7Lcqm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--uAKRQypu60I7Lcqm--
