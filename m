Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeDGPzt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 11:55:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:54083 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeDGPzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 11:55:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="48799116"
Subject: [PATCH v3 0/3] nfit, address-range-scrub: rework and fixes
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dave Jiang <dave.jiang@intel.com>, Toshi Kani <toshi.kani@hpe.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 07 Apr 2018 08:45:52 -0700
Message-ID: <152311595210.35426.13667585208560808244.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [1]:
* Handle -EAGAIN (no result) ars_status responses

---

Given the fact that ARS can take 10s to 100s of seconds it is not
feasible to wait for ARS completion before publishing persistent memory
namespaces. Instead convert the ARS implementation to perform a short
ARS for critical errors, ones that caused a previous system reset,
before registering namespaces. Finally, arrange for all long ARS
operations to run in the background and populate the badblock lists at
run time.

In the extreme situation that an implementation is unable to return
sufficient results in a short scan and the system encounters media
errors that machine check recovery does not handle, an administrator can
arrange to wait for a full ARS scan by doing the following:

1/ Boot with "modprobe.blacklist=nd_pmem" to stop pmem namespaces from
   starting automatically

2/ Call "ndctl wait-scrub" to wait for the OS or BIOS initiated ARS to complete

3/ Manually start up namespaces with the up to date error list
   "modprobe nd_pmem"

---

Dan Williams (3):
      nfit, address-range-scrub: determine one platform max_ars value
      nfit, address-range-scrub: rework and simplify ARS state machine
      nfit, address-range-scrub: add module option to skip initial ars


 drivers/acpi/nfit/core.c |  557 +++++++++++++++++++++-------------------------
 drivers/acpi/nfit/nfit.h |    6 
 2 files changed, 261 insertions(+), 302 deletions(-)
