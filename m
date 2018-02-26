Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuNnX8N6QVwQSQBGFDVlDSZYgGKGs9SNHBpWuiNAvfzagX669txHKdQCmv6sAzCC/3u9Cen
ARC-Seal: i=1; a=rsa-sha256; t=1519676832; cv=none;
        d=google.com; s=arc-20160816;
        b=zUKs28u5y6gF/oiGuPhDE0+tDLM9RIxCtzJc0w+SdGxHzcXNICjaDE3rfCK0WKBKPN
         hyiEo8+4JWDcY5Z4mMl1DftueSte247JRxSWDSWCgjkFJgjCPGGEtCxH981PbUtuF52v
         nXvBWeRz6/nzcQT1//5MNthsFI43EVEZN0joZ0dfKlBK9+8xv3KBY+4EmRVwY8sW0mE2
         IRzubINmydTSYf/ASn/OkuDYTtlvamOVhqnS+YTmHKfihTc5P18BtC67iBbAQB8FTIYS
         Q+LaJ/UUpaOC4QoLwM5wkJx9wMsPg7KcF4987W9smpElPNfOkdKFimyC7uUQsJWNb6Qi
         8gYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fxtWk2YGvzJNfOERnRgVP7xH2zLm89/51Ht4LxQTMjo=;
        b=oxiAFuo9/oPrl/y3SCX2lDaBURZuyCoxD303mEHAPwgkZB0RqtrigqHGGlOwit/vd6
         Z36hnl9Wy0pVbUsuHr0U/Qn71EI6XJlq0FxErqCR6MtV/hAglJEu0AHTaF3bvyb2lSGv
         jx7CzgtNB95fuU/KMlG8tB4iu54hEGEyM/n6WaV8shxpzef5KI5JK6KZDD/2tzlKBeIF
         BKzWikg+uj4bQtuZUeAoL590juwJHVOmfdlHuZt0UzeJhYkfs5QvrJka0Gu3ja6HHdyX
         16dnr83nwz5fU+elrk/Mv3WbfGGOG9geLfPLHt8iao6SLfkbR0wWhEs4RJOglFHDJPEl
         mecA==
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
Subject: [PATCH 4.15 03/64] kconfig.h: Include compiler types to avoid missed struct attributes
Date: Mon, 26 Feb 2018 21:21:40 +0100
Message-Id: <20180226202153.589811845@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496476457815622?=
X-GMAIL-MSGID: =?utf-8?q?1593496654254294275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
