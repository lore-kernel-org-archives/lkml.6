Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224wnz698lAYO2Unz3OPJsIa7l/slcP67IGEE0wRjax4CoNCUdLuSftqbXepmOB0/rlaYbhe
ARC-Seal: i=1; a=rsa-sha256; t=1517877368; cv=none;
        d=google.com; s=arc-20160816;
        b=vSexB7wZuNBYVfmnIokl2yWm3WYvRcq6EoFKh6EqAqmI0oMJ3gkQI2u0ps/hZVnBI1
         w1YoTMVsf2Cv4rx7en9hYEpAwy6VxIfLC0K35OeVlV+JNlI9wJNuWLZ110KpxcsWjYmP
         J3GPDx/OuFfbuA7Jft450EpprNA08ohRfde4Gt0/d+PO9DckWVUdHT9Eu4o7xrJg26FX
         bTEuzHFm554182eqGsYVh/x7qilwK5hmN2zay/fpibs0WdWTAXe3r/610jbtKL6ZmDmM
         XEhu2SsLs6ArXxoeyTCzNsI/sHwlgxsYTGn+VCgaU2ARBXk+BxRcv/mm7A2DeeQHNz/O
         /CEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=Noha0QiW63Ao007jCcFxnie6IMNyESx6eW/jUS2GKCc=;
        b=Q8YiogjOYMGmUezIjRojXc2I0bNxM3jlozv/UT2/ggfiWgwq+F8uIAIHMw9Dtv4fnm
         GmSkjYfm+3/p07pyY52ip/+YKOJDJmlS9prGcSg0n/iUlI7ZJ6IIBnMgIBgTnozP68QS
         duKUxRfI56FJxyL0zKZdyqJtMMD7JMPCjLe9TobG+NdLYTBLvk9sDXEoBp/0UeKEcLMn
         +g72F2ERAKGVwS70s0+AHcFQLuxptJke3VhEVy77ftELIkMc/5ntIsP0ysMRSGp3nEH0
         6ljbWXFLHrbtTLsqqp62P6m6GI9EU9Z5qczuxufZUO4CU8ihlcyA0lxsfROX+ILMTPfT
         CrKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=YHWqHF4x;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=YHWqHF4x;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAl011351
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 06/14] kbuild: define PYTHON2 and PYTHON3 variables instead of PYTHON
Date: Tue,  6 Feb 2018 09:34:46 +0900
Message-Id: <1517877294-4826-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609779326365104?=
X-GMAIL-MSGID: =?utf-8?q?1591609779326365104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The variable 'PYTHON' allows users to specify a proper executable
name in case the default 'python' does not work.  However, this does
not address the case where both Python 2 and Python 3 scripts are
used in one system.

PEP 394 (https://www.python.org/dev/peps/pep-0394/) provides a
convention for Python scripts portability.  Here is a quotation:

  In order to tolerate differences across platforms, all new code
  that needs to invoke the Python interpreter should not specify
  'python', but rather should specify either 'python2' or 'python3'.
  This distinction should be made in shebangs, when invoking from a
  shell script, when invoking via the system() call, or when invoking
  in any other context.

arch/ia64/scripts/unwcheck.py is apparently written in Python 2, so
it should be invoked by 'python2'.

It is legitimate to use 'python' for scripts compatible with both
Python 2 and Python 3, but this is rare (at least I do not see the
case in kernel tree).  You do not need to make efforts to write your
scripts in that way.  Anyway, Python 2 will retire in 2020.

This commit is needed for my new scripts written in Python 3.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile           | 5 +++--
 arch/ia64/Makefile | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 11aff0f..c4e935c 100644
--- a/Makefile
+++ b/Makefile
@@ -384,7 +384,8 @@ GENKSYMS	= scripts/genksyms/genksyms
 INSTALLKERNEL  := installkernel
 DEPMOD		= /sbin/depmod
 PERL		= perl
-PYTHON		= python
+PYTHON2		= python2
+PYTHON3		= python3
 CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
@@ -430,7 +431,7 @@ GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
-export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON UTS_MACHINE
+export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 2dd7f51..862a2ba 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -75,7 +75,7 @@ vmlinux.gz: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 unwcheck: vmlinux
-	-$(Q)READELF=$(READELF) $(PYTHON) $(srctree)/arch/ia64/scripts/unwcheck.py $<
+	-$(Q)READELF=$(READELF) $(PYTHON2) $(srctree)/arch/ia64/scripts/unwcheck.py $<
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-- 
2.7.4
