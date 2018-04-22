Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/QdH8+fHW7hz1/IPZae1Pt8tI196vLbKau5UEaoYJLR5h3dDAbfm2eOwN/paisZTUerX8r
ARC-Seal: i=1; a=rsa-sha256; t=1524406373; cv=none;
        d=google.com; s=arc-20160816;
        b=dgLYIavGAdjaYEx4GLAmMBC66vfC576N2U74co2Hv77vi9tivl2dvMeLZTDIvwNFRA
         jeaolnbTq6jFlpAGcfHpYPGyUe++TyoMFDQR5fc6LaHOWSpGh4j8vBMuy8j9qolEx323
         UGpuU4dw3THtaG8HCiWf5Ro/+RzqXHbe7C/+oikVDR0bf29uD9YCyvza6hd5TZryQ5iE
         NsGJBF42fTFzeX6diAGGNvnwjW5/9ey2V1pnrHHvvdwchVf5ivSH3MV0VipfMAHUAAt9
         jj8bK0H+5a8KJfPhbiPZNDhh6aicW6uF3deZzrlxZQVzj/jldofQFjCP4CTMdKyvduNE
         pGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3ErvBPokaK/X39YheVW+hF5zwDnHKJzXrQLygIpdzW4=;
        b=gUNrFsW+yR9mt/eJYu12GfCGPhFNxM7KCMQmqL4iCFZo2cYSo1rilkznhGhTF3BYMp
         aEgTT8zzmuu6uS0FfbYcaCkGJOONX3fTAJyQJaabLZvM0sbMJtAtsg95Xc/00pAw1f8X
         jLP0EygRnW7ZAozFSoC3SEztp8UnM7RN+RoHtA43dzKZ1oNmhlBnrDps8lq5aIS50osz
         tHcabliGp7EntrjtG8hBOtuQJLTyvdfUyNcMeV8bRAIFz2jYR/oZ2fSCCMt3nJWvk686
         T3cb6vzNrR8jWD0yx3496R1WP7JSxUzwnp4LCy20YV8m/J1Pw13GOn672RmpXeeU9LI7
         fxrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.9 47/95] um: Compile with modern headers
Date: Sun, 22 Apr 2018 15:53:16 +0200
Message-Id: <20180422135212.338598092@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455132138531431?=
X-GMAIL-MSGID: =?utf-8?q?1598455937157149907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 530ba6c7cb3c22435a4d26de47037bb6f86a5329 upstream.

Recent libcs have gotten a bit more strict, so we actually need to
include the right headers and use the right types. This enables UML to
compile again.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/os-Linux/file.c   |    1 +
 arch/um/os-Linux/signal.c |    1 +
 arch/x86/um/stub_segv.c   |    1 +
 3 files changed, 3 insertions(+)

--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -12,6 +12,7 @@
 #include <sys/mount.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/un.h>
 #include <sys/types.h>
 #include <os.h>
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -16,6 +16,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <um_malloc.h>
+#include <sys/ucontext.h>
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -6,6 +6,7 @@
 #include <sysdep/stub.h>
 #include <sysdep/faultinfo.h>
 #include <sysdep/mcontext.h>
+#include <sys/ucontext.h>
 
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
