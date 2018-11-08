Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D411CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF7420825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF7420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKIDnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:43:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:3631 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbeKIDnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:43:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 10:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="90542611"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2018 10:06:40 -0800
Subject: [driver-core PATCH v6 0/9] Add NUMA aware async_schedule calls
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Thu, 08 Nov 2018 10:06:40 -0800
Message-ID: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: StGit/unknown-version
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
    Continued rename from _near to _node to be consistent with queue_work_node
        Renamed async_schedule_near_domain to async_schedule_node_domain
        Renamed async_schedule_near to async_schedule_node
    Added kerneldoc for new async_schedule_XXX functions
    Updated patch description for patch 4 to include data on potential gains
v3->v4
    Added patch to consolidate use of need_parent_lock
    Make asynchronous driver probing explicit about use of drvdata
v4->v5
    Added patch to move async_synchronize_full to address deadlock
    Added bit async_probe to act as mutex for probe/remove calls
    Added back nvdimm patch as code it relies on is now in Linus's tree
    Incorporated review comments on parent & device locking consolidation
    Rebased on latest linux-next
v5->v6:
    Drop the "This patch" or "This change" from start of patch descriptions.
    Drop unnecessary parenthesis in first patch
    Use same wording for "selecting a CPU" in comments added in first patch
    Added kernel documentation for async_probe member of device
    Fixed up comments for async_schedule calls in patch 2
    Moved code related setting async driver out of device.h and into dd.c
    Added Reviewed-by for several patches

---

Alexander Duyck (9):
      workqueue: Provide queue_work_node to queue work near a given NUMA node
      async: Add support for queueing on specific NUMA node
      device core: Consolidate locking and unlocking of parent and device
      driver core: Move async_synchronize_full call
      driver core: Establish clear order of operations for deferred probe and remove
      driver core: Probe devices asynchronously instead of the driver
      driver core: Attach devices on CPU local to device node
      PM core: Use new async_schedule_dev command
      libnvdimm: Schedule device registration on node local to the device


 drivers/base/base.h       |    2 
 drivers/base/bus.c        |   46 +-------
 drivers/base/dd.c         |  265 ++++++++++++++++++++++++++++++++++-----------
 drivers/base/power/main.c |   12 +-
 drivers/nvdimm/bus.c      |   11 +-
 include/linux/async.h     |   82 +++++++++++++-
 include/linux/device.h    |   13 ++
 include/linux/workqueue.h |    2 
 kernel/async.c            |   53 +++++----
 kernel/workqueue.c        |   84 ++++++++++++++
 10 files changed, 428 insertions(+), 142 deletions(-)

--
