Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDE0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DCC223AE
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqjGesQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DCC223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbeKLIRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbeKLIRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:33 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17ED5214E0;
        Sun, 11 Nov 2018 22:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975258;
        bh=kyp9eh3FMcDiVTElO+0tcH8yFewdKMb2R8XEgKVPc6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqjGesQASjqkOXwlDoqMIG5OzXZk7qeiWmRsolJmAirLqpiUnmGZqAp9rcgQCWifU
         2QhwPdQF5+S818f6KgRks+kuyXi1SKdDzjxnGN3RI+6P925RrWPsjbdTuwFcohAt6i
         N7LL1KcEfh4T/OKq4Ij26PhBbDkXc3xGenE6Aeoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Xiao Ni <xni@redhat.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 134/361] MD: Memory leak when flush bio size is zero
Date:   Sun, 11 Nov 2018 14:18:01 -0800
Message-Id: <20181111221639.154959645@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiao Ni <xni@redhat.com>

[ Upstream commit af9b926de9c5986ab009e64917de87c9758bab10 ]

flush_pool is leaked when flush bio size is zero

Fixes: 5a409b4f56d5 ("MD: fix lock contention for flush bios")
Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -452,10 +452,11 @@ static void md_end_flush(struct bio *fbi
 	rdev_dec_pending(rdev, mddev);
 
 	if (atomic_dec_and_test(&fi->flush_pending)) {
-		if (bio->bi_iter.bi_size == 0)
+		if (bio->bi_iter.bi_size == 0) {
 			/* an empty barrier - all done */
 			bio_endio(bio);
-		else {
+			mempool_free(fi, mddev->flush_pool);
+		} else {
 			INIT_WORK(&fi->flush_work, submit_flushes);
 			queue_work(md_wq, &fi->flush_work);
 		}
@@ -509,10 +510,11 @@ void md_flush_request(struct mddev *mdde
 	rcu_read_unlock();
 
 	if (atomic_dec_and_test(&fi->flush_pending)) {
-		if (bio->bi_iter.bi_size == 0)
+		if (bio->bi_iter.bi_size == 0) {
 			/* an empty barrier - all done */
 			bio_endio(bio);
-		else {
+			mempool_free(fi, mddev->flush_pool);
+		} else {
 			INIT_WORK(&fi->flush_work, submit_flushes);
 			queue_work(md_wq, &fi->flush_work);
 		}


