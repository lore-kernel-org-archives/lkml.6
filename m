Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAD7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652832192B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406828AbfBNUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:22:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:20471 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387849AbfBNUWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:22:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 12:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="122509656"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2019 12:22:42 -0800
Subject: [PATCH 0/6] nfit/ars: Improve polling and short-ARS execution
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Erwin Tsaur <erwin.tsaur@oracle.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 12:10:04 -0800
Message-ID: <155017500427.944049.2254497897075714747.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
      nfit/ars: Allow root to busy-poll the ARS state machine
      nfit/ars: Remove ars_start_flags
      nfit/ars: Introduce scrub_flags
      nfit/ars: Avoid stale ARS results


 drivers/acpi/nfit/core.c |   67 ++++++++++++++++++++++++++++++++--------------
 drivers/acpi/nfit/nfit.h |   10 +++++--
 2 files changed, 53 insertions(+), 24 deletions(-)
