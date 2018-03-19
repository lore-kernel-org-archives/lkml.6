Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeCSFzQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 01:55:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37634 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbeCSFzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 01:55:14 -0400
X-Google-Smtp-Source: AG47ELtxw3N4pF99+oaopfjhZ66efvOndPB49JhhvhkwaDepz1v2CtcdOLwRHvPSAigm/b++jy28oQ==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] tools: Fix str_error_r() Werror=restrict build
Date: Mon, 19 Mar 2018 14:55:04 +0900
Message-Id: <20180319055504.757-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c8b5f2c96d1bf6c ("tools: Introduce str_error_r()") added
an str_error_r() wrapper which makes gcc8 unhappy due to
restrict-qualified parameter aliasing violation:

../lib/str_error_r.c: In function ‘str_error_r’:
../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
   snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
   ^~~~~~~~
cc1: all warnings being treated as errors

Workaround that aliasing error by creating an additional stack
variable which holds the buf pointer value we passed to strerror_r().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 tools/lib/str_error_r.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/str_error_r.c b/tools/lib/str_error_r.c
index d6d65537b0d9..11c3425f272b 100644
--- a/tools/lib/str_error_r.c
+++ b/tools/lib/str_error_r.c
@@ -21,7 +21,12 @@
 char *str_error_r(int errnum, char *buf, size_t buflen)
 {
 	int err = strerror_r(errnum, buf, buflen);
-	if (err)
-		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
+	if (err) {
+		char *err_buf = buf;
+
+		snprintf(err_buf, buflen,
+			 "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d",
+			 errnum, buf, buflen, err);
+	}
 	return buf;
 }
-- 
2.16.2
