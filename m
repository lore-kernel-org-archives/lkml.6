Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F26C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4195821479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6d+QtZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4195821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeJSCDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbeJSCDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07DBB205C9;
        Thu, 18 Oct 2018 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885657;
        bh=Q6UJ6hNVwggFKvDmA42g0y+vcUenp3k4S6+94zvz41Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6d+QtZtF3ezCcts4V6TpPsA9AfMNuFu6OHN8i2bkxYyh5k+lF4X6fPyLRVyZhH59
         Gt/txS0kqp8B8TCcUSAmUdgD+A7mhZ2RweGrn+4S8dmrfTMRQJOBvfZH20qQ/lbabk
         E08r0eBAveiSZ7zKOcO4T4JA1BU6OPnGs78b+Czc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 28/41] powerpc/tm: Avoid possible userspace r1 corruption on reclaim
Date:   Thu, 18 Oct 2018 19:54:43 +0200
Message-Id: <20181018175421.775568378@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

[ Upstream commit 96dc89d526ef77604376f06220e3d2931a0bfd58 ]

Current we store the userspace r1 to PACATMSCRATCH before finally
saving it to the thread struct.

In theory an exception could be taken here (like a machine check or
SLB miss) that could write PACATMSCRATCH and hence corrupt the
userspace r1. The SLB fault currently doesn't touch PACATMSCRATCH, but
others do.

We've never actually seen this happen but it's theoretically
possible. Either way, the code is fragile as it is.

This patch saves r1 to the kernel stack (which can't fault) before we
turn MSR[RI] back on. PACATMSCRATCH is still used but only with
MSR[RI] off. We then copy r1 from the kernel stack to the thread
struct once we have MSR[RI] back on.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/tm.S |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -170,6 +170,13 @@ _GLOBAL(tm_reclaim)
 	std	r11, GPR11(r1)			/* Temporary stash */
 
 	/*
+	 * Move the saved user r1 to the kernel stack in case PACATMSCRATCH is
+	 * clobbered by an exception once we turn on MSR_RI below.
+	 */
+	ld	r11, PACATMSCRATCH(r13)
+	std	r11, GPR1(r1)
+
+	/*
 	 * Store r13 away so we can free up the scratch SPR for the SLB fault
 	 * handler (needed once we start accessing the thread_struct).
 	 */
@@ -205,7 +212,7 @@ _GLOBAL(tm_reclaim)
 	SAVE_GPR(8, r7)				/* user r8 */
 	SAVE_GPR(9, r7)				/* user r9 */
 	SAVE_GPR(10, r7)			/* user r10 */
-	ld	r3, PACATMSCRATCH(r13)		/* user r1 */
+	ld	r3, GPR1(r1)			/* user r1 */
 	ld	r4, GPR7(r1)			/* user r7 */
 	ld	r5, GPR11(r1)			/* user r11 */
 	ld	r6, GPR12(r1)			/* user r12 */


