Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C3FECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A454E2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A454E2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbeIREgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:36:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbeIREgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:36 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 777A2C49;
        Mon, 17 Sep 2018 23:07:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 012/158] block: dont warn when doing fsync on read-only devices
Date:   Tue, 18 Sep 2018 00:40:42 +0200
Message-Id: <20180917211711.259329063@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

commit 8b2ded1c94c06f841f8c1612bcfa33c85012a36b upstream.

It is possible to call fsync on a read-only handle (for example, fsck.ext2
does it when doing read-only check), and this call results in kernel
warning.

The patch b089cfd95d32 ("block: don't warn for flush on read-only device")
attempted to disable the warning, but it is buggy and it doesn't
(op_is_flush tests flags, but bio_op strips off the flags).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 721c7fc701c7 ("block: fail op_is_write() requests to read-only partitions")
Cc: stable@vger.kernel.org	# 4.18
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2161,9 +2161,12 @@ static inline bool bio_check_ro(struct b
 {
 	const int op = bio_op(bio);
 
-	if (part->policy && (op_is_write(op) && !op_is_flush(op))) {
+	if (part->policy && op_is_write(op)) {
 		char b[BDEVNAME_SIZE];
 
+		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
+			return false;
+
 		WARN_ONCE(1,
 		       "generic_make_request: Trying to write "
 			"to read-only block-device %s (partno %d)\n",


