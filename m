Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeE1BrH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 21:47:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37879 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752934AbeE1BrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 21:47:06 -0400
X-ME-Proxy: <xmx:mV8LWxumUdYwyBRB0xTwONiqMdgvMjET20124FhglpfZLvP8hylBdQ>
X-ME-Proxy: <xmx:mV8LW3pSHD01pkz8nXYT5SF0K1KQuDUyo0W7ZDl06wbdoG1Mm-K5ww>
X-ME-Proxy: <xmx:mV8LW5QyWEMHWe7MnaQNBfgw2rSqRFXPyrdj6QiuNFS60njZGamneg>
X-ME-Proxy: <xmx:mV8LW0aIN_i0mfH_08yKFI9GD29XNzGq0zN1UxecEFCXs9xkon04tg>
X-ME-Proxy: <xmx:mV8LWy7PXU9GVwVeIiCrGutI9gUWS6jRbKARmuvvPS-oslG8aEWYlQ>
X-ME-Proxy: <xmx:mV8LWxeWqjWkFIbYJVIbnSA5gm1MlkjW3zJ1Jxa3eptljAYzb553tQ>
X-ME-Sender: <xms:mV8LWxMvfgTl1keT3pA-wyphHk6QudDJQFgPaovYsNDXy_i5kkXjBA>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] enable early printing of hashed pointers
Date: Mon, 28 May 2018 11:46:38 +1000
Message-Id: <1527472002-11571-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently printing pointers early in the boot sequence can result in a
dummy string '(____ptrval____)' being printed.  While resolving this
issue it was noticed that we can use the hw RNG if available for hashing
pointers.

Patch one and two do the ground work to be able to use hw RNG removing
from get_random_bytes_arch() the call to get_random_bytes() and
returning the number of bytes of random material successfully returned. 

Patch three uses the hw RNG to get keying material if it is available.

Patch four further assists debugging early in the boot sequence for
machines that do not have a hw RNG by adding a command line option
'debug_boot_weak_hash'.  If enabled, non-cryptographically secure hashing
is used instead of siphash so we can hash at any time. 

During the versions of this set I have been totally confused about which
patches go through which tree.  This version again puts all 4 patches
together in the hope they will go through Andrew's tree.


Steve,

Could you please take a quick squiz at the final 2 patches if you get a
chance.  I assumed we are in preemptible context during early_init based
on your code (and code comment) and called static_branch_disable()
directly if hw RNG returned keying material.  It's a pretty simple
change but I'd love to get someone else to check I've not noob'ed it.


thanks,
Tobin.

v6
 - Rebase on top of Steve's patch (fixing race condition).  Uses static
   branch instead of memory barrier.

v5
 - Use 'upside-down-xmas-tree' style to declare local variables (Steve)
 - Added Reviewed-by tag from Steve (patch 2 and 3).

v4
 - remove last patch of series (command line option patch)

v3
 - Add __ro_after_init (suggested by Kees).

v2
 - Use min_t() instead of min() (thanks checkpatch).
 - Add __must_check to function declaration (thanks Steve).
 - Use hw RNG by default if available (as originally suggested by Kees).
 - Add command line option to use cryptographically insecure hashing.
   If debug_early_boot is enabled use hash_long() instead of siphash
   (as requested by Steve, and solves original problem for Anna-Maria).
 - Added Acked-by tag from Ted (patch 1 and 2)



Tobin C. Harding (4):
  random: Fix whitespace pre random-bytes work
  random: Return nbytes filled from hw RNG
  vsprintf: Use hw RNG for ptr_key
  vsprintf: Add command line option debug_boot_weak_hash

 Documentation/admin-guide/kernel-parameters.txt |  9 ++++++++
 drivers/char/random.c                           | 19 ++++++++--------
 include/linux/random.h                          |  2 +-
 lib/vsprintf.c                                  | 30 ++++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 11 deletions(-)

-- 
2.7.4
