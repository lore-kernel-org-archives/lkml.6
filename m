Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E6C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661972063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078540;
	bh=ZPu5VjXHNIi76KjtVapQlZTgeBRtJDvw15Z0u8x/duk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4Pjtyxo6Bmcwm7KFXjT0FtpDwNvSWMWaTsPr9TlX7zk+fSvES6zq4xkQVenDiPhP
	 e+qq153RN+6HX93aH+lB2QdXipEFrvuvEMHBwt0ysUozYICYqeU4J0i8MPvc0RMnoQ
	 I78bxYs/fWyd+bXjv8lGn/KikjgohvQsRqSA782I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfAUNs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbfAUNsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D532063F;
        Mon, 21 Jan 2019 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078535;
        bh=ZPu5VjXHNIi76KjtVapQlZTgeBRtJDvw15Z0u8x/duk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0mkOF+6DTCBU5V2ZhIo6gNZs1gWpY6m4IyRB+oie3EFJMnXL0RmFxGcLcenbsLTh
         8N25fTa3EZCv9UXgMKP5E8kcFQ/tBmYTBnO5lShzFAKJTf7uc4xnwV8sOtotOGaOKk
         P43jT+bGNkR1HrgDY7k2DWpvM2z2Z5UTPwm1PAyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 066/111] powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM
Date:   Mon, 21 Jan 2019 14:43:00 +0100
Message-Id: <20190121122503.764750006@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit 897bc3df8c5aebb54c32d831f917592e873d0559 upstream.

Commit e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
moved a code block around and this block uses a 'msr' variable outside of
the CONFIG_PPC_TRANSACTIONAL_MEM, however the 'msr' variable is declared
inside a CONFIG_PPC_TRANSACTIONAL_MEM block, causing a possible error when
CONFIG_PPC_TRANSACTION_MEM is not defined.

	error: 'msr' undeclared (first use in this function)

This is not causing a compilation error in the mainline kernel, because
'msr' is being used as an argument of MSR_TM_ACTIVE(), which is defined as
the following when CONFIG_PPC_TRANSACTIONAL_MEM is *not* set:

	#define MSR_TM_ACTIVE(x) 0

This patch just fixes this issue avoiding the 'msr' variable usage outside
the CONFIG_PPC_TRANSACTIONAL_MEM block, avoiding trusting in the
MSR_TM_ACTIVE() definition.

Cc: stable@vger.kernel.org
Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Fixes: e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/signal_64.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -755,11 +755,12 @@ SYSCALL_DEFINE0(rt_sigreturn)
 		if (restore_tm_sigcontexts(current, &uc->uc_mcontext,
 					   &uc_transact->uc_mcontext))
 			goto badframe;
-	}
+	} else
 #endif
-	/* Fall through, for non-TM restore */
-	if (!MSR_TM_ACTIVE(msr)) {
+	{
 		/*
+		 * Fall through, for non-TM restore
+		 *
 		 * Unset MSR[TS] on the thread regs since MSR from user
 		 * context does not have MSR active, and recheckpoint was
 		 * not called since restore_tm_sigcontexts() was not called


