Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1EFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1033C222AB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897327;
	bh=LZGIfELqOQFeE763S90ATjwGHwXA6wEja8pBWX9ThrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HSWH/0LfKPJ+ymsfXE13qOh6jWRye9kRJTGEA0ilS+oIgTmaOCl6rs9x4sYz6Z/eG
	 GKKV+x0RTwBIl6QP6RjEIEbT0S1fTBXkdmvIpAmBw0D3wANC2QEAvULRotaa/41jXk
	 thYW15QY6vOI9hohOePBjb1eFBM7iwE9aVBxz6is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbfBKPCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:02:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbfBKPCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:02:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE7E222A7;
        Mon, 11 Feb 2019 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897322;
        bh=LZGIfELqOQFeE763S90ATjwGHwXA6wEja8pBWX9ThrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoQwpX3slCCI3Z/g039mfcqw3HFvF9coimGaO+FD3PkrQ7MYyVjiOBR7GNTGiFsHK
         MnRxFU7AxM6A7nFeO2K9T98T1n5AoYcc/vqxl6n4OJNmYX+n2W0vY8EDWhIjexwD3q
         AhdJ1ZNTVecKbkP8y4k7jZVdX00evXwDO6pvFAOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Du Changbin <changbin.du@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 164/205] scripts/gdb: fix lx-version string output
Date:   Mon, 11 Feb 2019 15:19:22 +0100
Message-Id: <20190211141839.085022574@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

[ Upstream commit b058809bfc8faeb7b7cae047666e23375a060059 ]

A bug is present in GDB which causes early string termination when
parsing variables.  This has been reported [0], but we should ensure
that we can support at least basic printing of the core kernel strings.

For current gdb version (has been tested with 7.3 and 8.1), 'lx-version'
only prints one character.

  (gdb) lx-version
  L(gdb)

This can be fixed by casting 'linux_banner' as (char *).

  (gdb) lx-version
  Linux version 4.19.0-rc1+ (changbin@acer) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #21 SMP Sat Sep 1 21:43:30 CST 2018

[0] https://sourceware.org/bugzilla/show_bug.cgi?id=20077

[kbingham@kernel.org: add detail to commit message]
Link: http://lkml.kernel.org/r/20181111162035.8356-1-kieran.bingham@ideasonboard.com
Fixes: 2d061d999424 ("scripts/gdb: add version command")
Signed-off-by: Du Changbin <changbin.du@gmail.com>
Signed-off-by: Kieran Bingham <kbingham@kernel.org>
Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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
2.19.1



