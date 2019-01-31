Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855BFC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BC6218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AX9iEGcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfAaDQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:16:48 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:52819 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfAaDQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:16:48 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0V3FgUg006531;
        Thu, 31 Jan 2019 12:15:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0V3FgUg006531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548904543;
        bh=I34mJ3HnIZyCkcu2RfosMy19Oz6QkmEQV1WPpelIdq0=;
        h=From:To:Cc:Subject:Date:From;
        b=AX9iEGcBwSq3DaVOOqyIP2Ok9F+w4636tcq5uWQXvxUkRaGdChohmGztx0NJz69U0
         xEdrU4N/CJEXJLD9x6h8sSOvRfxQNT0BAG3mla3CQxYuI1ylJy/OizCMrCSBu24wz8
         nMUsvR5IBBE9HQ8RMHeaM5RE0CXyqy10rTlDY/+R2+ZIAmYF1qUhRrvxqWzYdz5ysa
         jvxRG93qACY/7x6WRaICLXvDZ0jmf0j39bM4QJSiDuXfPc9EfwMJjZmzfAogdPpoRF
         U7HVHQ9XBNeUoAkaYfSApza3hvm6/AixXgpyAUdN9hrxDWppqxb5EEEJggw3pORoOv
         H5m7muAzcCYdw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matteo Croce <mcroce@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Laura Abbott <labbott@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] bpfilter: remove extra header search paths for bpfilter_umh
Date:   Thu, 31 Jan 2019 12:15:35 +0900
Message-Id: <1548904535-9853-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the header search paths -Itools/include and
-Itools/include/uapi are not used. Let's drop the unused code.

We can remove -I. too by fixing up one C file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Perhaps, are these extra header search paths for
more upstreaming in the future?

If this patch is rejected, I will send an alternative one.

To clean up the Kbuild core,
I want to drop as many unused header search paths as possible.


 net/bpfilter/Makefile | 1 -
 net/bpfilter/main.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 0947ee7..5d6c776 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -5,7 +5,6 @@
 
 hostprogs-y := bpfilter_umh
 bpfilter_umh-objs := main.o
-KBUILD_HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
 HOSTCC := $(CC)
 
 ifeq ($(CONFIG_BPFILTER_UMH), y)
diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
index 1317f10..61ce845 100644
--- a/net/bpfilter/main.c
+++ b/net/bpfilter/main.c
@@ -6,7 +6,7 @@
 #include <sys/socket.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include "include/uapi/linux/bpf.h"
+#include "../../include/uapi/linux/bpf.h"
 #include <asm/unistd.h>
 #include "msgfmt.h"
 
-- 
2.7.4

