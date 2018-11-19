Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBEBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234402147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNnBllJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234402147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404194AbeKTDU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404007AbeKTDU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:20:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F692147A;
        Mon, 19 Nov 2018 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646572;
        bh=1+rAxTvgfV4OcR0KV84OlVpwWzvR+++N8qctT5PH3U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNnBllJt/nNKdETwKUApFKV7OWhU/tuh2x1SWcmXDJS4gsQ941S5L3XC3rZV3snSA
         i8W/U11N/d7M+Q8L25Cv5MLMjdc3Tn0tdz/rPakbqOX/QhnWU7KoEUi1SJKleQp1Xl
         5kQJO7bBxIRKCU9YKNW29ZLZc94/Ksq7hDFogGdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui.linux@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 001/160] bcache: fix miss key refill->end in writeback
Date:   Mon, 19 Nov 2018 17:27:20 +0100
Message-Id: <20181119162630.228835543@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui.linux@gmail.com>

commit 2d6cb6edd2c7fb4f40998895bda45006281b1ac5 upstream.

refill->end record the last key of writeback, for example, at the first
time, keys (1,128K) to (1,1024K) are flush to the backend device, but
the end key (1,1024K) is not included, since the bellow code:
	if (bkey_cmp(k, refill->end) >= 0) {
		ret = MAP_DONE;
		goto out;
	}
And in the next time when we refill writeback keybuf again, we searched
key start from (1,1024K), and got a key bigger than it, so the key
(1,1024K) missed.
This patch modify the above code, and let the end key to be included to
the writeback key buffer.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/btree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2372,7 +2372,7 @@ static int refill_keybuf_fn(struct btree
 	struct keybuf *buf = refill->buf;
 	int ret = MAP_CONTINUE;
 
-	if (bkey_cmp(k, refill->end) >= 0) {
+	if (bkey_cmp(k, refill->end) > 0) {
 		ret = MAP_DONE;
 		goto out;
 	}


