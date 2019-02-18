Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C8A204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498727;
	bh=xvEabbRGBqNlLB407qoypuYo/LqRuUblc6/8FtX6UT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITppe2lB1z1wkRiwkWH/VslNDXNU491wUe4CFSjc8Hgsn46UmjrpEbMiNcLgigJec
	 +XJl+Wt/VzIZuJ3WyyQvOXg2t3h5lQg7Li+ZX++NdzUxF+B+UiKfSRVWQ7xs0wx4d2
	 qS6UoIshudyxcUrWRKOfAHAUjxVUbrAXrrZnlqpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389655AbfBROFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390137AbfBROFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D37FB204FD;
        Mon, 18 Feb 2019 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498721;
        bh=xvEabbRGBqNlLB407qoypuYo/LqRuUblc6/8FtX6UT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5UOe0Uem2sR4VA+tT0/TYpQBCKgvAGBkR1jTR9ftnkLEnGii41zOkpEMwlkyVdar
         vp7YdDKvUXmUdZY2z7ZRLxC7u7i/N/dxurxJdybXMQodVNsleWGnlIfWCXYNTPz2jt
         gNgAHfWUEsToaIDR72tCDat8q5uqs76sRKZCV6aw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.4 074/143] test_hexdump: use memcpy instead of strncpy
Date:   Mon, 18 Feb 2019 14:43:22 +0100
Message-Id: <20190218133531.797224373@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit b1286ed7158e9b62787508066283ab0b8850b518 upstream.

New versions of gcc reasonably warn about the odd pattern of

	strncpy(p, q, strlen(q));

which really doesn't make sense: the strncpy() ends up being just a slow
and odd way to write memcpy() in this case.

Apparently there was a patch for this floating around earlier, but it
got lost.

Acked-again-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test-hexdump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test-hexdump.c
+++ b/lib/test-hexdump.c
@@ -81,7 +81,7 @@ static void __init test_hexdump(size_t l
 		const char *q = *result++;
 		size_t amount = strlen(q);
 
-		strncpy(p, q, amount);
+		memcpy(p, q, amount);
 		p += amount + 1;
 	}
 	if (i)


