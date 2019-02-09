Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF3C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A18D218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="boy6UUUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfBIXJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 18:09:19 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:59096 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfBIXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 18:09:17 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8CB2F5C210A;
        Sun, 10 Feb 2019 00:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549753754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=yelkleMCJXLHP5LlESFJtU0Z18t/+Mx5P7qCJU7puu8=;
        b=boy6UUUDaweYefxBP4z+oAdgfxYxs8AXx7bmhFEwkY5EBzvu+4MtumDximF4Nk1y85uiOs
        rHjjcWZvW19PLjWqk8ZI4JdqHueJSpGqgzBs+NTmktnmECFIJf6jgRp9fsf/SitCisKVr8
        1o2S/ckZMqNlSgYzS3GGZD7P0BMJhd8=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/5] ARM: convert to unified syntax
Date:   Sun, 10 Feb 2019 00:08:57 +0100
Message-Id: <cover.1549753425.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset converts all assembly code to unified assembler
language (UAL) compatible assembly code. From what I can tell,
this mainly boils down to using conditional infixes instead of
postfixes.

Most of the conversion has been done using the following regular
expression:
  find ./arch/arm/ -name "*.[hSc]" -exec sed -i -r \
    "s/^((\s*[._a-zA-Z0-9]*[\:\(])?\s*)([a-z]{3})(eq|ne|cs|hs|cc|lo|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)([a-z]{1,2})(\s)/\1\3\5\4\6/"
\
    {} \;

The expression resulted in some false positives and missed some
instances where infix conditionals have been used. With this
changes applied, I compiled several kernel configurations
successfully and without a warning.

The file arch/arm/probes/kprobes/test-arm.c is still using some
divided syntax assembler.

This does not allow to use LLVM's integrated assembler just yet,
there is still some assembler which the integrated assembler does
not like (yet). But it is a big step towards that direction.

--
Stefan

Stefan Agner (5):
  ARM: use unified assembler in macros
  ARM: use unified assembler in headers
  ARM: use unified assembler in assembly files
  ARM: use unified assembler in c files
  ARM: warn if divided syntax assembler is used

 arch/arm/Makefile                             |  7 +---
 arch/arm/boot/bootp/init.S                    |  2 +-
 arch/arm/boot/compressed/ll_char_wr.S         |  4 +-
 arch/arm/include/asm/assembler.h              | 12 +++---
 .../include/asm/hardware/entry-macro-iomd.S   | 10 ++---
 arch/arm/include/asm/vfpmacros.h              |  8 ++--
 arch/arm/include/debug/tegra.S                |  2 +-
 arch/arm/kernel/debug.S                       |  2 +-
 arch/arm/kernel/entry-armv.S                  | 12 +++---
 arch/arm/kernel/entry-common.S                |  2 +-
 arch/arm/kernel/entry-header.S                |  8 ++--
 arch/arm/lib/bitops.h                         |  8 ++--
 arch/arm/lib/clear_user.S                     |  2 +-
 arch/arm/lib/copy_from_user.S                 |  2 +-
 arch/arm/lib/copy_page.S                      |  4 +-
 arch/arm/lib/copy_template.S                  |  4 +-
 arch/arm/lib/copy_to_user.S                   |  2 +-
 arch/arm/lib/csumpartial.S                    | 20 ++++-----
 arch/arm/lib/csumpartialcopygeneric.S         |  4 +-
 arch/arm/lib/csumpartialcopyuser.S            |  2 +-
 arch/arm/lib/div64.S                          |  4 +-
 arch/arm/lib/floppydma.S                      | 10 ++---
 arch/arm/lib/io-readsb.S                      | 20 ++++-----
 arch/arm/lib/io-readsl.S                      |  2 +-
 arch/arm/lib/io-readsw-armv3.S                |  6 +--
 arch/arm/lib/io-readsw-armv4.S                | 12 +++---
 arch/arm/lib/io-writesb.S                     | 20 ++++-----
 arch/arm/lib/io-writesl.S                     |  2 +-
 arch/arm/lib/io-writesw-armv3.S               |  2 +-
 arch/arm/lib/io-writesw-armv4.S               |  6 +--
 arch/arm/lib/lib1funcs.S                      |  4 +-
 arch/arm/lib/memcpy.S                         |  4 +-
 arch/arm/lib/memmove.S                        | 24 +++++------
 arch/arm/lib/memset.S                         | 42 +++++++++----------
 .../mach-ks8695/include/mach/entry-macro.S    |  2 +-
 arch/arm/mach-tegra/reset-handler.S           |  2 +-
 arch/arm/mm/cache-v6.S                        |  8 ++--
 arch/arm/mm/copypage-v4mc.c                   |  3 +-
 arch/arm/mm/copypage-v4wb.c                   |  3 +-
 arch/arm/mm/copypage-v4wt.c                   |  3 +-
 arch/arm/mm/proc-v7m.S                        |  4 +-
 41 files changed, 150 insertions(+), 150 deletions(-)

-- 
2.20.1

