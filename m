Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519236578; cv=none;
        d=google.com; s=arc-20160816;
        b=D8JDp05Uq+1gXgAEv7BwJbfGevG5EJgy5Oz+cuhO4pIuZ0hPyCSnyrOZYszNS05mqw
         dvkaLtnIkCaoJJMnqS5H6gaYyyopqIoYpj4o7TMvca2ZViIKo+0gA40QBvlBfoXMJTt7
         pJj5vcYfsocrnN/k6yVRveYb3+ByMKBWrzXthVzROLI0z8QffX1VH9VBfPGWuOZRndjD
         6M3mQ59UMxF+jSnx5QspoMPHPhL1jGiTdqbsV31ghLWSu00tGvH0bJh6d+4vLDy2uthN
         IYurkPx89bsDwcATKu5oWTtHQmVm8qwbh7EPcKeGWb13tVsFkx8B22BTbdYU6MmLldNK
         blEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=ljQ9h7q4idaGVu/GzNq7X6BG2wx+Noe4L1VTQ99qX7g=;
        b=K0qVlTvdIHOTmGzCkuK3smGF7jifGxbFjSYYE2403TpahTUq5To70BjI01NoWPCi1W
         Wk1N8ty/AlTY5nPjbntb/EFLLNLeff2LDD9Tk396EJr+OxeYsTiauffs2fSisGGFaLNB
         w4t6qsnzrpCZVD4sQoAQpwE9CmrifwmZZYqONCLzcu+ebrZF6345eg62qpR60D2XJEI8
         80GsZW+pWHoYwV5puM30w3e2TbT7jAY/B2ChYtE8FkJdH7r1FaWYXLgil/3jF2zathpH
         JsBX0KoPlI0JayCKHdbcjLz9xDUjumONLTlouA/xuYNuW1xDwFg+jL+oJPTv9V6x+FAf
         P8OA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BFbAmtRO;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BFbAmtRO;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x225RNK9nvXKglp6qigAVHxR169GnSlgaYQeQbh/dd9zgJG7Pd3zC60FHHirproYOpRKM5o+Pgg==
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	SeongJae Park <sj38.park@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/intel_pstate: Fix build rule for x86
Date: Wed, 21 Feb 2018 12:07:57 -0600
Message-Id: <1519236493-13851-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593035014326696662?=
X-GMAIL-MSGID: =?utf-8?q?1593035014326696662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ensure that ARCH is defined and that this only builds for
x86 architectures.

It is possible to build from the root of the Linux tree, which
will define ARCH, or to run make from the selftests/ directory
itself, which has no provision for defining ARCH, so this
change is to use the current definition (if any), or to check
uname -m if undefined.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/intel_pstate/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 5a3f7d37..7340fd6 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -2,7 +2,10 @@
 CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
 LDLIBS := $(LDLIBS) -lm
 
-ifeq (,$(filter $(ARCH),x86))
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq (x86,$(ARCH))
 TEST_GEN_FILES := msr aperf
 endif
 
-- 
2.7.4
