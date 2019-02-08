Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92722C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE1420855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfBHPYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:59810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbfBHPYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CAE9AD38;
        Fri,  8 Feb 2019 15:24:04 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v6 0/9] vsprintf: Prevent silent crashes and consolidate error handling
Date:   Fri,  8 Feb 2019 16:23:01 +0100
Message-Id: <20190208152310.29531-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crash in vsprintf() might be silent when it happens under logbuf_lock
in vprintk_emit(). This patch set prevents most of the crashes by probing
the address. The check is done only by %s and some %p* specifiers that need
to dereference the address.

Only the first byte of the address is checked to keep it simple. It should
be enough to catch most problems.

The check is explicitly done in each function that does the dereference.
It helps to avoid the questionable strchr() of affected specifiers. This
change motivated me to do some preparation patches that consolidated
the error handling and cleaned the code a bit.

I did my best to address the feedback against v5.


Note: Kbuild test robot reported slightly increased size of
      the tiny kernel on i386. I was able to get close to
      the original size with some dirty hacks. I think that
      the 0.03% sise is not worth it.

      Also I tried to remove all noinline_for_stack annotations.
      It surprisingly increased the size of the tiny kernel on i386.
      In addition, everything got inlined into pointer() function.
      It became a huge and hard to debug beast. I tend to leave it
      as is for now.


Changes against v5:

	+ Rebased on top of current Linus' tree
	+ Removed already included patch adding const qualifier
	  to ptr_to_id()
	+ Removed controversial patch adding WARN() on invalid pointers
	  [Rasmus, Sergey, Andy]
	+ Reshuffled changes to do all refactoring first.
	+ Added handling also for the new %pt* modifiers
	+ Use better descriptive function names [Andy]:
		+ valid_string() -> string_nocheck()
		+ valid_pointer_access() -> check_pointer()
		+ check_pointer_access() -> check_pointer_msg()
	+ Fixed typo and formatting [Andy]

Changes against v4:

	+ rebased on top of
git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-4.18
	+ Added missing conts into ptr_to_ind() in a separate patch
	+ Renamed __string to valid_string()
	+ Avoid WARN() for invalid poimter specifiers
	+ Removed noinline_for_stack where it was not really useful
	+ WARN() when accessing invalid non-NULL address

Changes against v3:

	+ Add valid_pointer_access() to do the check and store the error
	  message in one call.
	+ Remove strchr(). Instead, validate the address in functions
	  that dereference the address.
	+ Use probe_kernel_address() instead of probe_kernel_real().
	+ Do the check only for unknown address.
	+ Consolidate handling of unsupported pointer modifiers.

Changes against v2:

	+ Fix handling with strchr(string, '\0'). Happens with
	  %p at the very end of the string.
	+ Even more clear commit message
	+ Documentation/core-api/printk-formats.rst update.
	+ Add check into lib/test_printf.c.

Changes against v1:

	+ Do not check access for plain %p.
	+ More clear commit message.


Petr Mladek (9):
  vsprintf: Shuffle restricted_pointer()
  vsprintf: Consistent %pK handling for kptr_restrict == 0
  vsprintf: Do not check address of well-known strings
  vsprintf: Factor out %p[iI] handler as ip_addr_string()
  vsprintf: Factor out %pV handler as va_format()
  vsprintf: Factor out %pO handler as kobject_string()
  vsprintf: Consolidate handling of unknown pointer specifiers
  vsprintf: Prevent crash when dereferencing invalid pointers
  vsprintf: Avoid confusion between invalid address and value

 Documentation/core-api/printk-formats.rst |   8 +
 lib/test_printf.c                         |  62 ++---
 lib/vsprintf.c                            | 409 ++++++++++++++++++------------
 3 files changed, 286 insertions(+), 193 deletions(-)

-- 
2.13.7

