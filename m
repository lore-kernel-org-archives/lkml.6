Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A24C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8DA21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788952;
	bh=bhIDoveyRB4b7aBusXCHsUkYw1ylCCf2U3C3bIEac6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wGW3aiged0z+Pfgk6FZJFhe04wHaDEh0yavcbWBOxu5GXsu8hPPiPfqNDmsP5xF9T
	 a/cSoAJG8nF7Kyx/HOoBi6CGrypk+pXkSoBj1seqkvHKNpYxaj4/8WIesamWx+JGCP
	 hE8nrTmf1sJWlEBZsb5qL9ogCQNwXK41Z6CjXr4A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8DA21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbeLNMCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbeLNMC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9F62145D;
        Fri, 14 Dec 2018 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788948;
        bh=bhIDoveyRB4b7aBusXCHsUkYw1ylCCf2U3C3bIEac6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJtHJuU0+Hr04f/1aaOecO1aYNmZiipvw/Rjt0VQoA80LWYeogKXrfZVWGVSH0dAh
         vQt78rNlH40X4nZ1VKucZ+0CdsvvCctftBe6XUXsfM9MCQ29d59icuN6qy/T+JjAfH
         TWyudEAUo043DVDX6HLYEdNoNr+EwdC+NBlKYg54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/142] sysv: return err instead of 0 in __sysv_write_inode
Date:   Fri, 14 Dec 2018 12:58:40 +0100
Message-Id: <20181214115748.452422310@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 499a20a5a010..273736f41be3 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -275,7 +275,7 @@ static int __sysv_write_inode(struct inode *inode, int wait)
                 }
         }
 	brelse(bh);
-	return 0;
+	return err;
 }
 
 int sysv_write_inode(struct inode *inode, struct writeback_control *wbc)
-- 
2.19.1



