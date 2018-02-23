Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeBWRH7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:07:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:14344 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbeBWRH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:07:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="gz'50?scan'50,208,50";a="19821182"
Date: Sat, 24 Feb 2018 01:07:21 +0800
From: kbuild test robot <lkp@intel.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, ebiederm@xmission.com,
        bhe@redhat.com, andy.shevchenko@gmail.com,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/apic: Move pending intr check code into it's own
 function
Message-ID: <201802240115.RIHyd4fd%fengguang.wu@intel.com>
References: <20180223033557.31116-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20180223033557.31116-1-douly.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dou,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/auto-latest]
[also build test ERROR on v4.16-rc2 next-20180223]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dou-Liyang/x86-apic-Move-pending-intr-check-code-into-it-s-own-function/20180224-004030
config: i386-randconfig-x010-201807 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/kernel/apic/apic.c: In function 'setup_local_APIC':
>> arch/x86/kernel/apic/apic.c:1508:2: error: 'i' undeclared (first use in this function)
     i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
     ^
   arch/x86/kernel/apic/apic.c:1508:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/i +1508 arch/x86/kernel/apic/apic.c

0d827285 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-23  1461  
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1462  /**
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1463   * setup_local_APIC - setup the local APIC
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1464   *
543113d2 arch/x86/kernel/apic/apic.c Dou Liyang         2017-02-07  1465   * Used to setup local APIC while initializing BSP or bringing up APs.
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1466   * Always called with preemption disabled.
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1467   */
b753a2b7 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-14  1468  static void setup_local_APIC(void)
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1469  {
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1470  	int cpu = smp_processor_id();
0d827285 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-23  1471  	unsigned int value;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1472  
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1473  	if (disable_apic) {
7167d08e arch/x86/kernel/apic/apic.c Henrik Kretzschmar 2011-02-22  1474  		disable_ioapic_support();
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1475  		return;
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1476  	}
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1477  
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1478  #ifdef CONFIG_X86_32
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1479  	/* Pound the ESR really hard over the head with a big hammer - mbligh */
08125d3e arch/x86/kernel/apic.c      Ingo Molnar        2009-01-28  1480  	if (lapic_is_integrated() && apic->disable_esr) {
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1481  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1482  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1483  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1484  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1485  	}
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1486  #endif
cdd6c482 arch/x86/kernel/apic/apic.c Ingo Molnar        2009-09-21  1487  	perf_events_lapic_init();
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1488  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1489  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1490  	 * Double-check whether this APIC is really registered.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1491  	 * This is meaningless in clustered apic mode, so we skip it.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1492  	 */
c2777f98 arch/x86/kernel/apic/apic.c Daniel Walker      2009-09-12  1493  	BUG_ON(!apic->apic_id_registered());
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1494  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1495  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1496  	 * Intel recommends to set DFR, LDR and TPR before enabling
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1497  	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1498  	 * document number 292116).  So here it goes...
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1499  	 */
a5c43296 arch/x86/kernel/apic.c      Ingo Molnar        2009-01-28  1500  	apic->init_apic_ldr();
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1501  
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1502  #ifdef CONFIG_X86_32
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1503  	/*
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1504  	 * APIC LDR is initialized.  If logical_apicid mapping was
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1505  	 * initialized during get_smp_config(), make sure it matches the
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1506  	 * actual value.
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1507  	 */
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23 @1508  	i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1509  	WARN_ON(i != BAD_APICID && i != logical_smp_processor_id());
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1510  	/* always use the value from LDR */
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1511  	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1512  		logical_smp_processor_id();
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1513  #endif
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1514  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1515  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1516  	 * Set Task Priority to 'accept all'. We never change this
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1517  	 * later on.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1518  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1519  	value = apic_read(APIC_TASKPRI);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1520  	value &= ~APIC_TPRI_MASK;
11a8e778 arch/x86_64/kernel/apic.c   Andi Kleen         2006-01-11  1521  	apic_write(APIC_TASKPRI, value);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1522  
0d827285 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-23  1523  	apic_pending_intr_clear();
da7ed9f9 arch/x86_64/kernel/apic.c   Vivek Goyal        2006-03-25  1524  
da7ed9f9 arch/x86_64/kernel/apic.c   Vivek Goyal        2006-03-25  1525  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1526  	 * Now that we are all set up, enable the APIC
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1527  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1528  	value = apic_read(APIC_SPIV);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1529  	value &= ~APIC_VECTOR_MASK;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1530  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1531  	 * Enable APIC
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1532  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1533  	value |= APIC_SPIV_APIC_ENABLED;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1534  

:::::: The code at line 1508 was first introduced by commit
:::::: acb8bc09c6185e4d3d582d0076aaa6a89f19d8c5 x86: Add apic->x86_32_early_logical_apicid()

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--CE+1k2dSO48ffgeK--
