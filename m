Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49P+5z0bnzwqV2WyIByE/iVXccn2o2RlnySuiCTbT4yD+bVpBzPWvWEKWHFYVKD6NpvNU/s
ARC-Seal: i=1; a=rsa-sha256; t=1522168948; cv=none;
        d=google.com; s=arc-20160816;
        b=O7UOsvQPuBbVJ2mIsJLvANrJAPt967OMeH6FY4kYyGQBfi9UUV9qHa1xdzCYVAyqR0
         et9oju6wQW1n1eKvr14BGrJrzlcMcgaNScGyd3j8dfwIS2RXrFRDb1SJyAplvpjBy30H
         TOMpv/Yfuk41dRP2CMOJpf8nQRxhtfGzmqebWabtNFMKCZtu2HG9o8B0VpaKxlM7QbXH
         8euOokQ5KahRwUBFh5kBT+DZpH+XPCTltdmxhvQrr7HISu9gbQgB2Q0bjc9x7XmT/4xl
         AsX0HpbjljyxBVPNHgSjle1QlCFocWyRuYdGJzfw7xo8k1hHExDgkWjtOTrFCGZVAwXL
         friw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o4Cwe8DoPVSpkjUvOqTN/6t7LepiozWApqir6VG+Xic=;
        b=k2E7Z3E0WAZmTZj9zjd22h9TTgKJTKlTKeItsYNw7dK6Vo0dpQyQNTKWUbH2V1iySX
         YhfKytGDTu3E5QotxarjzdTGiDyheGyA5SqqvqaemNII8s1OZj6MlRSwdS8Yf2PSRZEG
         1vpTlk4WnetPOjXquLTaICfzydYVHob0pwJFNcn750WvK68eKbt55JHCKUlsl8ruI4Yv
         mRu9r/fexAtOUTtpqxIqCeF8Ma5D1TU0961mbY2kvYW0ubGOHicnqQbeTJexrryqQPpA
         8liU/+4vZG+rVuHyZYD8fKmgTkJDK+d4yPjzQqS+bLzuyBWXQg4kOFBQAOLVyNOwUMrv
         22Kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Kees Cook <keescook@chromium.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 089/105] x86/build/64: Force the linker to use 2MB page size
Date: Tue, 27 Mar 2018 18:28:09 +0200
Message-Id: <20180327162803.635579937@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109060047546231?=
X-GMAIL-MSGID: =?utf-8?q?1596109827307307758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: H.J. Lu <hjl.tools@gmail.com>

commit e3d03598e8ae7d195af5d3d049596dec336f569f upstream.

Binutils 2.31 will enable -z separate-code by default for x86 to avoid
mixing code pages with data to improve cache performance as well as
security.  To reduce x86-64 executable and shared object sizes, the
maximum page size is reduced from 2MB to 4KB.  But x86-64 kernel must
be aligned to 2MB.  Pass -z max-page-size=0x200000 to linker to force
2MB page size regardless of the default page size used by linker.

Tested with Linux kernel 4.15.6 on x86-64.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/CAMe9rOp4_%3D_8twdpTyAP2DhONOCeaTOsniJLoppzhoNptL8xzA@mail.gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Makefile |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -223,6 +223,15 @@ KBUILD_CFLAGS += $(cfi) $(cfi-sigframe)
 
 LDFLAGS := -m elf_$(UTS_MACHINE)
 
+#
+# The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
+# the linker to force 2MB page size regardless of the default page size used
+# by the linker.
+#
+ifdef CONFIG_X86_64
+LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
+endif
+
 # Speed up the build
 KBUILD_CFLAGS += -pipe
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
