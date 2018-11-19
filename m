Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFE42089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJXiJ1QN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFE42089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeKTCyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730042AbeKTCyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:54:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C1620831;
        Mon, 19 Nov 2018 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645028;
        bh=tW7aECEfKnmXjypAHlLz+zyso76frtJwQYX9hHdJmDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJXiJ1QNrwlsd/ZDh7iCJ/hYZo7r+zZB5Q38Y2cgpx/9h12GcWi/ubSdq+8Jp+MVo
         82/Og8u6nzITgdK6Oi7VgHLu3KPTKW2iK343G8DzGyzQ+I55ldNLPefcLbZGHN6aKT
         Qeqful6hoRJgU+MkRrDR+tpf1Uro6nfhdRKPa9vQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/205] powerpc/traps: restore recoverability of machine_check interrupts
Date:   Mon, 19 Nov 2018 17:25:08 +0100
Message-Id: <20181119162616.853926575@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit daf00ae71dad8aa05965713c62558aeebf2df48e ]

commit b96672dd840f ("powerpc: Machine check interrupt is a non-
maskable interrupt") added a call to nmi_enter() at the beginning of
machine check restart exception handler. Due to that, in_interrupt()
always returns true regardless of the state before entering the
exception, and die() panics even when the system was not already in
interrupt.

This patch calls nmi_exit() before calling die() in order to restore
the interrupt state we had before calling nmi_enter()

Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/traps.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -767,12 +767,17 @@ void machine_check_exception(struct pt_r
 	if (check_io_access(regs))
 		goto bail;
 
-	die("Machine check", regs, SIGBUS);
-
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		nmi_panic(regs, "Unrecoverable Machine check");
 
+	if (!nested)
+		nmi_exit();
+
+	die("Machine check", regs, SIGBUS);
+
+	return;
+
 bail:
 	if (!nested)
 		nmi_exit();


