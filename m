Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2261+VJjztQ/OpTynn4tnpBguRDF7FBf+uF9FbNTD9Ck22sKjRtRVqQGvESPGXRaXOUZg+YX
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=bRd0hOkjAFvOiNZUwd9jphkcgk452xu/jwJxLfCrxxK2Xyh1HeESvrGxQaDTAyuHWk
         Q2Fj0BpX/Mgx41X9oUGEK2wcQej9pu+dYAQsYpojK/5DC5xIK7SutU1EWGpbqs6CRNlH
         6AadOP+HIisSU/VPn+ITRuW63oYu7VgReL8oOQZhD8FGMid6wzql40Jt48/OeRCmdneF
         VZ2telzwix6W35cfYwy5phFpvPXcQWGb0TsbUpsPamxXvCg/tUNrKdlBjdl8kt2KZmf0
         NsWXI4+p+Gakc1NUnpntiZtqFcx/Jb34oSq/vfBo7NILMHu6qH8iZb97EXUGyM5E6XeD
         fiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=sm0FoNarUulcD/w2qLJkmkFC1PlsCAolV4lrUTnLk/g=;
        b=sbxU1HqmEVAdxL8hahEizLuWEA8P96xp9pLx+QnYGQipdyiRNJYPfSWJVDwcA9vf2n
         E280vveyf911arAcdpHcyW/atlQig0MlNIwn50USUpdOhblprzsC4ViADL8tbzkxCiuv
         TnS/5lO+l3TSr7MT10NToxdB9MQjBrQHviu+SQXSiKg6NUjM9LZG7fX5M/6tVZEv8CNy
         Gczmaw4V4uhHrXHr5vBKKyea8mM1t/GsVuaQ6qKi+0wJZ1jf6EJrMpl9Uqke4b8QycLQ
         /XEd0VVflKgofO6T5P3XiGSG2gojNLQ/tb8F6YohrdnM1ywF55Wigd6ofGG7lKJqs7CX
         P/jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RSV3Gzcv;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RSV3Gzcv;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAr011351
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
Subject: [PATCH 12/14] kconfig: test: check visibility of tristate choice values in y choice
Date: Tue,  6 Feb 2018 09:34:52 +0900
Message-Id: <1517877294-4826-13-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778417647763?=
X-GMAIL-MSGID: =?utf-8?q?1591609778417647763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If tristate choice values depend on symbols set to 'm', they should be
hidden when the choice containing them is changed from 'm' to 'y'
(i.e. exclusive choice).

This issue was fixed by commit fa64e5f6a35e ("kconfig/symbol.c: handle
choice_values that depend on 'm' symbols").

Add a test case to avoid regression.

For the input in this unit test, there is a room for argument if
"# CONFIG_CHOICE1 is not set" should be written to the .config file.

After commit fa64e5f6a35e, this line was written to the .config file.

Then, it is not written after my fix "kconfig: do not write choice
values when their dependency becomes n".

In this test, "# CONFIG_CHOICE1 is not set" is don't care.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../kconfig/tests/choice_value_with_m_dep/Kconfig    | 20 ++++++++++++++++++++
 .../tests/choice_value_with_m_dep/__init__.py        | 15 +++++++++++++++
 scripts/kconfig/tests/choice_value_with_m_dep/config |  2 ++
 .../tests/choice_value_with_m_dep/expected_config    |  3 +++
 .../tests/choice_value_with_m_dep/expected_stdout    |  4 ++++
 5 files changed, 44 insertions(+)
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/config
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/expected_config
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout

diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig b/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
new file mode 100644
index 0000000..dbc49e2
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
@@ -0,0 +1,20 @@
+config MODULES
+	bool
+	default y
+	option modules
+
+config DEP
+	tristate
+	default m
+
+choice
+	prompt "Tristate Choice"
+
+config CHOICE0
+	tristate "Choice 0"
+
+config CHOICE1
+	tristate "Choice 1"
+	depends on DEP
+
+endchoice
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py b/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
new file mode 100644
index 0000000..ec71777
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
@@ -0,0 +1,15 @@
+"""
+Hide tristate choice values with mod dependency in y choice
+===========================================================
+
+If tristate choice values depend on symbols set to 'm', they should be
+hidden when the choice containing them is changed from 'm' to 'y'
+(i.e. exclusive choice).
+
+Related Linux commit: fa64e5f6a35efd5e77d639125d973077ca506074
+"""
+
+def test(conf):
+    assert conf.oldaskconfig('config', 'y') == 0
+    assert conf.config_contains('expected_config')
+    assert conf.stdout_contains('expected_stdout')
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/config b/scripts/kconfig/tests/choice_value_with_m_dep/config
new file mode 100644
index 0000000..3a126b7
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/config
@@ -0,0 +1,2 @@
+CONFIG_CHOICE0=m
+CONFIG_CHOICE1=m
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/expected_config b/scripts/kconfig/tests/choice_value_with_m_dep/expected_config
new file mode 100644
index 0000000..4d07b44
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/expected_config
@@ -0,0 +1,3 @@
+CONFIG_MODULES=y
+CONFIG_DEP=m
+CONFIG_CHOICE0=y
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout b/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
new file mode 100644
index 0000000..5eac85d
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
@@ -0,0 +1,4 @@
+Tristate Choice [M/y/?] 
+Tristate Choice
+> 1. Choice 0 (CHOICE0)
+choice[1]: 1
-- 
2.7.4
