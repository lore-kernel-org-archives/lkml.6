Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C50C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05C020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05C020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeIMSxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:53:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbeIMSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:53:02 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 288A7CF3;
        Thu, 13 Sep 2018 13:43:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        icytxw@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 035/115] mm/fadvise.c: fix signed overflow UBSAN complaint
Date:   Thu, 13 Sep 2018 15:30:55 +0200
Message-Id: <20180913131825.870428284@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

[ Upstream commit a718e28f538441a3b6612da9ff226973376cdf0f ]

Signed integer overflow is undefined according to the C standard.  The
overflow in ksys_fadvise64_64() is deliberate, but since it is signed
overflow, UBSAN complains:

	UBSAN: Undefined behaviour in mm/fadvise.c:76:10
	signed integer overflow:
	4 + 9223372036854775805 cannot be represented in type 'long long int'

Use unsigned types to do math.  Unsigned overflow is defined so UBSAN
will not complain about it.  This patch doesn't change generated code.

[akpm@linux-foundation.org: add comment explaining the casts]
Link: http://lkml.kernel.org/r/20180629184453.7614-1-aryabinin@virtuozzo.com
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reported-by: <icytxw@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/fadvise.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -71,8 +71,12 @@ SYSCALL_DEFINE4(fadvise64_64, int, fd, l
 		goto out;
 	}
 
-	/* Careful about overflows. Len == 0 means "as much as possible" */
-	endbyte = offset + len;
+	/*
+	 * Careful about overflows. Len == 0 means "as much as possible".  Use
+	 * unsigned math because signed overflows are undefined and UBSan
+	 * complains.
+	 */
+	endbyte = (u64)offset + (u64)len;
 	if (!len || endbyte < len)
 		endbyte = -1;
 	else


