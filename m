Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B781C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06B32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfARQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:37:38 -0500
Received: from verein.lst.de ([213.95.11.211]:44649 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfARQhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:37:38 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 6A99268CEB; Fri, 18 Jan 2019 17:37:36 +0100 (CET)
To:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v7 0/3] arm64: ftrace with regs
Message-Id: <20190118163736.6A99268CEB@newverein.lst.de>
Date:   Fri, 18 Jan 2019 17:37:36 +0100 (CET)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So here's v7 of ftrace with regs only. I've split out the CC_FLAGS_FTRACE
cleanup and the gcc activation into separate patches, respectively. The set
should include all of Mark's requested changes. Most notably, it now patches
in the first insn "mov x9, lr" right at startup, to avoid the races we
discussed; I'm conveniently abusing the initial _make_nop for that. The empty
mcount: routine caused a lot of Q's, so it's gone now.

I updated the accompanying livepatch patches here as well, in case somebody is
interested ;) They have only been updated to match this current ftrace-regs set,
not more.

The whole series applies cleanly on 5.0-rc2

in detail:

changes since v6:

* change the stack layout once more; I hope I have it the "standard" way now.
  And yes, it looks simpler and cleaner; thanks, Mark, for nagging.

* split out the independent Kconfig and Makefile changes

* fixed style issues

* s/fp/x29/g

* MCOUNT_ADDR is now merely a 64-bit magic, as this is totally sufficient.

* QUICK_LR_SAVE renamed back to MOV_X9_X30.

* place MOV_X9_X30 insns on bootup, and only flip b <-> nop at runtime

* graph tracer "ifdeffery" reshuffle

	Torsten
  
