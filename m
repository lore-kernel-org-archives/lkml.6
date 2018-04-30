Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100218; cv=none;
        d=google.com; s=arc-20160816;
        b=z8kzhks9ckteeIpGfpMsvzGhEUDnUm/eMghHInhKK5f5aAuS7gHov1dVQzbZBv2uln
         iT2mx0Au4xRZmbFeI54BPvQ/URx9Dwu6BY/YzYoY/6aMdJHI+sXKHxPP6OFYW/yhOjtE
         UmBwn60fIYRYjkunw9lUyVjE3jHfI1hLrlKP3qSmmrWW36AbpkESncrzjT2CC2qcE5/S
         Y3LeVjdNwC9edBxDIXbQtEWxpRsdG+FWrbkWLYHdCAyZDgXxrgTfad4vJGJ+hTAsEHfJ
         VRCzGID6hjHKaXFypn6VPvjNycpg1WISL0DMUMIuDYTIs5o5e/wPDxPomU9KxAPeWo5J
         JRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=fjmC+kPlGE91uLgJT33jj6nSucLu36EYujTmEQhL5nY=;
        b=eK5KZRcQ8IrxyMQKKK3X6ACS/Vbg5Zh/uWaotiMg2MhMyfd5Bm7W4b+VzP4OMBV9B1
         Kisi7hDBrsRh4lZeNAiWUzNrV8v75915cx8El8PCZEXJmhCfxkoN59d0TpP9utEi9bl8
         3IZeFD9ZmywcHx4ZfQGPjb6sQiSo8kc+mQtIUtD+t/TV7dJAviKT6ayxOtTh4Cye86bP
         YwkuFBoArVypiRIFg0a5Ok/VsxN/JGlcO7oWTpjjUiX/SWnpe3oTCG+eEiuHD//FsXXN
         7e2iS18X4Acg4ng20eDya+SnF95Av+1t3GAFFuOG0FBYB0mQBuKPjZZxtZKS7gvAKSm4
         RVYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GBPOoj/g;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GBPOoj/g;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZodEV0i8zzV9sG3KhRBGYv2MMDLSoRzC0ItxrmXoNZ4Xb1py5sVRZMmieA8BfJCmHcpEOQJBw==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] tty: hvc: hvc_write may sleep
Date: Tue,  1 May 2018 00:55:56 +1000
Message-Id: <20180430145558.4308-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183486856301586?=
X-GMAIL-MSGID: =?utf-8?q?1599183486856301586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rework the hvc_write loop to drop and re-take the spinlock on each
iteration, add a cond_resched. Don't bother with an initial hvc_push
initially, which makes the logic simpler -- just do a hvc_push on
each time around the loop.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 36 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 2abfc0b15fbb..6131d5084c42 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -493,23 +493,29 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 	if (hp->port.count <= 0)
 		return -EIO;
 
-	spin_lock_irqsave(&hp->lock, flags);
+	while (count > 0) {
+		spin_lock_irqsave(&hp->lock, flags);
 
-	/* Push pending writes */
-	if (hp->n_outbuf > 0)
-		hvc_push(hp);
-
-	while (count > 0 && (rsize = hp->outbuf_size - hp->n_outbuf) > 0) {
-		if (rsize > count)
-			rsize = count;
-		memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
-		count -= rsize;
-		buf += rsize;
-		hp->n_outbuf += rsize;
-		written += rsize;
-		hvc_push(hp);
+		rsize = hp->outbuf_size - hp->n_outbuf;
+
+		if (rsize) {
+			if (rsize > count)
+				rsize = count;
+			memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
+			count -= rsize;
+			buf += rsize;
+			hp->n_outbuf += rsize;
+			written += rsize;
+		}
+
+		if (hp->n_outbuf > 0)
+			hvc_push(hp);
+
+		spin_unlock_irqrestore(&hp->lock, flags);
+
+		if (count)
+			cond_resched();
 	}
-	spin_unlock_irqrestore(&hp->lock, flags);
 
 	/*
 	 * Racy, but harmless, kick thread if there is still pending data.
-- 
2.17.0
