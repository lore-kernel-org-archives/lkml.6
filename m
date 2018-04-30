Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100180; cv=none;
        d=google.com; s=arc-20160816;
        b=Sz3c7YXvM0SETfDS9ITI+xR/188+EuF5JtgDsfDO2To6CCfj5YPyrm+WLPPUWi5ZHr
         SIeMj8sKhWq7jadu7jVCdU+/XVqXjLKTD+vHSvKZXu+MbEvRe2bxFze3fRbK7in+PWhT
         f6lPm+TH656cZJBU3PuEUfCnudjgnznhvYp26hsaQgEPiMyeJUXqpGYCSsvElWLEqvD7
         bKNyyqJgJnmoIWQywfxu9o9QcmsfNkG8jJiIgbbuqnlHzG9SomQV0XURAMQFom4VJVHc
         ICoqm2coMYI+xQZwZ5qoRa/moOGQr5JomFqBh3CeKChlqKXXMPuup48plSeuMY/TXjI7
         yFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=OA33Mn44o9a7jHdrvielS0XNTWuIP11zLDU6PWFQW8w=;
        b=JkA3LGJr7Yh7OD8HJNsFBGVtViTFus5FTECzYZ0WjJ29qQcV66W2Bwy5hF2dm5TcvT
         Ej0wLgNfKkgPiBXv7+b7hpI6+jE6L1tt/HJb/6kd0YxcBzsdLOjkJdwyGAp0Vlw7NkXZ
         UgRiDCQapGkLzyUN+N3KpyD4UJ2C/U65GQXJNIjqHjZ7oil/UyXvAoMwknxlnVQa5ZR0
         Q5+X7AMP46X3AWWc5e1A6Lm9bY6087qrXfYoTs8BLLs8bby97kFpJoHFyGfK1aGbcfNY
         qWD31eEER5sJryRhCKfsqPQH1w/aGGQ+RSwCctWmkMJnhxmhFUw51RgVveYTFo9KdeMl
         53lA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZHkrPJz9;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZHkrPJz9;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoxnLji7EvWn+DUznYYxjotBKTD6Mc2UpG03y6+6+dPTGRoWla4AlpcuY/FXJTnM0Pg0t9Obg==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] powerpc/powernv: opal-kmsg standardise OPAL_BUSY handling
Date: Tue,  1 May 2018 00:55:46 +1000
Message-Id: <20180430145558.4308-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183446978640518?=
X-GMAIL-MSGID: =?utf-8?q?1599183446978640518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OPAL_CONSOLE_FLUSH is documented as being able to return OPAL_BUSY,
so implement the standard OPAL_BUSY handling for it.

Reviewed-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-kmsg.c | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index 6f1214d4de92..f8f41ccce75f 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/kmsg_dump.h>
+#include <linux/delay.h>
 
 #include <asm/opal.h>
 #include <asm/opal-api.h>
@@ -26,8 +27,7 @@
 static void force_opal_console_flush(struct kmsg_dumper *dumper,
 				     enum kmsg_dump_reason reason)
 {
-	int i;
-	int64_t ret;
+	s64 rc;
 
 	/*
 	 * Outside of a panic context the pollers will continue to run,
@@ -37,14 +37,22 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 		return;
 
 	if (opal_check_token(OPAL_CONSOLE_FLUSH)) {
-		ret = opal_console_flush(0);
+		do  {
+			rc = OPAL_BUSY;
+			while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+				rc = opal_console_flush(0);
+				if (rc == OPAL_BUSY_EVENT) {
+					mdelay(OPAL_BUSY_DELAY_MS);
+					opal_poll_events(NULL);
+				} else if (rc == OPAL_BUSY) {
+					mdelay(OPAL_BUSY_DELAY_MS);
+				}
+			}
+		} while (rc == OPAL_PARTIAL); /* More to flush */
 
-		if (ret == OPAL_UNSUPPORTED || ret == OPAL_PARAMETER)
-			return;
-
-		/* Incrementally flush until there's nothing left */
-		while (opal_console_flush(0) != OPAL_SUCCESS);
 	} else {
+		int i;
+
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
-- 
2.17.0
