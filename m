Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZp/+aj9eG/Uq0O+TIvQIUceGiBzFYpLbE7hWusGhJI0Lsf9Zf/glBeQy+UOm9KlNI1xF6re
ARC-Seal: i=1; a=rsa-sha256; t=1525482890; cv=none;
        d=google.com; s=arc-20160816;
        b=z4XbKrShDUDoTp3ji5NG/KJP3FnOQzReZuX0Yngf2BBAmSyAUea9dKenxgOsCqqut+
         EFafOOS33wYj2euTifQXHKrqM+nZQimIjtVKLJqQUHhTs3+4bt4yBwg9eqe05Y34glGy
         B+VGCwtqh1tHtKGYJEIQIoWyUxrQPkiI1JJdoLtAuJXfH0gvnKYlM47OW3EYBwDikvH+
         QN4bOX3l7UMzU9KWF89BaQPZbi6p83UiASwac0qPLsP9CURD7NWaDXSjoG3SmRhrHVEX
         lpzKcEaO43U0nM43Jgdh9YbOY64XBZKpg8woM+xlrmiysOyDz8cIAZvsn6MguhMYgnYv
         QQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=unryU1uoUmNSCjzP8LXZ9ExQcvrtxknUogh9PT9d1vk=;
        b=S3IdsfvQzCJxi11Pd5tRJ1+p0O8FRaOttKAyj9V4VgX+uy+uRGXTnPg7ePx271gmvL
         pBMw3duPJNXVWF51ywMt3PPCH+5PPyjgOwjs/cpaOX+/b4BkAGkwzD0dg6AMm9efvMFH
         o142K+HWbu5Ew+HBAzXHLEAvV1ESmp/c1EcclRJB1lsTehz/Q9gp+aGtEEYmUs/hN2lF
         xmMQemTnO54YjzQ28SjilEfhfJQi5PreOFT5M6db1JVBuq3rUlGdj44MhTQxXU9/4Ohd
         1i6GDv0h21NuM8wP/nJIqYqVzIDSV+DA/rK9f097NRYRkA2qmjTWxSnqV5D39Nb1TQkf
         i08Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org,
	gregkh@linuxfoundation.org,
	christian.brauner@ubuntu.com,
	ebiederm@xmission.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/24] selftests: filesystems: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:11 -0600
Message-Id: <20180505011328.32078-7-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599584748100996964?=
X-GMAIL-MSGID: =?utf-8?q?1599584748100996964?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When devpts_pts test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as
a fail by the Kselftest framework. This leads to false negative
result even when the test could not be run.

In another case, it returns pass for a skipped test reporting a false
postive.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Change it to use ksft_exit_skip() when test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/filesystems/devpts_pts.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b9055e974289..0f2d9f427944 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -11,6 +11,7 @@
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
+#include "../kselftest.h"
 
 static bool terminal_dup2(int duplicate, int original)
 {
@@ -125,10 +126,12 @@ static int do_tiocgptpeer(char *ptmx, char *expected_procfd_contents)
 		if (errno == EINVAL) {
 			fprintf(stderr, "TIOCGPTPEER is not supported. "
 					"Skipping test.\n");
-			fret = EXIT_SUCCESS;
+			fret = KSFT_SKIP;
+		} else {
+			fprintf(stderr,
+				"Failed to perform TIOCGPTPEER ioctl\n");
+			fret = EXIT_FAILURE;
 		}
-
-		fprintf(stderr, "Failed to perform TIOCGPTPEER ioctl\n");
 		goto do_cleanup;
 	}
 
@@ -281,7 +284,7 @@ int main(int argc, char *argv[])
 	if (!isatty(STDIN_FILENO)) {
 		fprintf(stderr, "Standard input file desciptor is not attached "
 				"to a terminal. Skipping test\n");
-		exit(EXIT_FAILURE);
+		exit(KSFT_SKIP);
 	}
 
 	ret = unshare(CLONE_NEWNS);
-- 
2.14.1
