Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89896ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429C520857
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429C520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbeGTArm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:47:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:1843 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeGTArh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:47:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 17:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,376,1526367600"; 
   d="scan'208";a="56379418"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2018 17:01:58 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] ata: ahci: Enable DEVSLP by default on SLP_S0 support
Date:   Thu, 19 Jul 2018 17:01:54 -0700
Message-Id: <20180720000156.77759-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the requirement for modern x86 system to enter lowest power mode
(SLP_S0) is SATA IP block to be off. This is true even during when
platform is suspended to idle and not only in opportunistic (runtime)
suspend.
This series is to enable DEVSLP by default.

-current (non-rfc) series
Implemented suggestions from Hans
- no override of policy set via module param
- Overide lpm policy per host not global policy
- changed the new policy name to "min_power_with_partial"

rfc-v2
- As suggested by Hans, it is possible to have ASP with DEVSLP, so
add a new state.
- Removed usage of mem_sleep_current, instead just rely on low power
idle flag. Don't feel good to EXPORT from core suspend code.
- Depending host policy to decide if we enable DEVSLP by default.

Srinivas Pandruvada (2):
  ata: ahci: Support state with min power but Partial low power state
  ata: ahci: Enable DEVSLP by default on x86 with SLP_S0

 drivers/ata/ahci.c        | 33 +++++++++++++++++++++++++++++----
 drivers/ata/libahci.c     |  6 +++++-
 drivers/ata/libata-core.c |  1 +
 drivers/ata/libata-scsi.c |  1 +
 include/linux/libata.h    |  3 ++-
 5 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.17.1

