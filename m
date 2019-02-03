Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5FAC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B0A2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfBCOUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55564 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730139AbfBCOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:49 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdb-0006MG-Q8; Sun, 03 Feb 2019 14:20:47 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006si-6w; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Coly Li" <colyli@suse.de>,
        "Tang Junhui" <tang.junhui.linux@gmail.com>,
        "Jens Axboe" <axboe@kernel.dk>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.992021791@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 069/305] bcache: fix miss key refill->end in writeback
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2354,7 +2354,7 @@ static int refill_keybuf_fn(struct btree
 	struct keybuf *buf = refill->buf;
 	int ret = MAP_CONTINUE;
 
-	if (bkey_cmp(k, refill->end) >= 0) {
+	if (bkey_cmp(k, refill->end) > 0) {
 		ret = MAP_DONE;
 		goto out;
 	}

