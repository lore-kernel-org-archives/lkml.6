Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE41C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAB3213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAB3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeJAUyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:54:45 -0400
Received: from verein.lst.de ([213.95.11.211]:37889 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbeJAUyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:54:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 331EE68BC7; Mon,  1 Oct 2018 16:16:43 +0200 (CEST)
To:     Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v3 1/4] DYNAMIC_FTRACE configurable with and without REGS
In-Reply-To: <20181001140910.086E768BC7@newverein.lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de>
Message-Id: <20181001141643.331EE68BC7@newverein.lst.de>
Date:   Mon,  1 Oct 2018 16:16:43 +0200 (CEST)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 06aeaaeabf69da4, many ftrace-related config options are
consolidated. By accident, I guess, the choice about DYNAMIC_FTRACE
and DYNAMIC_FTRACE_WITH_REGS is no longer available explicitly but
determined by the sole availability on the architecture.

This makes it hard to introduce DYNAMIC_FTRACE_WITH_REGS if it depends
on new compiler features or other new properties of the toolchain
without breaking existing configurations.

This patch turns the def_bool into an actual choice. Should the toolchain
not meet the requirements for _WITH_REGS it can be turned off.

Signed-off-by: Torsten Duwe <duwe@suse.de>


--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -508,9 +508,15 @@ config DYNAMIC_FTRACE
 	  otherwise has native performance as long as no tracing is active.
 
 config DYNAMIC_FTRACE_WITH_REGS
-	def_bool y
+	bool "Include register content tracking in dynamic ftrace facility"
+	default y
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
+	help
+	  This architecture supports the inspection of register contents,
+	  as passed between functions, at the dynamic ftrace points.
+	  This is also a prerequisite for Kernel Live Patching (KLP).
+	  When in doubt, say Y.
 
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"
