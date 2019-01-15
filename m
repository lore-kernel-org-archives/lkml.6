Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E91FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E10E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570679;
	bh=3lLMw0CSiPzDfPv1USGwx2YWl5qJAJS9Fs6IWusn/5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HFfEp7181+Zvd9ZC0iKuEs7LuwCl59aIG4ZEvcQe3wiNB9Al0nbO0O6SVmAxzyKrY
	 EqpDhGPoTIzMgnUSTFkPOt5GPedjrbvjTZOC0T7GFBh44KKcpKN3ZbYToJlEJygegA
	 aQRZAQfMjCpZEk84Wp19gEfhvt4iEA1kql7+XGaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfAOQoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387561AbfAOQoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417C520675;
        Tue, 15 Jan 2019 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570673;
        bh=3lLMw0CSiPzDfPv1USGwx2YWl5qJAJS9Fs6IWusn/5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8hxahvAa0kwIGUhTeojnwWgYrq/jPv/N/Ejc8kxKn2hhrZCGQ5OzaQ/d8Uctx4Hm
         8o1bo6exPudGkpC1jXX3EygiFI+si/DS+EwjNJkLhqSdVBumd+yerWR2Y6P+LlKKEr
         Ei5Kqqv3npogJWucnBIcnNY3fku1SiY9b+dd8mPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 29/57] mm/usercopy.c: no check page span for stack objects
Date:   Tue, 15 Jan 2019 17:36:10 +0100
Message-Id: <20190115154912.309319386@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

From: Qian Cai <cai@lca.pw>

commit 7bff3c06997374fb9b9991536a547b840549a813 upstream.

It is easy to trigger this with CONFIG_HARDENED_USERCOPY_PAGESPAN=y,

  usercopy: Kernel memory overwrite attempt detected to spans multiple pages (offset 0, size 23)!
  kernel BUG at mm/usercopy.c:102!

For example,

print_worker_info
char name[WQ_NAME_LEN] = { };
char desc[WORKER_DESC_LEN] = { };
  probe_kernel_read(name, wq->name, sizeof(name) - 1);
  probe_kernel_read(desc, worker->desc, sizeof(desc) - 1);
    __copy_from_user_inatomic
      check_object_size
        check_heap_object
          check_page_span

This is because on-stack variables could cross PAGE_SIZE boundary, and
failed this check,

if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
	   ((unsigned long)end & (unsigned long)PAGE_MASK)))

ptr = FFFF889007D7EFF8
end = FFFF889007D7F00E

Hence, fix it by checking if it is a stack object first.

[keescook@chromium.org: improve comments after reorder]
  Link: http://lkml.kernel.org/r/20190103165151.GA32845@beast
Link: http://lkml.kernel.org/r/20181231030254.99441-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/usercopy.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -247,7 +247,8 @@ static DEFINE_STATIC_KEY_FALSE_RO(bypass
 /*
  * Validates that the given object is:
  * - not bogus address
- * - known-safe heap or stack object
+ * - fully contained by stack (or stack frame, when available)
+ * - fully within SLAB object (or object whitelist area, when available)
  * - not in kernel text
  */
 void __check_object_size(const void *ptr, unsigned long n, bool to_user)
@@ -262,9 +263,6 @@ void __check_object_size(const void *ptr
 	/* Check for invalid addresses. */
 	check_bogus_address((const unsigned long)ptr, n, to_user);
 
-	/* Check for bad heap object. */
-	check_heap_object(ptr, n, to_user);
-
 	/* Check for bad stack object. */
 	switch (check_stack_object(ptr, n)) {
 	case NOT_STACK:
@@ -282,6 +280,9 @@ void __check_object_size(const void *ptr
 		usercopy_abort("process stack", NULL, to_user, 0, n);
 	}
 
+	/* Check for bad heap object. */
+	check_heap_object(ptr, n, to_user);
+
 	/* Check for object in kernel to avoid text exposure. */
 	check_kernel_text_object((const unsigned long)ptr, n, to_user);
 }


