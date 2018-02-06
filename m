Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517961254; cv=none;
        d=google.com; s=arc-20160816;
        b=ah4ph9eYmB9qN98ETsJ222kBhSCdG815ZmJiz8iCFb3nMryEVbR7rxNHrlH0K0800Y
         BFr5hZfBN/xqQZF9J78jcJpeyk9jIAssbmsGIkpeKeZICNEovBZRDYHj5HxkF2doCDFJ
         ljayQYXvd+psRejs/WvYJNqlBGGDZp6TC1R94lIMg4EHQ+iI3Ifd3fvsCVtnJobu6k0R
         3oPsMBuzjpVLcHaAENPn3zLux7l6T3QxXbNsu/D2LNgUlpESZFuocjYsWcd92yX03oym
         0xI6MxFKMAvO5taGmmYDP7GUGkaaC5IkocJO7xTfVho6Ww8z2Bfg1icSq6jn1ZbSuxsM
         6z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=7aCWYerlux4ttemZHbU5bv+aMfjSx5ZhV4g02sA0R/c=;
        b=ys/5plWPjwm9u+XbHfHvwI5NzAyaWsimIaiT6xctUz5ul6Mt+fuuXNJGI17cgjuH8U
         ESBBp7EoQHClHY5jDTn3MaV88jqkwMe0Ahpv/nIp7j4LYCV0C4joSM2RtRs6WioQxfsU
         7PtBqTCo+maqHNlBC3JaK+ShMMgWxad0b/ejIhjXXvwAYpS+UCjYjiuGlJBSZHt9oqfi
         JxsJjgyzxW+xIfXhLI//XvPS1N13HO+na/nWKUau7IUpk+yvuN0d4vrdyIXdcfFPMP0L
         EYF5b3yEo9S3IH/8yVNmURsS4maq2d59Zy1iYw97ihr9n4jw8J4mvpQ5jAaGAlH8IS+1
         oKnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PY5q8Fjy;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PY5q8Fjy;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x2279Tf7eAnCgGrQkFYCj8X3TnSkn7/USjCXomrum1BejgevDsa8LxbN4TGXUAhffKTabmpPQFQ==
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pintu Agarwal <pintu.ping@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/android: Fix line continuation in Makefile
Date: Tue,  6 Feb 2018 17:52:05 -0600
Message-Id: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591697740031389880?=
X-GMAIL-MSGID: =?utf-8?q?1591697740031389880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Makefile lacks a couple of line continuation backslashes
in an `if' clause, which can make the subsequent rsync
command go awry over the whole filesystem (`rsync -a / /`).

  /bin/sh: -c: line 5: syntax error: unexpected end of file
  make[1]: [all] Error 1 (ignored)
  TEST=$DIR"_test.sh"; \
                  if [ -e $DIR/$TEST ]; then
  /bin/sh: -c: line 2: syntax error: unexpected end of file
  make[1]: [all] Error 1 (ignored)
  rsync -a $DIR/$TEST $BUILD_TARGET/;
  [...a myriad of:]
  [  rsync: readlink_stat("...") failed: Permission denied (13)]
  [  skipping non-regular file "..."]
  [  rsync: opendir "..." failed: Permission denied (13)]
  [and many other errors...]
  fi
  make[1]: fi: Command not found
  make[1]: [all] Error 127 (ignored)
  done
  make[1]: done: Command not found
  make[1]: [all] Error 127 (ignored)

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/android/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index 1a74922..f6304d2 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -11,11 +11,11 @@ all:
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
 		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
-		#SUBDIR test prog name should be in the form: SUBDIR_test.sh
+		#SUBDIR test prog name should be in the form: SUBDIR_test.sh \
 		TEST=$$DIR"_test.sh"; \
-		if [ -e $$DIR/$$TEST ]; then
-			rsync -a $$DIR/$$TEST $$BUILD_TARGET/;
-		fi
+		if [ -e $$DIR/$$TEST ]; then \
+			rsync -a $$DIR/$$TEST $$BUILD_TARGET/; \
+		fi \
 	done
 
 override define RUN_TESTS
-- 
2.7.4
