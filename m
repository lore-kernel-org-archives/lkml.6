Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC3C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF33C204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF33C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeJXDhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:37:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:14189 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbeJXDhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:37:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 12:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="gz'50?scan'50,208,50";a="81012746"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2018 12:12:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gF26q-000C9d-4F; Wed, 24 Oct 2018 03:12:56 +0800
Date:   Wed, 24 Oct 2018 03:12:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     kbuild-all@01.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/core: Don't mix isolcpus and housekeeping CPUs
Message-ID: <201810240330.2DUB7fst%fengguang.wu@intel.com>
References: <1540317297-14545-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1540317297-14545-1-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Srikar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on v4.19 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Srikar-Dronamraju/sched-core-Don-t-mix-isolcpus-and-housekeeping-CPUs/20181024-025019
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   kernel/sched/core.c: In function 'sched_setaffinity':
>> kernel/sched/core.c:4783:10: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     hk_mask = housekeeping_cpumask(HK_FLAG_DOMAIN);
             ^

vim +/const +4783 kernel/sched/core.c

  4734	
  4735	long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
  4736	{
  4737		cpumask_var_t cpus_allowed, new_mask;
  4738		struct task_struct *p;
  4739		struct cpumask *hk_mask;
  4740		int retval;
  4741	
  4742		rcu_read_lock();
  4743	
  4744		p = find_process_by_pid(pid);
  4745		if (!p) {
  4746			rcu_read_unlock();
  4747			return -ESRCH;
  4748		}
  4749	
  4750		/* Prevent p going away */
  4751		get_task_struct(p);
  4752		rcu_read_unlock();
  4753	
  4754		if (p->flags & PF_NO_SETAFFINITY) {
  4755			retval = -EINVAL;
  4756			goto out_put_task;
  4757		}
  4758		if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
  4759			retval = -ENOMEM;
  4760			goto out_put_task;
  4761		}
  4762		if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
  4763			retval = -ENOMEM;
  4764			goto out_free_cpus_allowed;
  4765		}
  4766		retval = -EPERM;
  4767		if (!check_same_owner(p)) {
  4768			rcu_read_lock();
  4769			if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
  4770				rcu_read_unlock();
  4771				goto out_free_new_mask;
  4772			}
  4773			rcu_read_unlock();
  4774		}
  4775	
  4776		retval = security_task_setscheduler(p);
  4777		if (retval)
  4778			goto out_free_new_mask;
  4779	
  4780	
  4781		cpuset_cpus_allowed(p, cpus_allowed);
  4782		cpumask_and(new_mask, in_mask, cpus_allowed);
> 4783		hk_mask = housekeeping_cpumask(HK_FLAG_DOMAIN);
  4784	
  4785		/*
  4786		 * If the cpumask provided has CPUs that are part of isolated and
  4787		 * housekeeping_cpumask, then restrict it to just the CPUs that
  4788		 * are part of the housekeeping_cpumask.
  4789		 */
  4790		if (!cpumask_subset(new_mask, hk_mask) &&
  4791				cpumask_intersects(new_mask, hk_mask)) {
  4792			pr_info("pid %d: Mix of isolcpus and non-isolcpus provided\n",
  4793				       p->pid);
  4794			cpumask_and(new_mask, new_mask, hk_mask);
  4795		}
  4796	
  4797		/*
  4798		 * Since bandwidth control happens on root_domain basis,
  4799		 * if admission test is enabled, we only admit -deadline
  4800		 * tasks allowed to run on all the CPUs in the task's
  4801		 * root_domain.
  4802		 */
  4803	#ifdef CONFIG_SMP
  4804		if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
  4805			rcu_read_lock();
  4806			if (!cpumask_subset(task_rq(p)->rd->span, new_mask)) {
  4807				retval = -EBUSY;
  4808				rcu_read_unlock();
  4809				goto out_free_new_mask;
  4810			}
  4811			rcu_read_unlock();
  4812		}
  4813	#endif
  4814	again:
  4815		retval = __set_cpus_allowed_ptr(p, new_mask, true);
  4816	
  4817		if (!retval) {
  4818			cpuset_cpus_allowed(p, cpus_allowed);
  4819			if (!cpumask_subset(new_mask, cpus_allowed)) {
  4820				/*
  4821				 * We must have raced with a concurrent cpuset
  4822				 * update. Just reset the cpus_allowed to the
  4823				 * cpuset's cpus_allowed
  4824				 */
  4825				cpumask_copy(new_mask, cpus_allowed);
  4826				goto again;
  4827			}
  4828		}
  4829	out_free_new_mask:
  4830		free_cpumask_var(new_mask);
  4831	out_free_cpus_allowed:
  4832		free_cpumask_var(cpus_allowed);
  4833	out_put_task:
  4834		put_task_struct(p);
  4835		return retval;
  4836	}
  4837	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AhhlLboLdkugWU4S
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Mgf9zH/7qq1F0lkAAA==

--AhhlLboLdkugWU4S--
