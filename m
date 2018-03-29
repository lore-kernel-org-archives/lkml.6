Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC2W3W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:29:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:60712 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbeC2W3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:29:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="28690087"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH RFC 0/6] Memory b/w allocation software controller
Date: Thu, 29 Mar 2018 15:26:10 -0700
Message-Id: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel RDT memory bandwidth allocation (MBA) currently uses the resctrl
interface and uses the schemata file in each rdtgroup to specify the max
b/w percentage that is allowed to be used by the "threads" and "cpus" in
the rdtgroup. These values are specified "per package" in each rdtgroup
in the schemata file as below:

$ cat /sys/fs/resctrl/p1/schemata 
    L3:0=7ff;1=7ff
    MB:0=100;1=50

In the above example the MB is the memory bandwidth percentage and "0"
and "1" specify the package/socket ids. The threads in rdtgroup "p1"
would get 100% memory b/w on socket0 and 50% b/w on socket1.

However, Memory bandwidth allocation (MBA) is a core specific mechanism
which means that when the Memory b/w percentage is specified in the
schemata per package it actually is applied on a per core basis via
IA32_MBA_THRTL_MSR interface. This may lead to confusion in scenarios
below:

1. User may not see increase in actual b/w when percentage values are
   increased:

This can occur when aggregate L2 external b/w is more than L3 external
b/w. Consider an SKL SKU with 24 cores on a package and where L2
external b/w is 10GBps (hence aggregate L2 external b/w is 240GBps) and
L3 external b/w is 100GBps. Now a workload with '20 threads, having 50%
b/w, each consuming 5GBps' consumes the max L3 b/w of 100GBps although
the percentage value specified is only 50% << 100%. Hence increasing
the b/w percentage will not yeild any more b/w. This is because
although the L2 external b/w still has capacity, the L3 external b/w
is fully used. Also note that this would be dependent on number of
cores the benchmark is run on.

2. Same b/w percentage may mean different actual b/w depending on # of
   threads:

For the same SKU in #1, a 'single thread, with 10% b/w' and '4 thread,
with 10% b/w' can consume upto 10GBps and 40GBps although they have same
percentage b/w of 10%. This is simply because as threads start using
more cores in an rdtgroup, the actual b/w may increase or vary although
user specified b/w percentage is same.

In order to mitigate this and make the interface more user friendly, we
can let the user specify the max bandwidth per rdtgroup in bytes(or mega
bytes). The kernel underneath would use a software feedback mechanism or
a "Software Controller" which reads the actual b/w using MBM counters
and adjust the memowy bandwidth percentages to ensure the "actual b/w
< user b/w".

The legacy behaviour is default and user can switch to the "MBA software
controller" mode using a mount option 'mba_MB'.

To use the feature mount the file system using mba_MB option:
 
$ mount -t resctrl resctrl [-o cdp[,cdpl2][mba_MB]] /sys/fs/resctrl

We could also use a config option as suggested by Fenghua. This may be
useful in situations where other resources need such options and we dont
have to keep growing the if else in the mount. However it needs enough
isolation when implemented with respect to resetting the values.

If the MBA is specified in MB(megabytes) then user can enter the max b/w
in MB rather than the percentage values. The default when mounted is
max_u32.

$ echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
$ echo "L3:0=3;1=3\nMB:0=1024;1=500" > /sys/fs/resctrl/p1/schemata

In the above example the tasks in "p1" and "p0" rdtgroup
would use a max b/w of 1024MBps on socket0 and 500MBps on socket1.

Vikas Shivappa (6):
  x86/intel_rdt/mba_sc: Add documentation for MBA software controller
  x86/intel_rdt/mba_sc: Add support to enable/disable via mount option
  x86/intel_rdt/mba_sc: Add initialization support
  x86/intel_rdt/mba_sc: Add schemata support
  x86/intel_rdt/mba_sc: Add counting for MBA software controller
  x86/intel_rdt/mba_sc: Add support to dynamically update the memory b/w

 Documentation/x86/intel_rdt_ui.txt          |  63 +++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt.c             |  50 +++++++++----
 arch/x86/kernel/cpu/intel_rdt.h             |  34 ++++++++-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c |  10 ++-
 arch/x86/kernel/cpu/intel_rdt_monitor.c     | 105 +++++++++++++++++++++++++---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  34 ++++++++-
 6 files changed, 268 insertions(+), 28 deletions(-)

-- 
1.9.1
