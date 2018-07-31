Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C6FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7C8208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="we3PkLaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7C8208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeGaCdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:33:53 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:52618 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbeGaCdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:33:53 -0400
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 7C9041288;
        Mon, 30 Jul 2018 17:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1532998575;
        bh=6onkBq6Ikvtnr7OaObXrWdNoJwf+AYgkJnkrXLuKW+U=;
        h=Date:From:To:Cc:Subject;
        b=we3PkLaOfssl/Vi5WiGWhsyVJMkj5GqztUtTqP3L0mgUal9nAESDspD0+eMe0O4uF
         mkxGhZ/Z83m4CDnWBQmW2ja0BOtB0+35DIpKTluq1jZebfm0ygbSIah0/owQKb0aK1
         /c++nF8xlWFfpMeHp3va7EAYPoNExD5cFIa4xvcO/IeAtsgpWgqynt37IVaNlDk2Pw
         dwok5xJ562JwwIeH/GTMhlM42H6Wy/0ZdwUlQA1G2DmXppWj6M0uk+At0Fz+tOb1AZ
         4RE/Jh5zVXDRlyhYbJH2yjFSxZERNXFxLQ/qBo7G2P4T4g1KJKyadJK1arD7yP2H65
         MQZQbijGQWGTg==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 7A5A81209;
        Mon, 30 Jul 2018 17:56:15 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:56:15 -0700
From:   Ivan Delalande <colona@arista.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] exec: don't force_sigsegv processes with a pending
 fatal signal
Message-ID: <20180731005615.GA2911@visor>
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
index bdd0eacefdf5..6e8007edbb2d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1656,7 +1656,8 @@ int search_binary_handler(struct linux_binprm *bprm)
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
