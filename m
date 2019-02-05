Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDCFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5512083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SGO4mhdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfBEPiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:38:12 -0500
Received: from mail.efficios.com ([167.114.142.138]:48452 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfBEPiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:38:11 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 075F4FBA2;
        Tue,  5 Feb 2019 10:38:10 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id jpf6cQE--O1a; Tue,  5 Feb 2019 10:38:09 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6065FFB9F;
        Tue,  5 Feb 2019 10:38:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6065FFB9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1549381089;
        bh=b5DHt8Mp1Iz3eBbkbGi36nkiHAx75LWiF4XGarel8Uk=;
        h=From:To:Date:Message-Id;
        b=SGO4mhdYKpxt934/2ifhQFZBpnYRmcJO95MNsAAJiCyZ9bIhFwVx9JrnbzEUwBqB6
         gEoddShtdeR7qK1Ha13vcfIeFzLnJEzjCdzy4xYOTjKNmIdsnQyGk77EfDNqhozdaD
         BVj1m0ztluP6WQDPGnQb85b/Zvz6LuONktoqX+SvMJ+wqBkAtlS3LuKT0n7qpvKeEE
         ttBlatIWDiSLWz7AQTHzWVQU0RtA0UlOQhBpNiiGq7KWhGBEc5bXcl/KXmDucZ0z8r
         HHm3i3fBWLKPY+PJJ519Mh2d8+T/KuQQgfAmQQzQ8f7sWt3KQm788j85JBXIxKWfVr
         LR7zqlarwI47A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id GdHa9A-vx4Bb; Tue,  5 Feb 2019 10:38:09 -0500 (EST)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 12D74FB99;
        Tue,  5 Feb 2019 10:38:09 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     patches@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "# v4 . 14+" <stable@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] Fix: arm: kprobes: optimized kprobes illegal instruction
Date:   Tue,  5 Feb 2019 10:37:40 -0500
Message-Id: <20190205153740.20942-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
FORTIFY_SOURCE") introduced a regression in optimized kprobes. It
triggers "invalid instruction" oopses when using kprobes instrumentation
through lttng and perf. This commit was introduced in kernel v4.20, and
has been backported to stable kernels 4.19 and 4.14.

This crash was also reported by Hongzhi Song on the redhat bugzilla
where the patch was originally introduced.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1639397
Link: https://bugs.lttng.org/issues/1174
Link: https://lore.kernel.org/lkml/342740659.2887.1549307721609.JavaMail.zimbra@efficios.com
Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Tested-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Acked-by: Kees Cook <keescook@chromium.org>
CC: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: William Cohen <wcohen@redhat.com>
CC: Laura Abbott <labbott@redhat.com>
CC: Kees Cook <keescook@chromium.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>
CC: <stable@vger.kernel.org> # v4.14+
CC: linux-arm-kernel@lists.infradead.org
CC: patches@armlinux.org.uk
---
KernelVersion: 5.0.0-rc5
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

