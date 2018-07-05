Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3EDC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C2424069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pfFv7SIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C2424069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeGECnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:43:45 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:43986 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeGEClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:39 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZW028145;
        Thu, 5 Jul 2018 11:39:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZW028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758397;
        bh=Y8UsLeKRYemE0CdhjyHCUFdeCX7SdgqXQgJrFjLkiM8=;
        h=From:To:Cc:Subject:Date:From;
        b=pfFv7SIqInUgiNXW5DRcgjZb1JJ1Oj4BN8MTVaK00M1mnTElGBEy3IKcplhi1LYJx
         LSNlz0i1i5VoLhrsjZizi82Zxj7vGG1P/UnDVYv4NJC3XFpverd7L2v3c2KnQCchFY
         N7DOKKSnSj7HUtI4wwg55MUqPA3YKTvagZP24WHVPm7oNZh/gsVLJsgO8CVBXCMNJZ
         jFIdTSO5f94HNNQBW/NBSBfWSWdN1wiAzZidnmUUY7itQ8zSUKsEW3fdqiBpZZsor9
         sXp3lfVYPQasNjYCEczmuJwP0RoJrRA5neBjgU44mF/cuWmULyCEUEoLS9um51pdG3
         cjqouWQ9SzKtA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] kbuild/kconfig: do not update config during installation
Date:   Thu,  5 Jul 2018 11:39:37 +0900
Message-Id: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The main motivation of this patch series is to suppress the syncconfig
during running installation targets.

V1 consisted of only two patches:
  https://patchwork.kernel.org/patch/10468105/
  https://patchwork.kernel.org/patch/10468103/

I noticed that installation targets would continue running
even if the source tree is not configured at all
because the inclusion of include/config/auto.conf was optional.

So, I added one more patch in V2:
 https://patchwork.kernel.org/patch/10483637/

However, kbuild test robot reported a new warning message was displayed:

Makefile:592: include/config/auto.conf: No such file or directory

This warning is displayed only for Make 4.1 or older.

To fix this annoying warning, I changed Kconfig too,
which leaded to more clean-up, improvements in Kconfig.

So, V3 is a big patch series.



Masahiro Yamada (12):
  kconfig: rename file_write_dep and move it to confdata.c
  kconfig: split out helpers to check file/directory, create directory
  kconfig: remove unneeded directory generation from local*config
  kconfig: create directories needed for syncconfig by itself
  kconfig: make syncconfig update .config regardless of sym_change_count
  kconfig: allow all config targets to write auto.conf if missing
  kbuild: use 'include' directive to load auto.conf from top Makefile
  kbuild: add .DELETE_ON_ERROR special target
  kbuild: do not update config when running install targets
  kbuild: do not update config for 'make kernelrelease'
  kbuild: remove auto.conf and tristate.conf from prerequisites
  kbuild: replace include/config/%.conf with include/config/auto.conf

 Makefile                    |  46 +++++++++------
 scripts/Kbuild.include      |   3 +
 scripts/kconfig/Makefile    |  16 ++---
 scripts/kconfig/conf.c      |  39 +++++++------
 scripts/kconfig/confdata.c  | 139 +++++++++++++++++++++++++++++++++++++-------
 scripts/kconfig/gconf.c     |   1 +
 scripts/kconfig/lkc.h       |   1 -
 scripts/kconfig/lkc_proto.h |   2 +-
 scripts/kconfig/mconf.c     |   1 +
 scripts/kconfig/nconf.c     |   1 +
 scripts/kconfig/qconf.cc    |   2 +
 scripts/kconfig/util.c      |  30 ----------
 12 files changed, 182 insertions(+), 99 deletions(-)

-- 
2.7.4

