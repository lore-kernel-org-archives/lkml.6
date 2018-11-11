Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5172220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEGoWwrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5172220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbeKLITm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387859AbeKLITk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:40 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D039622360;
        Sun, 11 Nov 2018 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975383;
        bh=t8ycP9LjGEeI0d2lYVhk5OX49lFhubf7eI0DN0hcFSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEGoWwrtjEhvpGsXNDTzvvVYDAS7lh/cyDDCtMOsWwymzTzkP1VL1ntrDWjlXZz7f
         gURbKh6dx3qZooO9ybRH120I/u+ArHhAn15fTEgCOnn0unCii9QIMzZ0ZXEbP51aoS
         YGUZXZsgBPQHLwDHm/L/43mfLwX++vhVmkccImb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 058/350] x86/fpu: Remove second definition of fpu in __fpu__restore_sig()
Date:   Sun, 11 Nov 2018 14:18:42 -0800
Message-Id: <20181111221709.588222087@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 6aa676761d4c1acfa31320e55fa1f83f3fcbbc7a ]

Commit:

  c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert it to fpu->fpstate_active")

introduced the 'fpu' variable at top of __restore_xstate_sig(),
which now shadows the other definition:

  arch/x86/kernel/fpu/signal.c:318:28: warning: symbol 'fpu' shadows an earlier one
  arch/x86/kernel/fpu/signal.c:271:20: originally declared here

Remove the shadowed definition of 'fpu', as the two definitions are the same.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert it to fpu->fpstate_active")
Link: http://lkml.kernel.org/r/20181016202525.29437-3-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/fpu/signal.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -314,7 +314,6 @@ static int __fpu__restore_sig(void __use
 		 * thread's fpu state, reconstruct fxstate from the fsave
 		 * header. Validate and sanitize the copied state.
 		 */
-		struct fpu *fpu = &tsk->thread.fpu;
 		struct user_i387_ia32_struct env;
 		int err = 0;
 


