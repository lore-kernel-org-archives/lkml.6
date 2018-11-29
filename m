Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282BEC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC8820673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TaA+cQc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC8820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeK3KSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:18:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44978 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeK3KQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so1768348pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYHL1GknfPZnGhtn8O/gU4na0wLc5ctGe1uKnMNWOT4=;
        b=TaA+cQc1/7+T5qacCyh0AAwLz3GPgtA9CMObEOi6jpamjleUWuvMh0LHBXUvpNCxL7
         9CR/2PdZuW7JNJ+nOq4FABOvs/Mp+GxIy7dONyGTgxWxhu/ff51jHPYH1LvZG3L9Hso7
         ti4Xj2pSArDeKcva/CRnBxS6xun/lvNPkW2RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYHL1GknfPZnGhtn8O/gU4na0wLc5ctGe1uKnMNWOT4=;
        b=uhkYBI30ccPB/df1i2dmOwTk1MmCiptp1XqmygqVjPW4azpCacYC6Zs/wLdsbY4g+C
         szrXkmcOFzYIdEYVITBFGvVbB0iYL9woByHbj+q7HZAw7/OgPZ9Cxij78P/avUL8UiTh
         35vIJXaFDte+985p+7DDBgmQc0NFI63lEIB2S4sGdEQ+8ejh91E8DyO8br35otCNAQ8l
         sHw8fR6kHqjN3CICifvJL1jDx39hHTBijasWuNsLwBrhnbrUBPFtQHAuX4WvZZJ9qPzK
         NqspSjPkAFbJOtASSXoNmUZHAdXz5v6fNVfVtc4UNnLWzz8KUsMkVrbgx5849++KsCsG
         Tu3w==
X-Gm-Message-State: AA+aEWZGHJzKMOSBOo7pxIKw9FRHg7PH9l9OalaQdlAXVYxitXKI6CSX
        aBLAlHo+q2cyliAIEea5s0U4+w==
X-Google-Smtp-Source: AFSGD/VRITuuXmEPfTlLIi6EbXimBJNN7RTXaXlDfh0jfXgGMjAVegg3qRAP/so5VF11tn2YxDQo8w==
X-Received: by 2002:a63:101d:: with SMTP id f29mr2927128pgl.38.1543532934634;
        Thu, 29 Nov 2018 15:08:54 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n68sm4737537pfb.62.2018.11.29.15.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 01/12] pstore/ram: Correctly calculate usable PRZ bytes
Date:   Thu, 29 Nov 2018 15:08:30 -0800
Message-Id: <20181129230841.29955-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
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

Backporting this depends on commit 70ad35db3321 ("pstore: Convert console
write to use ->write_buf")

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Fixes: b0aad7a99c1d ("pstore: Add compression support to pstore")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/ram.c        | 15 ++++++---------
 include/linux/pstore.h |  5 ++++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ffcff6516e89..e02a9039b5ea 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -816,17 +816,14 @@ static int ramoops_probe(struct platform_device *pdev)
 
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
index a15bc4d48752..30fcec375a3a 100644
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

