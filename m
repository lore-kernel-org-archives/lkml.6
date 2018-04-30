Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100226; cv=none;
        d=google.com; s=arc-20160816;
        b=cLQsQIJAcUk4PyD4MfWQ8mJiOEoT3bX6/v5OOwyiLGaS2z49sV2snmO7Bf8BTyq/tt
         0WEHi8ETdHv2PAnncuzV3ZAJcf+vb+W4LpF2KbEWpm4LO5wYJPt53eBDE0YB3FFbOLuS
         qJZXLUiKfbD3bG6hYpac5CpPG4TW5JJwiQMREOy36K6/PYIOHTUCsky3+zooRpbBnXo3
         kGV2LfL+X+Vue3UmYW4wqZmhbvDh4ZyI65dDqmnQZBoman/6BlN67ij3vD2gwEAuEjrV
         yTbIGei6IhBOKbS6bjWghiJJwxSCXFMw0sdzT+SkqK+TStieKeVAmClsrhkwaey5CH/H
         CKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=f9DYhpE0msiurLkmL5Bk4HG348z8gxYi6jMA0/iO/7o=;
        b=tZHoZnwkP2nExwsuWwTkUHXq8Xii1suqTlgILBtpE+izZeLKFaOFTWY6f5vLWW5q9l
         A30bVdXmkAnuClTdn5YnK4RVYYSgHyiPRpzbyKO0MbRL1EDyEEkiZHikk7q4RaM+MlJv
         ndqcFcCFs2Qu8O9K/0RHcNu0vj5ef18ZBkQ2526ioOrZ0n9M8TZfdJESp/J0VvnJRref
         6XAOno5f6OJJ8PYgg6L/7dlFayOHKyefy182iLsA4uwYbQ7vqMdSZxeuGZUtGaVp1Wlx
         XmNGZxLOPDmBktXkuBa7aLSCISgkghwP4+l07l1vJQGuYO598xeUSB3fAkfR0D15EvpX
         kyXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=loU8MxFk;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=loU8MxFk;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqTocWnMXGE8bM04EShexf8UvI7bjaKy8YwofV+TtR0m0ur68jkaaQncwJtCpbclqVLWizFww==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] powerpc/powernv: provide a console flush operation for opal hvc driver
Date: Tue,  1 May 2018 00:55:58 +1000
Message-Id: <20180430145558.4308-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183494768500805?=
X-GMAIL-MSGID: =?utf-8?q?1599183494768500805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Provide the flush hv_op for the opal hvc driver. This will flush the
firmware console buffers without spinning with interrupts disabled.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h       |  1 +
 arch/powerpc/platforms/powernv/opal.c | 83 +++++++++++++++++----------
 drivers/tty/hvc/hvc_opal.c            |  2 +
 3 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5d7072411561..a426d2caaf9f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -304,6 +304,7 @@ extern void opal_configure_cores(void);
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 extern int opal_put_chars_atomic(uint32_t vtermno, const char *buf, int total_len);
+extern int opal_flush_chars(uint32_t vtermno, bool wait);
 extern int opal_flush_console(uint32_t vtermno);
 
 extern void hvc_opal_init_early(void);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index bcdb90ada938..048bc09afc83 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -370,12 +370,8 @@ static int __opal_put_chars(uint32_t vtermno, const char *data, int total_len, b
 	olen = cpu_to_be64(total_len);
 	rc = opal_console_write(vtermno, &olen, data);
 	if (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-		if (rc == OPAL_BUSY_EVENT) {
-			mdelay(OPAL_BUSY_DELAY_MS);
+		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		} else if (rc == OPAL_BUSY_EVENT) {
-			mdelay(OPAL_BUSY_DELAY_MS);
-		}
 		written = -EAGAIN;
 		goto out;
 	}
@@ -401,15 +397,6 @@ static int __opal_put_chars(uint32_t vtermno, const char *data, int total_len, b
 	if (atomic)
 		spin_unlock_irqrestore(&opal_write_lock, flags);
 
-	/* In the -EAGAIN case, callers loop, so we have to flush the console
-	 * here in case they have interrupts off (and we don't want to wait
-	 * for async flushing if we can make immediate progress here). If
-	 * necessary the API could be made entirely non-flushing if the
-	 * callers had a ->flush API to use.
-	 */
-	if (written == -EAGAIN)
-		opal_flush_console(vtermno);
-
 	return written;
 }
 
@@ -429,40 +416,74 @@ int opal_put_chars_atomic(uint32_t vtermno, const char *data, int total_len)
 	return __opal_put_chars(vtermno, data, total_len, true);
 }
 
-int opal_flush_console(uint32_t vtermno)
+static s64 __opal_flush_console(uint32_t vtermno)
 {
 	s64 rc;
 
 	if (!opal_check_token(OPAL_CONSOLE_FLUSH)) {
 		__be64 evt;
 
-		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
 		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
 		 */
-		do {
-			opal_poll_events(&evt);
-		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
+		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
+
+		opal_poll_events(&evt);
+		if (!(be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT))
+			return OPAL_SUCCESS;
+		return OPAL_BUSY;
 
-		return OPAL_SUCCESS;
+	} else {
+		rc = opal_console_flush(vtermno);
+		if (rc == OPAL_BUSY_EVENT) {
+			opal_poll_events(NULL);
+			rc = OPAL_BUSY;
+		}
+		return rc;
 	}
 
-	do  {
-		rc = OPAL_BUSY;
-		while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-			rc = opal_console_flush(vtermno);
-			if (rc == OPAL_BUSY_EVENT) {
-				mdelay(OPAL_BUSY_DELAY_MS);
-				opal_poll_events(NULL);
-			} else if (rc == OPAL_BUSY) {
-				mdelay(OPAL_BUSY_DELAY_MS);
+}
+
+/*
+ * opal_flush_console spins until the console is flushed
+ */
+int opal_flush_console(uint32_t vtermno)
+{
+	for (;;) {
+		s64 rc = __opal_flush_console(vtermno);
+
+		if (rc == OPAL_BUSY || rc == OPAL_PARTIAL) {
+			mdelay(1);
+			continue;
+		}
+
+		return opal_error_code(rc);
+	}
+}
+
+/*
+ * opal_flush_chars is an hvc interface that sleeps until the console is
+ * flushed if wait, otherwise it will return -EBUSY if the console has data,
+ * -EAGAIN if it has data and some of it was flushed.
+ */
+int opal_flush_chars(uint32_t vtermno, bool wait)
+{
+	for (;;) {
+		s64 rc = __opal_flush_console(vtermno);
+
+		if (rc == OPAL_BUSY || rc == OPAL_PARTIAL) {
+			if (wait) {
+				msleep(OPAL_BUSY_DELAY_MS);
+				continue;
 			}
+			if (rc == OPAL_PARTIAL)
+				return -EAGAIN;
 		}
-	} while (rc == OPAL_PARTIAL); /* More to flush */
 
-	return opal_error_code(rc);
+		return opal_error_code(rc);
+	}
 }
 
 static int opal_recover_mce(struct pt_regs *regs,
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 786e76a1e06d..fd306033f8d4 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -52,6 +52,7 @@ static u32 hvc_opal_boot_termno;
 static const struct hv_ops hvc_opal_raw_ops = {
 	.get_chars = opal_get_chars,
 	.put_chars = opal_put_chars,
+	.flush = opal_flush_chars,
 	.notifier_add = notifier_add_irq,
 	.notifier_del = notifier_del_irq,
 	.notifier_hangup = notifier_hangup_irq,
@@ -141,6 +142,7 @@ static int hvc_opal_hvsi_tiocmset(struct hvc_struct *hp, unsigned int set,
 static const struct hv_ops hvc_opal_hvsi_ops = {
 	.get_chars = hvc_opal_hvsi_get_chars,
 	.put_chars = hvc_opal_hvsi_put_chars,
+	.flush = opal_flush_chars,
 	.notifier_add = hvc_opal_hvsi_open,
 	.notifier_del = hvc_opal_hvsi_close,
 	.notifier_hangup = hvc_opal_hvsi_hangup,
-- 
2.17.0
