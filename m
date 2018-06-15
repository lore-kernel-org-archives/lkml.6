Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D2FF5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA12208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synology.com header.i=@synology.com header.b="lGo6gar9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA12208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=synology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965662AbeFOKvQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:51:16 -0400
Received: from synology.com ([59.124.61.242]:45025 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965597AbeFOKvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:51:15 -0400
From:   Sig Shen <sigshen@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1529059873; bh=tC7izsHbUtRMFCZm4XlYiOTb0/UXGrnxr31foT868hQ=;
        h=From:To:Cc:Subject:Date;
        b=lGo6gar9u3H10Rp9gLnYmsdT67cbke13wqgH228Q9jrOgYunIUyY6Yih4a87WvrYU
         co+aJghO6ZrYDwRMf1CXZ9nfDUz2V8rOoIEzc7O5lsQFaYAw+vjvz+KZn06CUkExsn
         wYqTE59ZaMbSJTTMduSBwdipO7JZUBMBYjA0Uvy8=
Cc:     sigshen@synology.com, Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: Support FALLOC_FL_NO_HIDE_STALE flag with fallocate
Date:   Fri, 15 Jun 2018 18:51:08 +0800
Message-Id: <1529059871-11971-1-git-send-email-sigshen@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 5, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FALLOC_FL_NO_HIDE_STALE flag must be set if user want to issue
a discard request for block devices. But vfs_fallocate() will
return with an error -EOPNOTSUPP indicating lack of support
if this flag is set.

fix it by allowing FALLOC_FL_NO_HIDE_STALE flag in vfs_fallocate

Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
Signed-off-by: Sig Shen <sigshen@synology.com>
---
 include/linux/falloc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index 674d59f..770a122 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -27,6 +27,7 @@ struct space_resv {
 					 FALLOC_FL_COLLAPSE_RANGE |	\
 					 FALLOC_FL_ZERO_RANGE |		\
 					 FALLOC_FL_INSERT_RANGE |	\
+					 FALLOC_FL_NO_HIDE_STALE |	\
 					 FALLOC_FL_UNSHARE_RANGE)
 
 #endif /* _FALLOC_H_ */
-- 
2.7.4

