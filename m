Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965441AbeCAA7k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:59:40 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56082 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965410AbeCAA7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:59:39 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37353512"
Subject: Re: [tip:x86/apic 1/2] arch/x86/kernel/apic/apic.c:1507:2: error: 'i'
 undeclared
To: Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <fengguang.wu@intel.com>
CC: <kbuild-all@01.org>, <linux-kernel@vger.kernel.org>,
        <tipbuild@zytor.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
References: <201803010700.cyWg3pUI%fengguang.wu@intel.com>
 <alpine.DEB.2.21.1803010030530.1392@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <865f76c0-e1f8-787c-8540-070725c1692b@cn.fujitsu.com>
Date: Thu, 1 Mar 2018 08:59:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803010030530.1392@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 86EE548AE761.AF8ED
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 03/01/2018 07:31 AM, Thomas Gleixner wrote:
> Dou,
> 
> can you please look into that? I zapped the commits from x86/apic for now.
> 

OK, and zap them. I will send a new version.

> Thanks,
> 
> 	tglx
> 
> On Thu, 1 Mar 2018, kbuild test robot wrote:
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
>> head:   ea5dfef5a890c9e6e47bdddfc23c4a4ba0c1bea1
>> commit: 2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3 [1/2] x86/apic: Move pending intr check code into it's own function
>> config: i386-randconfig-x004-201808 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>          git checkout 2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> All errors (new ones prefixed by >>):
>>
>>     arch/x86/kernel/apic/apic.c: In function 'setup_local_APIC':
>>>> arch/x86/kernel/apic/apic.c:1507:2: error: 'i' undeclared (first use in this function)
>>       i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
>>       ^

Oops, my fault, I didn't consider the 32bit situation. lkp has reported
it before, but I ignored it. I am too stupid.

I will merge the following changes in the 1th patch

---------------------------->8------------------------------
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1467,6 +1467,7 @@ static void setup_local_APIC(void)
  {
         int cpu = smp_processor_id();
         unsigned int value;
+       int apicid;

         if (disable_apic) {
                 disable_ioapic_support();
@@ -1503,8 +1504,8 @@ static void setup_local_APIC(void)
          * initialized during get_smp_config(), make sure it matches the
          * actual value.
          */
-       i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
-       WARN_ON(i != BAD_APICID && i != logical_smp_processor_id());
+       apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
+       WARN_ON(apicid != BAD_APICID && apicid != 
logical_smp_processor_id());
         /* always use the value from LDR */
         early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
                 logical_smp_processor_id();
Thanks,
	dou

>>     arch/x86/kernel/apic/apic.c:1507:2: note: each undeclared identifier is reported only once for each function it appears in
>>
>> vim +/i +1507 arch/x86/kernel/apic/apic.c
>>
>> 2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1460
>> 0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1461  /**
>> 0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1462   * setup_local_APIC - setup the local APIC
>> 0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1463   *
>> 543113d2 arch/x86/kernel/apic/apic.c Dou Liyang         2017-02-07  1464   * Used to setup local APIC while initializing BSP or bringing up APs.
>> 0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1465   * Always called with preemption disabled.
>> 0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1466   */
>> b753a2b7 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-14  1467  static void setup_local_APIC(void)
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1468  {
>> 0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1469  	int cpu = smp_processor_id();
>> 2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1470  	unsigned int value;
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1471
>> f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1472  	if (disable_apic) {
>> 7167d08e arch/x86/kernel/apic/apic.c Henrik Kretzschmar 2011-02-22  1473  		disable_ioapic_support();
>> f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1474  		return;
>> f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1475  	}
>> f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1476
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1477  #ifdef CONFIG_X86_32
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1478  	/* Pound the ESR really hard over the head with a big hammer - mbligh */
>> 08125d3e arch/x86/kernel/apic.c      Ingo Molnar        2009-01-28  1479  	if (lapic_is_integrated() && apic->disable_esr) {
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1480  		apic_write(APIC_ESR, 0);
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1481  		apic_write(APIC_ESR, 0);
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1482  		apic_write(APIC_ESR, 0);
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1483  		apic_write(APIC_ESR, 0);
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1484  	}
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1485  #endif
>> cdd6c482 arch/x86/kernel/apic/apic.c Ingo Molnar        2009-09-21  1486  	perf_events_lapic_init();
>> 89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1487
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1488  	/*
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1489  	 * Double-check whether this APIC is really registered.
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1490  	 * This is meaningless in clustered apic mode, so we skip it.
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1491  	 */
>> c2777f98 arch/x86/kernel/apic/apic.c Daniel Walker      2009-09-12  1492  	BUG_ON(!apic->apic_id_registered());
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1493
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1494  	/*
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1495  	 * Intel recommends to set DFR, LDR and TPR before enabling
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1496  	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1497  	 * document number 292116).  So here it goes...
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1498  	 */
>> a5c43296 arch/x86/kernel/apic.c      Ingo Molnar        2009-01-28  1499  	apic->init_apic_ldr();
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1500
>> 6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1501  #ifdef CONFIG_X86_32
>> 6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1502  	/*
>> acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1503  	 * APIC LDR is initialized.  If logical_apicid mapping was
>> acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1504  	 * initialized during get_smp_config(), make sure it matches the
>> acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1505  	 * actual value.
>> 6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1506  	 */
>> acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23 @1507  	i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
>> acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1508  	WARN_ON(i != BAD_APICID && i != logical_smp_processor_id());
>> acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1509  	/* always use the value from LDR */
>> 6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1510  	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
>> 6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1511  		logical_smp_processor_id();
>> 6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1512  #endif
>> 6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1513
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1514  	/*
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1515  	 * Set Task Priority to 'accept all'. We never change this
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1516  	 * later on.
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1517  	 */
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1518  	value = apic_read(APIC_TASKPRI);
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1519  	value &= ~APIC_TPRI_MASK;
>> 11a8e778 arch/x86_64/kernel/apic.c   Andi Kleen         2006-01-11  1520  	apic_write(APIC_TASKPRI, value);
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1521
>> 2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1522  	apic_pending_intr_clear();
>> da7ed9f9 arch/x86_64/kernel/apic.c   Vivek Goyal        2006-03-25  1523
>> da7ed9f9 arch/x86_64/kernel/apic.c   Vivek Goyal        2006-03-25  1524  	/*
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1525  	 * Now that we are all set up, enable the APIC
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1526  	 */
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1527  	value = apic_read(APIC_SPIV);
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1528  	value &= ~APIC_VECTOR_MASK;
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1529  	/*
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1530  	 * Enable APIC
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1531  	 */
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1532  	value |= APIC_SPIV_APIC_ENABLED;
>> ^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1533
>>
>> :::::: The code at line 1507 was first introduced by commit
>> :::::: acb8bc09c6185e4d3d582d0076aaa6a89f19d8c5 x86: Add apic->x86_32_early_logical_apicid()
>>
>> :::::: TO: Tejun Heo <tj@kernel.org>
>> :::::: CC: Ingo Molnar <mingo@elte.hu>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>
> 
> 
> 
