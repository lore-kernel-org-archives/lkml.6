Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49UvlnOdm9lOq+Sn557zaq2pIWjHbPY/GWwhxjZf6L8szF34dpkjWmft1MZNh6pkILA6pxv
ARC-Seal: i=1; a=rsa-sha256; t=1523472840; cv=none;
        d=google.com; s=arc-20160816;
        b=nDHNEPhd0vnoOGMNjwE2g8RN03UUKs43Pf7nPrkvOS7GQnOCURE7EcErpWuvKOH+2Z
         Hno80BhNciV4qFLeIFpCTNVYQeTFSUgWrPh9lcbxaUaTw6GijUKFO0Q32QyOlXUU/qrC
         Ru/nBVDgIIXgALwh4klmeR11J0zGQlI/UcLImsEK+3IDirnJprsOPn86Pv8IhaktUQJR
         GX/3ywPdJ3vXpx5CvkGRKpQphOLjCF1Q3oOfb2fcEaN5Spym2gyzd/BYtlWyP/EjGg6n
         inpSb9MTUnfsjOa4cGPGUQN+PfaokKO5/sCqkv/lhdn2XMutBdfTvrCnAEgrNnF0wCtM
         BaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tvLI0YNERMjUItEDD1ikbYKwnaCOxmeCdD+c4gzRF68=;
        b=09voiMue7U4Pq/KT2rlt0qbgn9RBDgvkgZ3sOIn//hhqW6JuQIfQRqY2ImF1qXolHx
         o6CEOdEs2/o/gDf8um4wu0nvuetmakAbImVb5w3iXRs/RExj06TuQ7pcsGw/MioZUHR9
         qPUfazSBEgLACsM4UuS7iKttXga2mjeYLCP4AqC8NfHsOU73ZrzI/hwWvtGbPcFg936t
         7estIbk2Kmo47zbyjdiGGZsSd/+rh2R6TVsYM/WE8incbnrPeaVFxt1k0IVfAjE1/V+h
         E5RbkZymPzxjNjAVB78ysCldf+ZiPNYRtHD0pyYQ993KnpK0Iy/8/U//dgtXQDdOmpmK
         xhkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Daniel Micay <danielmicay@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 009/310] x86/boot: Declare error() as noreturn
Date: Wed, 11 Apr 2018 20:32:28 +0200
Message-Id: <20180411183622.709466179@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477057117703761?=
X-GMAIL-MSGID: =?utf-8?q?1597477057117703761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>


[ Upstream commit 60854a12d281e2fa25662fa32ac8022bbff17432 ]

The compressed boot function error() is used to halt execution, but it
wasn't marked with "noreturn". This fixes that in preparation for
supporting kernel FORTIFY_SOURCE, which uses the noreturn annotation
on panic, and calls error(). GCC would warn about a noreturn function
calling a non-noreturn function:

  arch/x86/boot/compressed/misc.c: In function ‘fortify_panic’:
  arch/x86/boot/compressed/misc.c:416:1: warning: ‘noreturn’ function does return
   }
 ^

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Daniel Micay <danielmicay@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: http://lkml.kernel.org/r/20170506045116.GA2879@beast
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/error.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/boot/compressed/error.h
+++ b/arch/x86/boot/compressed/error.h
@@ -1,7 +1,9 @@
 #ifndef BOOT_COMPRESSED_ERROR_H
 #define BOOT_COMPRESSED_ERROR_H
 
+#include <linux/compiler.h>
+
 void warn(char *m);
-void error(char *m);
+void error(char *m) __noreturn;
 
 #endif /* BOOT_COMPRESSED_ERROR_H */
