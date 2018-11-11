Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD91FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F6F214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPWHFk8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F6F214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbeKLIjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404336AbeKLIXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:18 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0559F21582;
        Sun, 11 Nov 2018 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975601;
        bh=KSeLQHAnSfOy6LeboWhKm0EnyMJZgIh/XPON6JKrl0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPWHFk8eTenycLG4cJrpDPF1KGOGrEGJztSeU2QHlaGBn3Umspakntc2UF4ccgEAg
         E7+MjJhXzdfSanRESFlp2hWqe4mlrbBLaaUmTdYK7PSSyzMwh+DAZ/6q9sOtiuLHiz
         okjr4SQdgkMS3bYLwZlxhBJB5uT41MxGwpBwr1Mw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 216/222] btrfs: dont run delayed_iputs in commit
Date:   Sun, 11 Nov 2018 14:25:13 -0800
Message-Id: <20181111221705.695071899@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 30928e9baac238a7330085a1c5747f0b5df444b4 upstream.

This could result in a really bad case where we do something like

evict
  evict_refill_and_join
    btrfs_commit_transaction
      btrfs_run_delayed_iputs
        evict
          evict_refill_and_join
            btrfs_commit_transaction
... forever

We have plenty of other places where we run delayed iputs that are much
safer, let those do the work.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/transaction.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2307,15 +2307,6 @@ int btrfs_commit_transaction(struct btrf
 
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
 
-	/*
-	 * If fs has been frozen, we can not handle delayed iputs, otherwise
-	 * it'll result in deadlock about SB_FREEZE_FS.
-	 */
-	if (current != fs_info->transaction_kthread &&
-	    current != fs_info->cleaner_kthread &&
-	    !test_bit(BTRFS_FS_FROZEN, &fs_info->flags))
-		btrfs_run_delayed_iputs(fs_info);
-
 	return ret;
 
 scrub_continue:


