Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DF020664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS8ufkyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DF020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeKAIHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbeKAIHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149D320840;
        Wed, 31 Oct 2018 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027223;
        bh=T1KXXEbo/2TZKhA3E8FGyXxqa5b5MRrLIA+lKK6BBxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oS8ufkyrU9jQ96v0oVaabJDkLc09zEG2Shpq30t7QRiomMkpgtGV8qnB2F2PdN9+Q
         jA4ytDnXe9EnX9G5Puw1LAGNGqb8Fo0M1Z55SLxTw0As4Ks4xulj+XbOXpq3pjPf+Q
         /vdKtSV+gSZdHjzeBOpJ302Et3OOZpE7EfoC2mHQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiao Ni <xni@redhat.com>, David Jeffery <djeffery@redhat.com>,
        Shaohua Li <shli@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 089/146] MD: Memory leak when flush bio size is zero
Date:   Wed, 31 Oct 2018 19:04:44 -0400
Message-Id: <20181031230541.28822-89-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiao Ni <xni@redhat.com>

[ Upstream commit af9b926de9c5986ab009e64917de87c9758bab10 ]

flush_pool is leaked when flush bio size is zero

Fixes: 5a409b4f56d5 ("MD: fix lock contention for flush bios")
Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 63ceabb4e020..06f68f19b5f3 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -452,10 +452,11 @@ static void md_end_flush(struct bio *fbio)
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
@@ -509,10 +510,11 @@ void md_flush_request(struct mddev *mddev, struct bio *bio)
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
-- 
2.17.1

