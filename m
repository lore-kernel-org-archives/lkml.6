Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA48AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575162146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575162146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeIRE2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:28:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbeIRE2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:28:43 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2BB54C77;
        Mon, 17 Sep 2018 22:59:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 68/70] mtd: ubi: wl: Fix error return code in ubi_wl_init()
Date:   Tue, 18 Sep 2018 00:42:41 +0200
Message-Id: <20180917211654.421563188@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 7233982ade15eeac05c6f351e8d347406e6bcd2f upstream.

Fix to return error code -ENOMEM from the kmem_cache_alloc() error
handling case instead of 0, as done elsewhere in this function.

Fixes: f78e5623f45b ("ubi: fastmap: Erase outdated anchor PEBs during
attach")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/wl.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1615,8 +1615,10 @@ int ubi_wl_init(struct ubi_device *ubi,
 		cond_resched();
 
 		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
-		if (!e)
+		if (!e) {
+			err = -ENOMEM;
 			goto out_free;
+		}
 
 		e->pnum = aeb->pnum;
 		e->ec = aeb->ec;
@@ -1635,8 +1637,10 @@ int ubi_wl_init(struct ubi_device *ubi,
 			cond_resched();
 
 			e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
-			if (!e)
+			if (!e) {
+				err = -ENOMEM;
 				goto out_free;
+			}
 
 			e->pnum = aeb->pnum;
 			e->ec = aeb->ec;


