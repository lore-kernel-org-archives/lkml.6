Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACECDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6B4214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbZfYIW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6B4214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeLEJom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbeLEJog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:44:36 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C4120989;
        Wed,  5 Dec 2018 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003075;
        bh=ZEAYmmUuDN1KtitKneYq3fyjM+CBeQSEIhbPJ7qK2DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbZfYIW86BTEOWBtnTzpAprm68NYJtWO/Bn/y0PPU5YpEa4iWpnvFVHJJfRNReGb6
         lbAytey333Ls75h7KdkPeDry20aySxbUNVQLqVTcSV2xhPs15SRUmmqZiCUVLreuPg
         8K9KEbVRL7knsIrB8iZJe/XZJGsFh4kUiNEiuxio=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 21/69] objtool: Fix double-free in .cold detection error path
Date:   Wed,  5 Dec 2018 04:41:59 -0500
Message-Id: <20181205094247.6556-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Savkov <asavkov@redhat.com>

[ Upstream commit 0b9301fb632f7111a3293a30cc5b20f1b82ed08d ]

If read_symbols() fails during second list traversal (the one dealing
with ".cold" subfunctions) it frees the symbol, but never deletes it
from the list/hash_table resulting in symbol being freed again in
elf_close(). Fix it by just returning an error, leaving cleanup to
elf_close().

Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Link: http://lkml.kernel.org/r/beac5a9b7da9e8be90223459dcbe07766ae437dd.1542736240.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 0d1acb704f64..3616d626991e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -312,7 +312,7 @@ static int read_symbols(struct elf *elf)
 			if (!pfunc) {
 				WARN("%s(): can't find parent function",
 				     sym->name);
-				goto err;
+				return -1;
 			}
 
 			sym->pfunc = pfunc;
-- 
2.17.1

