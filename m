Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC2EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0DB21019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeLaHUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:20:37 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25217 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbeLaHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:20:37 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 30 Dec 2018 23:20:33 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 75C4940687;
        Sun, 30 Dec 2018 23:20:35 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC v2 0/6] x86: dynamic indirect branch promotion
Date:   Sun, 30 Dec 2018 23:21:06 -0800
Message-ID: <20181231072112.21051-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revised version of optpolines (formerly named retpolines) for
dynamic indirect branch promotion in order to reduce retpoline overheads
[1].

This version address some of the concerns that were raised before.
Accordingly, the code was slightly simplified and patching is now done
using the regular int3/breakpoint mechanism.

Outline optpolines for multiple targets was added. I do not think the
way I implemented it is the correct one. In my original (private)
version, if there are more targets than the outline block can hold, the
outline block is completely removed. However, I think this is
more-or-less how Josh wanted it to be.

The code modifications are now done using a gcc-plugin. This allows to
easily ignore code from init and other code sections. I think it should
also allow us to add opt-in/opt-out support for each branch, for example
by marking function pointers using address-space attributes.

All of these changes required some optimizations to go away to keep the
code simple. I have still did not run the benchmarks again. 

So I might have not addressed all the open issues, but it is rather hard
to finish the implementation since some still open high-level decisions
affect the way in which optimizations should be done.

Specifically:

- Is it going to be the only indirect branch promotion mechanism? If so,
  it probably should also provide interface similar to Josh's
  "static-calls" with annotations.

- Should it also be used when retpolines are disabled (in the config)?
  This does complicate the implementation a bit (RFC v1 supported it).

- Is it going to be opt-in or opt-out? If it is an opt-out mechanism,
  memory and performance optimizations need to be more aggressive.

- Do we use periodic learning or not? Josh suggested to reconfigure the
  branches whenever a new target is found. However, I do not know at
  this time how to do learning efficiently, without making learning much
  more expensive.

[1] https://lore.kernel.org/patchwork/cover/1001332/

Nadav Amit (6):
  x86: introduce kernel restartable sequence
  objtool: ignore instructions
  x86: patch indirect branch promotion
  x86: interface for accessing indirect branch locations
  x86: learning and patching indirect branch targets
  x86: outline optpoline

 arch/x86/Kconfig                             |    4 +
 arch/x86/entry/entry_64.S                    |   16 +-
 arch/x86/include/asm/nospec-branch.h         |   83 ++
 arch/x86/include/asm/sections.h              |    2 +
 arch/x86/kernel/Makefile                     |    1 +
 arch/x86/kernel/asm-offsets.c                |    9 +
 arch/x86/kernel/nospec-branch.c              | 1293 ++++++++++++++++++
 arch/x86/kernel/traps.c                      |    7 +
 arch/x86/kernel/vmlinux.lds.S                |    7 +
 arch/x86/lib/retpoline.S                     |   83 ++
 include/linux/cpuhotplug.h                   |    1 +
 include/linux/module.h                       |    9 +
 kernel/module.c                              |    8 +
 scripts/Makefile.gcc-plugins                 |    3 +
 scripts/gcc-plugins/x86_call_markup_plugin.c |  329 +++++
 tools/objtool/check.c                        |   21 +-
 16 files changed, 1872 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kernel/nospec-branch.c
 create mode 100644 scripts/gcc-plugins/x86_call_markup_plugin.c

-- 
2.17.1

