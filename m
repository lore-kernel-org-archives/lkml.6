Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F200AC65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B367C20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWd+hOYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B367C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeJEPLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33122 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbeJEPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so3198694wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M974k2iyDJIOjsCt9yr954r2LChEqIlYPLi3JqN8ezM=;
        b=MWd+hOYP/XT8JhDN37zPYJpwEJYaMjz+DGw/Gv25gw+eg0s/a5gjnsTq2fxMFRjXfa
         XOMVBcpP7CyWqNHbBWmey7hjHyMNnG+gxrzc/jDFOObGBsroeG0GPzJLFwCtev3yPYQp
         vVyxleV0C7JUqQAW22vpLbZCcIWLOpw1cxhDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M974k2iyDJIOjsCt9yr954r2LChEqIlYPLi3JqN8ezM=;
        b=S3OJbaNXf01x3dL6PRKNk8CArExdDMpYeJpJq/XQR+7f45+SusiWL042j6mqyINvU7
         gpHa80Fk/AfbI7EWHH5bNrmitfP9aTX/v8RzMhiRajh6wFHpk6gmuGcWSMWGxYwCIoeZ
         B4+JDokLGGScpnj/yHStic4YejoPHfun5az9Y7otvUwWSBcur/KiJwwCvhLllidcQVw/
         3Q+HrYEl2PxfGPU65VznPrfxr2CpANaKLPrObl53ECA8Mb/KraE+YPCVV5+HkwX81B0L
         I67kBBhq+CfbA2knGym9+ZwTOx5FbAFg74CsIi0KlWqLrebLzrhHgLW8tEhIAfw6GdIY
         a8Kg==
X-Gm-Message-State: ABuFfoggDQ5Rtptf68p3s9W20q/Imk7whzT0fB/ecLiHP8BOqCnvq5hF
        QKmSQhgDIBLCHADrZZ9I152gncywoc4=
X-Google-Smtp-Source: ACcGV614x+adL4bvBW2ETzXeZ17LWqoKCU2QTWwE8UtRdZ8cX4K5Bkp1v89Z9ZQ2IkgyOmpJzyMJig==
X-Received: by 2002:a1c:9901:: with SMTP id b1-v6mr4381093wme.15.1538727220155;
        Fri, 05 Oct 2018 01:13:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:39 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/9] kernel: add support for patchable function pointers
Date:   Fri,  5 Oct 2018 10:13:25 +0200
Message-Id: <20181005081333.15018-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function pointer abstraction that can be implemented by the arch
in a manner that avoids the downsides of function pointers, i.e., the
fact that they are typically located in a writable data section, and
their vulnerability to Spectre like defects.

The FFP (or fast function pointer) is callable as a function, since
the generic incarnation is simply that. However, due to the fact that
C does not distinguish between functions and function pointers at the
call site, the architecture can instead emit it as a patchable sequence
of instructions consisting of ordinary branches.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig        |  3 ++
 include/linux/ffp.h | 43 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..2af3442a61d3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -862,6 +862,9 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config HAVE_ARCH_FFP
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/ffp.h b/include/linux/ffp.h
new file mode 100644
index 000000000000..8fc3b4c9b38f
--- /dev/null
+++ b/include/linux/ffp.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_FFP_H
+#define __LINUX_FFP_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+#ifdef CONFIG_HAVE_ARCH_FFP
+#include <asm/ffp.h>
+#else
+
+struct ffp {
+	void	(**fn)(void);
+	void	(*default_fn)(void);
+};
+
+#define DECLARE_FFP(_fn, _def)						\
+	extern typeof(_def) *_fn;					\
+	extern struct ffp const __ffp_ ## _fn
+
+#define DEFINE_FFP(_fn, _def)						\
+	typeof(_def) *_fn = &_def;					\
+	struct ffp const __ffp_ ## _fn					\
+		= { (void(**)(void))&_fn, (void(*)(void))&_def };	\
+	EXPORT_SYMBOL(__ffp_ ## _fn)
+
+static inline void ffp_set_target(const struct ffp *m, void *new_fn)
+{
+	WRITE_ONCE(*m->fn, new_fn);
+}
+
+static inline void ffp_reset_target(const struct ffp *m)
+{
+	WRITE_ONCE(*m->fn, m->default_fn);
+}
+
+#endif
+
+#define SET_FFP(_fn, _new)	ffp_set_target(&__ffp_ ## _fn, _new)
+#define RESET_FFP(_fn)		ffp_reset_target(&__ffp_ ## _fn)
+
+#endif
-- 
2.11.0

