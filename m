Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeBHOTN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:19:13 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41359 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeBHOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:19:12 -0500
X-Google-Smtp-Source: AH8x227A2RAitz2FBxQMqCd53tXeNVp3IVkVhc1b3A8bAhhl1WQNz7rAWrOUnLAETuYkManTuqGnWQ==
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        yasu.isimatu@gmail.com, ak@linux.intel.com
Cc: linux-kernel@vger.kernel.org
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [RESEND] [PATCH] x86/smpboot: avoid warning messages while
 hot-removing physical cpu
Message-ID: <ed738d54-0f01-b38b-b794-c31dc118c207@gmail.com>
Date: Thu, 8 Feb 2018 09:19:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

When a physical cpu is hot-removed, the following warning message
are shown while the uncore device is removing in uncore_pci_remove().

WARNING: CPU: 120 PID: 5 at arch/x86/events/intel/uncore.c:988
uncore_pci_remove+0xf1/0x110
...
CPU: 120 PID: 5 Comm: kworker/u1024:0 Not tainted 4.15.0-rc8 #1
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
...
Call Trace:
pci_device_remove+0x36/0xb0
device_release_driver_internal+0x145/0x210
pci_stop_bus_device+0x76/0xa0
pci_stop_root_bus+0x44/0x60
acpi_pci_root_remove+0x1f/0x80
acpi_bus_trim+0x54/0x90
acpi_bus_trim+0x2e/0x90
acpi_device_hotplug+0x2bc/0x4b0
acpi_hotplug_work_fn+0x1a/0x30
process_one_work+0x141/0x340
worker_thread+0x47/0x3e0
kthread+0xf5/0x130

When uncore_pci_remove() runs, it tries to get package id to
clear the value of uncore_extra_pci_dev[].dev[] by using
topology_phys_to_logical_pkg(). The warning messesage are
shown because topology_phys_to_logical_pkg() returns -1.

  arch/x86/events/intel/uncore.c:
  static void uncore_pci_remove(struct pci_dev *pdev)
  {
  ...
          phys_id = uncore_pcibus_to_physid(pdev->bus);
  ...
                  pkg = topology_phys_to_logical_pkg(phys_id); //returns -1
                  for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
                          if (uncore_extra_pci_dev[pkg].dev[i] == pdev) {
                                  uncore_extra_pci_dev[pkg].dev[i] = NULL;
                                  break;
                          }
                  }
                  WARN_ON_ONCE(i >= UNCORE_EXTRA_PCI_DEV_MAX); //HERE!!

topology_phys_to_logical_pkg() tries to find
cpuinfo_x86->phys_proc_id that matches the phys_pkg argument.

  arch/x86/kernel/smpboot.c:
  int topology_phys_to_logical_pkg(unsigned int phys_pkg)
  {
          int cpu;
  
          for_each_possible_cpu(cpu) {
                  struct cpuinfo_x86 *c = &cpu_data(cpu);
  
                  if (c->initialized && c->phys_proc_id == phys_pkg)
                          return c->logical_proc_id;
          }
          return -1;
  }

However, the phys_proc_id is already set to 0 by remove_siblinginfo()
when the cpu was offlined.
So, topology_phys_to_logical_pkg() cannot find correct the
logical_proc_id and always returns -1.
As the result, uncore_pci_remove() calls WARN_ON_ONCE() and the warning
messages are shown.

To avoid this, remove the setting from remove_siblinginfo().
There is no influence about the removing because phys_proc_id is not
used after it is hot-removed and it is re-set while hot-adding.

Fixes: 30bb9811856f ("x86/topology: Avoid wasting 128k for package id array")
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
 
---
 arch/x86/kernel/smpboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ed556d5..844279c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1431,7 +1431,6 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
-	c->phys_proc_id = 0;
 	c->cpu_core_id = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();
-- 
1.8.3.1

- Masayoshi
