Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA396C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE15020855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543853;
	bh=sIiJv8f773/KtXrqifesFxWZo52tXbRoN97aCtG6sSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ECXsBsBiLRtxff5JI07/QYkArT8hwCtCu7PqcwsK7KMHaHppY/IRnCtwGk7ZzVQK6
	 F7jcAmfHuEBQCOLuxMUu/aTmmg8ZUW4c1NEzEjrLZKGjuVQWVryNKsIR3SBfc0/DLL
	 RLGe3OeFbJXq0tj0IrnyVDUeBRYInRIeuZ6q5hXI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE15020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeLKP5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbeLKP53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED93F205C9;
        Tue, 11 Dec 2018 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543848;
        bh=sIiJv8f773/KtXrqifesFxWZo52tXbRoN97aCtG6sSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEhe3wU8iInNL318AzntcJFKEbqNdk1G7zXDQ8WNaRWB42adUM6kMPsJe/XKLIPfj
         JVZMnCMlPBIWBZByIi6i6MHbluITyHrJ7PFL2XKSfTQKWW7LXjGKlAFtnYPHqq5tw6
         xAND1mbYXoo4qZVC8lGbm4D2GUFAdIRSI8YeQoOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.19 088/118] ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
Date:   Tue, 11 Dec 2018 16:41:47 +0100
Message-Id: <20181211151647.822266181@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit e46daee53bb50bde38805f1823a182979724c229 upstream.

The arm compiler internally interprets an inline assembly label
as an unsigned long value, not a pointer. As a result, under
CONFIG_FORTIFY_SOURCE, the address of a label has a size of 4 bytes,
which was tripping the runtime checks. Instead, we can just cast the label
(as done with the size calculations earlier).

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1639397

Reported-by: William Cohen <wcohen@redhat.com>
Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
Cc: stable@vger.kernel.org
Acked-by: Laura Abbott <labbott@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: William Cohen <wcohen@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct
 	}
 
 	/* Copy arch-dep-instance from template. */
-	memcpy(code, &optprobe_template_entry,
+	memcpy(code, (unsigned char *)optprobe_template_entry,
 			TMPL_END_IDX * sizeof(kprobe_opcode_t));
 
 	/* Adjust buffer according to instruction. */


