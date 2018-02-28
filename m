Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964988AbeB1X2m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:28:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:56290 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964903AbeB1X2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:28:40 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="gz'50?scan'50,208,50";a="30516312"
Date: Thu, 1 Mar 2018 07:28:09 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [tip:x86/apic 1/2] arch/x86/kernel/apic/apic.c:1507:2: error: 'i'
 undeclared
Message-ID: <201803010700.cyWg3pUI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
head:   ea5dfef5a890c9e6e47bdddfc23c4a4ba0c1bea1
commit: 2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3 [1/2] x86/apic: Move pending intr check code into it's own function
config: i386-randconfig-x004-201808 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/kernel/apic/apic.c: In function 'setup_local_APIC':
>> arch/x86/kernel/apic/apic.c:1507:2: error: 'i' undeclared (first use in this function)
     i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
     ^
   arch/x86/kernel/apic/apic.c:1507:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/i +1507 arch/x86/kernel/apic/apic.c

2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1460  
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1461  /**
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1462   * setup_local_APIC - setup the local APIC
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1463   *
543113d2 arch/x86/kernel/apic/apic.c Dou Liyang         2017-02-07  1464   * Used to setup local APIC while initializing BSP or bringing up APs.
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1465   * Always called with preemption disabled.
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1466   */
b753a2b7 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-14  1467  static void setup_local_APIC(void)
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1468  {
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1469  	int cpu = smp_processor_id();
2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1470  	unsigned int value;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1471  
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1472  	if (disable_apic) {
7167d08e arch/x86/kernel/apic/apic.c Henrik Kretzschmar 2011-02-22  1473  		disable_ioapic_support();
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1474  		return;
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1475  	}
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1476  
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1477  #ifdef CONFIG_X86_32
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1478  	/* Pound the ESR really hard over the head with a big hammer - mbligh */
08125d3e arch/x86/kernel/apic.c      Ingo Molnar        2009-01-28  1479  	if (lapic_is_integrated() && apic->disable_esr) {
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1480  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1481  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1482  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1483  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1484  	}
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1485  #endif
cdd6c482 arch/x86/kernel/apic/apic.c Ingo Molnar        2009-09-21  1486  	perf_events_lapic_init();
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1487  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1488  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1489  	 * Double-check whether this APIC is really registered.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1490  	 * This is meaningless in clustered apic mode, so we skip it.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1491  	 */
c2777f98 arch/x86/kernel/apic/apic.c Daniel Walker      2009-09-12  1492  	BUG_ON(!apic->apic_id_registered());
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1493  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1494  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1495  	 * Intel recommends to set DFR, LDR and TPR before enabling
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1496  	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1497  	 * document number 292116).  So here it goes...
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1498  	 */
a5c43296 arch/x86/kernel/apic.c      Ingo Molnar        2009-01-28  1499  	apic->init_apic_ldr();
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1500  
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1501  #ifdef CONFIG_X86_32
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1502  	/*
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1503  	 * APIC LDR is initialized.  If logical_apicid mapping was
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1504  	 * initialized during get_smp_config(), make sure it matches the
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1505  	 * actual value.
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1506  	 */
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23 @1507  	i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1508  	WARN_ON(i != BAD_APICID && i != logical_smp_processor_id());
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1509  	/* always use the value from LDR */
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1510  	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1511  		logical_smp_processor_id();
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1512  #endif
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1513  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1514  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1515  	 * Set Task Priority to 'accept all'. We never change this
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1516  	 * later on.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1517  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1518  	value = apic_read(APIC_TASKPRI);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1519  	value &= ~APIC_TPRI_MASK;
11a8e778 arch/x86_64/kernel/apic.c   Andi Kleen         2006-01-11  1520  	apic_write(APIC_TASKPRI, value);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1521  
2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1522  	apic_pending_intr_clear();
da7ed9f9 arch/x86_64/kernel/apic.c   Vivek Goyal        2006-03-25  1523  
da7ed9f9 arch/x86_64/kernel/apic.c   Vivek Goyal        2006-03-25  1524  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1525  	 * Now that we are all set up, enable the APIC
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1526  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1527  	value = apic_read(APIC_SPIV);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1528  	value &= ~APIC_VECTOR_MASK;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1529  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1530  	 * Enable APIC
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1531  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1532  	value |= APIC_SPIV_APIC_ENABLED;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1533  

:::::: The code at line 1507 was first introduced by commit
:::::: acb8bc09c6185e4d3d582d0076aaa6a89f19d8c5 x86: Add apic->x86_32_early_logical_apicid()

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--YZ5djTAD1cGYuMQK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
otq1cNaN1+FEqo2pntXgHy87nYn/iwEA

--YZ5djTAD1cGYuMQK--
