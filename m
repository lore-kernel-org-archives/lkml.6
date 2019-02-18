Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C38C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B372081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500204;
	bh=tTkwjwq8E1QzwncGkvEvU5JgsPIcxIxyVLAEr2fQ52E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqYfSA7stYmxFlihSh4mDoVlqdeuKVfwDL5Uv6Y/k1SrbjebDEFOl2zqDMz5qn4kf
	 eW+HSrZ9AJJcEj55/1OGBrdXAnM238GH6PtygqF/Xj66rybW447cmUttDbt5KWQZFg
	 iwlfTn5EMnCDYLxMBueEb7gFm9JXcBBHjw2rN9fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbfBROaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388475AbfBRN67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118182070D;
        Mon, 18 Feb 2019 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498338;
        bh=tTkwjwq8E1QzwncGkvEvU5JgsPIcxIxyVLAEr2fQ52E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XmQMRgWqK7BGNkTE3sTrBJRPehZktmk39hQA/XbJk53IoAP8bnxfNmMTpgvg7wHt
         lfOaPnIU9ax/vStEtyQiWFeWOmSWTmvMkaXB70ma9vIJjiwMmbKd7l/H5zKMuHNWQ/
         /AhLT0Px6h2IK8bI16eHiJASHTsrZkY0q2mDfNJE=
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
Subject: [PATCH 4.9 37/58] perf/core: Fix impossible ring-buffer sizes warning
Date:   Mon, 18 Feb 2019 14:43:58 +0100
Message-Id: <20190218133511.494490954@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -700,7 +700,7 @@ struct ring_buffer *rb_alloc(int nr_page
 	size = sizeof(struct ring_buffer);
 	size += nr_pages * sizeof(void *);
 
-	if (order_base_2(size) >= MAX_ORDER)
+	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
 		goto fail;
 
 	rb = kzalloc(size, GFP_KERNEL);


