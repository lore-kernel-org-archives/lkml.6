Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D3AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FBF20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoxKIp7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FBF20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbeKLJd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387540AbeKLITS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:18 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF86216FD;
        Sun, 11 Nov 2018 22:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975361;
        bh=XezGKHYeotMynxKhgBRDcBmA40zJI0wqZ2mFUJcP1OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VoxKIp7oMWzTjxdQVFFlg9KOOjYA2Ts8CYvwuz2i/kfI7IYmbJO5v/+PkVTGA0Y/H
         Vd2CA+okEBDB6y5g8UmIqvjwmO6Em2NVxii6XJKfJEHR0fBqEOCCnYXwpUUbNBbeTe
         mJp8K6GYf0ofn/tkcrbde1TnioJlk1XneYfF3d+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 013/350] block: setup bounce bio_sets properly
Date:   Sun, 11 Nov 2018 14:17:57 -0800
Message-Id: <20181111221707.725045775@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 52990a5fb0c991ecafebdab43138b5ed41376852 upstream.

We're only setting up the bounce bio sets if we happen
to need bouncing for regular HIGHMEM, not if we only need
it for ISA devices.

Protect the ISA bounce setup with a mutex, since it's
being invoked from driver init functions and can thus be
called in parallel.

Cc: stable@vger.kernel.org
Reported-by: Ondrej Zary <linux@rainbow-software.org>
Tested-by: Ondrej Zary <linux@rainbow-software.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bounce.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

--- a/block/bounce.c
+++ b/block/bounce.c
@@ -31,6 +31,24 @@
 static struct bio_set bounce_bio_set, bounce_bio_split;
 static mempool_t page_pool, isa_page_pool;
 
+static void init_bounce_bioset(void)
+{
+	static bool bounce_bs_setup;
+	int ret;
+
+	if (bounce_bs_setup)
+		return;
+
+	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	BUG_ON(ret);
+	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
+		BUG_ON(1);
+
+	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
+	BUG_ON(ret);
+	bounce_bs_setup = true;
+}
+
 #if defined(CONFIG_HIGHMEM)
 static __init int init_emergency_pool(void)
 {
@@ -44,14 +62,7 @@ static __init int init_emergency_pool(vo
 	BUG_ON(ret);
 	pr_info("pool size: %d pages\n", POOL_SIZE);
 
-	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
-	BUG_ON(ret);
-	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
-		BUG_ON(1);
-
-	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
-	BUG_ON(ret);
-
+	init_bounce_bioset();
 	return 0;
 }
 
@@ -86,6 +97,8 @@ static void *mempool_alloc_pages_isa(gfp
 	return mempool_alloc_pages(gfp_mask | GFP_DMA, data);
 }
 
+static DEFINE_MUTEX(isa_mutex);
+
 /*
  * gets called "every" time someone init's a queue with BLK_BOUNCE_ISA
  * as the max address, so check if the pool has already been created.
@@ -94,14 +107,20 @@ int init_emergency_isa_pool(void)
 {
 	int ret;
 
-	if (mempool_initialized(&isa_page_pool))
+	mutex_lock(&isa_mutex);
+
+	if (mempool_initialized(&isa_page_pool)) {
+		mutex_unlock(&isa_mutex);
 		return 0;
+	}
 
 	ret = mempool_init(&isa_page_pool, ISA_POOL_SIZE, mempool_alloc_pages_isa,
 			   mempool_free_pages, (void *) 0);
 	BUG_ON(ret);
 
 	pr_info("isa pool size: %d pages\n", ISA_POOL_SIZE);
+	init_bounce_bioset();
+	mutex_unlock(&isa_mutex);
 	return 0;
 }
 


