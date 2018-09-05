Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E8EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC7A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC7A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeIFBDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:03:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:40627 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbeIFBDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:03:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 13:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="87961531"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2018 13:31:40 -0700
Subject: [PATCH] uio: fix is_source param for check_copy_size() in
 copy_to_iter_mcsafe()
From:   Dave Jiang <dave.jiang@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        fan.du@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 13:31:40 -0700
Message-ID: <153617950046.33664.13445188581267552601.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_to_iter_mcsafe() is passing in the is_source parameter as "false"
to check_copy_size(). This is different than what copy_to_iter() does.
Also, the addr parameter passed to check_copy_size() is the source so
therefore we should be passing in "true" instead.

Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")

Reported-by: Fan Du <fan.du@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
---
 include/linux/uio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 409c845d4cd3..422b1c01ee0d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -172,7 +172,7 @@ size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 static __always_inline __must_check
 size_t copy_to_iter_mcsafe(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, false)))
+	if (unlikely(!check_copy_size(addr, bytes, true)))
 		return 0;
 	else
 		return _copy_to_iter_mcsafe(addr, bytes, i);

