Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeDYLNe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:13:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752823AbeDYLN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:13:29 -0400
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 00/11] vsprintf: Prevent silent crashes and consolidate error handling
Date: Wed, 25 Apr 2018 13:12:40 +0200
Message-Id: <20180425111251.13246-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
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

I did my best to address the feedback. Note that there is still the
(efault) error message. But it is accompanied with WARN() when
panic_on_warn is not enabled. I hope that it makes it more acceptable.


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


Petr Mladek (11):
  vsprintf: Shuffle misc pointer to string functions
  vsprintf: Add missing const ptr qualifier to prt_to_id()
  vsprintf: Consistent %pK handling for kptr_restrict == 0
  vsprintf: Do not check address of well-known strings
  vsprintf: Consolidate handling of unknown pointer specifiers
  vsprintf: Factor out %p[iI] handler as ip_addr_string()
  vsprintf: Factor out %pV handler as va_format()
  vsprintf: Factor out %pO handler as kobject_string()
  vsprintf: Prevent crash when dereferencing invalid pointers
  vsprintf: WARN() on invalid pointer access
  vsprintf: Avoid confusion between invalid address and value

 Documentation/core-api/printk-formats.rst |  11 +
 lib/test_printf.c                         |  44 ++-
 lib/vsprintf.c                            | 549 ++++++++++++++++++------------
 3 files changed, 372 insertions(+), 232 deletions(-)

-- 
2.13.6
