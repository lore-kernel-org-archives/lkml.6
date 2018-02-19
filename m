Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeBSKOm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:14:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:53122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752309AbeBSKOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:14:39 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, x86@kernel.org
Cc: rafael.j.wysocki@intel.com, lenb@kernel.org,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 0/3] xen: re-enable booting as Xen PVH guest
Date: Mon, 19 Feb 2018 11:09:03 +0100
Message-Id: <20180219100906.14265-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen PVH boot protocol passes vital information to the kernel via
a start_info block. One of the data transferred is the physical address
of the RSDP table.

Unfortunately PVH support in the kernel didn't use that passed address
for RSDP, but relied on the legacy mechanism searching for the RSDP in
low memory. After a recent change in Xen putting the RSDP to a higher
address booting as PVH guest is now failing.

This small series repairs that by passing the RSDP address from the
start_info block to ACPI handling.

Changes in V3:
- instead of using a weak function add a function pointer to x86_init
  for obtaining the RSDP address

Juergen Gross (3):
  acpi: introduce acpi_arch_get_root_pointer() for getting rsdp address
  x86/acpi: add a new x86_init_acpi structure to x86_init_ops
  x86/xen: add pvh specific rsdp address retrieval function

 arch/x86/include/asm/acpi.h     |  7 +++++++
 arch/x86/include/asm/x86_init.h |  9 +++++++++
 arch/x86/kernel/x86_init.c      |  5 +++++
 arch/x86/xen/enlighten_pvh.c    | 14 +++++++++++---
 drivers/acpi/osl.c              |  5 ++++-
 include/linux/acpi.h            |  7 +++++++
 6 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.13.6
