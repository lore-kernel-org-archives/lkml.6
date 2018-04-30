Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100207; cv=none;
        d=google.com; s=arc-20160816;
        b=DZuOZHIvo1kYHUyvxOYGLmlp/rjT1zSNJ04xYEn0ch4nznOdzBnkNplZ3ftK+KABIJ
         Z3tTfhi27Mq5LJqA9Q1LpGNYJygrDASO4P47vp+BkIy1vNsx2hWEu6m0kTaRQsGNAa2i
         s5ytr0g/t7FXW5L9dykCYb0WoVkqiFcTJFJUAIkRlPDD6iS4x0CBlzsM0kOto9A7VXjH
         XGBA1NcsxvgGpgIy3TLp3uIBvAiMy4qzXgXDYpmBechrkVkApHjej5+LEeWC4ezBEmwa
         md3MPSyBPzmrbKjInDM1WJ7I244N9OVpwEK1N151HBsrSuqysGIm2w0h8uso5vz9R8UH
         URMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=9A9yJP8KTu1HlwBS06mSZVmty0mRd6rd0ELqr53RIYA=;
        b=flIhvxejKucDPvUjZq268CbEUgSVaqALlNa0Qac54IguLFygAylLQiFU0qEO9Ld0va
         6wz6e2QjWsnRmph9xHVaEVGicfq8Hx/aVg9OpwbQZpu3eRxOlZUGw2580pdTrCLfV8z6
         5b09Kuzr2QKfPQ4AvGY5UFx9s0i1lZrmk0wDhtG1LTcmffzo4zIjPI7tAWDIbl3FvsAD
         eeSywIgMQO5PJti7XpkIfjtJ1n8x+NlRWAW4wU6Oe65Z3qqlOHJUxedJkALjlJ3esGU1
         qStcnvQ3GjEir1JxTSStCM00XQiLgdGrrqB48AvxzXGw66Fsb/Q7y0iUrGJjRV+wI4T9
         uIPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FTY42b+S;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FTY42b+S;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqwWA7kZBHzp782O3ggYCdwSch1NT2EsPyLgnYBYw3dGYpzQzRQ/K95zTcgc75Lf+rYLZdhcA==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] tty: hvc: use mutex instead of spinlock for hvc_structs lock
Date: Tue,  1 May 2018 00:55:53 +1000
Message-Id: <20180430145558.4308-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183475049618365?=
X-GMAIL-MSGID: =?utf-8?q?1599183475049618365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This allows hvc operations to sleep under the lock.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 7709fcc707f4..fddb63322c67 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -73,7 +73,7 @@ static LIST_HEAD(hvc_structs);
  * Protect the list of hvc_struct instances from inserts and removals during
  * list traversal.
  */
-static DEFINE_SPINLOCK(hvc_structs_lock);
+static DEFINE_MUTEX(hvc_structs_mutex);
 
 /*
  * This value is used to assign a tty->index value to a hvc_struct based
@@ -83,7 +83,7 @@ static DEFINE_SPINLOCK(hvc_structs_lock);
 static int last_hvc = -1;
 
 /*
- * Do not call this function with either the hvc_structs_lock or the hvc_struct
+ * Do not call this function with either the hvc_structs_mutex or the hvc_struct
  * lock held.  If successful, this function increments the kref reference
  * count against the target hvc_struct so it should be released when finished.
  */
@@ -92,25 +92,24 @@ static struct hvc_struct *hvc_get_by_index(int index)
 	struct hvc_struct *hp;
 	unsigned long flags;
 
-	spin_lock(&hvc_structs_lock);
+	mutex_lock(&hvc_structs_mutex);
 
 	list_for_each_entry(hp, &hvc_structs, next) {
 		spin_lock_irqsave(&hp->lock, flags);
 		if (hp->index == index) {
 			tty_port_get(&hp->port);
 			spin_unlock_irqrestore(&hp->lock, flags);
-			spin_unlock(&hvc_structs_lock);
+			mutex_unlock(&hvc_structs_mutex);
 			return hp;
 		}
 		spin_unlock_irqrestore(&hp->lock, flags);
 	}
 	hp = NULL;
+	mutex_unlock(&hvc_structs_mutex);
 
-	spin_unlock(&hvc_structs_lock);
 	return hp;
 }
 
-
 /*
  * Initial console vtermnos for console API usage prior to full console
  * initialization.  Any vty adapter outside this range will not have usable
@@ -224,13 +223,13 @@ static void hvc_port_destruct(struct tty_port *port)
 	struct hvc_struct *hp = container_of(port, struct hvc_struct, port);
 	unsigned long flags;
 
-	spin_lock(&hvc_structs_lock);
+	mutex_lock(&hvc_structs_mutex);
 
 	spin_lock_irqsave(&hp->lock, flags);
 	list_del(&(hp->next));
 	spin_unlock_irqrestore(&hp->lock, flags);
 
-	spin_unlock(&hvc_structs_lock);
+	mutex_unlock(&hvc_structs_mutex);
 
 	kfree(hp);
 }
@@ -733,11 +732,11 @@ static int khvcd(void *unused)
 		try_to_freeze();
 		wmb();
 		if (!cpus_are_in_xmon()) {
-			spin_lock(&hvc_structs_lock);
+			mutex_lock(&hvc_structs_mutex);
 			list_for_each_entry(hp, &hvc_structs, next) {
 				poll_mask |= hvc_poll(hp);
 			}
-			spin_unlock(&hvc_structs_lock);
+			mutex_unlock(&hvc_structs_mutex);
 		} else
 			poll_mask |= HVC_POLL_READ;
 		if (hvc_kicked)
@@ -871,7 +870,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 
 	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
 	spin_lock_init(&hp->lock);
-	spin_lock(&hvc_structs_lock);
+	mutex_lock(&hvc_structs_mutex);
 
 	/*
 	 * find index to use:
@@ -891,7 +890,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	vtermnos[i] = vtermno;
 
 	list_add_tail(&(hp->next), &hvc_structs);
-	spin_unlock(&hvc_structs_lock);
+	mutex_unlock(&hvc_structs_mutex);
 
 	/* check if we need to re-register the kernel console */
 	hvc_check_console(i);
-- 
2.17.0
