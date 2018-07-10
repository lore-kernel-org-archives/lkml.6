Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94382C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D17E20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D17E20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbeGJS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:29:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45428 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732245AbeGJS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:29:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45F11EB4;
        Tue, 10 Jul 2018 18:29:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Whitehead <tedheadster@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 18/52] x86/cpu: Re-apply forced caps every time CPU caps are re-read
Date:   Tue, 10 Jul 2018 20:24:46 +0200
Message-Id: <20180710182451.211448595@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 60d3450167433f2d099ce2869dc52dd9e7dc9b29 upstream.

Calling get_cpu_cap() will reset a bunch of CPU features.  This will
cause the system to lose track of force-set and force-cleared
features in the words that are reset until the end of CPU
initialization.  This can cause X86_FEATURE_FPU, for example, to
change back and forth during boot and potentially confuse CPU setup.

To minimize the chance of confusion, re-apply forced caps every time
get_cpu_cap() is called.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Whitehead <tedheadster@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/c817eb373d2c67c2c81413a70fc9b845fa34a37e.1484705016.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/common.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -848,6 +848,13 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
+
+	/*
+	 * Clear/Set all flags overridden by options, after probe.
+	 * This needs to happen each time we re-probe, which may happen
+	 * several times during CPU initialization.
+	 */
+	apply_forced_caps(c);
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)


