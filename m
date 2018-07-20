Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D615ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC24620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LB5jJhTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC24620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeGTIfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:35:12 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28855 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeGTIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:35:12 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdiq008048;
        Fri, 20 Jul 2018 16:46:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdiq008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072799;
        bh=zJroUBO1wy+a8dN1vybMLf1niaR7c9LCNjsqDbF+BFA=;
        h=From:To:Cc:Subject:Date:From;
        b=LB5jJhTbcD2LZ3nMcY7puQIy10rGgorwbQ2Yph0h8QjMhZ6xzdBjOM1UeaG1dBDcH
         5seTVDyctg5f5d1Px5ALiKfEbplknTVEIn9/L4htqfZx/jhYzahuEFPhl6xk9MyB/e
         CFjX1NAevjKnIBgaB9YZg6wbPMAFMXMj8f63EbRkVWdTfd4U8dcPYQrn3jISMb2FB/
         KuXWBVxFAIjquChZXtV0YtO4jO+AlTA5MHkeJFo58Yft4qF6Ub8y7hneS8Dkbo9nuQ
         Nii0UGYJBqCJMMRSwdqcvAiu0nWaihnA8hC5+IYHHGvnZNnIhZtTNSYkh+KnuZlg6n
         4U5minbTfvvCA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] kbuild/kconfig: do not update config during installation
Date:   Fri, 20 Jul 2018 16:46:25 +0900
Message-Id: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
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

So, V3 became a big patch series.

Only a few changes for V4.
 - I dropped the last patch in v3.
 - I am keeping include/config/auto.conf as the prerequisite of modules.builtin (11/11)


Masahiro Yamada (11):
  kconfig: rename file_write_dep and move it to confdata.c
  kconfig: split out useful helpers in confdata.c
  kconfig: remove unneeded directory generation from local*config
  kconfig: create directories needed for syncconfig by itself
  kconfig: make syncconfig update .config regardless of sym_change_count
  kconfig: allow all config targets to write auto.conf if missing
  kbuild: use 'include' directive to load auto.conf from top Makefile
  kbuild: add .DELETE_ON_ERROR special target
  kbuild: do not update config when running install targets
  kbuild: do not update config for 'make kernelrelease'
  kbuild: remove auto.conf from prerequisite of phony targets

 Makefile                    |  44 +++++++++------
 scripts/Kbuild.include      |   3 +
 scripts/kconfig/Makefile    |  16 ++----
 scripts/kconfig/conf.c      |  39 +++++++------
 scripts/kconfig/confdata.c  | 135 +++++++++++++++++++++++++++++++++++++-------
 scripts/kconfig/gconf.c     |   1 +
 scripts/kconfig/lkc.h       |   1 -
 scripts/kconfig/lkc_proto.h |   2 +-
 scripts/kconfig/mconf.c     |   1 +
 scripts/kconfig/nconf.c     |   1 +
 scripts/kconfig/qconf.cc    |   2 +
 scripts/kconfig/util.c      |  30 ----------
 12 files changed, 177 insertions(+), 98 deletions(-)

-- 
2.7.4

