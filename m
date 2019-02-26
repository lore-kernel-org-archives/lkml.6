Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C5C218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFL9X14R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfBZXpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:45:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44105 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfBZXpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:45:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id c4so6995564pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=h9BaNE1bO4koOLx/aV3od4xE73WStlh+D014GAdjfWU=;
        b=gFL9X14Rmcq57/07UCBQ9MKb5VukmbMEAobG3o5vDgKI12nk7kt3l2+d3Avgh9srGU
         nnla/t33fIdNsOmglIR5/WpXMZ4KNuvljUwavpowYcdzdSrfLAd7fIfnGVNmiW6j7DY0
         eyrq1adGyaJ7SGjWatFx0ozwrNXg8hiQs/X7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=h9BaNE1bO4koOLx/aV3od4xE73WStlh+D014GAdjfWU=;
        b=mzB7pAHirFSfSBM5eI+1tPfw9utPQWO/qdVas37h1Cewm6uEV2D+Wj5mS9QcFBJpTn
         wATcYgniQ6d+EeZlcpfKY9KlTCP0W4CcbLKtSryVzy+tXEdNtiEPAR3X+SqDuNsB8yUN
         nzov2yg6Kgv8AInLRCJVUkroequLG7c4ZuwpsbY07Iu1mQahYTUoUJIfe+oPaCNxJkIZ
         GGb1+SEVmAZZLTr5YugVYv9LlrLs76G5udrSpsRHH3gKDPPweqHL44swm3LJuR5+lwEN
         gx6vWeocqu7W+gGAyIdL2DlYJVUr6Bm5tOH8SXCs3g9hi5XUCd7sjW5iNYKgqv7XvnaP
         ZdfA==
X-Gm-Message-State: AHQUAua0rDSZVYjYlAoFHHdKtr9drNViDf6GnL0MgN2ewbOzMRKPWkVN
        k20cy0sJ5jPezDfcBecLMksvcD7TcQs=
X-Google-Smtp-Source: AHgI3IZmNOL/dqsWwHjDJBha8d6D/YLnbrc7zMo2iOlXfymcy6kYvCrkZhtpXzujmft8sECA+xhLbw==
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr28618955pls.320.1551224732642;
        Tue, 26 Feb 2019 15:45:32 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h11sm7631375pgq.57.2019.02.26.15.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 15:45:31 -0800 (PST)
Date:   Tue, 26 Feb 2019 15:45:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] lkdtm: Check for SMEP clearing protections
Message-ID: <20190226234530.GA9209@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226233647.28547-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an x86-specific test for pinned cr4 bits. A successful test
will validate pinning and check the ROP-style call-middle-of-function
defense, if needed. For example, in the case of native_write_cr4()
looking like this:

ffffffff8171bce0 <native_write_cr4>:
ffffffff8171bce0:       48 8b 35 79 46 f2 00    mov    0xf24679(%rip),%rsi
ffffffff8171bce7:       48 09 f7                or     %rsi,%rdi
ffffffff8171bcea:       0f 22 e7                mov    %rdi,%cr4
...
ffffffff8171bd5a:       c3                      retq

The UNSET_SMEP test will jump to ffffffff8171bcea (the mov to cr4)
instead of ffffffff8171bce0 (native_write_cr4() entry) to simulate a
direct-call bypass attempt.

Expected successful results:

  # echo UNSET_SMEP > /sys/kernel/debug/provoke-crash/DIRECT
  # dmesg
  [   79.594433] lkdtm: Performing direct entry UNSET_SMEP
  [   79.596459] lkdtm: trying to clear SMEP normally
  [   79.598406] lkdtm: ok: SMEP did not get cleared
  [   79.599981] lkdtm: trying to clear SMEP with call gadget
  [   79.601810] ------------[ cut here ]------------
  [   79.603421] Attempt to unpin cr4 bits: 100000; bypass attack?!
  ...
  [   79.650170] ---[ end trace 2452ca0f6126242e ]---
  [   79.650937] lkdtm: ok: SMEP removal was reverted

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: fix 64 vs 256 loop-end comparison, use a #define instead
---
 drivers/misc/lkdtm/bugs.c  | 61 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  1 +
 drivers/misc/lkdtm/lkdtm.h |  1 +
 3 files changed, 63 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 7eebbdfbcacd..6176384b4f85 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -255,3 +255,64 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 	pr_err("FAIL: accessed page after stack!\n");
 }
+
+void lkdtm_UNSET_SMEP(void)
+{
+#ifdef CONFIG_X86_64
+#define MOV_CR4_DEPTH	64
+	void (*direct_write_cr4)(unsigned long val);
+	unsigned char *insn;
+	unsigned long cr4;
+	int i;
+
+	cr4 = native_read_cr4();
+
+	if ((cr4 & X86_CR4_SMEP) != X86_CR4_SMEP) {
+		pr_err("FAIL: SMEP not in use\n");
+		return;
+	}
+	cr4 &= ~(X86_CR4_SMEP);
+
+	pr_info("trying to clear SMEP normally\n");
+	native_write_cr4(cr4);
+	if (cr4 == native_read_cr4()) {
+		pr_err("FAIL: pinning SMEP failed!\n");
+		cr4 |= X86_CR4_SMEP;
+		pr_info("restoring SMEP\n");
+		native_write_cr4(cr4);
+		return;
+	}
+	pr_info("ok: SMEP did not get cleared\n");
+
+	/*
+	 * To test the post-write pinning verification we need to call
+	 * directly into the the middle of native_write_cr4() where the
+	 * cr4 write happens, skipping the pinning. This searches for
+	 * the cr4 writing instruction.
+	 */
+	insn = (unsigned char *)native_write_cr4;
+	for (i = 0; i < MOV_CR4_DEPTH; i++) {
+		/* mov %rdi, %cr4 */
+		if (insn[i] == 0x0f && insn[i+1] == 0x22 && insn[i+2] == 0xe7)
+			break;
+	}
+	if (i >= MOV_CR4_DEPTH) {
+		pr_info("ok: cannot locate cr4 writing call gadget\n");
+		return;
+	}
+	direct_write_cr4 = (void *)(insn + i);
+
+	pr_info("trying to clear SMEP with call gadget\n");
+	direct_write_cr4(cr4);
+	if (native_read_cr4() & X86_CR4_SMEP) {
+		pr_info("ok: SMEP removal was reverted\n");
+	} else {
+		pr_err("FAIL: cleared SMEP not detected!\n");
+		cr4 |= X86_CR4_SMEP;
+		pr_info("restoring SMEP\n");
+		native_write_cr4(cr4);
+	}
+#else
+	pr_err("FAIL: this test is x86_64-only\n");
+#endif
+}
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..fd668776414b 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -132,6 +132,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(CORRUPT_USER_DS),
+	CRASHTYPE(UNSET_SMEP),
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(CORRUPT_STACK_STRONG),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 3c6fd327e166..9c78d7e21c13 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -26,6 +26,7 @@ void lkdtm_CORRUPT_LIST_DEL(void);
 void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
+void lkdtm_UNSET_SMEP(void);
 
 /* lkdtm_heap.c */
 void lkdtm_OVERWRITE_ALLOCATION(void);
-- 
2.17.1


-- 
Kees Cook
