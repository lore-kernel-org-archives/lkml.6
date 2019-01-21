Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633EFC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E1A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079383;
	bh=EJ7mhCHlruBHBz7rBn73zQo/Dm4GHF6SYh1xiWP3R5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vzxnk9pCnbtjdVQBzg27A86i4SCJ4aqkbmbkBL19kfa4gIvvAeYvCf+ey/QMpGRg3
	 datTwajAffl3pphANC9EiN2KPpQZ7rpdrWL9hprxvmSefHlMTnrbQNOTBn4pNrx7z4
	 agz3AwBuLFgIb9QgyppaVNu9jUnxXLxhGEhwZjis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfAUODB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732895AbfAUOCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3CB2089F;
        Mon, 21 Jan 2019 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079372;
        bh=EJ7mhCHlruBHBz7rBn73zQo/Dm4GHF6SYh1xiWP3R5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smpy9/7hAUTrevGULM1pAv3Zq7Y5d4m7utj27y30w87UnR7ItPsto6ZFd+/qrv46u
         Pw/s9Nob9OWs5xlk7DBl2S7DPsDApZV4U+7h0WzxSEkxHTYh++sKxItffCcrxIxg5w
         58o38S8zVm1hbs60zRbDMoThzoc+F6eELGIuYyjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 82/99] loop: Fold __loop_release into loop_release
Date:   Mon, 21 Jan 2019 14:49:14 +0100
Message-Id: <20190121134917.220981242@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit 967d1dc144b50ad005e5eecdfadfbcfb399ffff6 upstream.

__loop_release() has a single call site. Fold it there. This is
currently not a huge win but it will make following replacement of
loop_index_mutex more obvious.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1642,12 +1642,15 @@ out:
 	return err;
 }
 
-static void __lo_release(struct loop_device *lo)
+static void lo_release(struct gendisk *disk, fmode_t mode)
 {
+	struct loop_device *lo;
 	int err;
 
+	mutex_lock(&loop_index_mutex);
+	lo = disk->private_data;
 	if (atomic_dec_return(&lo->lo_refcnt))
-		return;
+		goto unlock_index;
 
 	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
@@ -1657,7 +1660,7 @@ static void __lo_release(struct loop_dev
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			return;
+			goto unlock_index;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1668,12 +1671,7 @@ static void __lo_release(struct loop_dev
 	}
 
 	mutex_unlock(&loop_ctl_mutex);
-}
-
-static void lo_release(struct gendisk *disk, fmode_t mode)
-{
-	mutex_lock(&loop_index_mutex);
-	__lo_release(disk->private_data);
+unlock_index:
 	mutex_unlock(&loop_index_mutex);
 }
 


