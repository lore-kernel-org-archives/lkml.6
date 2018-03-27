Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx48X1j7IyajZt1BPGejJOmHXGu8pgdVP9l+YF+R+VcoC7i2MY4vPrbb/dy4D1ZSwlXUgZffj
ARC-Seal: i=1; a=rsa-sha256; t=1522128625; cv=none;
        d=google.com; s=arc-20160816;
        b=P8rcPVGKVWPB1W1TpZIQz38NJulmk2bcC+FLJJMvVNAlBRTzQa7ZuRbcFSwn2P5m9S
         FNg9VUXVeK6hpdk044lQIZbmeV+D5MMh6Xr8vgnMY4arTcfm8gzP4xcMmxU6DKgYtfuK
         jNvgPJS9i0sHj+2b03FqCvlkvPvcSRG7AVL2VkJui+JjpxBEV/7MerXQ0cSTOYR3Z6Hm
         gSMETP01uH976NgeiGWMQ+ZWralEff12kkxPibXbFvK16jOu1MtIVZR02etqBW8517gj
         S+mY9yTUoujlBMT+nCtsTJuosibnMmUgFRO6hH301r4BkKzM1EI4+7wlRYCHn9hjylHN
         B9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=KTAFEIHDxVPUJqtgMqFg6fVfd1iEr3uJrY/KTE9qXDA=;
        b=r1M0r2FC22yc9Orv0BGNPLBiVSlv2IWTL2zcEQj0VmeUyrz3r5ofwstpQ+sMhW5Ea2
         fFQGgw6xW+IhFGd4az9lXW4rpzH0qV3sg+D6TLMlfClh8URS0N4sgWbPfCGkjFSLO3Qo
         zVB5tenwzEotQA4+uRk46xdXEGdCQ3nMf7MjrtD8lfonc1Qf9aKnIHmYjwsYzo0FNasZ
         iUkGZh6z6P0WzBA9XH5jeLuDXjBi4aYyrMNUGXWZAlU+SNg33KLLfr9/0dbeK5PyI2wX
         VIOSGNKR9dxBm/t0pS1A5n5sgOHg97G7hvv/vuQag+RS8oCaNbZdF205DoEs/Da6DuwS
         hqhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=JRmZlpek;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=JRmZlpek;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLw011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/21] kconfig: add CC_IS_GCC and GCC_VERSION
Date: Tue, 27 Mar 2018 14:29:27 +0900
Message-Id: <1522128575-5326-14-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545516785753?=
X-GMAIL-MSGID: =?utf-8?q?1596067545516785753?=
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

Changes in v2: None

 init/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index c456030..923cab5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -14,6 +14,14 @@ macro success $(shell ($(1) && echo y) || echo n)
 # expanded to y if the given compiler flag is supported, n otherwise
 macro cc-option $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
 
+config CC_IS_GCC
+	def_bool $(success $CC --version | grep -q gcc)
+
+config GCC_VERSION
+	int
+	default $(shell $srctree/scripts/gcc-version.sh -p $CC | sed 's/^0*//') if CC_IS_GCC
+	default 0
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4
