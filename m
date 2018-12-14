Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D6F2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789685;
	bh=7Hw+5PxxPtrE3D/bmcRc5wN1C4SbqRBBPiIE5pLTLxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bcY80VAQkgQeA5liB8UjFzPcJ8j4DDHqoumQJu2Xg6oNKE++UcGKF9oqUTla3IAU6
	 PgRX5YB6nhuQ0YDybYaq9wHxpvc4vB+ofFmcAexkcLeFHrh1LX1nE4r6BbwDsm4psg
	 bz0qWrkNOpcCjHSK+57+SMhSJJtmd4k3wEng1oaA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D6F2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbeLNMOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732122AbeLNMOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D9252133F;
        Fri, 14 Dec 2018 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789679;
        bh=7Hw+5PxxPtrE3D/bmcRc5wN1C4SbqRBBPiIE5pLTLxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1R6YR1Csb0by0wB+XhSYIkHjqBRol7GAaG79C13BMwgs12Ac+WpX9GTHKj2MhsPu
         wlUqUf0RgKuPNASrrQKu0YZdSL5QNiF0rFIls6oajTBQwDwSyOUkmXjHfCPzyRuvow
         XYfNHj/F0c46b8V/xAzxDXKdW3wK576sjsNKyPiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 12/88] sysv: return err instead of 0 in __sysv_write_inode
Date:   Fri, 14 Dec 2018 12:59:46 +0100
Message-Id: <20181214115703.150853292@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 02fa1dcc5969..29f5b2e589a1 100644
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



