Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50093ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264692157C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264692157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJUDHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:07:48 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35996 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJUDHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:07:48 -0400
Received: by mail-yb1-f195.google.com with SMTP id w16-v6so1877496ybp.3;
        Sat, 20 Oct 2018 11:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L0Pq2h/W1f/KYzbrrTowNUuevgyASLGv6InK8Va0E1U=;
        b=ewQOpztj2I0W0+6wPbNGobLJiJAII8mINwrQXZyIxwnKMSxYYL0iey0raX+qNVt9YW
         5tt8rWTqCh/DoNFcyEDOpTFJaK0pd28OnE/FO/5Vpw64tS8/wIPAL4G+vgDLumXcrciR
         byA89Mrld5iT82uGk2WgBYN43BlfhKxxX3H8VthPk5WRggxaatvcBmnXPqbMErl3soEF
         hJUN4VZdxHGB5Bhw0nBN43gWI2MclWpNkZTxLpBdQ9xwpmmEiO5oNjSb3tsVqW4kS6JD
         SEBOqD/13lKhEOcs50o+SdwvnrMRAZAIIZTpkqbhhJFvgAPHxaScYKPfDxNjJrBEbRX4
         VkrQ==
X-Gm-Message-State: ABuFfoi+onzAUoD3iW3h+Kkq9Y/f7Ub5gryrHlvqp4a1ZgVrsxgNErfg
        /ZqG2wzdL9Lg/EMJdxPDU7g=
X-Google-Smtp-Source: ACcGV62QcjZJ5yqgOFNNTr8TrQWepjlmv4VHXaNBk0GkduVfY+YhYN9heIlg/OqqXOYOzjLlYmuSvw==
X-Received: by 2002:a25:bd05:: with SMTP id f5-v6mr6303567ybk.415.1540061785660;
        Sat, 20 Oct 2018 11:56:25 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.3])
        by smtp.gmail.com with ESMTPSA id h63-v6sm1977456ywb.110.2018.10.20.11.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 11:56:24 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 1/2] blkcg: fix edge case for blk_get_rl() under memory pressure
Date:   Sat, 20 Oct 2018 14:56:11 -0400
Message-Id: <20181020185612.51587-2-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181020185612.51587-1-dennis@kernel.org>
References: <20181020185612.51587-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for blkg creation to fail when in blk_get_rl(). In this
situation, the fallback logic returns the nearest created blkg. There is
however special handling for the request_list for the root blkcg. This
fixes the missing edge case from the earlier series changing
blk_get_rl().

Fixes: e2b0989954ae ("blkcg: cleanup and make blk_get_rl use blkg_lookup_create")
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 include/linux/blk-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b7fd08013de2..1e76ceebeb5d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -597,7 +597,7 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	if (unlikely(!blkg))
 		blkg = __blkg_lookup_create(blkcg, q);
 
-	if (!blkg_tryget(blkg))
+	if (blkg->blkcg == &blkcg_root || !blkg_tryget(blkg))
 		goto rl_use_root;
 
 	rcu_read_unlock();
-- 
2.17.1

