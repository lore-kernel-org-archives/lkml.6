Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0811C21508
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSh+6zzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0811C21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeLDLEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbeLDLEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F56E2087F;
        Tue,  4 Dec 2018 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921482;
        bh=MyNi0/ibGjfX8lttmFF/1Yf9ph80tEhY0IKXL0uK/yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSh+6zzWTaN+2PnDZZu3hUBa5nQZDvkcmdJB0yCEybeD9SzsclfjTZkdmRYj04Cbr
         7GPR7Sx2F+sPUKU7HjCnmuBCl8o78Gk/ryBvTD8jcWYQrTHr67Ga6051td3gM1E9u3
         /i7YDCAurd9iVnhDfUKZMDZr3FU4oqG2Ak9VvBAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 088/146] x86/Kconfig: Select SCHED_SMT if SMP enabled
Date:   Tue,  4 Dec 2018 11:49:34 +0100
Message-Id: <20181204103730.372543606@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit dbe733642e01dd108f71436aaea7b328cb28fd87 upstream

CONFIG_SCHED_SMT is enabled by all distros, so there is not a real point to
have it configurable. The runtime overhead in the core scheduler code is
minimal because the actual SMT scheduling parts are conditional on a static
key.

This allows to expose the scheduler's SMT state static key to the
speculation control code. Alternatively the scheduler's static key could be
made always available when CONFIG_SMP is enabled, but that's just adding an
unused static key to every other architecture for nothing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185004.337452245@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Kconfig |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -955,13 +955,7 @@ config NR_CPUS
 	  approximately eight kilobytes to the kernel image.
 
 config SCHED_SMT
-	bool "SMT (Hyperthreading) scheduler support"
-	depends on SMP
-	---help---
-	  SMT scheduler support improves the CPU scheduler's decision making
-	  when dealing with Intel Pentium 4 chips with HyperThreading at a
-	  cost of slightly increased overhead in some places. If unsure say
-	  N here.
+	def_bool y if SMP
 
 config SCHED_MC
 	def_bool y


