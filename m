Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DD021104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YgJws5sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DD021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeKLCJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:09:38 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:37582 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbeKLCJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:09:38 -0500
Received: from localhost.localdomain (unknown [31.221.87.67])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CEFFEDE;
        Sun, 11 Nov 2018 17:20:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541953239;
        bh=3SufsXOrKZU9+5zIKBCCraZzR7hq60talMyw219FL58=;
        h=From:To:Cc:Subject:Date:From;
        b=YgJws5sfmv7pt3QHDibne5sFVKkvbgv9UXI7Wtg1QCmeN/vpBpJL2165Nbw5TpWYV
         vWSxAUKCrde9ag+7Fo4olUPWVNGxpCJm06F0Ov04ikBtv0DIF11gtg/lpb++ZhXsTO
         Lst4XRbvN8L3J1Wn05Y3B86FZ3Jtw32RdeTfrLQA=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org, Du Changbin <changbin.du@gmail.com>
Subject: [PATCH v4] scripts/gdb: fix lx-version string output
Date:   Sun, 11 Nov 2018 16:20:35 +0000
Message-Id: <20181111162035.8356-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Du Changbin <changbin.du@gmail.com>

A bug is present in GDB which causes early string termination when
parsing variables. This has been reported [0], but we should ensure that
we can support at least basic printing of the core kernel strings.

For current gdb version (has been tested with 7.3 and 8.1), 'lx-version'
only prints one character.
(gdb) lx-version
L(gdb)

This can be fixed by casting 'linux_banner' as (char *).
(gdb) lx-version
Linux version 4.19.0-rc1+ (changbin@acer) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #21 SMP Sat Sep 1 21:43:30 CST 2018

[0] https://sourceware.org/bugzilla/show_bug.cgi?id=20077

Fixes: 2d061d999424 ("scripts/gdb: add version command")
Signed-off-by: Du Changbin <changbin.du@gmail.com>
Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
[Kieran: Added detail to commit message]
Signed-off-by: Kieran Bingham <kbingham@kernel.org>
---

Andrew - could you consider this patch for inclusion in your tree
please?

Regards

Kieran

 scripts/gdb/linux/proc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 086d27223c0c..0aebd7565b03 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -41,7 +41,7 @@ class LxVersion(gdb.Command):
 
     def invoke(self, arg, from_tty):
         # linux_banner should contain a newline
-        gdb.write(gdb.parse_and_eval("linux_banner").string())
+        gdb.write(gdb.parse_and_eval("(char *)linux_banner").string())
 
 LxVersion()
 
-- 
2.17.1

