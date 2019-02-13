Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A007CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685BD222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025427;
	bh=Wm+ux27XzyZ3VwF6J6vwHgEdVt3irBPBCiu5LU3q3Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iVK7BoYST5s5fXwq9VfAwCBgOcWClWTrk2g+gIhVcYlIocL8ZFk3/iC8awO3hszIl
	 UO98sEMOCo1qxAp+rF9yghHcE8Y7thmbENqHBaOPr0ZvilDMb/faipAP6Iri2+1+nf
	 lqoH9zFZxJbG8/5KMcjerbFZ5FnPmYn5b1V75Gek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbfBMChF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732562AbfBMChA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3770A222C9;
        Wed, 13 Feb 2019 02:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025419;
        bh=Wm+ux27XzyZ3VwF6J6vwHgEdVt3irBPBCiu5LU3q3Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqd8j+flebm6SHjF7LG2rIxWZrvNaCDgOKeARmKWzLxlj+4JRwQqSlh5uXw7s0Kq7
         1jFK1Kp7e/Iz3ziYM7m7iAsNT5mWSwoidi3Lc9TSNyKGOX3WZkxnmbSw8slb/lIB6l
         F6dnTCSclBmGDmvbyE9jp2IznS25LdGJ6y41kzUg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 105/105] isdn: avm: Fix string plus integer warning from Clang
Date:   Tue, 12 Feb 2019 21:33:36 -0500
Message-Id: <20190213023336.19019-105-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

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
index 4ac378e48902..40ca1e8fa09f 100644
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

