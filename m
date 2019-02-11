Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F88C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144CF21B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896633;
	bh=JPft0HWih1AUGe+uCLt+29lF9sR/QII7GK8rrEcDQ64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BN4VTeVq/99HN+JS6cEKDlwGHejHkNcPywG19WGxS1fSfvQ38ht7Z2denfYEJojtb
	 sxztHS5xot5lIC9pshMjveZGlUg6zQDjfRgXRhLDJ6iIN2bLDyMLIkLznsWKjZOQOu
	 CaJwwZn0r8gwOIRNS+e8oX/QDm74Co2Jg8+18Bd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbfBKOub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388094AbfBKOu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024DC222A1;
        Mon, 11 Feb 2019 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896627;
        bh=JPft0HWih1AUGe+uCLt+29lF9sR/QII7GK8rrEcDQ64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Al7l7eRMXHdoBY4c31WvuHRbrmbX4gn2sHb1vk6xQVCCaVs5NMzTWqbGEKgNNwRWu
         TQv4G3yI2sdLeTRRtSqkUpiaPolwHDNYjnYl0otlizD43Ac/o7VaTVEDpzGQ6Q1V06
         6gecNvwV696Pg0fiILsXXpJlqX5zzl/5d3Z0k8zo=
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
Subject: [PATCH 4.19 247/313] scripts/gdb: fix lx-version string output
Date:   Mon, 11 Feb 2019 15:18:47 +0100
Message-Id: <20190211141909.850312519@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



