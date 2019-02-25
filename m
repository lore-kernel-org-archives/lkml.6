Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B064AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3DB2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130089;
	bh=4xO8Pzn4ynfJuC0DrBhdjhNHPWp2Wt28CqB7qf23XHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zai9oOVdNl40+HPRgJrN3J0kfez23hQ1WGHcZuRtVCA5wp7FnuqjM5Xg8651PScHV
	 VHom1QprSTqp3/BT3eo4uqa26/6SQQAGfjoLZeYf+z4JFjiWv5sJINd0HpBiC4ZNjJ
	 wx1DzU8AQsx6tOZWJAGVubHLdvf71ZOJ8RMtOHUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfBYV2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731808AbfBYV2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38EB0213A2;
        Mon, 25 Feb 2019 21:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130082;
        bh=4xO8Pzn4ynfJuC0DrBhdjhNHPWp2Wt28CqB7qf23XHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIjspxjkUDHLzjina7MGlAuBiqFzUhLDecsg2qlaIp2oky+u3ira5lowJc2nlVUJO
         Zro63wxPR8cDeDU3Lk4xDI/0SNBcJHtQSX6mHmWirwj0HvXQbWd2ff8rv7BOpEEZle
         rHsPV/Z0gfR1LGUFHy0QCHH9wcMc6IyOeTSS9TsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.20 001/183] ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction
Date:   Mon, 25 Feb 2019 22:09:34 +0100
Message-Id: <20190225195054.951789086@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c upstream.

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
Cc: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org> # v4.14+
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
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
-	memcpy(code, (unsigned char *)optprobe_template_entry,
+	memcpy(code, (unsigned long *)&optprobe_template_entry,
 			TMPL_END_IDX * sizeof(kprobe_opcode_t));
 
 	/* Adjust buffer according to instruction. */


