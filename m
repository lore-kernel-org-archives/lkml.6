Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100214; cv=none;
        d=google.com; s=arc-20160816;
        b=dN7BUxYLGAqvqfUO3D0Qgrx0LMXLEUNLClJHk1VicojH1/16UYg3TA9d3IYYt91HZd
         pwxmac9VWjV8Ni+irIqkvbq3ZBhDUNzyloNPHt9VHB1O3AdAaZxyHSBDnEpN6FpjBmHZ
         KCKCP0DeM7Y2J7Q09Jr1T7+MwfkuIshFhvdbLUeq1qp2tlUsQDa+wr5rhOLO5iZw8djN
         s3ipGBiWsuFMf8kbSfqPwm1H7dBmMAO4g+ndPzuXQ5eJE8XrDKiqc71Z7NdmNB4o2HV2
         jtMVCPAJ5uFHwuL6PTfsyTrw14mxsb+yJ9NoZmq8/h+EUswD+C+i3phTICYcnl1ddJup
         yxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=+IU9OuKDo/5/9ugzSvyn0R1pJSCZ7KdQ+KLiU89lKWk=;
        b=dGB3ZrKw7raB97UJvxLXRBToVNvNdqWWNEqPfdEyxmH40rMSJlkKkJVyeBuAq9c2yX
         zPPT9K40Un+fVEn/6FqFSzMGuIca0RrjKUkp706IGd6KOXP8uU3gh9irlTWZ/g9uebtq
         A6AI8A4dGb4Q5yA1iJ80plcFpQjyzjYyRf9dHHHMA6oRj1khC02jZAf72fhv4Cc3zolb
         PuwdpgEvqg2iaHBRZWX2eZuwd5so/L2YkLerBUcmB7qvIykLw/BcZI3UcPv0Ti9z0noq
         LbFSuQ7djjCO+/mDbOXtepJGw5pJG6TQqeQp8SFrarDCRpZVW3j2iKXjwI9+JUM7sxFp
         spDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cbNhWRUl;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cbNhWRUl;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrU2OEUOSWu+MSE/XPJHZGdDd8+ZJyg9PLDHn+bmN5mI7cQk82AMK1CB3jS+hgYbVHs4EZOFQ==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] tty: hvc: hvc_poll may sleep
Date: Tue,  1 May 2018 00:55:55 +1000
Message-Id: <20180430145558.4308-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183483271658480?=
X-GMAIL-MSGID: =?utf-8?q?1599183483271658480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce points where hvc_poll drops the lock, enables interrupts,
and reschedules.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 745ac220fce8..2abfc0b15fbb 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -589,7 +589,7 @@ static u32 timeout = MIN_TIMEOUT;
 #define HVC_POLL_READ	0x00000001
 #define HVC_POLL_WRITE	0x00000002
 
-int hvc_poll(struct hvc_struct *hp)
+static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 {
 	struct tty_struct *tty;
 	int i, n, count, poll_mask = 0;
@@ -611,6 +611,12 @@ int hvc_poll(struct hvc_struct *hp)
 		timeout = (written_total) ? 0 : MIN_TIMEOUT;
 	}
 
+	if (may_sleep) {
+		spin_unlock_irqrestore(&hp->lock, flags);
+		cond_resched();
+		spin_lock_irqsave(&hp->lock, flags);
+	}
+
 	/* No tty attached, just skip */
 	tty = tty_port_tty_get(&hp->port);
 	if (tty == NULL)
@@ -698,6 +704,11 @@ int hvc_poll(struct hvc_struct *hp)
 
 	return poll_mask;
 }
+
+int hvc_poll(struct hvc_struct *hp)
+{
+	return __hvc_poll(hp, false);
+}
 EXPORT_SYMBOL_GPL(hvc_poll);
 
 /**
@@ -736,7 +747,8 @@ static int khvcd(void *unused)
 		if (!cpus_are_in_xmon()) {
 			mutex_lock(&hvc_structs_mutex);
 			list_for_each_entry(hp, &hvc_structs, next) {
-				poll_mask |= hvc_poll(hp);
+				poll_mask |= __hvc_poll(hp, true);
+				cond_resched();
 			}
 			mutex_unlock(&hvc_structs_mutex);
 		} else
-- 
2.17.0
