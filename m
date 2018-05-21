Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqznLtxjkaNG+PwzDYDqMYzaEm3ndVgqrB40zRqtM4VXAmb3zr9wD+MNj7GQgMEppOb4W5H
ARC-Seal: i=1; a=rsa-sha256; t=1526937339; cv=none;
        d=google.com; s=arc-20160816;
        b=CfGtI+igoyVYDnhth/5X/RLDiW2f8Ybmsjqgll+vn660/oHg6LI8vV41wkidl0jfoJ
         AttT3+alFfj6phGvghd9lmpXQwqP9QC+W52+o1uDPss2r5+J65ef6wkEc0qBYkMhllqE
         IYJwb2BCgCQp2e0yS72B/h0zTDP4Z9IbBtDX/8HhQqxWYCI8ZdGkBLVg4wRsxzX2nYXP
         33rozbw9N1CZKoQKzrrj/OjDq6XCxLezTXpEhnibApoyoY3JFRVIdfLyw6+Djmb45+JA
         fvfrzS+O83e/HuArOD39D8It3pGNVkA+RIwZpR3fQIPlNvQHYybDXzoZZQuMJPlF1euJ
         cdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=MSNyiNFT0FKT+CYQ2hH9hi/M52j9S/M/MffrYC6Tk7w=;
        b=N/yP2dv/k6B9g6ZkCWa5/DK+jxHdVVb+uujP4fXx8P1GfOA5PJO9bop27MoVFpczFC
         cVGcXMNbNLfAV7iwa+cI+m0Rm4Vi48PgDlIKhVrZapvj0HI/kInDNjWYKvMoyWoT52qq
         EP7OFR27zMp/Znpz8bhMQXgE95SEdbxkkNyuZ4HGrXH3lE2cvM+q6BNc6JnpGVpFIpl4
         Pk6E34v6z/+PJKhVboqtmcY9XK+aoB7uFi4ojfstlzrzWf/5Tnc8dLyEfIvbOcO6R6cq
         jV6VE42Ut9drut+3TWxPPYFkq5TGiIC0t0IVuHzYK9A01+OhHEAwq9ueJitW87+wSqAN
         auAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GhposM3n;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GhposM3n;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 18/87] powerpc/powernv: Fix NVRAM sleep in invalid context when crashing
Date: Mon, 21 May 2018 23:10:54 +0200
Message-Id: <20180521210421.964411464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109847879759429?=
X-GMAIL-MSGID: =?utf-8?q?1601109847879759429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit c1d2a31397ec51f0370f6bd17b19b39152c263cb upstream.

Similarly to opal_event_shutdown, opal_nvram_write can be called in
the crash path with irqs disabled. Special case the delay to avoid
sleeping in invalid context.

Fixes: 3b8070335f75 ("powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops")
Cc: stable@vger.kernel.org # v3.2
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -44,6 +44,10 @@ static ssize_t opal_nvram_read(char *buf
 	return count;
 }
 
+/*
+ * This can be called in the panic path with interrupts off, so use
+ * mdelay in that case.
+ */
 static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	s64 rc = OPAL_BUSY;
@@ -58,10 +62,16 @@ static ssize_t opal_nvram_write(char *bu
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
 		if (rc == OPAL_BUSY_EVENT) {
-			msleep(OPAL_BUSY_DELAY_MS);
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
 		} else if (rc == OPAL_BUSY) {
-			msleep(OPAL_BUSY_DELAY_MS);
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 		}
 	}
 
