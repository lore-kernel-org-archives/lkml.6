Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1735FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A2D21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="L0/JYsGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A2D21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbeKOSgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:36:33 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:52830 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbeKOSgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:36:32 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAF8RHoX022794;
        Thu, 15 Nov 2018 17:27:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAF8RHoX022794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542270439;
        bh=IRtBlra79ityFxOzerUxtBZ6lgbNtkSmw7waFIWzvW8=;
        h=From:To:Cc:Subject:Date:From;
        b=L0/JYsGCHGw9RdA0nXXyQTKucxaanMg9FPbDoZhP1nH8N6t59KJzqQgkBS3jLzIVp
         9HoQI+x8Ak1IEsWhVRGGeiBZriIttOYRjzXzoqtegTN5mCJRTM8rOyx9bcSup3/y17
         fClIOULsk2a8u+JxIcadlAIhQvLdHCBtci9ny5CRsbUywdnIqsfxP3PUt2xc5587Zh
         NSgWpGqwqhT5S12N+SeQcsrrC+2HgxUzcjJvvz+ruhbp6GRQmuUZqII6VEVpoVFUTS
         PabHxVysRfBFUIc8zENeI4mnff7x0SzMLx9giBbgOd2w1nXxKRwSm6DG8wA7WskVG4
         yYwgqr3/PSJpA==
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
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 0/8] kbuild: clean-up modversion, TRIM_UNUSED_KSYMS, if_changed_rule, etc.
Date:   Thu, 15 Nov 2018 17:27:07 +0900
Message-Id: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
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



Masahiro Yamada (8):
  kbuild: remove redundant 'set -e' from filechk_* defines
  kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
  kbuild: refactor modversions build rules
  kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
  kbuild: change if_changed_rule to accept multi-line recipe
  kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
  kbuild: refactor if_changed and if_changed_dep
  kbuild: remove redundant 'set -e' from cmd_* defines

 arch/um/Makefile             |  2 +-
 include/asm-generic/export.h | 13 +++---
 include/linux/export.h       | 18 ++++----
 scripts/Kbuild.include       | 44 +++-----------------
 scripts/Makefile.build       | 98 +++++++++++++++++++-------------------------
 scripts/Makefile.lib         |  2 +-
 scripts/basic/fixdep.c       | 31 ++------------
 scripts/gen_ksymdeps.sh      | 25 +++++++++++
 scripts/package/Makefile     |  1 -
 9 files changed, 96 insertions(+), 138 deletions(-)
 create mode 100755 scripts/gen_ksymdeps.sh

-- 
2.7.4

