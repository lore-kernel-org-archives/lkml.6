Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E614C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07D5208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+JIBEAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07D5208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405237AbeKLIZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405183AbeKLIZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:24 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B36822353;
        Sun, 11 Nov 2018 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975726;
        bh=wM2L7KON328iApwinFtybaB87lHUAtfqJB0mxbU0dQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+JIBEARyhL37LkHNc6kgsvTxFzA7BLN5YGGiBxOaz5qhdQjJss6mtp/cN9CgnWpT
         2o4lK/xmt7ITxJJY2IpCM29UUoN+ATovW2T5KEb22hF4Vk8vWsEvF/H53oxGvZ8oQM
         K7P+yx3eNQTmiKfRRP7N5kVNvcm/F3rdZpNNgIF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 096/141] crypto: lrw - Fix out-of bounds access on counter overflow
Date:   Sun, 11 Nov 2018 14:25:55 -0800
Message-Id: <20181111221641.301536299@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

commit fbe1a850b3b1522e9fc22319ccbbcd2ab05328d2 upstream.

When the LRW block counter overflows, the current implementation returns
128 as the index to the precomputed multiplication table, which has 128
entries. This patch fixes it to return the correct value (127).

Fixes: 64470f1b8510 ("[CRYPTO] lrw: Liskov Rivest Wagner, a tweakable narrow block cipher mode")
Cc: <stable@vger.kernel.org> # 2.6.20+
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/lrw.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -132,7 +132,12 @@ static inline int get_index128(be128 *bl
 		return x + ffz(val);
 	}
 
-	return x;
+	/*
+	 * If we get here, then x == 128 and we are incrementing the counter
+	 * from all ones to all zeros. This means we must return index 127, i.e.
+	 * the one corresponding to key2*{ 1,...,1 }.
+	 */
+	return 127;
 }
 
 static int crypt(struct blkcipher_desc *d,


