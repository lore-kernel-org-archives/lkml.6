Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C62DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C020818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW5RKZS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0C020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbeKLJeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbeKLITK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:10 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0403E21527;
        Sun, 11 Nov 2018 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975355;
        bh=KiNOLMJVUcLjgxQf5E+uFRrFFTHKwmIGlFLBj9IfUgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SW5RKZS6sfqcwFi5atYccyBLNq8+InFIzRwzy9pH4nGy7NZf+pujoJBy6+bJOnvW0
         SYvzq3hF977XqoyyOsjt7suju0bMUoIN/iR1BMSo4cyNKbcJWpEaTRz3CXXjOFb2TL
         sLzkfGAVII0E5h52tnLtw/uH6RcaQWvf5BRLXanQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui.linux@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 009/350] bcache: correct dirty data statistics
Date:   Sun, 11 Nov 2018 14:17:53 -0800
Message-Id: <20181111221707.518232358@linuxfoundation.org>
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

From: Tang Junhui <tang.junhui.linux@gmail.com>

commit 2e17a262a2371d38d2ec03614a2675a32cef9912 upstream.

When bcache device is clean, dirty keys may still exist after
journal replay, so we need to count these dirty keys even
device in clean status, otherwise after writeback, the amount
of dirty data would be incorrect.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/super.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1131,11 +1131,12 @@ int bch_cached_dev_attach(struct cached_
 	}
 
 	if (BDEV_STATE(&dc->sb) == BDEV_STATE_DIRTY) {
-		bch_sectors_dirty_init(&dc->disk);
 		atomic_set(&dc->has_dirty, 1);
 		bch_writeback_queue(dc);
 	}
 
+	bch_sectors_dirty_init(&dc->disk);
+
 	bch_cached_dev_run(dc);
 	bcache_device_link(&dc->disk, c, "bdev");
 


