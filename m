Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6939C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1742080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yXiT2JB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1742080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbeKTLeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:34:23 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36340 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbeKTLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:34:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAK15ZEX029284;
        Tue, 20 Nov 2018 10:05:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAK15ZEX029284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542675936;
        bh=2k9f55soMPd/Iws6FlSrWOYqKz514YwJQl2vshauAoE=;
        h=From:To:Cc:Subject:Date:From;
        b=yXiT2JB7LNlHMv9ppcREechBTbTG7qYwIr1yRDWRceeY1sWf6OnlTqR04blEhyqM0
         jqmXK9WE79jvjMiF4D6HgP7EiHQ4b/xUAnZYzQjFEL0gNsGtoBKZkBdeOROTXIIqMN
         kXD9rPuGvJi+NwTJPhvK49g7tbb1bB5bT71MZ/XHHD5uyHdk9juymkKnBBlhEHdHYB
         zRlzv4lk+mKBy2sb7NyRX/AjN9SUs/kSKf/PAUrBVfYnftcEYX4VGzNuUveupC2mjo
         7W7DRtWVn3opu6Z9Bte2MC71I4OuUhROzoFcqM6oMms57mtSpMzo+309YRjv09WU7+
         l1fo5RjlQnhBA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH v2 0/9] kbuild: clean-up modversion, TRIM_UNUSED_KSYMS, if_changed_rule, etc.
Date:   Tue, 20 Nov 2018 10:05:21 +0900
Message-Id: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a Kbuild maintainer, I always struggle to keep the core makefiles
clean because people tend to squeeze more and more clutter code into
the kbuild core in order to do what they want to do.

The biggest step forward in this series is to re-implement
the build trick of CONFIG_TRIM_UNUSED_KSYMS in a cleaner way.
scripts/Kbuild.include now looks nice again.
Also, in my rough estimation, building with CONFIG_TRIM_UNUSED_KSYMS
became 40-50 % faster.

Besides those, nice cleanups are here and there.

Masahiro Yamada (9):
  kbuild: let fixdep directly write to .*.cmd files
  kbuild: remove redundant 'set -e' from filechk_* defines
  kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
  kbuild: refactor modversions build rules
  kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
  kbuild: change if_changed_rule for multi-line recipe
  kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
  kbuild: refactor if_changed and if_changed_dep
  kbuild: remove redundant 'set -e' from cmd_* defines

 Makefile                     |  13 +++---
 arch/um/Makefile             |   2 +-
 include/asm-generic/export.h |  13 +++---
 include/linux/export.h       |  18 ++++----
 scripts/Kbuild.include       |  49 +++-----------------
 scripts/Makefile.build       | 105 ++++++++++++++++++-------------------------
 scripts/Makefile.lib         |   2 +-
 scripts/basic/fixdep.c       |  31 ++-----------
 scripts/gen_ksymdeps.sh      |  25 +++++++++++
 scripts/package/Makefile     |   1 -
 10 files changed, 106 insertions(+), 153 deletions(-)
 create mode 100755 scripts/gen_ksymdeps.sh

-- 
2.7.4

