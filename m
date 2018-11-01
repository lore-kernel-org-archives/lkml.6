Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7620BECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39711205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvGXcWzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39711205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeKBI5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44555 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeKBI5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3-v6so94854pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lrjVa4iTLl9nQXBs4uXosWRG47+s0LvlTKQZsRmWgZU=;
        b=gvGXcWzu0Wgd4cp9EC/yrHWfWiRY49LiSR1slTgY++7NUxGMyCxjgmujYMwJjHcRLd
         L8k9ej3LedPxqAcGRjNVeApUpreJyQWM2N0muoVg4g5hywuqpWiws44wmHSBKtVj3tjI
         6KUrJzErjXgnycoOrl+KZoJd2FqlSH2SX5ahU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lrjVa4iTLl9nQXBs4uXosWRG47+s0LvlTKQZsRmWgZU=;
        b=j/ylMHBGOOUA4O1QrW+LMQ/9nzyY4cZ0LQ+PNmiUhqgOlwj6esTuvlOGURFnpacEC7
         AKQY7NHWkGziu8kQH6p+JmKSITRRJZUiLOQVCmBiFgSf5snbdn+Z3WwZgK2lYxrdw6zV
         rZw5R3M4tFCJ/q1NsTf38OTMN+N9H+Rp55Kq5MVtyIlmUxL1/rF1nkoGQ9BKgXilLxb+
         BvrOIzSWIiFdV0YwPrc3iqKnbrhhi7ThxeCVQNAjNW/4U87NAdJo7ygSMt9SbVsrpRxs
         s15I87xDUhAj8MgfULGY54/HrVJJ8BYV8Kn0ZyjBuWaVPnFe5aMkiIpUg+xmaoMdFf9K
         TTBw==
X-Gm-Message-State: AGRZ1gIs2ALdvRl9cUMjueQ/RFzMF4F3stLiU7IJw4q6LTivIayclOF3
        WYsHY33jNGMhNaEHTps37M7mgw==
X-Google-Smtp-Source: AJdET5dL9qCP+/r0lRSnJrz/CgL45BUyRQHlMcaHQQTzUZdlPoYqhr9YZwhHXt73xxtLiroD6FafLQ==
X-Received: by 2002:a63:b04f:: with SMTP id z15-v6mr8996113pgo.442.1541116332242;
        Thu, 01 Nov 2018 16:52:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t4-v6sm36305861pfb.44.2018.11.01.16.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 8/8] pstore/ram: Correctly calculate usable PRZ bytes
Date:   Thu,  1 Nov 2018 16:52:00 -0700
Message-Id: <20181101235200.28584-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101235200.28584-1-keescook@chromium.org>
References: <20181101235200.28584-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual number of bytes stored in a PRZ is smaller than the
bytes requested by platform data, since there is a header on each
PRZ. Additionally, if ECC is enabled, there are trailing bytes used
as well. Normally this mismatch doesn't matter since PRZs are circular
buffers and the leading "overflow" bytes are just thrown away. However, in
the case of a compressed record, this rather badly corrupts the results.

This corruption was visible with "ramoops.mem_size=204800 ramoops.ecc=1".
Any stored crashes would not be uncompressable (producing a pstorefs
"dmesg-*.enc.z" file), and triggering errors at boot:

  [    2.790759] pstore: crypto_comp_decompress failed, ret = -22!

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Fixes: b0aad7a99c1d ("pstore: Add compression support to pstore")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c        | 15 ++++++---------
 include/linux/pstore.h |  5 ++++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 25bede911809..10ac4d23c423 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -814,17 +814,14 @@ static int ramoops_probe(struct platform_device *pdev)
 
 	cxt->pstore.data = cxt;
 	/*
-	 * Console can handle any buffer size, so prefer LOG_LINE_MAX. If we
-	 * have to handle dumps, we must have at least record_size buffer. And
-	 * for ftrace, bufsize is irrelevant (if bufsize is 0, buf will be
-	 * ZERO_SIZE_PTR).
+	 * Since bufsize is only used for dmesg crash dumps, it
+	 * must match the size of the dprz record (after PRZ header
+	 * and ECC bytes have been accounted for).
 	 */
-	if (cxt->console_size)
-		cxt->pstore.bufsize = 1024; /* LOG_LINE_MAX */
-	cxt->pstore.bufsize = max(cxt->record_size, cxt->pstore.bufsize);
-	cxt->pstore.buf = kmalloc(cxt->pstore.bufsize, GFP_KERNEL);
+	cxt->pstore.bufsize = cxt->dprzs[0]->buffer_size;
+	cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
 	if (!cxt->pstore.buf) {
-		pr_err("cannot allocate pstore buffer\n");
+		pr_err("cannot allocate pstore crash dump buffer\n");
 		err = -ENOMEM;
 		goto fail_clear;
 	}
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 3549f2ba865c..f46e5df76b58 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -90,7 +90,10 @@ struct pstore_record {
  *
  * @buf_lock:	spinlock to serialize access to @buf
  * @buf:	preallocated crash dump buffer
- * @bufsize:	size of @buf available for crash dump writes
+ * @bufsize:	size of @buf available for crash dump bytes (must match
+ *		smallest number of bytes available for writing to a
+ *		backend entry, since compressed bytes don't take kindly
+ *		to being truncated)
  *
  * @read_mutex:	serializes @open, @read, @close, and @erase callbacks
  * @flags:	bitfield of frontends the backend can accept writes for
-- 
2.17.1

