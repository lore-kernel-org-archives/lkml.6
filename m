Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFAE20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeY2WD9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFAE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeLEJln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbeLEJlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:40 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C6E2084C;
        Wed,  5 Dec 2018 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002898;
        bh=g4o0eXPK8XctBxCpZ+SaN2+4+DO7Dcm43ogEwVLU7e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeY2WD9PubYdk9sw9yiMx8gBQcReuV5rrUfarHEGMIxtmWfGxkpay0lFKMDSSbR7t
         JxoMYCkwqmeX1diRKA9GZEDafSR4Q9wWqWS9BX04MNVzXwdNA9EP29B5P/6uZWL/Wl
         tsPsBzTBho672b3GkQDss5V0q/xlkKiRZD6INdM8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 104/123] pstore/ram: Correctly calculate usable PRZ bytes
Date:   Wed,  5 Dec 2018 04:35:36 -0500
Message-Id: <20181205093555.5386-104-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 89d328f637b9904b6d4c9af73c8a608b8dd4d6f8 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram.c        | 15 ++++++---------
 include/linux/pstore.h |  5 ++++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index f4fd2e72add4..03cd59375abe 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -806,17 +806,14 @@ static int ramoops_probe(struct platform_device *pdev)
 
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

