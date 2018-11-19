Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22401C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C3B22353
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xV6CMBQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C3B22353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405491AbeKTDZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404694AbeKTDZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:25:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3715F21731;
        Mon, 19 Nov 2018 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646850;
        bh=R6mK60ulBnm9ohVNTyY4GQK2r6tyXi6Qr/0v9PPd8bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xV6CMBQVzMdd6S2zCNPNJuEP/QX2ccFb1oOt7+xyCYA2v1rC1yOzCjlqVNhL5PxzN
         32/JmA2uBdicYskz2UoTfGfHa8H/W7uY7adkm9+DtBvsIQhqlINL1kKAs1vDS8Yo6M
         XLR60/Kev+oq5mSSloXmzMfPhrtmWwclmqRpYLYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 115/160] fs, elf: make sure to page align bss in load_elf_library
Date:   Mon, 19 Nov 2018 17:29:14 +0100
Message-Id: <20181119162641.879208238@linuxfoundation.org>
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

commit 24962af7e1041b7e50c1bc71d8d10dc678c556b5 upstream.

The current code does not make sure to page align bss before calling
vm_brk(), and this can lead to a VM_BUG_ON() in __mm_populate() due to
the requested lenght not being correctly aligned.

Let us make sure to align it properly.

Kees: only applicable to CONFIG_USELIB kernels: 32-bit and configured
for libc5.

Link: http://lkml.kernel.org/r/20180705145539.9627-1-osalvador@techadventures.net
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reported-by: syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 2963a23f7a80..f010d6c8dd14 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1214,9 +1214,8 @@ static int load_elf_library(struct file *file)
 		goto out_free_ph;
 	}
 
-	len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr +
-			    ELF_MIN_ALIGN - 1);
-	bss = eppnt->p_memsz + eppnt->p_vaddr;
+	len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
+	bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
 	if (bss > len) {
 		error = vm_brk(len, bss - len);
 		if (BAD_ADDR(error))
-- 
2.17.1



