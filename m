Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1581020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1581020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeIMSwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:52:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeIMSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:52:24 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7053FD10;
        Thu, 13 Sep 2018 13:42:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Omar Sandoval <osandov@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 028/115] fs/proc/kcore.c: use __pa_symbol() for KCORE_TEXT list entries
Date:   Thu, 13 Sep 2018 15:30:48 +0200
Message-Id: <20180913131825.374866287@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

[ Upstream commit df865e8337c397471b95f51017fea559bc8abb4a ]

elf_kcore_store_hdr() uses __pa() to find the physical address of
KCORE_RAM or KCORE_TEXT entries exported as program headers.

This trips CONFIG_DEBUG_VIRTUAL's checks, as the KCORE_TEXT entries are
not in the linear map.

Handle these two cases separately, using __pa_symbol() for the KCORE_TEXT
entries.

Link: http://lkml.kernel.org/r/20180711131944.15252-1-james.morse@arm.com
Signed-off-by: James Morse <james.morse@arm.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/kcore.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -384,8 +384,10 @@ static void elf_kcore_store_hdr(char *bu
 		phdr->p_flags	= PF_R|PF_W|PF_X;
 		phdr->p_offset	= kc_vaddr_to_offset(m->addr) + dataoff;
 		phdr->p_vaddr	= (size_t)m->addr;
-		if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
+		if (m->type == KCORE_RAM)
 			phdr->p_paddr	= __pa(m->addr);
+		else if (m->type == KCORE_TEXT)
+			phdr->p_paddr	= __pa_symbol(m->addr);
 		else
 			phdr->p_paddr	= (elf_addr_t)-1;
 		phdr->p_filesz	= phdr->p_memsz	= m->size;


