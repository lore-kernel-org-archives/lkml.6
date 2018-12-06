Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9458C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697CB20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107326;
	bh=eiKeFqhTYnN8UM5oVt26eBXuZb4ygNkKKZUlp2oYhO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EkSuc6EOzexP3Th4E1qcqfLrfFITBUGBHv4maE9hlnql6RomQJjoo6rnrRQIqDkJy
	 af6R0VzJem36oqqcLaIZQV0TMm5zLJTGVz0OuBMmnunE3eNejWPTMhMf2Prq+p8WPY
	 hYW0iylhXeEys+xHeeyiF7pU/CqYBx3RiTnqAKX0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697CB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbeLFOmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbeLFOmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6892B20892;
        Thu,  6 Dec 2018 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107322;
        bh=eiKeFqhTYnN8UM5oVt26eBXuZb4ygNkKKZUlp2oYhO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQCx8gPowKZkNv5898goR0t72GqIUnSYGzvR6LOdlFsEco1RZSmBny3hz4cR3Enl5
         tzJlgltcFoZx4xp8v8kxWUiqh+9oxPxIyc8KA9WfmpeArLBvwxrxuE/d+q0cMKGsK/
         0ZZljyregDGjJ1tEP9u7eKatVlkWUZYBkyCipi4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 03/55] test_hexdump: use memcpy instead of strncpy
Date:   Thu,  6 Dec 2018 15:38:37 +0100
Message-Id: <20181206143001.933529895@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 lib/test_hexdump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -81,7 +81,7 @@ static void __init test_hexdump_prepare_
 		const char *q = *result++;
 		size_t amount = strlen(q);
 
-		strncpy(p, q, amount);
+		memcpy(p, q, amount);
 		p += amount;
 
 		*p++ = ' ';


