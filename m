Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100203; cv=none;
        d=google.com; s=arc-20160816;
        b=V7c4D5sIKjFpaZKYm7LljQeebZuMgNr1xwbctigeOBCum4LHspoalpxN7lilD52EpJ
         9uIl9pfPQET7PYTYwBwJGlTGfKFIJZuJ2p/Bi5mqgRbw8SmZjXWtCgb8oDa3iF0dUQar
         CAWFDjzBrskm4zk7jH+0PhjNRoBRA/z1stYKJjh42ymNU8bxhPneB2RdB0lUKxtj9QQ+
         0j/EuM1sk/OXXTI1U//SBeIuZ2b4hDnegZCbrpFLEQsv7yryxaY8fPhEahWQAnAP2Gok
         HB9gzCsXzCiSnvbUh9/sUX/RUCke2tM7LkqjkPLKWdNtntkUAgjOKUWpmhhrY6zXwy++
         VCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=SOU5sS4nma5DlNvaiAdBk32+S4FmzOBgfbwzbCSCGGk=;
        b=xLuoVYpp1BrNemU3pxwpexm/pqnuYDnOCyFt5mxFNB+N4+M53zpwphvCpAS9t7vCD/
         RLmewF92jGFtpaxDOaOH/NU6nmH5jUdCSDB3cAV1YATLk2FpU6YsMk8AWQ8nxNQcCj3G
         apBOEXpU6Knqos1ziJqUBA+0khfpbJ2NqlMbFQ7155kA00l/lqHbw/ZxOlrhk+v2Sxth
         ZjOJkJGjNvfNu3KENhRwZznvs0ZxhboCzKPd8ouLamUminFN+bjcvHg48yfYifTlakKN
         6PK4HKF/W4+zpJfgtdFz1OLf5kranIRuY3lHonZ+0c2yTzDkrHl3zBGLS8nGhrkZbOYW
         Tx7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KXWV7DLm;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KXWV7DLm;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpocTYGN4tkta9ZnJublkEz2XT+iGWaLifhGooDI+6wgGWSU5lsofslg8Qj7GzH/Dr7FeRnRw==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] tty: hvc: remove unexplained "just in case" spin delay
Date: Tue,  1 May 2018 00:55:52 +1000
Message-Id: <20180430145558.4308-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183470570985095?=
X-GMAIL-MSGID: =?utf-8?q?1599183470570985095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This delay was in the very first OPAL console commit 6.5 years ago,
and came from the vio hvc driver. The firmware console has hardened
sufficiently to remove it.

Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_opal.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 0a72f98ee082..786e76a1e06d 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -313,14 +313,8 @@ static int udbg_opal_getc(void)
 	int ch;
 	for (;;) {
 		ch = udbg_opal_getc_poll();
-		if (ch == -1) {
-			/* This shouldn't be needed...but... */
-			volatile unsigned long delay;
-			for (delay=0; delay < 2000000; delay++)
-				;
-		} else {
+		if (ch != -1)
 			return ch;
-		}
 	}
 }
 
-- 
2.17.0
