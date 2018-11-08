Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F19ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69F620892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd6mD2Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69F620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeKIHce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbeKIHce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:34 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4980A2086C;
        Thu,  8 Nov 2018 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714107;
        bh=epz/mPTNffpvPRkjh8JJ7xd75ZU2m54LhvQihjbsyJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bd6mD2ZsnsE8pLKPr12P5CKzPKem+1JyGF31wL6ARVgLaRhYK1TgrTtPet2HtD/c8
         fKZsTohYt5Ub1eJ5JxV6JzdKnGgVdznQgrZfiqJFMLrMSadYNmU/EdILTBxAPg7adQ
         q+PFPdGmKxfndssuboWX4WvXMcwR38rSVZdZyq9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Joe Thornber <ejt@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 032/144] dm thin: restore requested error_if_no_space setting on OODS to WRITE transition
Date:   Thu,  8 Nov 2018 13:50:03 -0800
Message-Id: <20181108215057.177607086@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 172c238612ebf81cabccc86b788c9209af591f61 ]

A thin-pool that is in out-of-data-space (OODS) mode may transition back
to write mode -- without the admin adding more space to the thin-pool --
if/when blocks are released (either by deleting thin devices or
discarding provisioned blocks).

But as part of the thin-pool's earlier transition to out-of-data-space
mode the thin-pool may have set the 'error_if_no_space' flag to true if
the no_space_timeout expires without more space having been made
available.  That implementation detail, of changing the pool's
error_if_no_space setting, needs to be reset back to the default that
the user specified when the thin-pool's table was loaded.

Otherwise we'll drop the user requested behaviour on the floor when this
out-of-data-space to write mode transition occurs.

Reported-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Acked-by: Joe Thornber <ejt@redhat.com>
Fixes: 2c43fd26e4 ("dm thin: fix missing out-of-data-space to write mode transition if blocks are released")
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-thin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 68c7102a64c8..936c57b57539 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1909,6 +1909,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 	case PM_WRITE:
 		if (old_mode != new_mode)
 			notify_of_pool_mode_change(pool, "write");
+		pool->pf.error_if_no_space = pt->requested_pf.error_if_no_space;
 		dm_pool_metadata_read_write(pool->pmd);
 		pool->process_bio = process_bio;
 		pool->process_discard = process_discard;
-- 
2.17.1



