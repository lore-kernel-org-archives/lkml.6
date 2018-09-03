Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62543C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AA020779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AA020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeICVLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeICVLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:39 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C3A8CEE;
        Mon,  3 Sep 2018 16:50:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 19/56] media: staging: omap4iss: Include asm/cacheflush.h after generic includes
Date:   Mon,  3 Sep 2018 18:49:09 +0200
Message-Id: <20180903164925.048470666@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 0894da849f145af51bde88a6b84f95b9c9e0bc66 ]

Including asm/cacheflush.h first results in the following build error
when trying to build sparc32:allmodconfig, because 'struct page' has not
been declared, and the function declaration ends up creating a separate
(private) declaration of struct page (as a result of function arguments
being in the scope of the function declaration and definition, not in
global scope).

The C scoping rules do not just affect variable visibility, they also
affect type declaration visibility.

The end result is that when the actual call site is seen in
<linux/highmem.h>, the 'struct page' type in the caller is not the same
'struct page' that the function was declared with, resulting in:

  In file included from arch/sparc/include/asm/page.h:10:0,
                   ...
                   from drivers/staging/media/omap4iss/iss_video.c:15:
  include/linux/highmem.h: In function 'clear_user_highpage':
  include/linux/highmem.h:137:31: error:
	passing argument 1 of 'sparc_flush_page_to_ram' from incompatible
	pointer type

Include generic includes files first to fix the problem.

Fixes: fc96d58c10162 ("[media] v4l: omap4iss: Add support for OMAP4 camera interface - Video devices")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ Added explanation of C scope rules - Linus ]
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/omap4iss/iss_video.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/media/omap4iss/iss_video.c
+++ b/drivers/staging/media/omap4iss/iss_video.c
@@ -11,7 +11,6 @@
  * (at your option) any later version.
  */
 
-#include <asm/cacheflush.h>
 #include <linux/clk.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -22,6 +21,8 @@
 #include <media/v4l2-dev.h>
 #include <media/v4l2-ioctl.h>
 
+#include <asm/cacheflush.h>
+
 #include "iss_video.h"
 #include "iss.h"
 


