Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD6DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2160920664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2160920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeKAL6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeKAL6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 352DD88308;
        Thu,  1 Nov 2018 02:57:34 +0000 (UTC)
Received: from treble.redhat.com (ovpn-123-155.rdu2.redhat.com [10.10.123.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8648B600CC;
        Thu,  1 Nov 2018 02:57:33 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] objtool: Support GCC 9 cold subfunction naming scheme
Date:   Wed, 31 Oct 2018 21:57:30 -0500
Message-Id: <015e9544b1f188d36a7f02fa31e9e95629aa5f50.1541040800.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 01 Nov 2018 02:57:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with GCC 8, a lot of unlikely code was moved out of line to
"cold" subfunctions in .text.unlikely.

For example, the unlikely bits of:

  irq_do_set_affinity()

are moved out to the following subfunction:

  irq_do_set_affinity.cold.49()

Starting with GCC 9, the numbered suffix has been removed.  So in the
above example, the cold subfunction is instead:

  irq_do_set_affinity.cold()

Tweak the objtool subfunction detection logic so that it detects both
GCC 8 and GCC 9 naming schemes.

Reported-and-tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f7082de1ee82..6dbb9fae0f9d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -301,7 +301,7 @@ static int read_symbols(struct elf *elf)
 			if (sym->type != STT_FUNC)
 				continue;
 			sym->pfunc = sym->cfunc = sym;
-			coldstr = strstr(sym->name, ".cold.");
+			coldstr = strstr(sym->name, ".cold");
 			if (!coldstr)
 				continue;
 
-- 
2.17.2

