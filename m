Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB45C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 04:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2969627DD7
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 04:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="dSGi2dM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2969627DD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeF3EpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 00:45:16 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:49308 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754057AbeF3EpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 00:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LEfzN9ze+dnIy8DtqTFvaN1F42EjmnLazd/RE656SCM=; b=dSGi2dM4uJE9nIjmVDwKN6/YhW
        4fieIWYknrC6kFsS43QS1ga7WOOl5JhTcb5GdFC9+d5iaTE/9lzEJ6B4yAHGuPcwPSP4issoTRLzf
        WGS32SILoZsPuRQWv6WfLXxIukaL+cTFc792+uWzum9iV4islayh7qH/YWJ5LNGaotZmtAMaFj/MC
        iEKOYCIo2RVx/9d2jeWiDwiaXEy7HuHJ8vZnwtQ9yMXmf51wpRXsEwNVnulxVdOMufd4wPS48FrXa
        6F8IxB44rBr62eF208tzPpxwb7Zyn06H4dFMZIbLQPD3T5KvqFtAPHOY/viKV9M+nHqTuCLT1uZqV
        ib98JgjA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59382 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fZ7l3-003ujS-0l; Sat, 30 Jun 2018 04:45:13 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH] sparc32: cacheflush_32: Declare struct page
Date:   Fri, 29 Jun 2018 21:45:10 -0700
Message-Id: <1530333910-31209-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building allmodconfig images for sparc32 generates warnings such as

arch/sparc/include/asm/cacheflush_32.h:40:37: warning:
	'struct page' declared inside parameter list

This results in odd warnings such as

arch/sparc/include/asm/cacheflush_32.h:40:6: note:
	expected 'struct page *' but argument is of type 'struct page *'

With recent compilers (gcc 5.5.0 and later), this warning turns into
a build error when compiling drivers/staging/media/omap4iss/iss_video.c.

./include/linux/highmem.h: In function 'copy_user_highpage':
./include/linux/highmem.h:233:36: error:
	passing argument 1 of 'sparc_flush_page_to_ram'
				from incompatible pointer type

Declare struct page to fix the problem.

Fixes: 84fc727ed49c ("media: omap4iss: make it build with COMPILE_TEST")
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/include/asm/cacheflush_32.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index fb66094a2c30..acb072c71e42 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -4,6 +4,8 @@
 
 #include <asm/cachetlb_32.h>
 
+struct page;
+
 #define flush_cache_all() \
 	sparc32_cachetlb_ops->cache_all()
 #define flush_cache_mm(mm) \
-- 
2.7.4

