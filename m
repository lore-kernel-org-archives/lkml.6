Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EADCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5E121537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5E121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeI0EGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:06:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:58649 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbeI0EGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:06:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 14:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="94009066"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.154])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 14:51:32 -0700
Subject: [RFC workqueue/driver-core PATCH 0/5] Add NUMA aware async_schedule
 calls
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-nvdimm@lists.01.org, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
Cc:     len.brown@intel.com, dave.jiang@intel.com, rafael@kernel.org,
        vishal.l.verma@intel.com, jiangshanlai@gmail.com, pavel@ucw.cz,
        zwisler@kernel.org, dan.j.williams@intel.com
Date:   Wed, 26 Sep 2018 14:51:32 -0700
Message-ID: <20180926214433.13512.30289.stgit@localhost.localdomain>
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

I am submitting this an RFC to figure out just how far off I am from where
I need to be on this patch set and to determine which tree I should
ultimately be submitting this to.

---

Alexander Duyck (5):
      workqueue: Provide queue_work_near to queue work near a given NUMA node
      async: Add support for queueing on specific NUMA node
      driver core: Probe devices asynchronously instead of the driver
      driver core: Use new async_schedule_dev command
      nvdimm: Schedule device registration on node local to the device


 drivers/base/bus.c        |   23 +-------
 drivers/base/dd.c         |   44 +++++++++++++++
 drivers/base/power/main.c |   12 ++--
 drivers/nvdimm/bus.c      |   11 +++-
 include/linux/async.h     |   27 ++++++++-
 include/linux/workqueue.h |    2 +
 kernel/async.c            |   62 ++++++++++++++++------
 kernel/workqueue.c        |  129 ++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 258 insertions(+), 52 deletions(-)

--
