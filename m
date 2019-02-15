Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65123C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F42A222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfBOT40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:56:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:49041 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbfBOT40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:56:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 11:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="300096946"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2019 11:56:25 -0800
Subject: [PATCH v2 0/6] nfit/ars: Improve polling and short-ARS execution
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Erwin Tsaur <erwin.tsaur@oracle.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Feb 2019 11:43:47 -0800
Message-ID: <155025982726.1043225.15436410616433285475.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1: [1]
* Fix the root poll interval support to avoid a infinite loop condition
  when the polling is faster than the ARS completion.
* Move the introduction of scrub_flags earlier in the series and
  introduce ARS_POLL to fix the above issue.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-February/019964.html

---

Here is a small pile of updates to better coordinate the Linux ARS state
machine with platform-BIOS implementations. Specifically, take advantage
of opportunities to run short-ARS whenever the ARS interface is found to
be idle at init, always run short-ARS even if no_init_ars is specified,
allow root to reset the exponential backoff polling interval for ARS
completion, and protect the kernel against the consumption of stale ARS
results.

---

Dan Williams (6):
      nfit/ars: Attempt a short-ARS whenever the ARS state is idle at boot
      nfit/ars: Attempt short-ARS even in the no_init_ars case
      nfit/ars: Remove ars_start_flags
      nfit/ars: Introduce scrub_flags
      nfit/ars: Allow root to busy-poll the ARS state machine
      nfit/ars: Avoid stale ARS results


 drivers/acpi/nfit/core.c |   70 ++++++++++++++++++++++++++++++++--------------
 drivers/acpi/nfit/nfit.h |   11 +++++--
 2 files changed, 57 insertions(+), 24 deletions(-)
