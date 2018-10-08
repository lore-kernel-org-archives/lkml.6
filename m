Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A780BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C432087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep2uHrl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C432087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeJIBxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeJIBxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:53:11 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBB3214C3;
        Mon,  8 Oct 2018 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024007;
        bh=4Sq+qpIWduUW/Dcm6wdl+uwyRI8RUS8SyX+cuOdmiZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ep2uHrl2MBl3UJvwjylsMjCT4VjbqARjo7eNce+CfUPyILDk62JV7q1N/kY22Sa73
         2Y+yFvPAUldjV5TCisa6JiTn6NYro/VI6qPJm/kZHP2QDFbo5gxDiXeJ1dkfm89n/9
         wYBYKiH9zERjkUI4X/Uepj9Dpf1t4BeWZD9skkmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacek Tomaka <jacek.tomaka@poczta.fm>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 40/59] perf/x86/intel: Add support/quirk for the MISPREDICT bit on Knights Landing CPUs
Date:   Mon,  8 Oct 2018 20:31:47 +0200
Message-Id: <20181008175550.673563753@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Tomaka <jacek.tomaka@poczta.fm>

[ Upstream commit 16160c1946b702dcfa95ef63389a56deb2f1c7cb ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/lbr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1195,4 +1195,8 @@ void intel_pmu_lbr_init_knl(void)
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
+
+	/* Knights Landing does have MISPREDICT bit */
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
+		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }


