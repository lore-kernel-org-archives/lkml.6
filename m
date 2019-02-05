Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B86C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571FE2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S/RxLFnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfBEP2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:28:24 -0500
Received: from mail.efficios.com ([167.114.142.138]:42354 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfBEP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:28:23 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8CBA1F969;
        Tue,  5 Feb 2019 10:28:22 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Y3C_C66IFDpl; Tue,  5 Feb 2019 10:28:21 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6E9C3F966;
        Tue,  5 Feb 2019 10:28:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6E9C3F966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1549380501;
        bh=Eissxu//C6TIPi4CXUeneX0SH2fIoOeeeUuZkt6w6Lw=;
        h=From:To:Date:Message-Id;
        b=S/RxLFnYrveue9XPv8jOwHD4Saqfp+SYKCpXAv+LCukkhi61RtLCOf0GXdqO13eB4
         wua1eZ9oTTLk3kNwQMM9aemESU0H5QOeoiJKBhGSypImDqqQs2LYUAMGCtJeo6zzdN
         fG6XQqBSZYcKDWK1ssq5JUu/2WiQD1OkpCQoPz0CWUaqOfgepuCODw8Od9zX6YXmY6
         K1i2GbumhZoQEH2JK7WnWq0xnFtMQQ2JAWJfANGhCdxWzkz8TEldCyn9WdRmfi+BtK
         dgELXgyQYfg2DFrZVM3nX+hmp/jIaDhyJV1HN5DLVGFo9A+pOmNWB50q5yBLTTLfCW
         7YlRAKpMChW+w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id QUKA5d_XpPdH; Tue,  5 Feb 2019 10:28:21 -0500 (EST)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 2A326F94E;
        Tue,  5 Feb 2019 10:28:21 -0500 (EST)
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
Date:   Tue,  5 Feb 2019 10:28:06 -0500
Message-Id: <20190205152806.20340-1-mathieu.desnoyers@efficios.com>
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

