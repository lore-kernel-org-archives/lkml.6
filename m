Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48phIA7Ers7cZ5O3FT990P2l443c1G3JyvhfpRi3fwWIUmXK6ibyQ1KJ80n4s1Rlz14Z2me
ARC-Seal: i=1; a=rsa-sha256; t=1524406413; cv=none;
        d=google.com; s=arc-20160816;
        b=ahmeOjJg8MHAIxyay+HXTTUZUD8B02jIpzNoCtrxjbB5zIJU5ZdFiQAZZ27RfBEwhR
         Im8oh1iMXbhMwkoFe8bHkb1CFjBnq3/MSG7XLcNl2RmLyqAZg0IeM8xqhzyKbZtOw4LL
         qQLE2zXJ5aDpxB+C7HX/r03C+m/p9SR5kLNL22KwSYomYp/lbvOhTL2PgCN3XWtDyl/B
         Z93tCTuamD7e4DYm2UYyM+ltTuJe1xnIu0bHWuz5YT/KGRCTaz2I5DL1mzEzGBztlwbL
         Fx+8xIVKZ406IKpCdjMecHzTD9J7y+7SPuiM/OJCBuWOGsDPHUKXb09tcFIgDHgIcDil
         SCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IVSwu8RR8cWuefbsO5Ynb5b0uX5uxV4w2uDzW74ojhQ=;
        b=QX0/MS1EmCi8xJaAX8ZwFyMkSHu3K6Oj4u2o6UVC5DBhLxxe3LeHxOMV7JZWXDqn75
         GjB7CwXeNORXNUgr67Oueuvs+MqQNe91cVYPH0TMpu9Lzr3DpWG0QcaJYWUJiIZaKkZ8
         GVTSZMPNK2Mby9ah7uUiaAStC6x0NBvusUVCh/WjH+/46TW+9SEREh/SQJWpH1Hl6xSB
         22CkV5+NaxGIjqL+iHu1Vf156H0/w1UmO9TsHpkJBC4ETw2u4fQR+ORQBzYlF2BBoFJ0
         a7IG+ZXG3KgGqWDGHDrTMb1aJyUme7aPqKycyM6+PLUUtFyqwwWl/m+8LcpfNfZaCo3k
         EFnA==
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
Subject: [PATCH 4.9 27/95] powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
Date: Sun, 22 Apr 2018 15:52:56 +0200
Message-Id: <20180422135211.547774444@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454959303912084?=
X-GMAIL-MSGID: =?utf-8?q?1598455979788646097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -56,8 +57,12 @@ static ssize_t opal_nvram_write(char *bu
 
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
