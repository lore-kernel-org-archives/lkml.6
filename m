Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A4CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA702146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfBSN5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:57:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54711 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfBSN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:57:15 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gw5ta-0002Mh-0U; Tue, 19 Feb 2019 13:57:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] vhost: only return early if ret indicates an error or no iovecs have been processed
Date:   Tue, 19 Feb 2019 13:57:13 +0000
Message-Id: <20190219135713.10426-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the loop that calls log_write_hva on each iovec is never
executed because of an incorrect error check on the return from the
call to translate_desc.  The check should be checking for a -ve error
return and because it makes no sense to iterate over zero items, the
checks should also check for zero too.

Detected by CoverityScan, CID#1476969 ("Logically dead code")

Fixes: cc5e71075947 ("vhost: log dirty page correctly")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 24a129fcdd61..a9a1709a859a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1788,7 +1788,7 @@ static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
 
 	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
 			     len, iov, 64, VHOST_ACCESS_WO);
-	if (ret)
+	if (ret <= 0)
 		return ret;
 
 	for (i = 0; i < ret; i++) {
-- 
2.20.1

