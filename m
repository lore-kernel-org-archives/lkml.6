Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D6FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91131208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NN2XCwW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91131208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeJPRBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:01:37 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57575 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJPRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:01:37 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w9G9BLLu029692;
        Tue, 16 Oct 2018 18:11:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w9G9BLLu029692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539681082;
        bh=TZr7U70F1em4iQZV5aISNk6Uw8fHBV39AhiwopUnR88=;
        h=From:To:Cc:Subject:Date:From;
        b=NN2XCwW7vuSmdkLzu1XRSaNslDdwUW5Nk/xbZUgxLWpiC++aadayTGkuzF34YS2d1
         6Xqa/nY7mXP1JiHVmqIMd9eWuvQ3S7H5z+Jw/HREN3lMi3+k+WelRo+S9gTs4ra+TT
         i1ozw1h0wfB84yrsCxbjJi3MH/N+/r6DjcOKpVHgfD9YDlSvo6lS8xgeH4l0vIr80j
         E//9QNlzoU3Uo/yS5I2KRtd8EePZwG8pxHEj76liZYSV/FGxrX/o5v2tqxaYffYlVc
         57wET0/LokZ6Lu81pdqC4Ow31ddAkur+copaPf72pTGIVUse8j5emOi0HN2XW4xi4U
         qNU2N0scSR/hA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kbuild: add scripts/Makefile.toolcheck to check necessary host tools
Date:   Tue, 16 Oct 2018 18:10:50 +0900
Message-Id: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote this patch set to cater to some reports:

 - Bernd Edlinger reports false positive check of libelf
   once CONFIG_UNWINDER_ORC is enabled.
   https://lore.kernel.org/patchwork/patch/960411/

 - Borislav Petkov reports the build fails very late
   if CONFIG_KERNEL_LZ4 is enabled but lz4 is missing.
   https://patchwork.kernel.org/patch/10635381/

From the discussion
https://patchwork.kernel.org/patch/10516049/
people like to see a build error when some host tools
are missing.

So, we need to check host tools in makefiles.
(Or, do not check at all. The build will fail anyway,
but the error message might not be clear enough in some cases.)

A problem is people check host tools
in random places in the top Makefile.
This does not work because the top Makefile is parsed twice
when the include/config/auto.config is updated.
Once with a stale auto.config, and once again with a
new auto.conf.
This will cause false positive build error.

One solution is to provide a systematic way to
do host-tool checks.

I added small macros in scripts/Makefile.toolcheck
to describe tool checks in a Kbuild-ish taste.


Masahiro Yamada (3):
  kbuild: provide a new place to check necessary host tools
  objtool: move libelf check out of top Makefile
  kbuild: check the presence of lzo and lz4 tools when necessary

 Makefile                   | 22 ++++-----------------
 scripts/Makefile.build     |  2 --
 scripts/Makefile.toolcheck | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 20 deletions(-)
 create mode 100644 scripts/Makefile.toolcheck

-- 
2.7.4

