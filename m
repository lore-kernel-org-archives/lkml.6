Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9DCC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3199E214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="VrukCQR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3199E214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJISaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35522 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJISaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so683743pff.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMma1QgoNzYAJWq7mzyuRrx+HVtXHEDnfcf4uhZYrKU=;
        b=VrukCQR+K4zG+3m9erzdrqhco9bKKjEgvErBy08wMdvMoLUHyGW0BFBaz/MIXr0cT4
         2n6JWUlIgo6EG0KQXe6seCVpV5hRNc7XCCewO0iMNojj0GU2m3ttR1beVC2EInFSAGZB
         ept+gN0WhvJxnlQk6xv826fm50u+x5r7PqWXs+W4xLvv+TOBhA4I5Q7KL+SfPPS/ZxvT
         b4i/eVsH6ctCNWtIH76ofdnlAQV7c6Ofcu4fMiCbTChjVl6NZBs3O9UF4Skw3m5OJ+/I
         AgDjoOp4H3ojzXYxkKDNE9nrgpCABkRNMErlyWsdhr2XqcemKHogjl2SPetbPUnuN58/
         T4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMma1QgoNzYAJWq7mzyuRrx+HVtXHEDnfcf4uhZYrKU=;
        b=d1pqNROJNwuRM/hJ6mVvZV/uGvpPdBkyn5/I+hT8+dMGMUyyNWgL+sjpHYb2O5yeBq
         Sju/bdP2NoChhGUF6QvY/B3EWgRogsGKlPEHRkfXLK8vmpz+RoBP4gnhDv06wFgA510c
         I+WjGe3i8nse7QNzFHPvBtz60/NU7F/EOq6IP6DEQhr8IiqiurjWm5KrwR44sOFre8ze
         WTDed0bOdrQzrUdbV4A09w1/dKtw5ryAqmOq7HC+WHPha5pBPeY/SYY08qt2114RfCdS
         QSQh2D3mKMjWKrBeGTfwPJEgfrhgtiDRsVKMbZseCshq2KuytgujPLoslNbp/IFyHRJi
         LSJA==
X-Gm-Message-State: ABuFfoiPQFJoeEYthZFa/DJjcMm5FqMGJwOwq8GWtdPdAmwxdhUaNRwv
        ErgrLYaBN8QJfnOzEpH2n2qNrA==
X-Google-Smtp-Source: ACcGV63iVZ0TEo9GvllHBPN4OSIrePCrYFk3miPQsnm0tdX40ajEp4xOtUOQi2iyV2uexNH/f/qf/Q==
X-Received: by 2002:a63:1d10:: with SMTP id d16-v6mr24128416pgd.228.1539083623731;
        Tue, 09 Oct 2018 04:13:43 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:42 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/45] lightnvm: pblk: remove size and out of bounds read check
Date:   Tue,  9 Oct 2018 13:11:39 +0200
Message-Id: <20181009111215.7653-10-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I/O size and capacity checks are already done by the block layer.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 9c61c19be5dc..ba3dcb6be4c3 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -449,13 +449,6 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
 	int ret = NVM_IO_ERR;
 
-	/* logic error: lba out-of-bounds. Ignore read request */
-	if (blba >= pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
-		WARN(1, "pblk: read lba out of bounds (lba:%llu, nr:%d)\n",
-					(unsigned long long)blba, nr_secs);
-		return NVM_IO_ERR;
-	}
-
 	generic_start_io_acct(q, REQ_OP_READ, bio_sectors(bio),
 			      &pblk->disk->part0);
 
-- 
2.17.1

