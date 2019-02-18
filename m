Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAB1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2A721908
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499601;
	bh=y7PtTaeXyw7aOi/hb5Lbau3D8T1iTw9/vGxPsqZEBXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HQhlmiGfchjVIfLmc4T+xMJ7zeFuoGM1us/7Fx0+QPVfXludvJj8J6/I5Thx7Y3Kx
	 JV6ctu9lTe/IfLL359yWmFYHRhuAnnA/pQrYJCbKNLEdWeLgr/VgaskTbTNkOyDBbb
	 y97aXDLwCXwbnuZ0stspK/4o7mmKvwr5rhccS0LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391004AbfBROUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390774AbfBROHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D415204FD;
        Mon, 18 Feb 2019 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498865;
        bh=y7PtTaeXyw7aOi/hb5Lbau3D8T1iTw9/vGxPsqZEBXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlEsDocZZebmwzdp46LOMx5m8pruf2RwYUv1ni/6AiujYexFcs2YqlvG6/OTa+h/N
         68KnSkFK8fXEwBx1A1S5Ls2v7b+wbQQBLxHBZ1EbSmj+8YWg2MLkSyamTVhEtueDU+
         ZjEi91DDJwM2/MLz4wpTa80nmNTa49CbJ8twsuBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jin, Yao" <yao.jin@linux.intel.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH 4.4 127/143] perf/core: Fix impossible ring-buffer sizes warning
Date:   Mon, 18 Feb 2019 14:44:15 +0100
Message-Id: <20190218133533.634690773@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

commit 528871b456026e6127d95b1b2bd8e3a003dc1614 upstream.

The following commit:

  9dff0aa95a32 ("perf/core: Don't WARN() for impossible ring-buffer sizes")

results in perf recording failures with larger mmap areas:

  root@skl:/tmp# perf record -g -a
  failed to mmap with 12 (Cannot allocate memory)

The root cause is that the following condition is buggy:

	if (order_base_2(size) >= MAX_ORDER)
		goto fail;

The problem is that @size is in bytes and MAX_ORDER is in pages,
so the right test is:

	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
		goto fail;

Fix it.

Reported-by: "Jin, Yao" <yao.jin@linux.intel.com>
Bisected-by: Borislav Petkov <bp@alien8.de>
Analyzed-by: Peter Zijlstra <peterz@infradead.org>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Fixes: 9dff0aa95a32 ("perf/core: Don't WARN() for impossible ring-buffer sizes")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/ring_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -637,7 +637,7 @@ struct ring_buffer *rb_alloc(int nr_page
 	size = sizeof(struct ring_buffer);
 	size += nr_pages * sizeof(void *);
 
-	if (order_base_2(size) >= MAX_ORDER)
+	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
 		goto fail;
 
 	rb = kzalloc(size, GFP_KERNEL);


