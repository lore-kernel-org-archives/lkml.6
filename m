Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E792C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9562175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695323;
	bh=yzX3yOPfXHZAsRv4i1lqHC0NmaDrNzvgnQSWp1yz1Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ff1iPZiH72dGV9HWMymgoBOgsQPNJeiGP/Eo4EQW3Ip30ma9Q+0rgmRU/Pk8cpil
	 gRuJXKLSp4xnvgTJxEOblhwZFL4KR0MxNuLaslaZulX4eyr99DJ2eQsu0wTJGBq4Y3
	 HZjOTQY9dvD1Xix3sPBwTvsrli0xKbWD1MhaMtI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfA1QMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732390AbfA1QL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:11:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23572177E;
        Mon, 28 Jan 2019 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691918;
        bh=yzX3yOPfXHZAsRv4i1lqHC0NmaDrNzvgnQSWp1yz1Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hrAmJPpuTBnYAE04e2XcTUP2c+eqZdi87pwT87wEC+87CEupueZQ/iZu5j0oqvPh
         zzd+/PTMDZul0JbmNEhFt69O2/FdFJJh1bMSnxK6uGR/MZYv9voxchPlaMSW1Hqg39
         qr25b6mkJwvEdwcxIajhX33cmX67nQkCt7tIG+/I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Du Changbin <changbin.du@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 258/258] scripts/gdb: fix lx-version string output
Date:   Mon, 28 Jan 2019 10:59:24 -0500
Message-Id: <20190128155924.51521-258-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Du Changbin <changbin.du@gmail.com>

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

