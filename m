Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F808C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1B7242DE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1B7242DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031683AbeGAQjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:39:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031375AbeGAQi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:38:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ADD8C92B;
        Sun,  1 Jul 2018 16:38:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.17 054/220] libnvdimm, pmem: Do not flush power-fail protected CPU caches
Date:   Sun,  1 Jul 2018 18:21:18 +0200
Message-Id: <20180701160910.596750459@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Zwisler <ross.zwisler@linux.intel.com>

commit 546eb0317cfa3c4f9e1d9ab892766d65d7f78fad upstream.

This commit:

5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")

intended to make sure that deep flush was always available even on
platforms which support a power-fail protected CPU cache.  An unintended
side effect of this change was that we also lost the ability to skip
flushing CPU caches on those power-fail protected CPU cache.

Fix this by skipping the low level cache flushing in dax_flush() if we have
CPU caches which are power-fail protected.  The user can still override this
behavior by manually setting the write_cache state of a namespace.  See
libndctl's ndctl_namespace_write_cache_is_enabled(),
ndctl_namespace_enable_write_cache() and
ndctl_namespace_disable_write_cache() functions.

Cc: <stable@vger.kernel.org>
Fixes: 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/region_devs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1132,7 +1132,8 @@ EXPORT_SYMBOL_GPL(nvdimm_has_flush);
 
 int nvdimm_has_cache(struct nd_region *nd_region)
 {
-	return is_nd_pmem(&nd_region->dev);
+	return is_nd_pmem(&nd_region->dev) &&
+		!test_bit(ND_REGION_PERSIST_CACHE, &nd_region->flags);
 }
 EXPORT_SYMBOL_GPL(nvdimm_has_cache);
 


