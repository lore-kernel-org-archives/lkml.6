Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02AEECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5102084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nwywHYpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5102084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeGSVqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:46:55 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:59373 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727523AbeGSVqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:46:55 -0400
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2018 17:46:54 EDT
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 8F02D10C3;
        Thu, 19 Jul 2018 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1532033614;
        bh=fT4JI+vJ1G3qXT1/jFNxasArjdZvQQLQmN4wRLC9X+o=;
        h=Date:From:To:Cc:Subject;
        b=nwywHYpkaWVJI8bVzfL+1jvvNlTDg2kAPUGhGnOXOlIoDDskTGbWmbLu5VFZ4WNYJ
         uCXwRnorUNI/6BUkwxMOgpevW8FDs55tN67FceWvlCbc6zwVKSqrkG0HPmIogaYFhs
         oFwFdKSvDatR+LGoAnvu7DDurgbvjF6nJF3p86gxn1MFjah5jxstQpsncNh7tf174n
         IZM+JQpXnW77GY3IdNKaAAnujdyrPgOvvso9d2wT404Tub1B6KL4C214GDAMzZSwoR
         wggFPOkhpL6urVA4JjNiZ4WQdU15L5l19Lgg2p+qd5EJ+2YoCkwcSFBvRoKKZusfpI
         99srOk6vNzDZw==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 80ED410BF;
        Thu, 19 Jul 2018 13:53:34 -0700 (PDT)
Date:   Thu, 19 Jul 2018 13:53:34 -0700
From:   Ivan Delalande <colona@arista.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exec: don't force_sigsegv processes with a pending fatal
 signal
Message-ID: <20180719205334.GA23942@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were seeing unexplained segfaults in coreutils processes and other
basic utilities that we tracked down to binfmt_elf failing to load
segments for ld.so. Digging further, the actual problem seems to occur
when a process gets sigkilled while it is still being loaded by the
kernel. In our case when _do_page_fault goes for a retry it will return
early as it first checks for fatal_signal_pending(), so load_elf_interp
also returns with error and as a result search_binary_handler will
force_sigsegv() which is pretty confusing as nothing actually failed
here.

Fixes: 19d860a140be ("handle suicide on late failure exits in execve() in search_binary_handler()")
Reference: https://lkml.org/lkml/2013/2/14/5
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 fs/exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2d4e0075bd24..620d6489b61c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1657,7 +1657,8 @@ int search_binary_handler(struct linux_binprm *bprm)
 		if (retval < 0 && !bprm->mm) {
 			/* we got to flush_old_exec() and failed after it */
 			read_unlock(&binfmt_lock);
-			force_sigsegv(SIGSEGV, current);
+			if (!fatal_signal_pending(current))
+				force_sigsegv(SIGSEGV, current);
 			return retval;
 		}
 		if (retval != -ENOEXEC || !bprm->file) {
-- 
2.18.0
