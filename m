Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B136AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7317420844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7317420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeIHCU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:20:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbeIHCU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:20:58 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68B31D6B;
        Fri,  7 Sep 2018 21:38:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shan Hai <shan.hai@oracle.com>,
        Coly Li <colyli@suse.de>, Shenghui Wang <shhuiw@foxmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 59/63] bcache: release dc->writeback_lock properly in bch_writeback_thread()
Date:   Fri,  7 Sep 2018 23:10:30 +0200
Message-Id: <20180907211016.200223100@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shan Hai <shan.hai@oracle.com>

commit 3943b040f11ed0cc6d4585fd286a623ca8634547 upstream.

The writeback thread would exit with a lock held when the cache device
is detached via sysfs interface, fix it by releasing the held lock
before exiting the while-loop.

Fixes: fadd94e05c02 (bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set)
Signed-off-by: Shan Hai <shan.hai@oracle.com>
Signed-off-by: Coly Li <colyli@suse.de>
Tested-by: Shenghui Wang <shhuiw@foxmail.com>
Cc: stable@vger.kernel.org #4.17+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/writeback.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -456,8 +456,10 @@ static int bch_writeback_thread(void *ar
 			 * data on cache. BCACHE_DEV_DETACHING flag is set in
 			 * bch_cached_dev_detach().
 			 */
-			if (test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags))
+			if (test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags)) {
+				up_write(&dc->writeback_lock);
 				break;
+			}
 		}
 
 		up_write(&dc->writeback_lock);


