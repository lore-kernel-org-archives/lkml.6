Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ACCC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF652147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789033;
	bh=e1a/2wCPgUDjTDQjzayiTJM0wvQm9O4+poxvGL18Ngs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0j3O52phafjlsI+he2Dbq2ciTNQROm9GqDIJJoPbNCyq6UeIMmM7jVHmh1GlrQ9S
	 RL1pfXeMkbqhjmub4GRbRBqotQcT/Qpq5IQ3i9I6xW5YAaez9SgNyTKAS7gkHcy5Qw
	 rgcUkzvTDeVXbRL+k7Yk/WrgHbRCa4SyomZvw9Wg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF652147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbeLNMDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbeLNMDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B204F2146E;
        Fri, 14 Dec 2018 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789027;
        bh=e1a/2wCPgUDjTDQjzayiTJM0wvQm9O4+poxvGL18Ngs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOvd6Ze1igaIUikFOUHWZHJ1imQ22mu6TYnzNvgU1q+H8mT7EEJiy7Ex9VLCpaGtx
         I1Rq9LOb78YjcvnQND0tyBNYEahiv+gXVggFkNIhOOzD39fW3dqTYvliDvIkHJMrrX
         B1BMziMdgbv02KtsjZw4a7zNfXo30e4qh/xd6hOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/142] objtool: Fix double-free in .cold detection error path
Date:   Fri, 14 Dec 2018 12:59:10 +0100
Message-Id: <20181214115749.656201027@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 7ec85d567598..a6f543e0b387 100644
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
2.19.1



