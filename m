Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B01CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7712186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfBLOa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:27 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43681 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfBLOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:27 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4e-0005Af-6B; Tue, 12 Feb 2019 15:30:12 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v1 03/25] printk-rb: define ring buffer struct and initializer
Date:   Tue, 12 Feb 2019 15:29:41 +0100
Message-Id: <20190212143003.48446-4-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See Documentation/printk-ringbuffer.txt for details about the
initializer arguments.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk_ringbuffer.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
index 75f5708ea902..0e6e8dd0d01e 100644
--- a/include/linux/printk_ringbuffer.h
+++ b/include/linux/printk_ringbuffer.h
@@ -10,6 +10,20 @@ struct prb_cpulock {
 	unsigned long __percpu *irqflags;
 };
 
+struct printk_ringbuffer {
+	void *buffer;
+	unsigned int size_bits;
+
+	u64 seq;
+
+	atomic_long_t tail;
+	atomic_long_t head;
+	atomic_long_t reserve;
+
+	struct prb_cpulock *cpulock;
+	atomic_t ctx;
+};
+
 #define DECLARE_STATIC_PRINTKRB_CPULOCK(name)				\
 static DEFINE_PER_CPU(unsigned long, _##name##_percpu_irqflags);	\
 static struct prb_cpulock name = {					\
@@ -17,6 +31,20 @@ static struct prb_cpulock name = {					\
 	.irqflags = &_##name##_percpu_irqflags,				\
 }
 
+#define DECLARE_STATIC_PRINTKRB(name, szbits, cpulockptr)		\
+static char _##name##_buffer[1 << (szbits)]				\
+	__aligned(__alignof__(long));					\
+static struct printk_ringbuffer name = {				\
+	.buffer = &_##name##_buffer[0],					\
+	.size_bits = szbits,						\
+	.seq = 0,							\
+	.tail = ATOMIC_LONG_INIT(-111 * sizeof(long)),			\
+	.head = ATOMIC_LONG_INIT(-111 * sizeof(long)),			\
+	.reserve = ATOMIC_LONG_INIT(-111 * sizeof(long)),		\
+	.cpulock = cpulockptr,						\
+	.ctx = ATOMIC_INIT(0),						\
+}
+
 /* utility functions */
 void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
 void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
-- 
2.11.0

