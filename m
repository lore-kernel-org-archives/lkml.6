Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225WJZ6omiLTD9p5bBmzl3stJtMAf/LUqqB0BbIcnHw42TTTXFLmg6iWNe+9WcUu1k+CD7Z/
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=NmUDJXUF/OhVrPMkSyP/bxQneQ5tmHqD2577eu6HFYTNR+gap+luytK+GQMF6zH6b2
         YnXHY51pj6peZRTydNOVjdcECzn4ex1lCVCqQS44GLB9a2UJtibOgu+EOx2neKWtT5r4
         VtKT/dvg2DTwR24uVYwtL9gAihhUqeJCCC0k8WSlt9k2lXddEqlwLiegulwwuYJxVl+b
         fTgZOeTiRYoIGQbhzVUcXDsc/5CtOMKiIRreG8138dlFc+sR1X0jXprb8bKpyrFDOJV4
         RAh57WIfNxiE3uq/Db70DtwIhEj4ljfcBKRwXGUpTf+otpB6aY++enKUv8iG94+KIwWh
         RVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=0tMiHBIy1G322QUF9DUnzHnXWHn+vjfiFlPgF9g/e+U=;
        b=g4G7JiAsLTKMIZ/0L0y51ocz0BsQbBTQOhn5HzK9UFZnRko+nALQmZNTqcFcwyVoCV
         kCTI3FM/MgSF0udE6jk8rhBZgCOu80yt+nNdL6BsfraVw9SuIPIGRveasOJsNhHg8uQ3
         PVEi/KH0Ib0FDsFH3KP+MZFTpRdN4jLmjZwIgSfuVeA/gptT27TvC6EZG2xjHgtJPGjT
         JtRYJLGUrjn5sO6g6//9XQGqOoIPDYQwMpDXQRiUCwn6mF4zOBq6prQVA9/Ir++rRUa9
         A2dZGqFsarJoSLfLomFtwiA1KZrkojX9z3pEOiSlS5jsZ+D9zCSeqrLqS2pV3K2TKSxm
         P60Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=uji2Pv9h;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=uji2Pv9h;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAo011351
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
Subject: [PATCH 09/14] kconfig: test: test automatic submenu creation
Date: Tue,  6 Feb 2018 09:34:49 +0900
Message-Id: <1517877294-4826-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778638341632?=
X-GMAIL-MSGID: =?utf-8?q?1591609778638341632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If a symbols has dependency on the preceding symbol, the menu entry
should become the submenu of the preceding one, and displayed with
deeper indentation.

This is done by restructuring the menu tree in menu_finalize().
It is a bit complicated computation, so let's add a test case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../kconfig/tests/auto_submenu_creation/Kconfig    | 50 ++++++++++++++++++++++
 .../tests/auto_submenu_creation/__init__.py        | 12 ++++++
 .../tests/auto_submenu_creation/expected_stdout    | 10 +++++
 3 files changed, 72 insertions(+)
 create mode 100644 scripts/kconfig/tests/auto_submenu_creation/Kconfig
 create mode 100644 scripts/kconfig/tests/auto_submenu_creation/__init__.py
 create mode 100644 scripts/kconfig/tests/auto_submenu_creation/expected_stdout

diff --git a/scripts/kconfig/tests/auto_submenu_creation/Kconfig b/scripts/kconfig/tests/auto_submenu_creation/Kconfig
new file mode 100644
index 0000000..9e11502
--- /dev/null
+++ b/scripts/kconfig/tests/auto_submenu_creation/Kconfig
@@ -0,0 +1,50 @@
+config A
+	bool "A"
+	default y
+
+config A0
+	bool "A0"
+	depends on A
+	default y
+	help
+	  This depends on A, so should be a submenu of A.
+
+config A0_0
+	bool "A1_0"
+	depends on A0
+	help
+	  Submenus are created recursively.
+	  This should be a submenu of A0.
+
+config A1
+	bool "A1"
+	depends on A
+	default y
+	help
+	  This should line up with A0.
+
+choice
+	prompt "choice"
+	depends on A1
+	help
+	  Choice should become a submenu as well.
+
+config A1_0
+	bool "A1_0"
+
+config A1_1
+	bool "A1_1"
+
+endchoice
+
+config B
+	bool "B"
+	help
+	  This is independent of A.
+
+config C
+	bool "C"
+	depends on A
+	help
+	  This depends on A, but not a consecutive item, so should not
+	  be a submenu.
diff --git a/scripts/kconfig/tests/auto_submenu_creation/__init__.py b/scripts/kconfig/tests/auto_submenu_creation/__init__.py
new file mode 100644
index 0000000..dda866d
--- /dev/null
+++ b/scripts/kconfig/tests/auto_submenu_creation/__init__.py
@@ -0,0 +1,12 @@
+"""
+Create submenu for symbols that depend on the preceding one
+===========================================================
+
+If a symbols has dependency on the preceding symbol, the menu entry
+should become the submenu of the preceding one, and displayed with
+deeper indentation.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stdout_contains('expected_stdout')
diff --git a/scripts/kconfig/tests/auto_submenu_creation/expected_stdout b/scripts/kconfig/tests/auto_submenu_creation/expected_stdout
new file mode 100644
index 0000000..bf5236f
--- /dev/null
+++ b/scripts/kconfig/tests/auto_submenu_creation/expected_stdout
@@ -0,0 +1,10 @@
+A (A) [Y/n/?] (NEW) 
+  A0 (A0) [Y/n/?] (NEW) 
+    A1_0 (A0_0) [N/y/?] (NEW) 
+  A1 (A1) [Y/n/?] (NEW) 
+    choice
+    > 1. A1_0 (A1_0) (NEW)
+      2. A1_1 (A1_1) (NEW)
+    choice[1-2?]: 
+B (B) [N/y/?] (NEW) 
+C (C) [N/y/?] (NEW) 
-- 
2.7.4
