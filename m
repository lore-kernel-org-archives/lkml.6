Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A3DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7899320845
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiJ8uQL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7899320845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeIAQud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeIAQud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:50:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A0962083B;
        Sat,  1 Sep 2018 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535805517;
        bh=yrA8Izz7I4BDIPMaW2hIHPnRrsVRlQC9HKKS4CzJU/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PiJ8uQL+uf8MHpHDFvAoXGy+BJH6Xl4Y8Not5xBf2K3olecPgt6IE5u6HdqMtGXEP
         cm6ivAdm7Q+SiLQVUscDETQVzMRrG/n0gOf5WYO2Tn4rXsUR4nDTiSG/YslKXz1hEb
         nCXQVyD6OkitpjBysHbvCLE0ZwyRXLLl41JtE1k4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: linker script: GCOV kernel may refers data in __exit
Date:   Sat,  1 Sep 2018 21:38:13 +0900
Message-Id: <153580549235.10130.1495077983569784123.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180901185017.0a81bc3e61f5d021664f13f3@kernel.org>
References: <20180901185017.0a81bc3e61f5d021664f13f3@kernel.org>
In-Reply-To: <20180901185017.0a81bc3e61f5d021664f13f3@kernel.org>
References: <20180901185017.0a81bc3e61f5d021664f13f3@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCOV kernel embeds counters in the kernel for each line
and a part of that embed in __exit text. So we need to
keep the __exit text if CONFIG_GCOV_KERNEL=y.

Without this patch, if we discards __exit text (e.g.
disables CONFIG_GENERIC_BUG, CONFIG_JUMP_LABEL and
CONFIG_SMP_ON_UP) but enables CONFIG_GCOV_PROFILE_FTRACE,
ld will error like below on ARM.

`.text.exit' referenced in section `.ARM.exidx.text.exit' of
kernel/trace/trace_clock.o: defined in discarded section `.text.exit'
of kernel/trace/trace_clock.o

To fix this issue, we keep __exit when CONFIG_GCOV_KERNEL=y.

The reason why not depending CONFIG_GCOV_PROFILE_X, is
that the Documentation/dev-tools/gcov.rst says that the
developer can enable gcov profile on a file or a directory
by customizing Makefile, and that will only depend on
CONFIG_GCOV_KERNEL.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/vmlinux.lds.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index ae5fdff18406..baaacee9f5ce 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -9,7 +9,8 @@
 #endif
 
 #if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
-	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
+	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL) || \
+	defined(CONFIG_GCOV_KERNEL)
 #define ARM_EXIT_KEEP(x)	x
 #define ARM_EXIT_DISCARD(x)
 #else

