Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DFFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742B220847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtLpOsjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742B220847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbeKCDyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:17 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA1420847;
        Fri,  2 Nov 2018 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184363;
        bh=1qADsAp/w3konQaCVsj/kZdiS0tewDiQsek94bVz/WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtLpOsjcizgRwGXuz+FCvfVQqtWANde47lvgH7t+FLMZj0mSEqyXe9MpNCZ/j0gRT
         WDeEuk6qut1vAiK0IdtVU0PUriMZ4Qu2M3v0MhQsUDp7+jCe9YAMNAjm0/lvgud1FP
         ejM2wNHsFbtQFdqh14lWG6nlxcJBpHU/O7CQ3bAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 145/150] sparc64: Set %l4 properly on trap return after handling signals.
Date:   Fri,  2 Nov 2018 19:35:07 +0100
Message-Id: <20181102182912.529395378@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit d1f1f98c6d1708a90436e1a3b2aff5e93946731b ]

If we did some signal processing, we have to reload the pt_regs
tstate register because it's value may have changed.

In doing so we also have to extract the %pil value contained in there
anre load that into %l4.

This value is at bit 20 and thus needs to be shifted down before we
later write it into the %pil register.

Most of the time this is harmless as we are returning to userspace
and the %pil is zero for that case.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/rtrap_64.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -85,8 +85,9 @@ __handle_signal:
 		ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 		sethi			%hi(0xf << 20), %l4
 		and			%l1, %l4, %l4
+		andn			%l1, %l4, %l1
 		ba,pt			%xcc, __handle_preemption_continue
-		 andn			%l1, %l4, %l1
+		 srl			%l4, 20, %l4
 
 		/* When returning from a NMI (%pil==15) interrupt we want to
 		 * avoid running softirqs, doing IRQ tracing, preempting, etc.


