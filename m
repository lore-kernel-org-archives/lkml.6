Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D9FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7689820892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791087;
	bh=W420lO1MlgV4JUBlAi7eZOjqqZTyEAEocg2/0SksJkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGbN4SzuRVzUAIKtFwQud6HVg4JC3HxietfV6vcT0LCdQsb3Uj59C7gaVxnWhhpux
	 R3WFcmBXTY3FFecZR5D7zQBer2Hz+m4eA1Gu+xiTmx6fDuNCoKoZgsoU9DdvSqDCUo
	 V2fHo6o4Wq+XnyWce9U3LolFb3MkA1fL3MIVnYdU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7689820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeLNMiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbeLNMF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A53C2147D;
        Fri, 14 Dec 2018 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789156;
        bh=W420lO1MlgV4JUBlAi7eZOjqqZTyEAEocg2/0SksJkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0nJBVkWDU7FPfw4F798YSsIkTcXlKIl3xPP6nanD22EF1oUcXJOoEtKdvECPdtrg
         47O3VTqI+NGZECWRMQjR4nD7M8acwcOdzH5IECay+nqLwZhbKgCnmlJDnyzYBmDrRb
         PlTF7phj4vPGVlYIUh8P2cRENptNoWtn0/yqK2l0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 115/142] pstore/ram: Correctly calculate usable PRZ bytes
Date:   Fri, 14 Dec 2018 13:00:00 +0100
Message-Id: <20181214115751.639146529@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



