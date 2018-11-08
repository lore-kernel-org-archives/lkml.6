Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD46ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3108620825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3108620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeKIFSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:18:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725739AbeKIFSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:18:33 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7psjOG2r6ZMX; Thu,  8 Nov 2018 20:41:36 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FBB11EC02D1;
        Thu,  8 Nov 2018 20:41:36 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, arnd@arndb.de,
        aryabinin@virtuozzo.com, Boqun Feng <boqun.feng@gmail.com>,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxdrivers@attotech.com,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] locking/atomics: Fix out-of-tree build
Date:   Thu,  8 Nov 2018 20:41:28 +0100
Message-Id: <20181108194128.13368-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Building a kernel out of tree with:

  make O=/tmp/b oldconfig
  cd /tmp/b
  make

gives this:

  CALL    /mnt/kernel/kernel/linux/scripts/atomic/check-atomics.sh
/bin/bash: scripts/atomic/check-atomics.sh: No such file or directory
make[3]: *** [/mnt/kernel/kernel/linux/./Kbuild:86: old-atomics] Error 127
make[3]: *** Waiting for unfinished jobs....

Make the command use the proper build prerequisite which is the absolute
path to the script.

Fixes: 8d32588077bd ("locking/atomics: Check generated headers are up-to-date")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: arnd@arndb.de
Cc: aryabinin@virtuozzo.com
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: catalin.marinas@arm.com
Cc: dvyukov@google.com
Cc: glider@google.com
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxdrivers@attotech.com
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 Kbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kbuild b/Kbuild
index 47c9fe175bd9..780048056ac5 100644
--- a/Kbuild
+++ b/Kbuild
@@ -80,7 +80,7 @@ always += old-atomics
 targets += old-atomics
 
 quiet_cmd_atomics = CALL    $<
-      cmd_atomics = $(CONFIG_SHELL) scripts/atomic/check-atomics.sh
+      cmd_atomics = $(CONFIG_SHELL) $<
 
 old-atomics: scripts/atomic/check-atomics.sh FORCE
 	$(call cmd,atomics)
-- 
2.19.1

