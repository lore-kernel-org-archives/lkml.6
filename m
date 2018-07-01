Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A1225076
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A1225076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbeGAQO5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:14:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeGAQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:14:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D23B986A;
        Sun,  1 Jul 2018 16:14:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3.18 59/85] powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_DEBUGREG
Date:   Sun,  1 Jul 2018 18:02:17 +0200
Message-Id: <20180701153124.709389266@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit 4f7c06e26ec9cf7fe9f0c54dc90079b6a4f4b2c3 upstream.

In commit e2a800beaca1 ("powerpc/hw_brk: Fix off by one error when
validating DAWR region end") we fixed setting the DAWR end point to
its max value via PPC_PTRACE_SETHWDEBUG. Unfortunately we broke
PTRACE_SET_DEBUGREG when setting a 512 byte aligned breakpoint.

PTRACE_SET_DEBUGREG currently sets the length of the breakpoint to
zero (memset() in hw_breakpoint_init()). This worked with
arch_validate_hwbkpt_settings() before the above patch was applied but
is now broken if the breakpoint is 512byte aligned.

This sets the length of the breakpoint to 8 bytes when using
PTRACE_SET_DEBUGREG.

Fixes: e2a800beaca1 ("powerpc/hw_brk: Fix off by one error when validating DAWR region end")
Cc: stable@vger.kernel.org # v3.11+
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/ptrace.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1004,6 +1004,7 @@ static int ptrace_set_debugreg(struct ta
 	/* Create a new breakpoint request if one doesn't exist already */
 	hw_breakpoint_init(&attr);
 	attr.bp_addr = hw_brk.address;
+	attr.bp_len = 8;
 	arch_bp_generic_fields(hw_brk.type,
 			       &attr.bp_type);
 


