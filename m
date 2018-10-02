Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E74DC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5962089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5962089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbeJBUNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbeJBUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:02 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D70DDB2F;
        Tue,  2 Oct 2018 13:29:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fan Du <fan.du@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wenwei Tao <wenwei.tww@alibaba-inc.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.18 157/228] uaccess: Fix is_source param for check_copy_size() in copy_to_iter_mcsafe()
Date:   Tue,  2 Oct 2018 06:24:14 -0700
Message-Id: <20181002132509.570370249@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

commit dfb06cba8c73c0704710b2e3fbe2c35ac66a01b4 upstream.

copy_to_iter_mcsafe() is passing in the is_source parameter as "false"
to check_copy_size(). This is different than what copy_to_iter() does.
Also, the addr parameter passed to check_copy_size() is the source so
therefore we should be passing in "true" instead.

Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
Cc: <stable@vger.kernel.org>
Reported-by: Fan Du <fan.du@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: Wenwei Tao <wenwei.tww@alibaba-inc.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/uio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -172,7 +172,7 @@ size_t copy_from_iter_flushcache(void *a
 static __always_inline __must_check
 size_t copy_to_iter_mcsafe(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, false)))
+	if (unlikely(!check_copy_size(addr, bytes, true)))
 		return 0;
 	else
 		return _copy_to_iter_mcsafe(addr, bytes, i);


