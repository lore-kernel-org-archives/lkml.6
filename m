Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBC7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA8B20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA8B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTNfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:35:37 -0400
Received: from gateway20.websitewelcome.com ([192.185.53.25]:46209 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752901AbeFTNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:35:36 -0400
X-Greylist: delayed 1430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2018 09:35:36 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 63A8F400E63FF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:11:03 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Vct5fQ4GTSjJAVct5fxZHE; Wed, 20 Jun 2018 08:11:03 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=59518 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fVct3-003EGb-Qv; Wed, 20 Jun 2018 08:11:01 -0500
Date:   Wed, 20 Jun 2018 08:10:59 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] fs/super.c: Fix lock/unlock imbalance in sget_fc
Message-ID: <20180620131059.GA28925@embeddedor.com>
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
X-Exim-ID: 1fVct3-003EGb-Qv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:59518
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems a spin_unlock is missing before return at line 532: return old.

Addresses-Coverity-ID: 1470111 ("Missing unlock")
Fixes: 4f3911e76e19 ("vfs: Implement a filesystem superblock creation/configuration context")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/super.c b/fs/super.c
index 43400f5..ff24532 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -529,6 +529,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 				destroy_unused_super(s);
 				s = NULL;
 			}
+			spin_unlock(&sb_lock);
 			return old;
 		}
 	}
-- 
2.7.4

