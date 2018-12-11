Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2716BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1EC2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lOb2hJb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1EC2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeLKLD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:03:58 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:40153 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLKLD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:03:56 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5b017210;
        Tue, 11 Dec 2018 20:01:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5b017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526073;
        bh=Z/kHxnD36c3oVOGfo1iWK8KYD5sXAJ88UzOGKFNqvfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lOb2hJb4WTGHwsHZAMoJG6Axbi3gbyL/FI1KnvYeUbegRSTFmInqWEQMhaNjFFMUh
         IYRRTFww77M5vu8WEf0HR+iqrqAdNeZVQeoCQCCBhfjVtmzTRWwTDB2VESsENB2xnX
         0f3UYJweUyciKDaiRjShBvhDY74qJYy8eBTk27i2WPWsWv5ESdFIfEucfQpTKXlPR0
         V7ZHnwdADLDaG/cvFu9xTh4IqfxIdnrkg3v9hAI7b8yQ0JSOrfjVnBKw61MZK6vvse
         kY0FUQtdbpeoW9S46ipXyrWyDPQqPCcUMpU2IoCXo+MhYll8oE5Kj2v/pPKvv7dg8i
         sCJ5D+/UClOsg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/27] kconfig: remove all reduce/shift conflicts, refactor lexer, fix various issues
Date:   Tue, 11 Dec 2018 20:00:43 +0900
Message-Id: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When I tryed to change something, I was often hit by annoying
shift/reduce conflicts in the parser.

The lexer and parser are too cluttered.

So, I decided to clean-up now.

  - Fix all shift/reduce conflicts in the parser

  - Rewrite the lexer. The linear keyword search was removed.
    The number of states descreased from 6 to 4.

  - Fix various subtle issues



Masahiro Yamada (27):
  kconfig: fix file name and line number of warn_ignored_character()
  kconfig: fix memory leak when EOF is encountered in quotation
  kconfig: require T_EOL to reduce visible statement
  kconfig: remove unneeded pattern matching to whitespaces
  kconfig: refactor pattern matching in STRING state
  kconfig: fix ambiguous grammar in terms of new lines
  kconfig: clean up EOF handling in the lexer
  kconfig: warn no new line at end of file
  kconfig: remove grammatically ambiguous "unexpected option" diagnostic
  kconfig: remove grammatically ambiguous option_error
  kconfig: remove redundant if_block rule
  kconfig: remove redundant menu_block rule
  kconfig: loosen the order of "visible" and "depends on" in menu entry
  kconfig: rename depends_list to comment_option_list
  kconfig: remove redundant token defines
  kconfig: use distinct tokens for type and default properties
  kconfig: refactor scanning and parsing "option" properties
  kconfig: use specific tokens instead of T_ASSIGN for assignments
  kconfig: use T_WORD instead of T_VARIABLE for variables
  microblaze: surround string default in Kconfig with double quotes
  treewide: surround file paths in Kconfig files with double quotes
  kconfig: ban the use of '.' and '/' in unquoted words
  kconfig: refactor end token rules
  kconfig: stop associating kconf_id with yylval
  kconfig: switch to ASSIGN_VAL state in the second lexer
  kconfig: update current_pos in the second lexer
  kconfig: remove keyword lookup table entirely

 arch/arm/Kconfig                 |   2 +-
 arch/arm/kvm/Kconfig             |   2 +-
 arch/arm64/Kconfig               |   2 +-
 arch/arm64/kvm/Kconfig           |   2 +-
 arch/ia64/Kconfig                |   2 +-
 arch/m68k/Kconfig                |   6 +-
 arch/microblaze/Kconfig.platform |   2 +-
 arch/mips/kvm/Kconfig            |   2 +-
 arch/openrisc/Kconfig            |   2 +-
 arch/powerpc/Kconfig             |   4 +-
 arch/powerpc/kvm/Kconfig         |   2 +-
 arch/riscv/Kconfig               |   2 +-
 arch/s390/Kconfig                |   2 +-
 arch/s390/kvm/Kconfig            |   2 +-
 arch/sh/Kconfig                  |   2 +-
 arch/sparc/Kconfig               |   2 +-
 arch/x86/Kconfig                 |   2 +-
 arch/x86/kvm/Kconfig             |   2 +-
 block/Kconfig                    |   2 +-
 crypto/Kconfig                   |   4 +-
 drivers/crypto/Kconfig           |   2 +-
 drivers/gpu/drm/i915/Kconfig     |   2 +-
 drivers/hwmon/Kconfig            |   2 +-
 drivers/i2c/Kconfig              |   6 +-
 drivers/pps/Kconfig              |   4 +-
 drivers/ras/Kconfig              |   2 +-
 drivers/thermal/Kconfig          |   2 +-
 drivers/w1/Kconfig               |   4 +-
 kernel/Kconfig.preempt           |   2 +-
 lib/Kconfig.debug                |   4 +-
 scripts/kconfig/kconf_id.c       |  52 --------
 scripts/kconfig/lkc.h            |  19 +--
 scripts/kconfig/menu.c           |  43 +++---
 scripts/kconfig/preprocess.c     |   3 +-
 scripts/kconfig/zconf.l          | 232 +++++++++++++++++---------------
 scripts/kconfig/zconf.y          | 280 ++++++++++++++++-----------------------
 security/Kconfig                 |  16 +--
 security/integrity/Kconfig       |   4 +-
 38 files changed, 313 insertions(+), 414 deletions(-)
 delete mode 100644 scripts/kconfig/kconf_id.c

-- 
2.7.4

