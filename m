Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C258FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788F02084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK6uhC+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788F02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbeKLIQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbeKLIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:54 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30AB621527;
        Sun, 11 Nov 2018 22:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975219;
        bh=CuyEFBEWLYmhb94IMfLbUQJ5VmZwNoNhizxEjahO2S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZK6uhC+6mFAYf3r0YPiiEgKGh51nxevkG+2/34nVAfOmcwLW97wJEzf5LqxEioZTD
         dIBGO10/NoN48adaAD5+CoKRk5jGofuKC2ikHe+NaWBg7uBzZRtggt6HbLH1RQ2oun
         NfXJeGSjLiKiXzxY9OJy4PfuNCF94YM1e2yUcDuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 020/361] block: make sure writesame bio is aligned with logical block size
Date:   Sun, 11 Nov 2018 14:16:07 -0800
Message-Id: <20181111221622.535130111@linuxfoundation.org>
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

From: Ming Lei <ming.lei@redhat.com>

commit 34ffec60b27aa81d04e274e71e4c6ef740f75fc7 upstream.

Obviously the created writesame bio has to be aligned with logical block
size, and use bio_allowed_max_sectors() to retrieve this number.

Cc: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Xiao Ni <xni@redhat.com>
Cc: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Fixes: b49a0871be31a745b2ef ("block: remove split code in blkdev_issue_{discard,write_same}")
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -161,7 +161,7 @@ static int __blkdev_issue_write_same(str
 		return -EOPNOTSUPP;
 
 	/* Ensure that max_write_same_sectors doesn't overflow bi_size */
-	max_write_same_sectors = UINT_MAX >> 9;
+	max_write_same_sectors = bio_allowed_max_sectors(q);
 
 	while (nr_sects) {
 		bio = next_bio(bio, 1, gfp_mask);


