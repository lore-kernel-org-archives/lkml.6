Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100176; cv=none;
        d=google.com; s=arc-20160816;
        b=D3r9O41M4+A7LTqRDAabG/8R2ojDx53HiA/e7S9f7ZfJOJLqwMJ2Cv0EsFGuJ2g3Gr
         oRuB5loDSsCQEeI5px8EESNkO8kafTgGTXmfgHhT7pajBRrNExFHeMgAw1gHfPXX7wN8
         jp30LDgBEovCfkwwO05jZRLZ0uEMydZ8UQkd5svNUJnFrjNzxO60899XIWDB5g3AJ9OQ
         Fqj6iSAu63td0O4jOsx7uM1zyXUefAxrbUh7m15e8jKBGefWgI3C2R9HijnOJeCUqq2p
         X1xSRua7OAY+o6Tgr8BaCPK1bRl+7q6UAzkOomN3Z0WZDtHYZRNAd/DNcLBJstwLYWyp
         bszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sd88prHf5rtLnyO68gtc/59LXDPfxF6onmPanQ5rfZY=;
        b=N1pV0XAQqy3iMDg0IebfsGWHmqG2SYTSH7HL5js+FFQkQGIdOJiiypWzdfBJ5UaF41
         SfJ816Dc0uEhAJS1hhATJ+KuqSbdteRlC54vhMEEzs3tXCl2AEFrYvFwzGnIfQjqxN4G
         lNmMmMSapbyAGHC6JxeAn7MODu9rTVvWCcLa82t4LSqmcS+p7tj5bCX2OIhFvknoYcom
         +jwkdr6UrSlT9n/GXAyoEd9KTRsOA61oJFWZDs7vxFA8UcKmm9gUThpApFtj7m8XRw7l
         KKjNYw7FT/YEZhwWGJQrWJ8J+QUb4bMjinQ6C3BBMQsmi5Es10n6gE+XSjua1CEf1O0J
         AIpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c4GeRREG;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c4GeRREG;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoPTz6DZZobYKqRaFp1sp0YJIHcWvN+gbtyFqtGEQo0UrLs2sDY1UEq1A9+9b8qxUhBvsXH+Q==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] powerpc/powernv: Fix OPAL console driver OPAL_BUSY loops
Date: Tue,  1 May 2018 00:55:45 +1000
Message-Id: <20180430145558.4308-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183442783390128?=
X-GMAIL-MSGID: =?utf-8?q?1599183442783390128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The OPAL console driver does not delay in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware.

It can't yet be made to sleep because it is called under spinlock,
but it can be changed to the standard OPAL_BUSY loop form, and a
delay added to keep it from hitting the firmware too frequently.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 38 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e695b836fd49..6b621d47ac29 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -378,33 +378,41 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	/* We still try to handle partial completions, though they
 	 * should no longer happen.
 	 */
-	rc = OPAL_BUSY;
-	while(total_len > 0 && (rc == OPAL_BUSY ||
-				rc == OPAL_BUSY_EVENT || rc == OPAL_SUCCESS)) {
+
+	while (total_len > 0) {
 		olen = cpu_to_be64(total_len);
-		rc = opal_console_write(vtermno, &olen, data);
+
+		rc = OPAL_BUSY;
+		while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+			rc = opal_console_write(vtermno, &olen, data);
+			if (rc == OPAL_BUSY_EVENT) {
+				mdelay(OPAL_BUSY_DELAY_MS);
+				opal_poll_events(NULL);
+			} else if (rc == OPAL_BUSY) {
+				mdelay(OPAL_BUSY_DELAY_MS);
+			}
+		}
+
 		len = be64_to_cpu(olen);
 
 		/* Closed or other error drop */
-		if (rc != OPAL_SUCCESS && rc != OPAL_BUSY &&
-		    rc != OPAL_BUSY_EVENT) {
-			written += total_len;
+		if (rc != OPAL_SUCCESS) {
+			written += total_len; /* drop remaining chars */
 			break;
 		}
-		if (rc == OPAL_SUCCESS) {
-			total_len -= len;
-			data += len;
-			written += len;
-		}
+
+		total_len -= len;
+		data += len;
+		written += len;
+
 		/* This is a bit nasty but we need that for the console to
 		 * flush when there aren't any interrupts. We will clean
 		 * things a bit later to limit that to synchronous path
 		 * such as the kernel console and xmon/udbg
 		 */
-		do
+		do {
 			opal_poll_events(&evt);
-		while(rc == OPAL_SUCCESS &&
-			(be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT));
+		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
 	}
 	spin_unlock_irqrestore(&opal_write_lock, flags);
 	return written;
-- 
2.17.0
