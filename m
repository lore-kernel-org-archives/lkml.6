Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5851C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD9F2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSVdTpQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD9F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeJKXEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 058B22087A;
        Thu, 11 Oct 2018 15:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272178;
        bh=vYmrlYBnxF7Wk7dsUJ+UBRFHcg3puZzaREDcrjUdTxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSVdTpQxcmbCEMD2xZlCAOGF4CgqK0S6hA5rO/skN1yp5WKQ1Os6isAG6teYFtvUX
         3WOIVjdGMm0bEvDxyLFZgrgUOMFqtKlNLydZivL1e0jGHDxA4pUYByp+PN6iNvtl7u
         olNureGFippS0Qa8aIinHBFS4MZWNlbUaFVu9OaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 017/120] arm64: Add trace_hardirqs_off annotation in ret_to_user
Date:   Thu, 11 Oct 2018 17:33:18 +0200
Message-Id: <20181011152550.335120417@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catalin Marinas <catalin.marinas@arm.com>

commit db3899a6477a4dccd26cbfb7f408b6be2cc068e0 upstream.

When a kernel is built with CONFIG_TRACE_IRQFLAGS the following warning
is produced when entering userspace for the first time:

  WARNING: at /work/Linux/linux-2.6-aarch64/kernel/locking/lockdep.c:3519
  Modules linked in:
  CPU: 1 PID: 1 Comm: systemd Not tainted 4.4.0-rc3+ #639
  Hardware name: Juno (DT)
  task: ffffffc9768a0000 ti: ffffffc9768a8000 task.ti: ffffffc9768a8000
  PC is at check_flags.part.22+0x19c/0x1a8
  LR is at check_flags.part.22+0x19c/0x1a8
  pc : [<ffffffc0000fba6c>] lr : [<ffffffc0000fba6c>] pstate: 600001c5
  sp : ffffffc9768abe10
  x29: ffffffc9768abe10 x28: ffffffc9768a8000
  x27: 0000000000000000 x26: 0000000000000001
  x25: 00000000000000a6 x24: ffffffc00064be6c
  x23: ffffffc0009f249e x22: ffffffc9768a0000
  x21: ffffffc97fea5480 x20: 00000000000001c0
  x19: ffffffc00169a000 x18: 0000005558cc7b58
  x17: 0000007fb78e3180 x16: 0000005558d2e238
  x15: ffffffffffffffff x14: 0ffffffffffffffd
  x13: 0000000000000008 x12: 0101010101010101
  x11: 7f7f7f7f7f7f7f7f x10: fefefefefefeff63
  x9 : 7f7f7f7f7f7f7f7f x8 : 6e655f7371726964
  x7 : 0000000000000001 x6 : ffffffc0001079c4
  x5 : 0000000000000000 x4 : 0000000000000001
  x3 : ffffffc001698438 x2 : 0000000000000000
  x1 : ffffffc9768a0000 x0 : 000000000000002e
  Call trace:
  [<ffffffc0000fba6c>] check_flags.part.22+0x19c/0x1a8
  [<ffffffc0000fc440>] lock_is_held+0x80/0x98
  [<ffffffc00064bafc>] __schedule+0x404/0x730
  [<ffffffc00064be6c>] schedule+0x44/0xb8
  [<ffffffc000085bb0>] ret_to_user+0x0/0x24
  possible reason: unannotated irqs-off.
  irq event stamp: 502169
  hardirqs last  enabled at (502169): [<ffffffc000085a98>] el0_irq_naked+0x1c/0x24
  hardirqs last disabled at (502167): [<ffffffc0000bb3bc>] __do_softirq+0x17c/0x298
  softirqs last  enabled at (502168): [<ffffffc0000bb43c>] __do_softirq+0x1fc/0x298
  softirqs last disabled at (502143): [<ffffffc0000bb830>] irq_exit+0xa0/0xf0

This happens because we disable interrupts in ret_to_user before calling
schedule() in work_resched. This patch adds the necessary
trace_hardirqs_off annotation.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/kernel/entry.S |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -633,6 +633,9 @@ work_pending:
 	bl	do_notify_resume
 	b	ret_to_user
 work_resched:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off		// the IRQs are off here, inform the tracing code
+#endif
 	bl	schedule
 
 /*


