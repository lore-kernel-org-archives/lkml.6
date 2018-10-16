Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5DFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5383820866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeT5Bt+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5383820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbeJPMEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbeJPMET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DC33214DA;
        Tue, 16 Oct 2018 04:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663355;
        bh=YKWNT0pIHwQBFjRYMuZqDabIOvUoQ6Ls3x4kZ6tqr9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HeT5Bt+R8cvta0xGqiAgwZNaSC79o2qFxFtISusarm0gbaE6a3k4k3GKWN3cOdnMw
         cr4MkYrQUwDFGbjCAVnBhvgRyID4oiKymAAcatRFIjame5W53j02sQWC4BumfoCr65
         Erq5Zbb8W0cWzOjRbWz6qO5kkWmZOXgd9L7XmjIE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 33/38] perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX
Date:   Tue, 16 Oct 2018 00:15:17 -0400
Message-Id: <20181016041522.135789-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041522.135789-1-sashal@kernel.org>
References: <20181016041522.135789-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 9d92cfeaf5215158d26d2991be7f7ff865cb98f3 ]

The counters on M3UPI Link 0 and Link 3 don't count properly, and writing
0 to these counters may causes system crash on some machines.

The PCI BDF addresses of the M3UPI in the current code are incorrect.

The correct addresses should be:

  D18:F1	0x204D
  D18:F2	0x204E
  D18:F5	0x204D

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Link: http://lkml.kernel.org/r/1537538826-55489-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 6bc36944a8c1..8c2a9fa0caf3 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3767,16 +3767,16 @@ static const struct pci_device_id skx_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_FULL_DATA(21, 5, SKX_PCI_UNCORE_M2PCIE, 3),
 	},
 	{ /* M3UPI0 Link 0 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204C),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 0, SKX_PCI_UNCORE_M3UPI, 0),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 1, SKX_PCI_UNCORE_M3UPI, 0),
 	},
 	{ /* M3UPI0 Link 1 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 1, SKX_PCI_UNCORE_M3UPI, 1),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204E),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 2, SKX_PCI_UNCORE_M3UPI, 1),
 	},
 	{ /* M3UPI1 Link 2 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204C),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 4, SKX_PCI_UNCORE_M3UPI, 2),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 5, SKX_PCI_UNCORE_M3UPI, 2),
 	},
 	{ /* end: all zeroes */ }
 };
-- 
2.17.1

