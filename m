Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC2C20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC2C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbeKLFsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49890 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730182AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000oF-24; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001jD-HO; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michal Hocko" <mhocko@suse.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        "Nicolas Pitre" <nicolas.pitre@linaro.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com,
        "Kees Cook" <keescook@chromium.org>,
        "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.337815760@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 253/366] fs, elf: make sure to page align bss in
 load_elf_library
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oscar Salvador <osalvador@suse.de>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/binfmt_elf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1083,9 +1083,8 @@ static int load_elf_library(struct file
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

