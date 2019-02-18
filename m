Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0AF2077B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498169;
	bh=kuSksr68v4wttPCml9hDtdGbSwJCSp1GlLmCa+8guKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5Y7bFcg15Rh2WR/V0W6JxwHYCo7rv9EtSHWyKdgcvE3KBu86KwRKUCwyva7CC8/y
	 0kpQF6WeIcde9HB/o4s+ygnSIViOhag1C3ImhMYX/25dMZDtOlJn5wMonc6nOcUQoR
	 uRpV2vQddk89nOo4t6Ps4eNZFQF8qo2wtB693AzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfBRN4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfBRN4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5A220842;
        Mon, 18 Feb 2019 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498160;
        bh=kuSksr68v4wttPCml9hDtdGbSwJCSp1GlLmCa+8guKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnbYqk4gSunw2FJyVklSVo84C2iSUNLH1tqjDfUePrqrr0cKVYMQ10jRsOYK0We8r
         3kuknoaQRxX4rA4oIXOFL61c5WtVBDmrFev4YU/xYAbQ/TmQyonAw+DUSYmc57G/Is
         zwXBj4MJFxvGpeYiGwOW4ooNdkViiFUIrGUNAOeA=
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
Subject: [PATCH 4.14 42/62] perf/core: Fix impossible ring-buffer sizes warning
Date:   Mon, 18 Feb 2019 14:43:48 +0100
Message-Id: <20190218133509.482525110@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -719,7 +719,7 @@ struct ring_buffer *rb_alloc(int nr_page
 	size = sizeof(struct ring_buffer);
 	size += nr_pages * sizeof(void *);
 
-	if (order_base_2(size) >= MAX_ORDER)
+	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
 		goto fail;
 
 	rb = kzalloc(size, GFP_KERNEL);


