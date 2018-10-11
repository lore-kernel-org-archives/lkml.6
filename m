Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38FEC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB092098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB092098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJLFjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:39:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:53737 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbeJLFjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:39:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 15:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,370,1534834800"; 
   d="scan'208";a="80764009"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.157])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 15:09:16 -0700
Subject: [driver-core PATCH v3 0/5] Add NUMA aware async_schedule calls
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com
Date:   Thu, 11 Oct 2018 15:09:16 -0700
Message-ID: <20181011220134.1408.63391.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set provides functionality that will help to improve the
locality of the async_schedule calls used to provide deferred
initialization.

This patch set originally started out with me focused on just the one call
to async_schedule_domain in the nvdimm tree that was being used to
defer the device_add call however after doing some digging I realized the
scope of this was much broader than I had originally planned. As such I
went through and reworked the underlying infrastructure down to replacing
the queue_work call itself with a function of my own and opted to try and
provide a NUMA aware solution that would work for a broader audience.

Ideally this solution should be agnostic enough that it can be used for any
given device type. So ideally we shouldn't need to implement one-off
solutions for each bus as has already kind of happened in the PCI tree with
pci_call_probe.

RFC->v1:
    Dropped nvdimm patch to submit later.
		It relies on code in libnvdimm development tree.
    Simplified queue_work_near to just convert node into a CPU.
    Split up drivers core and PM core patches.
v1->v2:
    Renamed queue_work_near to queue_work_node
    Added WARN_ON_ONCE if we use queue_work_node with per-cpu workqueue
v2->v3:
    Added Acked-by for queue_work_node patch
    Continued rename from _near to _node for consistency with queue_work_node
        Renamed async_schedule_near_domain to async_schedule_node_domain
        Renamed async_schedule_near to async_schedule_node
    Added kerneldoc for new async_schedule_XXX functions
    Added nvdimm boot time improvement data to description of patch 4
---

Alexander Duyck (5):
      workqueue: Provide queue_work_node to queue work near a given NUMA node
      async: Add support for queueing on specific NUMA node
      driver core: Probe devices asynchronously instead of the driver
      driver core: Attach devices on CPU local to device node
      PM core: Use new async_schedule_dev command


 drivers/base/bus.c        |   23 ++----------
 drivers/base/dd.c         |   44 +++++++++++++++++++++++-
 drivers/base/power/main.c |   12 +++---
 include/linux/async.h     |   84 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/workqueue.h |    2 +
 kernel/async.c            |   53 ++++++++++++++++------------
 kernel/workqueue.c        |   84 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 248 insertions(+), 54 deletions(-)

--
