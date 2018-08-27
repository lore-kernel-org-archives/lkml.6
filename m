Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48EEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DE1208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JSMj8KGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DE1208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH0GVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:21:04 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19319 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeH0GVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:21:04 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7R2YWB9016286;
        Mon, 27 Aug 2018 11:34:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7R2YWB9016286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535337273;
        bh=sd2nww59g4iiI+YHeknbbkbjmb8vxLHOPeYSzpWtCtk=;
        h=From:To:Cc:Subject:Date:From;
        b=JSMj8KGwKXG79dbeBnw+45Aev4/IJW5Qve4++gLwLnyYeHObeTerfmMUi07fmXWQt
         vEt0bqO5c+Aw8MP1mWaX3OLL0v8Ih/0mPiQmF5MZtyChXczGKz6/f3BwBdxRKvGl4k
         A//LiBn6/hUZYR4hd0HZHqnkOGcKGw6Bw/Ry1rwNXS63ae/hXko0PdtxAGNdhFHYrw
         4wTRJzch/5GxhP2LfLRPM1/EebJ+OyzW4X4QxgEiKy1m3vQvOXzid2hSFrvBsDFOTU
         FyAWYTRr+IjfyIwLY0WOlZRsQqx0uwGox4iwpFZ3WgxYCcwvxUjfiHZD6oWg0tDg3y
         fikq9HkIXzL9w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     reiserfs-devel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] reiserfs: remove workaround code for GCC 3.x
Date:   Mon, 27 Aug 2018 11:33:50 +0900
Message-Id: <1535337230-13222-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

The workaround code in fs/reiserfs/Makefile is obsolete now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 fs/reiserfs/Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/reiserfs/Makefile b/fs/reiserfs/Makefile
index a39a562..bd29c58 100644
--- a/fs/reiserfs/Makefile
+++ b/fs/reiserfs/Makefile
@@ -26,14 +26,5 @@ ifeq ($(CONFIG_REISERFS_FS_POSIX_ACL),y)
 reiserfs-objs += xattr_acl.o
 endif
 
-# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
-# functions are used.  This causes the compiler to advance the stack
-# pointer out of the available stack space, corrupting kernel space,
-# and causing a panic. Since this behavior only affects ppc32, this ifeq
-# will work around it. If any other architecture displays this behavior,
-# add it here.
-ccflags-$(CONFIG_PPC32) := $(call cc-ifversion, -lt, 0400, -O1)
-
 TAGS:
 	etags *.c
-
-- 
2.7.4

