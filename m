Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2244rjnH3djUCkMplmX6SfcVFWp+aIrKrw8YfJrbEDhZnSsNBDzYroi3Q6fR7Hc6z4mJIZIF
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=KJj3q9BuHSwlzhcB5Pv0sZII5WuufrC6oPoJwaYUYTLmqC6/tyWdxUb3YrMwaJQ8v2
         KB1Z+T9wlVgfafLKBq+XujrX4JASLxnZtFUydx8pi2In6ndXzcQOHnHMHAsNZNfMDDp6
         ynPpITuQ6bHFsqPsPIqCnsbpABR8GkwTOEmF041u9u5fzqB61V8JrFLE9uqdmbXX+ykK
         TMLQQPljtYrjmclxUGAeqSbNSYvXpOYcQqqy4unE6amtb79M9A+7o2wqdLDRa/wlvGzo
         gGCMjBF9zmvvkjNARXFVb+RooAvDR/4sYfkA/2NAGxqQnlFhPTxSYnU8+mJpRMTmPbFr
         1ZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=OgysUZNJJuQDhed5u2YwuFH43q8TTfIJ3GyWfIBQjIM=;
        b=O0RG415lGuDndwyzSmwq7r8fg2WukzpmLpkg0LT20P64htSv/nAM/1vP0F/xNQ5GDd
         28e/UNM7MSCWjk24GpxKLN8mPFRa75NUyyUGGcyvfh/7SLEasuJESIHmnkqhAlYQ3rqX
         kZKKm8Pycgqa3AI6rTGamcArRSVd0T+Pt8v59henlIYoCII9bj7i4c+XRFWH2kcQkuRq
         2TGhXVBQTyv0Ks64nSldBhJDFfZr9xYN3GwJUTbfGCVMNzAVVCt8YTZRhYcwGyXCjIyM
         TJb8ebcEadWymDj6/7x3UemsCqyDKLMLYQeYDl76RwWM9qChXqO6kSp0aWZ6QyZbcTeO
         8dVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=CMKz2JAQ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=CMKz2JAQ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAs011351
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
Subject: [PATCH 13/14] kconfig: test: check if recursive dependencies are detected
Date: Tue,  6 Feb 2018 09:34:53 +0900
Message-Id: <1517877294-4826-14-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778492159314?=
X-GMAIL-MSGID: =?utf-8?q?1591609778492159314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Recursive dependency should be detected and warned.  Test this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/tests/warn_recursive_dep/Kconfig   | 62 ++++++++++++++++++++++
 .../kconfig/tests/warn_recursive_dep/__init__.py   | 10 ++++
 .../tests/warn_recursive_dep/expected_stderr       | 33 ++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/expected_stderr

diff --git a/scripts/kconfig/tests/warn_recursive_dep/Kconfig b/scripts/kconfig/tests/warn_recursive_dep/Kconfig
new file mode 100644
index 0000000..9ab2474
--- /dev/null
+++ b/scripts/kconfig/tests/warn_recursive_dep/Kconfig
@@ -0,0 +1,62 @@
+# depends on itself
+
+config A
+	bool "A"
+	depends on A
+
+# select itself
+
+config B
+	bool
+	select B
+
+# depends on each other
+
+config C1
+	bool "C1
+	depends on C2
+
+config C2
+	bool "C2"
+	depends on C1
+
+# depends on and select
+
+config D1
+	bool "D1"
+	depends on D2
+	select D2
+
+config D2
+	bool
+
+# depends on and imply
+# This is not recursive dependency
+
+config E1
+	bool "E1"
+	depends on E2
+	imply E2
+
+config E2
+	bool "E2"
+
+# property
+
+config F1
+	bool "F1"
+	default F2
+
+config F2
+	bool "F2"
+	depends on F1
+
+# menu
+
+menu "menu depending on its content"
+	depends on G
+
+config G
+	bool "G"
+
+endmenu
diff --git a/scripts/kconfig/tests/warn_recursive_dep/__init__.py b/scripts/kconfig/tests/warn_recursive_dep/__init__.py
new file mode 100644
index 0000000..cdf2c13
--- /dev/null
+++ b/scripts/kconfig/tests/warn_recursive_dep/__init__.py
@@ -0,0 +1,10 @@
+"""
+Warn recursive inclusion
+========================
+
+Recursive dependency should be warned.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_contains('expected_stderr')
diff --git a/scripts/kconfig/tests/warn_recursive_dep/expected_stderr b/scripts/kconfig/tests/warn_recursive_dep/expected_stderr
new file mode 100644
index 0000000..ea47cae
--- /dev/null
+++ b/scripts/kconfig/tests/warn_recursive_dep/expected_stderr
@@ -0,0 +1,33 @@
+Kconfig:16:warning: multi-line strings not supported
+Kconfig:9:error: recursive dependency detected!
+Kconfig:9:	symbol B is selected by B
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:3:error: recursive dependency detected!
+Kconfig:3:	symbol A depends on A
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:15:error: recursive dependency detected!
+Kconfig:15:	symbol C1 depends on C2
+Kconfig:19:	symbol C2 depends on C1
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:30:error: recursive dependency detected!
+Kconfig:30:	symbol D2 is selected by D1
+Kconfig:25:	symbol D1 depends on D2
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:59:error: recursive dependency detected!
+Kconfig:59:	symbol G depends on G
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:50:error: recursive dependency detected!
+Kconfig:50:	symbol F2 depends on F1
+Kconfig:48:	symbol F1 default value contains F2
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
-- 
2.7.4
