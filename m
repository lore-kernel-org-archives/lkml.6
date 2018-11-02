Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0152C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E232084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="goNnU3eN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E232084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeKCECn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbeKCECm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:02:42 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6B420848;
        Fri,  2 Nov 2018 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184867;
        bh=rDh4nSash09K8Skgz8hcGspWEl8vlEmtLH7GWl8c72Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goNnU3eN3stoV69Z/fDxh55HSNfJJK7G9DKGqzTzqE677XfAtUDakRE5aiAkgEQNy
         10MlvzfZlRxLE7qc/IiHvVsvOTs6YDu5V5vfm8KClCPg7kp1WT5wl5JMYBxn7W6VY5
         bj1LsnexjbDJiR34xNL72mm0yy4477QY5WayyZrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 105/143] fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()
Date:   Fri,  2 Nov 2018 19:34:50 +0100
Message-Id: <20181102182906.252302821@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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
index a40f36b1b292..9635df94db7d 100644
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



