Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9143FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7D3224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v870DV5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7D3224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405934AbeKTD0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:26:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405038AbeKTD0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:26:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D65B22443;
        Mon, 19 Nov 2018 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646942;
        bh=eTJGnP8BmWH5au/0xNLM92/T2MMx6IDAdq4fgoMcywU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v870DV5S4+ewqKh4bewQ4hnMGo+zZ5GeejdrmGPiKwk2hw78aszrXjtruaEfpSnes
         vqpRLC3ve5Js/TULOBdYzOQVoq7rn2mD/PBdiEVn4cJ09F6pJlAOqKEGilQGaajhnq
         R1fpwXTvhzVosy+VzE91953FupwaNvSWE/CWryvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 112/160] mm, elf: handle vm_brk error
Date:   Mon, 19 Nov 2018 17:29:11 +0100
Message-Id: <20181119162641.644164203@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

commit ecc2bc8ac03884266cf73f8a2a42b911465b2fbc upstream.

load_elf_library doesn't handle vm_brk failure although nothing really
indicates it cannot do that because the function is allowed to fail due
to vm_mmap failures already.  This might be not a problem now but later
patch will make vm_brk killable (resp.  mmap_sem for write waiting will
become killable) and so the failure will be more probable.

Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 62bc72001fce..70ea4b9c6dd9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1215,8 +1215,11 @@ static int load_elf_library(struct file *file)
 	len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr +
 			    ELF_MIN_ALIGN - 1);
 	bss = eppnt->p_memsz + eppnt->p_vaddr;
-	if (bss > len)
-		vm_brk(len, bss - len);
+	if (bss > len) {
+		error = vm_brk(len, bss - len);
+		if (BAD_ADDR(error))
+			goto out_free_ph;
+	}
 	error = 0;
 
 out_free_ph:
-- 
2.17.1



