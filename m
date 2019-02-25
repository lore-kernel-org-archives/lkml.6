Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F3B21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129599;
	bh=YUA0NAqmVtkBKSYlkXPjO0Lb2GyBoJPbuDomsv30lj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iugZe0ymChv49UbsAa9yLQDF5JjMAD22ar3QvtGXub6xz3qmfIuayVObMxXb/nfoA
	 UyL+pR3iWYMm3MCaVApzkFm8nTJaHlZDR1d7O7hEIKewH4KqFmYDKahFBJJOD4bKnn
	 t3yVFOQwiv8cy/+6+ZzumHHvejaQq643btz28/FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfBYVT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfBYVTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:19:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C885B2183F;
        Mon, 25 Feb 2019 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129592;
        bh=YUA0NAqmVtkBKSYlkXPjO0Lb2GyBoJPbuDomsv30lj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D79b95lwrdHXRR/ro8D7xj4z/FVvokLVTMY2nbmok636Zkev14kVWVrhuqcw4GSpI
         zb4820AILDFSsFKGCIE5kH/8jkvadP3E2F3CI/42y3xP+oJK8sNpss2CtVDPkp82Ho
         Z7w066b9L4dLZoGYtF1vdkW7BBR5XMMGW/i3Za7I=
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
Subject: [PATCH 4.19 001/152] ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction
Date:   Mon, 25 Feb 2019 22:09:53 +0100
Message-Id: <20190225195043.761067800@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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


