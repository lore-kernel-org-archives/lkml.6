Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F505C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272B6208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790799;
	bh=JrXWgQ8O+20gKlPtOuFNtidrJAPdAAh0z5cPeKx/yvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pcmq3EAbCA6enEhYe2E6AI66x5S+D9QUnRZHleQhGmZ5AOgPmAT6OdvwnD2+SN2LG
	 IiVS54HHQLeOhZ8BS7EirWnjXrMSLdLB1wFv6q0VHl4IjD+pmq6eOdGu2ioSyuZR6D
	 MjQKAfxUBaus1Sl9cPBTF9FT/QjpFCFLAJ8xcOl8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272B6208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbeLNMdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730896AbeLNMIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CF12147D;
        Fri, 14 Dec 2018 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789318;
        bh=JrXWgQ8O+20gKlPtOuFNtidrJAPdAAh0z5cPeKx/yvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2SolNzop/yXDin1HpztzCHsljZsa3t14WovC7vCWApw2avUX6T+CofF9YAqMLUfX
         G4b4/cyd5wHao14fQB0dG2YBzorvKPF1OdrNgEKnnrQFPUFOwKUyWnt5LKutXRPqlg
         IlrSzrfYtwyVwVctvxuBgbdLwlGBxiLVz/WadwQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 35/89] objtool: Fix double-free in .cold detection error path
Date:   Fri, 14 Dec 2018 12:59:48 +0100
Message-Id: <20181214115731.417094599@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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
2.19.1



