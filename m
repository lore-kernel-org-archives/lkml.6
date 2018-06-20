Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796F2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F7F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F7F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeFTNTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:19:19 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.43]:17203 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751422AbeFTNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:19:17 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 3339C1FE44
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:19:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Vd13fEawMkBj6Vd13ffblK; Wed, 20 Jun 2018 08:19:17 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=59592 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fVd12-003KGI-OU; Wed, 20 Jun 2018 08:19:16 -0500
Date:   Wed, 20 Jun 2018 08:19:12 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] afs/super.c: Fix memory leak in afs_init_fs_context
Message-ID: <20180620131912.GA31745@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fVd12-003KGI-OU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:59592
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release resources allocated for *ctx* before return.

Addresses-Coverity-ID: 1470101 ("Resource leak")
Fixes: 1ec2b51af007 ("afs: Add fs_context support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/afs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 656f810..037f20f 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -596,8 +596,10 @@ static int afs_init_fs_context(struct fs_context *fc, struct dentry *reference)
 		break;
 
 	case FS_CONTEXT_FOR_SUBMOUNT:
-		if (!reference)
+		if (!reference) {
+			kfree(ctx);
 			return -EINVAL;
+		}
 
 		src_as = AFS_FS_S(reference->d_sb);
 		ASSERT(src_as);
-- 
2.7.4

