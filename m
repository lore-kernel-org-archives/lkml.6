Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934925AbeBMLtR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:49:17 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43420 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeBMLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:48:45 -0500
X-Google-Smtp-Source: AH8x225XzdL4xvWnfGndFzWOY0opr6QAx1wIQ9+joC/XnmNJsTOt/oMgs3TtEVwPIhofs6zfznlOGg==
Date: Tue, 13 Feb 2018 12:48:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        yasu.isimatu@gmail.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/smpboot: Fix uncore_pci_remove() indexing bug when
 hot-removing a physical CPU
Message-ID: <20180213114841.dsvzsgdk76nsy4lt@gmail.com>
References: <ed738d54-0f01-b38b-b794-c31dc118c207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed738d54-0f01-b38b-b794-c31dc118c207@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> When a physical cpu is hot-removed, the following warning message
> are shown while the uncore device is removing in uncore_pci_remove().
> 
> WARNING: CPU: 120 PID: 5 at arch/x86/events/intel/uncore.c:988
> uncore_pci_remove+0xf1/0x110
> ...
> CPU: 120 PID: 5 Comm: kworker/u1024:0 Not tainted 4.15.0-rc8 #1
> Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> ...
> Call Trace:
> pci_device_remove+0x36/0xb0
> device_release_driver_internal+0x145/0x210
> pci_stop_bus_device+0x76/0xa0
> pci_stop_root_bus+0x44/0x60
> acpi_pci_root_remove+0x1f/0x80
> acpi_bus_trim+0x54/0x90
> acpi_bus_trim+0x2e/0x90
> acpi_device_hotplug+0x2bc/0x4b0
> acpi_hotplug_work_fn+0x1a/0x30
> process_one_work+0x141/0x340
> worker_thread+0x47/0x3e0
> kthread+0xf5/0x130
> 
> When uncore_pci_remove() runs, it tries to get package id to
> clear the value of uncore_extra_pci_dev[].dev[] by using
> topology_phys_to_logical_pkg(). The warning messesage are
> shown because topology_phys_to_logical_pkg() returns -1.
> 
>   arch/x86/events/intel/uncore.c:
>   static void uncore_pci_remove(struct pci_dev *pdev)
>   {
>   ...
>           phys_id = uncore_pcibus_to_physid(pdev->bus);
>   ...
>                   pkg = topology_phys_to_logical_pkg(phys_id); //returns -1
>                   for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
>                           if (uncore_extra_pci_dev[pkg].dev[i] == pdev) {
>                                   uncore_extra_pci_dev[pkg].dev[i] = NULL;
>                                   break;
>                           }
>                   }
>                   WARN_ON_ONCE(i >= UNCORE_EXTRA_PCI_DEV_MAX); //HERE!!
> 
> topology_phys_to_logical_pkg() tries to find
> cpuinfo_x86->phys_proc_id that matches the phys_pkg argument.
> 
>   arch/x86/kernel/smpboot.c:
>   int topology_phys_to_logical_pkg(unsigned int phys_pkg)
>   {
>           int cpu;
>   
>           for_each_possible_cpu(cpu) {
>                   struct cpuinfo_x86 *c = &cpu_data(cpu);
>   
>                   if (c->initialized && c->phys_proc_id == phys_pkg)
>                           return c->logical_proc_id;
>           }
>           return -1;
>   }
> 
> However, the phys_proc_id is already set to 0 by remove_siblinginfo()
> when the cpu was offlined.
> So, topology_phys_to_logical_pkg() cannot find correct the
> logical_proc_id and always returns -1.
> As the result, uncore_pci_remove() calls WARN_ON_ONCE() and the warning
> messages are shown.
> 
> To avoid this, remove the setting from remove_siblinginfo().
> There is no influence about the removing because phys_proc_id is not
> used after it is hot-removed and it is re-set while hot-adding.

So I think this fix goes beyond fixing a 'warning', if we get -1 for 'pkg':

>                   pkg = topology_phys_to_logical_pkg(phys_id); //returns -1
>                   for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
>                           if (uncore_extra_pci_dev[pkg].dev[i] == pdev) {
>                                   uncore_extra_pci_dev[pkg].dev[i] = NULL;

... then that creates two _real_ bugs AFAICS:

 1) we dereference uncore_extra_pci_dev[] with a negative index

 2) we fail to clean up a stale pointer in uncore_extra_pci_dev[][]

So I've rewritten your changelog accordingly - see the attached patch.

I have also added a Cc: stable tag.

Thanks,

	Ingo

===================>
>From 295cc7eb314eb3321fb6d67ca6f7305f5c50d10f Mon Sep 17 00:00:00 2001
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Date: Thu, 8 Feb 2018 09:19:08 -0500
Subject: [PATCH] x86/smpboot: Fix uncore_pci_remove() indexing bug when hot-removing a physical CPU

When a physical CPU is hot-removed, the following warning messages
are shown while the uncore device is removed in uncore_pci_remove():

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

When uncore_pci_remove() runs, it tries to get the package ID to
clear the value of uncore_extra_pci_dev[].dev[] by using
topology_phys_to_logical_pkg(). The warning messesages are
shown because topology_phys_to_logical_pkg() returns -1.

  arch/x86/events/intel/uncore.c:
  static void uncore_pci_remove(struct pci_dev *pdev)
  {
  ...
          phys_id = uncore_pcibus_to_physid(pdev->bus);
  ...
                  pkg = topology_phys_to_logical_pkg(phys_id); // returns -1
                  for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
                          if (uncore_extra_pci_dev[pkg].dev[i] == pdev) {
                                  uncore_extra_pci_dev[pkg].dev[i] = NULL;
                                  break;
                          }
                  }
                  WARN_ON_ONCE(i >= UNCORE_EXTRA_PCI_DEV_MAX); // <=========== HERE!!

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

However, the phys_proc_id was already set to 0 by remove_siblinginfo()
when the CPU was offlined.

So, topology_phys_to_logical_pkg() cannot find the correct
logical_proc_id and always returns -1.

As the result, uncore_pci_remove() calls WARN_ON_ONCE() and the warning
messages are shown.

What is worse is that the bogus 'pkg' index results in two bugs:

 - We dereference uncore_extra_pci_dev[] with a negative index
 - We fail to clean up a stale pointer in uncore_extra_pci_dev[][]

To fix these bugs, remove the clearing of ->phys_proc_id from remove_siblinginfo().

This should not cause any problems, because ->phys_proc_id is not
used after it is hot-removed and it is re-set while hot-adding.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: yasu.isimatu@gmail.com
Cc: <stable@vger.kernel.org>
Fixes: 30bb9811856f ("x86/topology: Avoid wasting 128k for package id array")
Link: http://lkml.kernel.org/r/ed738d54-0f01-b38b-b794-c31dc118c207@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/smpboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6f27facbaa9b..cfc61e1d45e2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1430,7 +1430,6 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
-	c->phys_proc_id = 0;
 	c->cpu_core_id = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();
