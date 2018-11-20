Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F0EC46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445BA206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445BA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbeKUEXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:23:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbeKUEXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:23:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D8B3C04B2DF;
        Tue, 20 Nov 2018 17:53:11 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-214.rdu2.redhat.com [10.10.122.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88C4D19C7F;
        Tue, 20 Nov 2018 17:53:10 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] objtool: Fix double-free in .cold detection error path
Date:   Tue, 20 Nov 2018 11:52:15 -0600
Message-Id: <beac5a9b7da9e8be90223459dcbe07766ae437dd.1542736240.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1542736240.git.jpoimboe@redhat.com>
References: <cover.1542736240.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 20 Nov 2018 17:53:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Savkov <asavkov@redhat.com>

If read_symbols() fails during second list traversal (the one dealing
with ".cold" subfunctions) it frees the symbol, but never deletes it
from the list/hash_table resulting in symbol being freed again in
elf_close(). Fix it by just returning an error, leaving cleanup to
elf_close().

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6dbb9fae0f9d..e7a7ac40e045 100644
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
2.17.2

