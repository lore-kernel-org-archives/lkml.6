Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC62C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBF0218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357701;
	bh=qG1/cHiAxBwgGnjg3q1aPn0MjvfJ9DkF/0zqWGTApbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VBMWr0Dnn70x8w5kNR2KUbP9NREWmbLfLiOgN2Ozy9QEmdj897ueMClnNM0XWbc3D
	 EkzELApqXwb8X29ChzZe1ScL06tDh6QGZNDgfSCFAhDN0NqayK9fDDPVqH4oU5rTsw
	 lleBzD8XehnqIJGlIFOvBRXkX7hR8fCIY7ozUXag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfAXTVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfAXTVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:21:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8E2218CD;
        Thu, 24 Jan 2019 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357697;
        bh=qG1/cHiAxBwgGnjg3q1aPn0MjvfJ9DkF/0zqWGTApbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsmIL7s58ILdZMeEnNwg1OxSnZMPmhNbwgFQZUb3EOSrhz0OhsBIawGuQZaLqC84r
         3mdDcN40PM4P2s2r0mgNrbvgxfVd3ZgIn1dNMBLmFwsThmzvCOEJdudK2JVOwx2ED2
         2FGR84VyF26wsvSCHHRcIL2D+w4iKqZzmUm+E2pA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 01/52] sparc32: Fix inverted invalid_frame_pointer checks on sigreturns
Date:   Thu, 24 Jan 2019 20:19:25 +0100
Message-Id: <20190124190141.127425024@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Larsson <andreas@gaisler.com>

commit 07b5ab3f71d318e52c18cc3b73c1d44c908aacfa upstream.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sparc/kernel/signal_32.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -89,7 +89,7 @@ asmlinkage void do_sigreturn(struct pt_r
 	sf = (struct signal_frame __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (!invalid_frame_pointer(sf, sizeof(*sf)))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
 		goto segv_and_exit;
 
 	if (get_user(ufp, &sf->info.si_regs.u_regs[UREG_FP]))
@@ -150,7 +150,7 @@ asmlinkage void do_rt_sigreturn(struct p
 
 	synchronize_user_stack();
 	sf = (struct rt_signal_frame __user *) regs->u_regs[UREG_FP];
-	if (!invalid_frame_pointer(sf, sizeof(*sf)))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
 		goto segv;
 
 	if (get_user(ufp, &sf->regs.u_regs[UREG_FP]))


