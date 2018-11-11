Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A94C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98DC22353
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1kEwHiUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98DC22353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbeKLIVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389880AbeKLIVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535B22241B;
        Sun, 11 Nov 2018 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975507;
        bh=mjv3blygUp7a7jj2K10zj82mHHt74Frp1rFkMCXkrp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1kEwHiUNKQ8H1Gntd0EgM5a1zb2Xd7JlRR4YepBtfTiU/R4xyjDWt/2tMmyAZymhc
         CfBXk+qp2pApz/RTNbYuLwwPO2h1ayl5Mw4Ll6RuQE3UEG/BUYE+tkbTWuOgBFpp/M
         5lcFIejonqOe3T+69/RcnDPwo8mNb048ApdulL2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 329/350] btrfs: release metadata before running delayed refs
Date:   Sun, 11 Nov 2018 14:23:13 -0800
Message-Id: <20181111221721.851284792@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

commit f45c752b65af46bf42963295c332865d95f97fff upstream.

We want to release the unused reservation we have since it refills the
delayed refs reserve, which will make everything go smoother when
running the delayed refs if we're short on our reservation.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/transaction.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1930,6 +1930,9 @@ int btrfs_commit_transaction(struct btrf
 		return ret;
 	}
 
+	btrfs_trans_release_metadata(trans);
+	trans->block_rsv = NULL;
+
 	/* make a pass through all the delayed refs we have so far
 	 * any runnings procs may add more while we are here
 	 */
@@ -1939,9 +1942,6 @@ int btrfs_commit_transaction(struct btrf
 		return ret;
 	}
 
-	btrfs_trans_release_metadata(trans);
-	trans->block_rsv = NULL;
-
 	cur_trans = trans->transaction;
 
 	/*


