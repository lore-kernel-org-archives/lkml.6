Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F0C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509122146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132126;
	bh=SO2iUqNXpKAYyfx4n8Bf9H83N6Vx6MYjef3dvkF+hhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XKkvIklAQdLpX7eAuKUSWsHEa6WE6oLCCNHjPxCkXqRLD8cFexinOAC8tB/8RTpHr
	 tTIhIpNVOtQuw+Wgn0nYpKeb18DQvGmmSMttT6/em91Uzvo22SriCekFf5zxChbbrP
	 nl6SwlIb/vPY0emiOoY8nHdL+AqSY/hrFFKqsjvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfBYVQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfBYVPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B292147C;
        Mon, 25 Feb 2019 21:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129355;
        bh=SO2iUqNXpKAYyfx4n8Bf9H83N6Vx6MYjef3dvkF+hhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6JB8r4+twtMN2NyYXqsuCKxiroAt9vCXWVlUJ74L0P2i2kXcQiWVr5EShvKTyrLy
         4i2QCOyARNq4PmuBTSPs5MUCmwjGuaYn6cShqMzpXajZtbjvNMn0lkCvVPa1Geh3rf
         /vSVd9RYUsdG1mj+yTGgqaqmtOJaxoyTbmwI8+/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 57/63] mm/zsmalloc.c: fix -Wunneeded-internal-declaration warning
Date:   Mon, 25 Feb 2019 22:11:57 +0100
Message-Id: <20190225195040.181329973@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <nick.desaulniers@gmail.com>

commit 3457f4147675108aa83f9f33c136f06bb9f8518f upstream.

is_first_page() is only called from the macro VM_BUG_ON_PAGE() which is
only compiled in as a runtime check when CONFIG_DEBUG_VM is set,
otherwise is checked at compile time and not actually compiled in.

Fixes the following warning, found with Clang:

  mm/zsmalloc.c:472:12: warning: function 'is_first_page' is not needed and will not be emitted [-Wunneeded-internal-declaration]
  static int is_first_page(struct page *page)
           ^

Link: http://lkml.kernel.org/r/20170524053859.29059-1-nick.desaulniers@gmail.com
Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zsmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -473,7 +473,7 @@ static bool is_zspage_isolated(struct zs
 	return zspage->isolated;
 }
 
-static int is_first_page(struct page *page)
+static __maybe_unused int is_first_page(struct page *page)
 {
 	return PagePrivate(page);
 }


