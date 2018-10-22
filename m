Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F2C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEBD20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mokrBoil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEBD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeJVSlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbeJVSlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:41:09 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490C2208AE;
        Mon, 22 Oct 2018 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203794;
        bh=yUgnr2rEKP4dlaWxa1Q86JuhC+gdgZ/P8pkWCldjMhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mokrBoil3BZjOmJSOE9Gk/4m9xvMwsDhhYyOhscFBtNHZ/yRYou2guEnseuacMihF
         ZcrmUHynFJ750NmZkOgMqLv9ZrLx7SOEWGucdUKy5wH4s1kIopnK/SHGd7fMX2bFn/
         HnSoU5MdWgztrSJB4BW1ZGAn6+CaVvqPTyNVSXRg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Khazhismel Kumykov <khazhy@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 4/4] fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()
Date:   Mon, 22 Oct 2018 06:22:55 -0400
Message-Id: <20181022102255.41695-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102255.41695-1-sashal@kernel.org>
References: <20181022102255.41695-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Khazhismel Kumykov <khazhy@google.com>

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
index 08b3db146888..83550ac31f49 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -684,6 +684,7 @@ int fat_count_free_clusters(struct super_block *sb)
 			if (ops->ent_get(&fatent) == FAT_ENT_FREE)
 				free++;
 		} while (fat_ent_next(sbi, &fatent));
+		cond_resched();
 	}
 	sbi->free_clusters = free;
 	sbi->free_clus_valid = 1;
-- 
2.17.1

