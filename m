Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48W/NMTusVKZhP6QjhWDJ9bY2JmeCIfDrAcq6aOSnyynDQ4V6n5CXW5bqC6ydyOl8pBSLOs
ARC-Seal: i=1; a=rsa-sha256; t=1524405440; cv=none;
        d=google.com; s=arc-20160816;
        b=P6Vh0eDY3SZyVIXfz6L7ZvNTdiF39AqbApsYhIL9RWcGW3HzmIvMAlgfODlZ0BKkh3
         AnVV0xQy8ALWs3rgagYJ6F+DBIRE/k9t/PpxqwQNQktVhqu+gWp/rMlI0As7rYlzQO+m
         ZRR/4y2mS8ECzSsn/FEeVno1vJwNJId/HWck54tMFjInrR57wf4N0fLd6UKPc/THIQYJ
         EWuBDhkRopjirQFICXSK7GBuXU+SdbB4Az2Y5n2yOZ9ayrSYSN0XhVk3d+IqW+E0heGR
         CW3E3fNRvp8G/Lt2ypZA1HhXYIQYy14yY7ODHkn+eW+DfUsC7hVIUB/gLpsCfg9KdYvT
         nqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XVP1F8m8Ni009f84k6cnUCYAq1kOZCr2fWoSiPsONTk=;
        b=WYrYrkNpgmpFUNGuE53+4atpXN34SoLqmDEWEZeN38H1ugpXbg94U8c7EbsYd+o0e0
         eiAywnrm+PWp0lD/u6RKRVtTzJigElPXiJEAczEj7tXln8owKzkuGtt71fYzNKpB6sFw
         9uKYXjb8C3yXZbGAOxnOc0NKICgsWKoEmxpUzpDHCjnQIrwBQCeyGykDC0AQ63UB+a3q
         MoR8LfsjyGddzrfrVlTPwhmX3uzKl0v71Oh1vdS87vWCQB5WAuzpWvrkdPIWdqL2nJIN
         ui3yQi5abiLsWljEEteGM9Rl4+qzYmRf6TdAwXPF1uPgdLDBqR0lsoFZHtTt9rznK5EO
         +eog==
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
Subject: [PATCH 4.16 067/196] powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
Date: Sun, 22 Apr 2018 15:51:27 +0200
Message-Id: <20180422135107.722037428@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454959303912084?=
X-GMAIL-MSGID: =?utf-8?q?1598454959303912084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
