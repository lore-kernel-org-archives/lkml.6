Return-Path: <miguel.ojeda.sandonis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518894661; cv=none;
        d=google.com; s=arc-20160816;
        b=zdr+e0caNoFOv+5WiHuaOszq3x8otRmJSwqAm7DsKGtvftvtIU18kz/v7Y19AUg/X0
         f3qem5/BaLQ7bnoKjpg9NxWomgvlr+nScP2BQAs6eFT+vtUiMjEiCs3izGNzbtg+2mwg
         isqa9bPMhJPvDBLW0y2qkyqIAvRhKZEKNs0CyxoyGckLk0a+agTT4w+HEzk1U0TykNmN
         MttkP+4fjyIG2yxmb1aKNfOoxoQMCjFJNPAmA24N54WOO/1y2iaPPx8/ESNMra86mitK
         M9nA5RtNMkrHWXhTCKQIwVyZ4uZG1lQfEZR8yGDLbjtvK7lBwdkuHIrAu719zAMvPHJF
         4U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:dkim-signature:arc-authentication-results;
        bh=GRjfS5XSnFMj+OAVb200NhhnKlX3943C4nrKZnzWwCY=;
        b=sZUlLWGE75PXfl5SiFZwgwElB8zBkUgtNy/4ACRBqmlm/6izLkSB9yiUJ0x7TH3rk9
         5o1KlRUd7wZ6PCzCO8f579wA0siJ5ngbXkeG6KgYdk8WWC/xsraLVPC6wKKzjHcA70qG
         2yL27wo1fs3OqH4VbSQL3ChxXTv0gX0GvozK4pUnoXAltyH7VhMAUc2bbyvUhDlopGcP
         xR53HYb4C/8rlWYqt2LQU/mejs7BxawuoMNxXN0XQcdmfbRHOjSc2CND8SDDJvb2u4Jh
         v2rQB9LDuz+xghmh3j5EX8s62WshKrw/THg9Jx2BGZSKXuxgYgvaZTn0bfBpMXM0kvvV
         Fscg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l322XWu5;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l322XWu5;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2260JhK5/8ycbtX2vQnTujL9TeQl2RL8cc6Q/aq9mZHnUOPcui7zReHgyvUuGLw6dVD3n/qcKw==
Date: Sat, 17 Feb 2018 20:10:35 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: mingo@kernel.org, jpoimboe@redhat.com, keescook@chromium.org,
	akpm@linux-foundation.org, tglx@linutronix.de, geert@linux-m68k.org,
	gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
	rientjes@google.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Support the nonstring variable attribute (gcc >= 8)
Message-ID: <20180217191035.gol4woxsgzpo4bfq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592676488865934389?=
X-GMAIL-MSGID: =?utf-8?q?1592676488865934389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>From the GCC manual:

The nonstring variable attribute specifies that an object or member
declaration with type array of char or pointer to char is intended to
store character arrays that do not necessarily contain a terminating NUL
character. This is useful in detecting uses of such arrays or pointers
with functions that expect NUL-terminated strings, and to avoid warnings
when such an array or pointer is used as an argument to a bounded string
manipulation function such as strncpy.

  https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html

Some reports are already coming to the LKML regarding these
warnings. When they are false positives, we can use __nonstring to let
gcc know a NUL character is not required; like in this case:

  https://lkml.org/lkml/2018/1/16/135

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Rientjes <rientjes@google.com>
---
Another option is using -Wno-stringop-truncation, but it remains to be
seen how useful the new warning will be. We can try to keep it for the
moment until the real bugs and false positives are dealt with and see if
it is worth it.

At least in the reported case at drivers/auxdisplay, using __nonstring
is enough and it can actually replace a comment that was there about the
non-stringness of the char arrays that gcc complained about.
See https://godbolt.org/g/dydPah to play with the warning in this case.

 include/linux/compiler-gcc.h   | 14 ++++++++++++++
 include/linux/compiler_types.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 73bc63e0a1c4..6a9784c0c7f3 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -317,6 +317,20 @@
 #define __designated_init __attribute__((designated_init))
 #endif
 
+#if GCC_VERSION >= 80000
+/*
+ * The nonstring variable attribute specifies that an object or member
+ * declaration with type array of char or pointer to char is intended
+ * to store character arrays that do not necessarily contain a terminating
+ * NUL character. This is useful in detecting uses of such arrays or pointers
+ * with functions that expect NUL-terminated strings, and to avoid warnings
+ * when such an array or pointer is used as an argument to a bounded string
+ * manipulation function such as strncpy.
+ * https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
+ */
+#define __nonstring __attribute__((nonstring))
+#endif
+
 #endif	/* gcc version >= 40000 specific checks */
 
 #if !defined(__noclone)
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6b79a9bba9a7..654dd3114052 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -271,4 +271,8 @@ struct ftrace_likely_data {
 # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 #endif
 
+#ifndef __nonstring
+# define __nonstring
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.14.1
