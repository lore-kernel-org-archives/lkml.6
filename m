Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AEA20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130868;
	bh=NoYumBzEtxYKTxy9krW8bWe5BW/b1/PN6gA+rftI5BE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ukBImWvx2chbmUje0QSjuCNDkL/GZ7niM6NOP+dUKPYEHAERH2J6+Jg0L67WEvFM
	 HhRq6kr29ICiC0egK2lk1N4B3ymmduuScUhd3qX1pr80WMPGA101u2b6aqkXpFOOW2
	 AdPj3LcJF6lKFZHnlIG7ysMeVVgHMnQ8ZUpXhc0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfBYVlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:41:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732430AbfBYVd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E7820578;
        Mon, 25 Feb 2019 21:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130438;
        bh=NoYumBzEtxYKTxy9krW8bWe5BW/b1/PN6gA+rftI5BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXC7b5fvhRKXu6MuS3JIDMa1nOZNpvzpOQxBOqvB02ANfyoZZ2MFffl/ht/o8uy/q
         iUHlUSeCq9ZU277S3mMXvRvrxsqBoUl6N5fWZ6djX/o9iWvA4jXk9MBIMb/lH1JSc2
         GDVotpT4EIefSxisGKSQxDB2T8b3meemEIqHp5Qo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 121/183] isdn: avm: Fix string plus integer warning from Clang
Date:   Mon, 25 Feb 2019 22:11:34 +0100
Message-Id: <20190225195115.050812135@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7afa81c55fca0cad589722cb4bce698b4803b0e1 ]

A recent commit in Clang expanded the -Wstring-plus-int warning, showing
some odd behavior in this file.

drivers/isdn/hardware/avm/b1.c:426:30: warning: adding 'int' to a string does not append to the string [-Wstring-plus-int]
                cinfo->version[j] = "\0\0" + 1;
                                    ~~~~~~~^~~
drivers/isdn/hardware/avm/b1.c:426:30: note: use array indexing to silence this warning
                cinfo->version[j] = "\0\0" + 1;
                                           ^
                                    &      [  ]
1 warning generated.

This is equivalent to just "\0". Nick pointed out that it is smarter to
use "" instead of "\0" because "" is used elsewhere in the kernel and
can be deduplicated at the linking stage.

Link: https://github.com/ClangBuiltLinux/linux/issues/309
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/hardware/avm/b1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
index 4ac378e489023..40ca1e8fa09fc 100644
--- a/drivers/isdn/hardware/avm/b1.c
+++ b/drivers/isdn/hardware/avm/b1.c
@@ -423,7 +423,7 @@ void b1_parse_version(avmctrl_info *cinfo)
 	int i, j;
 
 	for (j = 0; j < AVM_MAXVERSION; j++)
-		cinfo->version[j] = "\0\0" + 1;
+		cinfo->version[j] = "";
 	for (i = 0, j = 0;
 	     j < AVM_MAXVERSION && i < cinfo->versionlen;
 	     j++, i += cinfo->versionbuf[i] + 1)
-- 
2.19.1



