Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpCRZ4WsmSmZ2UO0wOHgEVMGwFVIUHnJcS3oQ6RcMUgzRm54idshd07dxs7ifFHfMvMajrG
ARC-Seal: i=1; a=rsa-sha256; t=1525215378; cv=none;
        d=google.com; s=arc-20160816;
        b=TT309VwqAk0tUAmgmj88dCWQQ+Ppr3Nnyxwxb+NUj9mh2dG5v7komDKEvgrOUfiAXE
         MmsrbD3c0bhP1g1j2ei8hE5XSTDyNPLzTt+CAh9z9m8KchC0H3uvkIXxMtTDDaHABf+d
         3qGnWn6CNqBfqQ4jvfMBXvE2Mwchfaa292EV0fALWpPoqHITl3zuSoIOEf0v3SHf+8BT
         /Bn/4rg7OKuovPPoI1C60nDfk9BtvWgF5RZxTeyqeHJsbtXK6bViKQJcJeYvVETqObQ+
         D0EMdYuTeMDIfRx3lSdhUBhuq8v8uoxVno2Or9aOu6/2Cz2Cs8epW/qHE0Y9U078Y9yC
         K1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3gRycC5L6j9SfCyg8KUJNCvpZSkDs6aSdGAYbgvYo2k=;
        b=y/4lXKEXB4dgzCnZ4Eu3e7hVMZyhlLab5UITHEhwghQIVT6o52NaCk0WLN8P7ifNg6
         dfnJ0wcH/Dd9fRQ10//qVn3p2i9bag2pdmKjRO89GhhmM0P1QXpHmXKMH8x7wkIVFmJ+
         Yk0zHeGTeoyP1YiyGDufkdw3x9WBjg8ZJa1hLTHBu9GWW5PHlqJ0IBA4aaenPg1Ho/oD
         6GwLY338lclFQsNWmCR0ktQqg/LBXMskb/2Qo0JPfQoSiV2Xsl+A7gBoZR+wmsksFwZP
         fj9Aka51sk2+qGivHZLoTEIMqvyjqDVRjFCMSgvys8iAjahcV0b/6hhlWPXKQY/45HGy
         3obw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeEAWzm (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 1 May 2018 18:55:42 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38404 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWzh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 May 2018 18:55:37 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] selftests: lib.mk: add test execute bit check to EMIT_TESTS
Date: Tue,  1 May 2018 16:54:38 -0600
Message-Id: <ff755cbe7a3d62e729e62f57880df94f25bad5dd.1525212671.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599304240166969119?=
X-GMAIL-MSGID: =?utf-8?q?1599304240166969119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Similar to what RUN_TESTS does, change EMIT_TESTS to check for execute
bit and emit code to print warnings if test isn't executable to the
the run_kselftest.sh.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/lib.mk | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 0c6012500026..6466294366dc 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -100,7 +100,12 @@ define EMIT_TESTS
 		test_num=`echo $$test_num+1 | bc`;	\
 		TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
 		echo "echo $$TEST_HDR_MSG";	\
-		echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"ok 1..$$test_num $$TEST_HDR_MSG [PASS]\") || (if [ \$$? -eq \$$skip ]; then echo \"not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]\"; else echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\"; fi;)"; \
+		if [ ! -x $$TEST ]; then	\
+			echo "echo \"$$TEST_HDR_MSG: Warning: file $$BASENAME_TEST is not executable, correct this.\"";		\
+			echo "echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\""; \
+		else
+			echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"ok 1..$$test_num $$TEST_HDR_MSG [PASS]\") || (if [ \$$? -eq \$$skip ]; then echo \"not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]\"; else echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\"; fi;)"; \
+		fi;		\
 	done;
 endef
 
-- 
2.14.1

