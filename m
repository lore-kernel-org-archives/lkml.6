Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 05:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C3820865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 05:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3NCvc2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C3820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeIIK2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 06:28:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39849 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeIIK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 06:28:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so8877008pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 22:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E48l/aqBz54nPrvKRMKkRqIgwe4+fA2vTM9eLntqxis=;
        b=t3NCvc2GtjXNSJcLTyJ1ibgN+wfSmAZEodQ9vjYM/6GXmMoExL6UBjfbzD60q4IgWL
         oZswFJKl/+cKvUWxB8j30xesnQWti2Z4k46m/70QMb4JIn5ICgz6AXvDk9SiOZKFkDq7
         k8wrR1ZB8s+2QK6D9S7nqPy8DzDBj97zwrbD3R+XVdqeS6D3frI/jKh2i7zCXtB2gKxF
         PiY6VMzB1lVc6yZ/Gq+MZVTEqs4XXXCSmo3DTMo0fIhSreDHiNpVPO+EAn7mteMdt08Z
         pMrnzmTdTkT7AM2b+YAXDQAXWP4UCS9Tw3I1PCm8Rs16CAJcbPryoMrWQqNZkNSlQB+e
         FGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E48l/aqBz54nPrvKRMKkRqIgwe4+fA2vTM9eLntqxis=;
        b=VJgZjXb13Ixl4Y78ZlO+/IPaYDB8ytItiDNy/sfckelkY6PGSbyA/d4eClKKn0Rbsf
         /QnDX62JmE8Uhu0ODNtmvSKPiJD+6l2Fbj1Hr8I2lk2IBlBO1Z4wCWEIYWs7h2uL3qYV
         mpReEQgzeLGonvXLAbq/jiThbbEFINFX/tdXhP9BsmvBZ4clSppiBCdVV9wk9brvT4Yg
         eDdyjIsJX0L9SGNzuysjSqO+9hUfr9lguRIn+iIC4sea4m5w6A5BD+9MpaQw5WYe6quX
         doPOII5byOeUvJ7PTIozXNeM1Bz3qTeYeomPfB80TeerLig3/XWrT0USskdITzc4QZdK
         qo/g==
X-Gm-Message-State: APzg51Bs7HtPSrcCOlZGlN6MLCt90rg0m4X2rgcD2eQ9CzxwIao3y49d
        paZ/FJ1RsSeSS642LPsr+sc=
X-Google-Smtp-Source: ANB0VdYFsVLP80qffem2frEYWMjOViN6umTO5HcYmsQARfKxLBnU4zanLGvG/HDAY9x1R98v07XlFA==
X-Received: by 2002:a63:d150:: with SMTP id c16-v6mr16287901pgj.188.1536471575684;
        Sat, 08 Sep 2018 22:39:35 -0700 (PDT)
Received: from roar.au.ibm.com (115-64-249-220.tpgi.com.au. [115.64.249.220])
        by smtp.gmail.com with ESMTPSA id 186-v6sm6491034pgg.56.2018.09.08.22.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 22:39:35 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH v2 2/3] tty: hvc: hvc_poll() fix read loop batching
Date:   Sun,  9 Sep 2018 15:39:15 +1000
Message-Id: <20180909053916.14139-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180909053916.14139-1-npiggin@gmail.com>
References: <20180909053916.14139-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop")
removes get_chars batching entirely, which slows down large console
operations like paste -- virtio console "feels worse than a 9600 baud
serial line," reports Matteo.

This adds back batching in a more latency friendly way. If the caller
can sleep then we try to fill the entire flip buffer, releasing the
lock and scheduling between each iteration. If it can not sleep, then
batches are limited to 128 bytes. Matteo confirms this fixes the
performance problem.

Latency testing the powerpc OPAL console with OpenBMC UART with a
large paste shows about 0.25ms latency, which seems reasonable. 10ms
latencies were typical for this case before the latency breaking work,
so we still see most of the benefit.

  kopald-1204    0d.h.    5us : hvc_poll <-hvc_handle_interrupt
  kopald-1204    0d.h.    5us : __hvc_poll <-hvc_handle_interrupt
  kopald-1204    0d.h.    5us : _raw_spin_lock_irqsave <-__hvc_poll
  kopald-1204    0d.h.    5us : tty_port_tty_get <-__hvc_poll
  kopald-1204    0d.h.    6us : _raw_spin_lock_irqsave <-tty_port_tty_get
  kopald-1204    0d.h.    6us : _raw_spin_unlock_irqrestore <-tty_port_tty_get
  kopald-1204    0d.h.    6us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.    7us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.    7us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.   36us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   36us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   36us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.   65us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   65us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   66us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.   94us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   95us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   95us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  124us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  124us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  125us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  154us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  154us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  154us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  183us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  184us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  184us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  213us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  213us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  213us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  242us : _raw_spin_unlock_irqrestore <-__hvc_poll
  kopald-1204    0d.h.  242us : tty_flip_buffer_push <-__hvc_poll
  kopald-1204    0d.h.  243us : queue_work_on <-tty_flip_buffer_push
  kopald-1204    0d.h.  243us : tty_kref_put <-__hvc_poll
  kopald-1204    0d.h.  243us : hvc_kick <-hvc_handle_interrupt
  kopald-1204    0d.h.  243us : wake_up_process <-hvc_kick
  kopald-1204    0d.h.  244us : try_to_wake_up <-hvc_kick
  kopald-1204    0d.h.  244us : _raw_spin_lock_irqsave <-try_to_wake_up
  kopald-1204    0d.h.  244us : _raw_spin_unlock_irqrestore <-try_to_wake_up

Reported-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index c917749708d2..bacf9b73ec98 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -623,6 +623,15 @@ static int hvc_chars_in_buffer(struct tty_struct *tty)
 #define MAX_TIMEOUT		(2000)
 static u32 timeout = MIN_TIMEOUT;
 
+/*
+ * Maximum number of bytes to get from the console driver if hvc_poll is
+ * called from driver (and can't sleep). Any more than this and we break
+ * and start polling with khvcd. This value was derived from from an OpenBMC
+ * console with the OPAL driver that results in about 0.25ms interrupts off
+ * latency.
+ */
+#define HVC_ATOMIC_READ_MAX	128
+
 #define HVC_POLL_READ	0x00000001
 #define HVC_POLL_WRITE	0x00000002
 
@@ -669,8 +678,8 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 	if (!hp->irq_requested)
 		poll_mask |= HVC_POLL_READ;
 
+ read_again:
 	/* Read data if any */
-
 	count = tty_buffer_request_room(&hp->port, N_INBUF);
 
 	/* If flip is full, just reschedule a later read */
@@ -717,7 +726,18 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 #endif /* CONFIG_MAGIC_SYSRQ */
 		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
-	read_total = n;
+	read_total += n;
+
+	if (may_sleep) {
+		/* Keep going until the flip is full */
+		spin_unlock_irqrestore(&hp->lock, flags);
+		cond_resched();
+		spin_lock_irqsave(&hp->lock, flags);
+		goto read_again;
+	} else if (read_total < HVC_ATOMIC_READ_MAX) {
+		/* Break and defer if it's a large read in atomic */
+		goto read_again;
+	}
 
 	/*
 	 * Latency break, schedule another poll immediately.
-- 
2.18.0

