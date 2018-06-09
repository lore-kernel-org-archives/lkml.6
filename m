Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YDU0BN3hG1vhcwAAmS7hNA
	; Sat, 09 Jun 2018 14:19:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 00691608BA; Sat,  9 Jun 2018 14:19:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5BB4F605A5;
	Sat,  9 Jun 2018 14:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BB4F605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbeFIOTF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:19:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbeFIOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:19:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w59EIsmw3021735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Jun 2018 07:18:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w59EIswq3021732;
        Sat, 9 Jun 2018 07:18:54 -0700
Date: Sat, 9 Jun 2018 07:18:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-1d9f3e20a56d33e55748552aeec597f58542f92d@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, fenghua.yu@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: vikas.shivappa@linux.intel.com, fenghua.yu@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, tony.luck@intel.com
In-Reply-To: <20180608160732.9842-1-tony.luck@intel.com>
References: <20180608160732.9842-1-tony.luck@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Enable CMT and MBM on new Skylake
 stepping
Git-Commit-ID: 1d9f3e20a56d33e55748552aeec597f58542f92d
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

Commit-ID:  1d9f3e20a56d33e55748552aeec597f58542f92d
Gitweb:     https://git.kernel.org/tip/1d9f3e20a56d33e55748552aeec597f58542f92d
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Fri, 8 Jun 2018 09:07:32 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 9 Jun 2018 16:04:34 +0200

x86/intel_rdt: Enable CMT and MBM on new Skylake stepping

New stepping of Skylake has fixes for cache occupancy and memory
bandwidth monitoring.

Update the code to enable these by default on newer steppings.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: stable@vger.kernel.org # v4.14
Cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>
Link: https://lkml.kernel.org/r/20180608160732.9842-1-tony.luck@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 589b948e6e01..316a8875bd90 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -821,6 +821,8 @@ static __init void rdt_quirks(void)
 	case INTEL_FAM6_SKYLAKE_X:
 		if (boot_cpu_data.x86_stepping <= 4)
 			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
+		else
+			set_rdt_options("!l3cat");
 	}
 }
 
