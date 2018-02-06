Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224B4IPwpFYb5ly/o7MJl2Ht0IjwtlfX9CTBCkakKraBn3rPV1k4oTo+ZNp3sgiiU5ZsWuUF
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=zhWUzTTGAU1152Wbb8XNXE9bD6AIZcq8RHmOfJJuxrHTik0ocWCsAU7knZ7azNk+Io
         tkvwjiXOEY5WBbNxbAqn43HWnlbOfS8TTkZ34B5bLRkbGGB0NS3aYaoXT0/okHlowSw3
         xnxNyOs/PMKlik8d9mbjuw9SUltf1snVNJTN6QAUrv+eFPLHIyUR2Syiz6XfjN1Ti3BW
         /bWA55CvIGKGAJSPg5PHCIp1TmbcT08mMtiUlDhwdFz6ctoxM3XQmRjTrc/FDGHoALoB
         OjFwFlv983U2ZAl5mLN16F8gC90DRzjah/I+IeVmJN/5TJZDhQBCJ9xTKO4pEu0VjbmG
         5CkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=XD7I3n5RiSKKYFJXgK1WrirTuPvIOYYcK1MRPL7S890=;
        b=Jt241atucazU89xB8c6S+VL/mqA3r2HPbJrJYwyz72M2FRl/mWYTamlKSKMN2t2IYF
         jP/6FzQCoecijUWZg4VDOTxI10NEBjXYZzDyHjoiLQbEK/q9WxCJy+Op+t1vToSqqsZ8
         w6N7eSWaJzKMrgQ3jvg+6Uh4c0INSJ2DaaBu8uiuevo3yD1NbTKr1QBOTrzYcNc6KTma
         gyHIzlOAjh3CSQ/LLuBwLJ1LY7YN5oNo+WzaesN1H8izrNuoSUe632U/AEALZB0+tbqg
         oJbC5dx63hS35wrYYvG8vGqdkObczC8JTxNqZlVyCITwqw23RiREpOftKZMzXTtC72Ef
         QYPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=rktzfeeo;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=rktzfeeo;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAq011351
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] kconfig: test: check .config sanity for choice values with unmet dep
Date: Tue,  6 Feb 2018 09:34:51 +0900
Message-Id: <1517877294-4826-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778788390389?=
X-GMAIL-MSGID: =?utf-8?q?1591609778788390389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I fixed a problem where "# CONFIG_..." for choice values are wrongly
written into the .config file when they are once visible, then become
invisible later.

Add a test for this subtle case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig     | 14 ++++++++++++++
 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py | 17 +++++++++++++++++
 scripts/kconfig/tests/no_write_if_dep_unmet/config      |  1 +
 .../kconfig/tests/no_write_if_dep_unmet/expected_config |  5 +++++
 4 files changed, 37 insertions(+)
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/config
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/expected_config

diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig b/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
new file mode 100644
index 0000000..c00b8fe
--- /dev/null
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
@@ -0,0 +1,14 @@
+config A
+	bool "A"
+
+choice
+	prompt "Choice ?"
+	depends on A
+
+config CHOICE_B
+	bool "Choice B"
+
+config CHOICE_C
+	bool "Choice C"
+
+endchoice
diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
new file mode 100644
index 0000000..d096622
--- /dev/null
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
@@ -0,0 +1,17 @@
+"""
+Do not write choice values to .config if the dependency is unmet
+================================================================
+
+"# CONFIG_... is not set" should not be written into the .config file
+for symbols with unmet dependency.
+
+This was not working correctly for choice values because choice needs
+a bit different symbol computation.
+
+This checks that no unneeded "# COFIG_... is not set" is contained in
+the .config file.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig('config', 'n') == 0
+    assert conf.config_matches('expected_config')
diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/config b/scripts/kconfig/tests/no_write_if_dep_unmet/config
new file mode 100644
index 0000000..abd280e
--- /dev/null
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/config
@@ -0,0 +1 @@
+CONFIG_A=y
diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
new file mode 100644
index 0000000..0d15e41
--- /dev/null
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
@@ -0,0 +1,5 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Linux Kernel Configuration
+#
+# CONFIG_A is not set
-- 
2.7.4
