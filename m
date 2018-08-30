Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A952205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A952205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbeH3S3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:29:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39528 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbeH3S3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:29:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fvNup-0007vf-8h; Thu, 30 Aug 2018 14:27:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next] xdp: remove redundant variable 'headroom'
Date:   Thu, 30 Aug 2018 15:27:18 +0100
Message-Id: <20180830142718.10850-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable 'headroom' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
variable ‘headroom’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/core/xdp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 654dbb19707e..4b2b194f4f1f 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -412,7 +412,7 @@ EXPORT_SYMBOL_GPL(xdp_attachment_setup);
 
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 {
-	unsigned int metasize, headroom, totsize;
+	unsigned int metasize, totsize;
 	void *addr, *data_to_copy;
 	struct xdp_frame *xdpf;
 	struct page *page;
@@ -420,7 +420,6 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	/* Clone into a MEM_TYPE_PAGE_ORDER0 xdp_frame. */
 	metasize = xdp_data_meta_unsupported(xdp) ? 0 :
 		   xdp->data - xdp->data_meta;
-	headroom = xdp->data - xdp->data_hard_start;
 	totsize = xdp->data_end - xdp->data + metasize;
 
 	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
-- 
2.17.1

