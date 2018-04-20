Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeDTWjK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:39:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:60382 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbeDTWjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:39:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="34982628"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH V2 0/6] Memory bandwidth allocation software controller(mba_sc)
Date: Fri, 20 Apr 2018 15:36:15 -0700
Message-Id: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending the second version of MBA software controller which addresses
the feedback on V1. Thanks to the feedback from Thomas on the V1. Thomas
was unhappy about the bad structure and english in the documentation and
comments explaining the changes and also about duct taping of data
structure which saves the throttle MSRs. Also issues were pointed out in
the mounting and other init code.
This series also changed the counting
and feedback loop patches with some improvements to not do any division
and take care of hierarchy and some l2 -> l3 traffic scenarios.

The patches are based on 4.16.

Background:

Intel RDT memory bandwidth allocation (MBA) currently uses the resctrl
interface and uses the schemata file in each rdtgroup to specify the max
"bandwidth percentage" that is allowed to be used by the "threads" and
"cpus" in the rdtgroup. These values are specified "per package" in each
rdtgroup in the schemata file as below:

$ cat /sys/fs/resctrl/p1/schemata 
    L3:0=7ff;1=7ff
    MB:0=100;1=50

In the above example the MB is the memory bandwidth percentage and "0"
and "1" specify the package/socket ids. The threads in rdtgroup "p1"
would get 100% memory bandwidth on socket0 and 50% bandwidth on socket1.

Problem:

However there are confusions in specifying the MBA in "percentage":

1. In some scenarios, when user increases bandwidth percentage values he
   does not not see any raw bandwidth increase in "MBps" 
2. Same bandwidth "percentage values" may mean different raw bandwidth
   in "MBps".
3. This interface may also end up unnecessarily controlling the L2 <->
   L3 traffic which has no or very minimal L3 external traffic.

Proposed solution:

In short, we let user specify the bandwidth in "MBps" and we introduce
a software feedback loop which measures the bandwidth using MBM and
restricts the bandwidth "percentage" internally.

The fact that Memory bandwidth allocation(MBA) is a core specific
mechanism where as memory bandwidth monitoring(MBM) is done at the
package level is what leads to confusion when users try to apply control
via the MBA and then monitor the bandwidth to see if the controls are
effective. Below are details on such scenarios:

1. User may *not* see increase in actual bandwidth when bandwidth
   percentage values are increased:

This can occur when aggregate L2 external bandwidth is more than L3
external bandwidth. Consider an SKL SKU with 24 cores on a package and
where L2 external  is 10GBps (hence aggregate L2 external bandwidth is
240GBps) and L3 external bandwidth is 100GBps. Now a workload with '20
threads, having 50% bandwidth, each consuming 5GBps' consumes the max L3
bandwidth of 100GBps although the percentage value specified is only 50%
<< 100%. Hence increasing the bandwidth percentage will not yield any
more bandwidth. This is because although the L2 external bandwidth still
has capacity, the L3 external bandwidth is fully used. Also note that
this would be dependent on number of cores the benchmark is run on.

2. Same bandwidth percentage may mean different actual bandwidth
   depending on # of threads:

For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
they have same percentage bandwidth of 10%. This is simply because as
threads start using more cores in an rdtgroup, the actual bandwidth may
increase or vary although user specified bandwidth percentage is same.

In order to mitigate this and make the interface more user friendly,
resctrl added support for specifying the bandwidth in "MBps" as well.
The kernel underneath would use a software feedback mechanism or
a "Software Controller" which reads the actual bandwidth using MBM
counters and adjust the memory bandwidth percentages to ensure

	"actual bandwidth < user specified bandwidth".

By default, the schemata would take the bandwidth percentage values
where as user can switch to the "MBA software controller" mode using
a mount option 'mba_MBps'. The schemata format is specified in the
below.

To use the feature mount the file system using mba_MBps option:
 
$ mount -t resctrl resctrl -o mba_MBps /sys/fs/resctrl

If the MBA is specified in MBps then user can enter the max bandwidth in
MBps rather than the percentage values. The default value when mounted
is max_u32.

$ echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
$ echo "L3:0=3;1=3\nMB:0=1024;1=500" > /sys/fs/resctrl/p1/schemata

In the above example the tasks in "p1" and "p0" rdtgroup
would use a max bandwidth of 1024MBps on socket0 and 500MBps on socket1.

Vikas Shivappa (6):
  x86/intel_rdt/mba_sc: Documentation for MBA software
    controller(mba_sc)
  x86/intel_rdt/mba_sc: Enable/disable MBA software controller(mba_sc)
  x86/intel_rdt/mba_sc: Add initialization support
  x86/intel_rdt/mba_sc: Add schemata support
  x86/intel_rdt/mba_sc: Prepare for feedback loop
  x86/intel_rdt/mba_sc: Feedback loop to dynamically update mem
    bandwidth

 Documentation/x86/intel_rdt_ui.txt          |  75 +++++++++++--
 arch/x86/kernel/cpu/intel_rdt.c             |  50 ++++++---
 arch/x86/kernel/cpu/intel_rdt.h             |  18 +++
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c |  24 +++-
 arch/x86/kernel/cpu/intel_rdt_monitor.c     | 166 ++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  33 ++++++
 6 files changed, 333 insertions(+), 33 deletions(-)

-- 
1.9.1
