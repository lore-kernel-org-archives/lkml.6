Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571B4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B22020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B22020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeIJO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:57:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45423 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIJO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:57:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AA3vuA1804990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:03:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AA3uqr1804987;
        Mon, 10 Sep 2018 03:03:56 -0700
Date:   Mon, 10 Sep 2018 03:03:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jacek Tomaka <tipbot@zytor.com>
Message-ID: <tip-16160c1946b702dcfa95ef63389a56deb2f1c7cb@git.kernel.org>
Cc:     jacek.tomaka@poczta.fm, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, jacek.tomaka@poczta.fm
In-Reply-To: <20180802013830.10600-1-jacekt@dugeo.com>
References: <20180802013830.10600-1-jacekt@dugeo.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Add support/quirk for the
 MISPREDICT bit on Knights Landing CPUs
Git-Commit-ID: 16160c1946b702dcfa95ef63389a56deb2f1c7cb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  16160c1946b702dcfa95ef63389a56deb2f1c7cb
Gitweb:     https://git.kernel.org/tip/16160c1946b702dcfa95ef63389a56deb2f1c7cb
Author:     Jacek Tomaka <jacek.tomaka@poczta.fm>
AuthorDate: Thu, 2 Aug 2018 09:38:30 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:03:01 +0200

perf/x86/intel: Add support/quirk for the MISPREDICT bit on Knights Landing CPUs

Problem: perf did not show branch predicted/mispredicted bit in brstack.

Output of perf -F brstack for profile collected

Before:

 0x4fdbcd/0x4fdc03/-/-/-/0
 0x45f4c1/0x4fdba0/-/-/-/0
 0x45f544/0x45f4bb/-/-/-/0
 0x45f555/0x45f53c/-/-/-/0
 0x7f66901cc24b/0x45f555/-/-/-/0
 0x7f66901cc22e/0x7f66901cc23d/-/-/-/0
 0x7f66901cc1ff/0x7f66901cc20f/-/-/-/0
 0x7f66901cc1e8/0x7f66901cc1fc/-/-/-/0

After:

 0x4fdbcd/0x4fdc03/P/-/-/0
 0x45f4c1/0x4fdba0/P/-/-/0
 0x45f544/0x45f4bb/P/-/-/0
 0x45f555/0x45f53c/P/-/-/0
 0x7f66901cc24b/0x45f555/P/-/-/0
 0x7f66901cc22e/0x7f66901cc23d/P/-/-/0
 0x7f66901cc1ff/0x7f66901cc20f/P/-/-/0
 0x7f66901cc1e8/0x7f66901cc1fc/P/-/-/0

Cause:

As mentioned in Software Development Manual vol 3, 17.4.8.1,
IA32_PERF_CAPABILITIES[5:0] indicates the format of the address that is
stored in the LBR stack. Knights Landing reports 1 (LBR_FORMAT_LIP) as
its format. Despite that, registers containing FROM address of the branch,
do have MISPREDICT bit but because of the format indicated in
IA32_PERF_CAPABILITIES[5:0], LBR did not read MISPREDICT bit.

Solution:

Teach LBR about above Knights Landing quirk and make it read MISPREDICT bit.

Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180802013830.10600-1-jacekt@dugeo.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/lbr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f3e006bed9a7..c88ed39582a1 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1272,4 +1272,8 @@ void intel_pmu_lbr_init_knl(void)
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
+
+	/* Knights Landing does have MISPREDICT bit */
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
+		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
