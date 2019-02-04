Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34575C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0026A20818
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Nf00teSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBDVwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:52:42 -0500
Received: from mail.efficios.com ([167.114.142.138]:39960 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBDVwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:52:41 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 362F018DC35;
        Mon,  4 Feb 2019 16:52:40 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ZKjVVbWkraIz; Mon,  4 Feb 2019 16:52:39 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9CE4918DC32;
        Mon,  4 Feb 2019 16:52:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9CE4918DC32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1549317159;
        bh=OoW4fV1D+fMhZ6BAZDHVm1gLd5FedAbDaFdPRAmniWM=;
        h=From:To:Date:Message-Id;
        b=Nf00teSIdOVt9FYA8oP0ZFtn/TmtDmIbNsnsQXipYE+i2kZJ70gmz+Qs0ZsgbAoYc
         3bg5IjLgK+3lSFecdpdEQAEJG2AHcBTLDQj00MAQPEEbt8rry8fR/q5Glz1nz1Zq7q
         pn1SH8e852PbZ65BpzEDQ6gA0EIM9aaF7YJj1mc57+08jMcDGabYRmDcNexPmKrvQa
         e/uzgAv+gET73V3vkNh+Cwp+RXbONq/C5b8z/sJtUe90BG5jIBSDk5lEymn7NZFf3C
         0fRoecCJSXgYNElcLfVx1xraXXkvwVtwkMuYSBv8Ml9S/kf8KDlSKW98rBFBjc8mHm
         koDQfNn2EKygw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id YWoSBw7tuRTI; Mon,  4 Feb 2019 16:52:39 -0500 (EST)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 647F118DC2D;
        Mon,  4 Feb 2019 16:52:39 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "# v4 . 14+" <stable@vger.kernel.org>
Subject: [PATCH 1/1] Fix: arm: kprobes: optimized kprobes illegal instruction
Date:   Mon,  4 Feb 2019 16:52:19 -0500
Message-Id: <20190204215219.5691-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e46daee53bb5 "ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE"
introduced a regression in optimized kprobes. It triggers "invalid
instruction" oopses when using kprobes instrumentation through lttng and
perf. This commit was introduced in kernel v4.20, and has been backported
to stable kernels 4.19 and 4.14.

This crash was also reported by Hongzhi Song on the redhat bugzilla
where the patch was originally introduced.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1639397
Link: https://bugs.lttng.org/issues/1174
Link: https://lore.kernel.org/lkml/342740659.2887.1549307721609.JavaMail.zimbra@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Tested-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
CC: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: William Cohen <wcohen@redhat.com>
CC: Laura Abbott <labbott@redhat.com>
CC: Kees Cook <keescook@chromium.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>
CC: <stable@vger.kernel.org> # v4.14+
---
 arch/arm/probes/kprobes/opt-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index 2c118a6ab358..0dc23fc227ed 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
 	}
 
 	/* Copy arch-dep-instance from template. */
-	memcpy(code, (unsigned char *)optprobe_template_entry,
+	memcpy(code, (unsigned long *)&optprobe_template_entry,
 			TMPL_END_IDX * sizeof(kprobe_opcode_t));
 
 	/* Adjust buffer according to instruction. */
-- 
2.11.0

