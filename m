Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA8EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B380B20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7olsBIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B380B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbeLEJza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:55:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbeLEJz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:55:26 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3DB220661;
        Wed,  5 Dec 2018 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003725;
        bh=2+LkGUCJA5F+CJuoOb9s4mjMsJTb5bXcUaxg5rQuJyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7olsBIRwHZNu0qJDyctd5nP/5JMO1+aHK8HUt4LQzZwBMYX/FqE9BYz3kKeQZefz
         UHFoOrAKsG5X+Su0Bhcd893ouazcyhM0vyQ++REtgOtyLC+lTNb/BcU8ZlEGBsaZs0
         myUQKlf5KPLEPpeVom1YpU/DiSJ0I9TzWePVHLLQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 03/26] sysv: return 'err' instead of 0 in __sysv_write_inode
Date:   Wed,  5 Dec 2018 04:54:07 -0500
Message-Id: <20181205095430.8019-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095430.8019-1-sashal@kernel.org>
References: <20181205095430.8019-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit c4b7d1ba7d263b74bb72e9325262a67139605cde ]

Fixes gcc '-Wunused-but-set-variable' warning:

fs/sysv/inode.c: In function '__sysv_write_inode':
fs/sysv/inode.c:239:6: warning:
 variable 'err' set but not used [-Wunused-but-set-variable]

__sysv_write_inode should return 'err' instead of 0

Fixes: 05459ca81ac3 ("repair sysv_write_inode(), switch sysv to simple_fsync()")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/sysv/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 88956309cc86..9d26f2034d54 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -281,7 +281,7 @@ static int __sysv_write_inode(struct inode *inode, int wait)
                 }
         }
 	brelse(bh);
-	return 0;
+	return err;
 }
 
 int sysv_write_inode(struct inode *inode, struct writeback_control *wbc)
-- 
2.17.1

