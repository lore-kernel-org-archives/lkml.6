Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48/jZJADycTdec9O+HO0XH1nZX14r4JTBa7I9NwjsRd59Mb6sdwqZGpdqTobVL5Llmro9Vv
ARC-Seal: i=1; a=rsa-sha256; t=1524406880; cv=none;
        d=google.com; s=arc-20160816;
        b=VVZf6EmT8nCQAQWjztrgjodsqTXuQftrv24ycLPHNgkE+luOZdiFBB5WOaxh4J/BiQ
         ppAYs51gYZT25Ezan+dNKLHWgrEB822GezBBqg11I2NZ7xdT8JFIdgi3XLqzxtMI+Bbu
         ntfXcPlouvzxd3R5KYQgfin9qBjCooEPpNk4DOEZkbJVa7P0n5lnrQR47CgwRqjlgutp
         tDD+bJZ1pwfa8/pGcOKr7ECs8c7jJ8/aAv6TD7TyYmx+n+gOLLx16esjNOFFVOIW9e6A
         mqZb+T4wS0wdTFAeEPUN31RXTErvqaFRpMwSEYp/ha8x8FtZAm48s79AFgh9tZFhjiuM
         pU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7/u9HnoRRwqi8OcEFcY/YAa7gI54IQegSHIxXQs/y8s=;
        b=HYVISGKaLISciOlSVQPjC8uXFuDyiVkZZqHpJpb4rOlRMIOpp4OrkFu61jFAd+C/ii
         D0PoKFcdLrsjcrFvB0NQsvzKuT2RK1jLFSEroxyGoAkmPiP6NZB7gKGa9xvf2CX0hr8U
         dcMX9eMkTKhuBn5FLfnD5Ikq43UkXee7Xzoii+MXnSXIm9u/YUwjwbGnkKrj8KY/BU6m
         VKB3OPlPRID7fZUYTMTCCN2i6tHeQK3VQVXRzb9V6cbml2j2rFYYo76cNt2sJkk0e48X
         IVA+Xp/6dVal6m2glcxs2hsj9I7VALoiVf7n+SH+3MDIfPoNAJbH40Wgg+GQUuXa78mG
         JDKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3.18 21/52] powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
Date: Sun, 22 Apr 2018 15:53:54 +0200
Message-Id: <20180422135316.257965246@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454959303912084?=
X-GMAIL-MSGID: =?utf-8?q?1598456469032855720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 3b8070335f751aac9f1526ae2e012e6f5b8b0f21 upstream.

The OPAL NVRAM driver does not sleep in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware, which causes large scheduling
latencies, and various lockup errors to trigger (again, BMC reboot
can cause it).

Fix this by converting it to the standard form OPAL_BUSY loop that
sleeps.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Depends-on: 34dd25de9fe3 ("powerpc/powernv: define a standard delay for OPAL_BUSY type retry loops")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -11,6 +11,7 @@
 
 #define DEBUG
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -55,8 +56,12 @@ static ssize_t opal_nvram_write(char *bu
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 
 	if (rc)
