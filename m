Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvH25wgoSTT5G/2EFEAhFJqzuMxvXU1bhiolE4dCONc4co3tZ4A4eZL/YAj7zD3vsGy+69L
ARC-Seal: i=1; a=rsa-sha256; t=1519411220; cv=none;
        d=google.com; s=arc-20160816;
        b=i9JXaSIprWQt8Z1PKUYxwqVhdD0m5AFe8taW2cu0eDLHIb3SS90zXy2iRqjKVa8OTK
         e0SvFj/6jtBjJYBox23Il+R3R3mW5vMA6bzRVohFo07nkEre2npuaMrjinrjEebXY9sh
         HhNNWyZEqoDwgdFaR5LxNfrHRmsqyqYC/KO0UcUVXaiVptcNClt92zsj51WSs+uyRPBm
         oC6OqKxQ/QcfM4jpjzrkqD+xcaIZcU3refsa0HegLKnsdhC04LQrUhraPYBzT7Xzcfkd
         OBoMwLxCiJmMPYFtTIr+IqOS6P0ZraLTGKec6nz6imkPBEg40Sx0p3XWFLgU7GOei1eQ
         GRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZRlfLM+WB/TSReAOMe9FyZn0RHPdGjKW2YRaKDSxwXg=;
        b=GK/YxBYEVvg/N2B3saD2vum0je+WyFDnSabRo9vxPmOp1JEjoyVbxRtSNMbnHymvFm
         LvQlb1VHf6AjKJ9Do6N79LqNPCPmebtRZz8IDb4UHW3WAvjaM119xdez0hjIkLhoBjTw
         RFtzFJw0tTgKBzA1puFmIMgM9CUxfRgvQjsyaNe1WVGEIk1nJiJHVcB5EM3lQ2WtzZte
         TeUxafmH5BuHr89usqW3cyS+Ue1I5ic+vBP1w+W2KHw7jSaTkq1VuZwStUcmUFe9sD10
         KF1m4FKRvkJCH6D7RzN+FtFgfWs7oyoae6/y6/VSCs6wnYkUIF0z0oXSYrKcasfyuU+9
         rWiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 163/193] kasan: rework Kconfig settings
Date: Fri, 23 Feb 2018 19:26:36 +0100
Message-Id: <20180223170351.424191376@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218140126518943?=
X-GMAIL-MSGID: =?utf-8?q?1593218140126518943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit e7c52b84fb18f08ce49b6067ae6285aca79084a8 upstream.

We get a lot of very large stack frames using gcc-7.0.1 with the default
-fsanitize-address-use-after-scope --param asan-stack=1 options, which can
easily cause an overflow of the kernel stack, e.g.

  drivers/gpu/drm/i915/gvt/handlers.c:2434:1: warning: the frame size of 46176 bytes is larger than 3072 bytes
  drivers/net/wireless/ralink/rt2x00/rt2800lib.c:5650:1: warning: the frame size of 23632 bytes is larger than 3072 bytes
  lib/atomic64_test.c:250:1: warning: the frame size of 11200 bytes is larger than 3072 bytes
  drivers/gpu/drm/i915/gvt/handlers.c:2621:1: warning: the frame size of 9208 bytes is larger than 3072 bytes
  drivers/media/dvb-frontends/stv090x.c:3431:1: warning: the frame size of 6816 bytes is larger than 3072 bytes
  fs/fscache/stats.c:287:1: warning: the frame size of 6536 bytes is larger than 3072 bytes

To reduce this risk, -fsanitize-address-use-after-scope is now split out
into a separate CONFIG_KASAN_EXTRA Kconfig option, leading to stack
frames that are smaller than 2 kilobytes most of the time on x86_64.  An
earlier version of this patch also prevented combining KASAN_EXTRA with
KASAN_INLINE, but that is no longer necessary with gcc-7.0.1.

All patches to get the frame size below 2048 bytes with CONFIG_KASAN=y
and CONFIG_KASAN_EXTRA=n have been merged by maintainers now, so we can
bring back that default now.  KASAN_EXTRA=y still causes lots of
warnings but now defaults to !COMPILE_TEST to disable it in
allmodconfig, and it remains disabled in all other defconfigs since it
is a new option.  I arbitrarily raise the warning limit for KASAN_EXTRA
to 3072 to reduce the noise, but an allmodconfig kernel still has around
50 warnings on gcc-7.

I experimented a bit more with smaller stack frames and have another
follow-up series that reduces the warning limit for 64-bit architectures
to 1280 bytes (without CONFIG_KASAN).

With earlier versions of this patch series, I also had patches to address
the warnings we get with KASAN and/or KASAN_EXTRA, using a
"noinline_if_stackbloat" annotation.

That annotation now got replaced with a gcc-8 bugfix (see
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715) and a workaround for
older compilers, which means that KASAN_EXTRA is now just as bad as
before and will lead to an instant stack overflow in a few extreme
cases.

This reverts parts of commit 3f181b4d8652 ("lib/Kconfig.debug: disable
-Wframe-larger-than warnings with KASAN=y").  Two patches in linux-next
should be merged first to avoid introducing warnings in an allmodconfig
build:
  3cd890dbe2a4 ("media: dvb-frontends: fix i2c access helpers for KASAN")
  16c3ada89cff ("media: r820t: fix r820t_write_reg for KASAN")

Do we really need to backport this?

I think we do: without this patch, enabling KASAN will lead to
unavoidable kernel stack overflow in certain device drivers when built
with gcc-7 or higher on linux-4.10+ or any version that contains a
backport of commit c5caf21ab0cf8.  Most people are probably still on
older compilers, but it will get worse over time as they upgrade their
distros.

The warnings we get on kernels older than this should all be for code
that uses dangerously large stack frames, though most of them do not
cause an actual stack overflow by themselves.The asan-stack option was
added in linux-4.0, and commit 3f181b4d8652 ("lib/Kconfig.debug:
disable -Wframe-larger-than warnings with KASAN=y") effectively turned
off the warning for allmodconfig kernels, so I would like to see this
fix backported to any kernels later than 4.0.

I have done dozens of fixes for individual functions with stack frames
larger than 2048 bytes with asan-stack, and I plan to make sure that
all those fixes make it into the stable kernels as well (most are
already there).

Part of the complication here is that asan-stack (from 4.0) was
originally assumed to always require much larger stacks, but that
turned out to be a combination of multiple gcc bugs that we have now
worked around and fixed, but sanitize-address-use-after-scope (from
v4.10) has a much higher inherent stack usage and also suffers from at
least three other problems that we have analyzed but not yet fixed
upstream, each of them makes the stack usage more severe than it should
be.

Link: http://lkml.kernel.org/r/20171221134744.2295529-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[arnd: rebase to v4.4; only re-enable warning]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -197,7 +197,7 @@ config ENABLE_MUST_CHECK
 config FRAME_WARN
 	int "Warn for stack frames larger than (needs gcc 4.4)"
 	range 0 8192
-	default 0 if KASAN
+	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
 	default 1024 if !64BIT
 	default 2048 if 64BIT
 	help
