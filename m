Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226pKyhN2n6Q2QEhCT0Wp/RyLhpD16RPySqPMjK8o4yxw3yDKFHOQWeFVw3hHu0+RUYPTOQU
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=xM+R/Poya2ggOBGLi7L8AOzHM5Ur2WVFu37bh0nGgTwJQpTMUepm10/POxMEgtXDZN
         zyrrFxCzk212HGDLrTDvHPjlL8sltQNAm1pW5xl06MyxPcDNlLpz0lLgaFh6jE7pYEMM
         2u0SICse+V0tEmzPXlBCXzEw7orley0qd42Yej3DfEPkIuNsjWBaFH3ItIW3i5wpV7M0
         58LjzSYB9XDj8w0J3kjXMlSrkVGQCmKshpfypJ79RUgxlDT5uaCeQ0ZtGRv6bARmqnCY
         uk6s1oM3a5EsvUUyZNV1aICPbm7g3lRWDYFip7c1CIc5N/cP1ThPV/6JudJrT3R04MuE
         dWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=WqMC/J/ZklNycTvQVm5mFpJGFmWJQ7pZGdtACgEPnzo=;
        b=lXuwIgioTJzVpf7UoinGtEXhfQYiMpNdcs5IlDzPNLAlA/0H8JC7pHzUnMPoYihsRi
         BapvtiioqTLGUN+q74KGhK2zmJu9zK89+Y2MB2J0VkLStzDpii0ti+E/2u20DtMFcHPs
         fYGPX4i6C6ma7S1ZYP3m8bsnCBC3ahUZl6fzztxUjUPRDIZFSv3wqLhTzduJMlc5upqJ
         3l7owdAgv3qEtk8SsrptNPQ41eWWokCOPIi63U6iUo/z6S19HiUIzDn7vHO7I9vgkndv
         EFn3o5mstCAh2V9qkjfCgQ2cumiY4MACuzGBn+X91w48FIUsQl3nxLXMD5Boz6dSUSpH
         LeXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RpwtBOh3;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RpwtBOh3;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTI013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/23] kconfig: add CC_IS_GCC and GCC_VERSION
Date: Sat, 17 Feb 2018 03:38:43 +0900
Message-Id: <1518806331-7101-16-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935564397749?=
X-GMAIL-MSGID: =?utf-8?q?1592583935564397749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This will be useful to specify the required compiler version,
like this:

config FOO
        bool "Use Foo"
        depends on GCC_VERSION >= 408000
        help
          This feature requires GCC 4.8 or newer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 837a584..f2da5e9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -12,6 +12,15 @@ config cc-option
 	string
 	macro $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
 
+config CC_IS_GCC
+	bool
+	default $(shell $CC --version | grep -q gcc)
+
+config GCC_VERSION
+	int
+	default $(shell-stdout $srctree/scripts/gcc-version.sh -p $CC | sed 's/^0*//') if CC_IS_GCC
+	default 0
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4
