Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13611C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C033D219E8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C033D219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753816AbeGEOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:55:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35867 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeGEOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:55:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so1341323wro.3;
        Thu, 05 Jul 2018 07:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vnynUJRrhmyvbhjWglxVURQkDlJBwYoP1B2qLfca2jo=;
        b=RVC7gUhyExdhYAte8zr5sFiWpAiuNvZue6i5pQpVuw84X0/k4rdDEFwsMHv5QTkhar
         tnGAVZGGYiDeVsbRPhlG21kKX+/ok0rvps18OvdYn0GV35i3bTU8thK3GWuJO4Fg/rAU
         lUScG08rcur1WCOCv1qtNTCb7vdHJkmbq65jhf/tNLTJ1awmaisza/9+orw4nY5BntiD
         JZ6/30IJHRSAahsk6JBhMg3ARP05Ha1hOuGIragZjlqx4Ho+5QpdEa8ce2mxVKDldjVq
         kUa3h/V2/J2iDrhZkhuEIUlm/Xkz4P+vfW4HlouWlBI/8AfGfooioeD3bp3WiFL4wqMD
         ANKw==
X-Gm-Message-State: APt69E28Bpsuy6c4DzmSQjGULZPHAGlzWasxHp9BCfHUC9V7zK4OXDOy
        nK/0k+WrMyCLEaxjLNfx/Y0=
X-Google-Smtp-Source: AAOMgpcVYxfwfSJTvLtf17u0PGbJDp+VeAt+PCx/Tx6lqnGdIGuqmdRNDx0beQxCqYaIvPaEjkmDNw==
X-Received: by 2002:adf:c612:: with SMTP id n18-v6mr4729886wrg.177.1530802549492;
        Thu, 05 Jul 2018 07:55:49 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q17-v6sm8845707wrr.7.2018.07.05.07.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 07:55:48 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 0878D123BDA;
        Thu,  5 Jul 2018 16:55:48 +0200 (CEST)
From:   osalvador@techadventures.net
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        nicolas.pitre@linaro.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] fs, elf: Make sure to page align bss in load_elf_library
Date:   Thu,  5 Jul 2018 16:55:39 +0200
Message-Id: <20180705145539.9627-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

The current code does not make sure to page align bss before calling
vm_brk(), and this can lead to a VM_BUG_ON() in __mm_populate()
due to the requested lenght not being correctly aligned.

Let us make sure to align it properly.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com
---
 fs/binfmt_elf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 0ac456b52bdd..816cc921cf36 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1259,9 +1259,8 @@ static int load_elf_library(struct file *file)
 		goto out_free_ph;
 	}
 
-	len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr +
-			    ELF_MIN_ALIGN - 1);
-	bss = eppnt->p_memsz + eppnt->p_vaddr;
+	len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
+	bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
 	if (bss > len) {
 		error = vm_brk(len, bss - len);
 		if (error)
-- 
2.13.6

