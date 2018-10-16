Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80873C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3171F2148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBvgp0mJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3171F2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJQHre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:34 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:53828 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJQHre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:34 -0400
Received: by mail-it1-f201.google.com with SMTP id f79-v6so233773ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/cIwxaWjuX5zXpExKbickYNnSKyceHv4B+fk4+zCXKw=;
        b=OBvgp0mJoUKBhNDc6ja0qaG2wAkB/90CV8v/Kg64dnb5uhOHYgNt0vzASZj3BC/gFI
         w5LcxMMLMCl5Pwqlt2IMQ1RMPA36CUqknXp1erMIeAw1MbwYapX+oAVc5l4lND9WHFo9
         b/ix6YlvXa1qVgmRZnDewfyU7zeaO8zdj00glgldVCmtP8JZ89aX+Sfgq9tPXoY/Y1Xy
         Cq9liBf5Fw4Huhl4Rr/5/zZ/6lIIejypwAIRx87X/mHqG7psjzMbKN6ED08PYfCArJwt
         4TjkiQL5HNW274WbipUOqzDrjbYgMiR/DZfHkvBJaTbNtYquCqmH9u27BlLfYYT4rbFV
         Ahug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/cIwxaWjuX5zXpExKbickYNnSKyceHv4B+fk4+zCXKw=;
        b=r86/xJJefFLLnISANatMdqGcpIY7jvKuWnVwjRbvmqANzk5NAdvNvPcMRPOGq5ETQU
         nLnOt+Am6n5g9icy1xmYMIvu78EjGVUAaQC8hsGsr3s3pe3RZkPxdJUkEG/UWjNQRIiD
         0DUfAF9oA/L/AYBAq6nENh6vIfvrt4qubZksxTePqu9+6WmI5JuL2Mup83CqEnPJ3dUe
         50Fvu3oQCRI80NGugvXBDzo0H9qNf3cHKeQ17FlzBtO/DB+syWfXUjJWeobkSmlrsfSW
         W+EGRoQexnwrDpa5TSB4wKRCuaa8/36EGOHmW8Xo9B/njGxY+fHhNk15BbdoeJQv96gS
         TQKg==
X-Gm-Message-State: ABuFfohBP3L+eGS6EszhSK+78sDSdEe0GZRC7PhvwQFO3DsGtXW8m07W
        ULu12UpKTEo3NQjbBq2Naf46BD+h3Hjyurac5XyaSg==
X-Google-Smtp-Source: ACcGV62l5qWluLUdWqzgSRINvFIqAn0zVr+2iNoYAcJiT8V6kuklivgL4UhosQ3bkbFHrilEw3E9ehC0f6RUy2ud4LHt7A==
X-Received: by 2002:a24:fe01:: with SMTP id w1-v6mr224693ith.0.1539734085013;
 Tue, 16 Oct 2018 16:54:45 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:13 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-25-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 24/31] kunit: improved sigsegv stack trace printing
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sacrificed the control of printing stack trace within the crash handler
in the test runner for getting a better stack trace; this is still not
ideal, but much better than before.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/kernel/trap.c | 11 ++++++++++-
 kunit/test.c          | 13 +++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 9b97712daf14f..c3ff8346800c4 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -226,8 +226,17 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
 	catcher = current->thread.fault_catcher;
-	if (catcher && current->thread.is_running_test)
+	if (catcher && current->thread.is_running_test) {
+		/*
+		 * TODO(b/77223210): Right now we don't have a way to store a
+		 * copy of the stack, or a copy of information from the stack,
+		 * so we need to print it now; otherwise, the stack will be
+		 * destroyed by segv_run_catcher which works by popping off
+		 * stack frames.
+		 */
+		show_stack(NULL, NULL);
 		segv_run_catcher(catcher, (void *) address);
+	}
 	else if (!is_user && (address >= start_vm) && (address < end_vm)) {
 		flush_tlb_kernel_vm();
 		goto out;
diff --git a/kunit/test.c b/kunit/test.c
index 6ea60059b4918..5d78f76b421af 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -210,12 +210,17 @@ static void test_handle_test_crash(struct test *test,
 				   struct test_module *module,
 				   struct test_case *test_case)
 {
-	test_err(test, "%s crashed", test_case->name);
 	/*
-	 * TODO(brendanhiggins@google.com): This prints the stack trace up
-	 * through this frame, not up to the frame that caused the crash.
+	 * TODO(brendanhiggins@google.com): Right now we don't have a way to
+	 * store a copy of the stack, or a copy of information from the stack,
+	 * so we need to print it in the "trap" handler; otherwise, the stack
+	 * will be destroyed when it returns to us by popping off the
+	 * appropriate stack frames (see longjmp).
+	 *
+	 * Ideally we would print the stack trace here, but we do not have the
+	 * ability to do so with meaningful information at this time.
 	 */
-	show_stack(NULL, NULL);
+	test_err(test, "%s crashed", test_case->name);
 
 	test_case_internal_cleanup(test);
 }
-- 
2.19.1.331.ge82ca0e54c-goog

