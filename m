Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100222; cv=none;
        d=google.com; s=arc-20160816;
        b=blSZlQFMt4PlFrJ0kcDtcRnMloa91geP6Z8pp48xNBAQbNWedmAExbSdscbXz9ULdI
         6/lK6Cl2/h1z9augHIlR8Rh/EEeX3v+hjjyCmrtdg/IMb16ImQ+r9uztsFBvq+aoyA/W
         KYxKzBO2xXj0qyZZyCshmej7M11xpjfr8FNz0XLalLCuEC24u6XX6HQwSAoKwaGa6vgu
         K8xALUkIQiH8cVCjzcd+ZBdb+nEum82wAaO1LTx3NUrjq/TpHg+ewtFWjYqMXFtBlXsM
         2SVs1h8KTKkLe9MX+/qxTkJalyXdxGpiRrt9OqG2vqU782VF81vJf1A9/gaXmOX40W7A
         8JWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=G71Q2+BYKVYzt309ct9Pa3OzRte+vGtslkS0sjb0+U0=;
        b=B6gQJZzWvHGtw0YeRMIAuQI0qG/2esBMm1/UFVk6HZNBbmCjfOC0mwFRDmo7dN2bN0
         VV49blNkWxLlMqAQQ4HawgOk4BBhN7q2rGnBRGWhwHGZFhBl+GHCkeHHALiVfQkdx8Vl
         20DzH3JnCFWQQvSQfWtiOExnPbMH2JuHqjXdn6PU8TP281R2syXFk/o536KzlGkpvqXn
         LvV4dD3LWtcvP8UfT/6La1ISZJ/kYgkxV5VKwSfwRFd7uuAOJOq0J667NgRl0ZsWyjAk
         JXrQOQKHrrU+pPN7bMzMnVkIwK190WKA8dITgWUZq+/ODisC42jDby9YSCeMtw0Rz/rf
         P0OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C2BhGwkz;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C2BhGwkz;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrudu7cN9RyhjReEL06ucNxGkCdh5I2hcIKoFiYhqWZwe+t59Z57Q/F3VzKXBY/ydIT30VRuQ==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] tty: hvc: introduce the hv_ops.flush operation for hvc drivers
Date: Tue,  1 May 2018 00:55:57 +1000
Message-Id: <20180430145558.4308-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183490983783729?=
X-GMAIL-MSGID: =?utf-8?q?1599183490983783729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use .flush to wait for drivers to flush their console outside of
the spinlock, to reduce lock/irq latencies.

Flush the hvc console driver after each write, which can help
messages make it out to the console after a crash.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 35 +++++++++++++++++++++++++++++++++--
 drivers/tty/hvc/hvc_console.h |  1 +
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 6131d5084c42..5414c4a87bea 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -110,6 +110,29 @@ static struct hvc_struct *hvc_get_by_index(int index)
 	return hp;
 }
 
+static int __hvc_flush(const struct hv_ops *ops, uint32_t vtermno, bool wait)
+{
+	if (wait)
+		might_sleep();
+
+	if (ops->flush)
+		return ops->flush(vtermno, wait);
+	return 0;
+}
+
+static int hvc_console_flush(const struct hv_ops *ops, uint32_t vtermno)
+{
+	return __hvc_flush(ops, vtermno, false);
+}
+
+/*
+ * Wait for the console to flush before writing more to it. This sleeps.
+ */
+static int hvc_flush(struct hvc_struct *hp)
+{
+	return __hvc_flush(hp->ops, hp->vtermno, true);
+}
+
 /*
  * Initial console vtermnos for console API usage prior to full console
  * initialization.  Any vty adapter outside this range will not have usable
@@ -155,8 +178,12 @@ static void hvc_console_print(struct console *co, const char *b,
 			if (r <= 0) {
 				/* throw away characters on error
 				 * but spin in case of -EAGAIN */
-				if (r != -EAGAIN)
+				if (r != -EAGAIN) {
 					i = 0;
+				} else {
+					hvc_console_flush(cons_ops[index],
+						      vtermnos[index]);
+				}
 			} else if (r > 0) {
 				i -= r;
 				if (i > 0)
@@ -164,6 +191,7 @@ static void hvc_console_print(struct console *co, const char *b,
 			}
 		}
 	}
+	hvc_console_flush(cons_ops[index], vtermnos[index]);
 }
 
 static struct tty_driver *hvc_console_device(struct console *c, int *index)
@@ -513,8 +541,11 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 
 		spin_unlock_irqrestore(&hp->lock, flags);
 
-		if (count)
+		if (count) {
+			if (hp->n_outbuf > 0)
+				hvc_flush(hp);
 			cond_resched();
+		}
 	}
 
 	/*
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index ea63090e013f..e9319954c832 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -54,6 +54,7 @@ struct hvc_struct {
 struct hv_ops {
 	int (*get_chars)(uint32_t vtermno, char *buf, int count);
 	int (*put_chars)(uint32_t vtermno, const char *buf, int count);
+	int (*flush)(uint32_t vtermno, bool wait);
 
 	/* Callbacks for notification. Called in open, close and hangup */
 	int (*notifier_add)(struct hvc_struct *hp, int irq);
-- 
2.17.0
