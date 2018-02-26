Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtv/KplVLC8CQNe+Vq5cJImxXjTywHpbu4nWWglFYy4Buf6mOH6oEZyyNRNi1tfd6KA5rH3
ARC-Seal: i=1; a=rsa-sha256; t=1519676663; cv=none;
        d=google.com; s=arc-20160816;
        b=raL9zSOBPXk9prrIGzY2cw4EMBjYlJy4eSEeZjkZwSodl6HKMGXW1joCTA3qILBLaV
         JH5PMQZD+UPqZjdsinlkk2OnqRIFpHSSpfUmyWKYOWFcII8MyQIeO01Qqq68dy1RrUjq
         T6h+B/3oyWlvBXsZZ15ItP0yZkNLFC9pVq5t65pp/ZNswG29gTShN0bZfgNGtpWVDkoH
         I45mWPghsixwR+qm+JevkrIutl06vkEFW9s8mp07z+yDf6Q1EfQrha26IoLXd32l/p9S
         1yIYfqbi8skx1iBoVcMWcHxatwyGuyIGhri6PYPLv4UdJFWVV59usTF2B2SdBAAej8+2
         TjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OzFsR65ffzHt7To8tyOyFuuuyT36neiPijR28UKXoSM=;
        b=R1PuTRyzkOE3djNDBMNC/xYZL5yZ7T/8c2lokeQjhecM8awMe+zoGf83aWFR/tZQyh
         WArPA1G4+K7C+sByiG2fMl2E+W6+iF5L5F7y4qtMBr60eQkR+jfLaqPm3UiVL/BKd0Gj
         M+HClQ7vvOo4mOMCs2uK4bRspCmJ8U0daS/0C8W7Gb3W8xMC9Hxejb4LXxs+Wdrbf3y2
         cYp91ztHuY8xTBYQbS1vsAsauY6vzXmClnSCXQA4P0Ab2RgrpFlGxNcKyfNgzsYfBO1S
         atC7NLuxG6Wrp7wLXEnknodV1qbnDnncMegJomauDzk2WEIeqcMMz3rWq4FVYvnWFRGi
         gAJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Patrick McLean <chutzpah@gentoo.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 03/54] kconfig.h: Include compiler types to avoid missed struct attributes
Date: Mon, 26 Feb 2018 21:21:40 +0100
Message-Id: <20180226202144.541380019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496476457815622?=
X-GMAIL-MSGID: =?utf-8?q?1593496476457815622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 28128c61e08eaeced9cc8ec0e6b5d677b5b94690 upstream.

The header files for some structures could get included in such a way
that struct attributes (specifically __randomize_layout from path.h) would
be parsed as variable names instead of attributes. This could lead to
some instances of a structure being unrandomized, causing nasty GPFs, etc.

This patch makes sure the compiler_types.h header is included in
kconfig.h so that we've always got types and struct attributes defined,
since kconfig.h is included from the compiler command line.

Reported-by: Patrick McLean <chutzpah@gentoo.org>
Root-caused-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: 3859a271a003 ("randstruct: Mark various structs for randomization")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/kconfig.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -64,4 +64,7 @@
  */
 #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
 
+/* Make sure we always have all types and struct attributes defined. */
+#include <linux/compiler_types.h>
+
 #endif /* __LINUX_KCONFIG_H */
