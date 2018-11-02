Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4509C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819B82084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILCojGky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819B82084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeKCDu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeKCDuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:55 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858232084A;
        Fri,  2 Nov 2018 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184163;
        bh=QGlC5bGiuGuvYiu043agKkj4LXuJIBCsI3bh0+t2Uuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILCojGkygKzOGLEWGwyycun303yGV995B27JYXtiGGI1ERD/FuCN0cyc4nE3jOsuc
         bi7uoahteHCeofr+q5k//LYtwP45VulTd/XuY+BhUjQkVfzOG8cScYX3R32Ysb6fgX
         aaoxgBBcZgohWqGWSHduPZ0c+S3EWUJG8YO5dp3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 099/150] fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()
Date:   Fri,  2 Nov 2018 19:34:21 +0100
Message-Id: <20181102182910.288113111@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

[ Upstream commit ac081c3be3fae6d0cc3e1862507fca3862d30b67 ]

On non-preempt kernels this loop can take a long time (more than 50 ticks)
processing through entries.

Link: http://lkml.kernel.org/r/20181010172623.57033-1-khazhy@google.com
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fat/fatent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 3aef8630a4b9..95d2c716e0da 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -681,6 +681,7 @@ int fat_count_free_clusters(struct super_block *sb)
 			if (ops->ent_get(&fatent) == FAT_ENT_FREE)
 				free++;
 		} while (fat_ent_next(sbi, &fatent));
+		cond_resched();
 	}
 	sbi->free_clusters = free;
 	sbi->free_clus_valid = 1;
-- 
2.17.1



