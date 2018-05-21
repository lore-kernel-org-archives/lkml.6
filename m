Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqT2FCGkuT9YyTG3FdncMgY0/H7YiFAWoSX8VNypOcdbGJERmnf8JkvUpCKvI08z15dFDWW
ARC-Seal: i=1; a=rsa-sha256; t=1526937858; cv=none;
        d=google.com; s=arc-20160816;
        b=Du9Mf0TpUnCT1kjIw6LpAVl0CDoiIL2zmAw9vC8JyOTM/1IsKXkQGgh1jb9Hvp6zek
         YJlpx3i+L7OROdqwBaDbMW7tQXzUk6mGmwqMeJNe1+HdQVo84eBzGs5bjrjUvC4Izf5S
         thFIo/+sFL6uImrLq1VExJtP+8siXgeCuh5OmJFPqYYzuXEFJ3dD7d1eOOF80bw4yf5Z
         HZ0Lfw3eMrliopf9Xp+NedsUzWaKjRZfSTsYAsMaKuFbinGoU2Afs8WqjY1veRKxug5e
         h3biemVft3TZrf42K0C7VkHWDkHM1u6uItr+qegMyvHVsw35OvClkFm++KRu1/TqmpmE
         2KFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=K1kkr//HmVHsKbQygVFljizo4JApU5OUpk4rQYLVrek=;
        b=RK2uvN7SkpFTF1O9vCspAYHET+pQnKVsHkBJSPE+DCndbb+5SOs0GakDW8cH4P8qXa
         B6v8BvDUMo0mJnak1GSxeA+wNZu4gVyhjHEBpdrydeOZ84izjxV9KRGz8VQdGZvQoode
         Nfqy8stwu5jIGMBuLgiTKvZjxjKviZUHeeSHHgV11mZB/3XijQExchyStiU6chVXVwxb
         mAYe5VkybdKl64+dXhGTge7EuhN9WOql06ReTH4gnOGZsP/Lg5p8UV2uq2pfM9LjS0ej
         qFfWkJY4PgFA9qnr4WdCA3ap2Ry0tL0GJ6pslWytOpXvXufwi7Lv0m8oFB9DSCfKtolw
         4CXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=g69PstjA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=g69PstjA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poulson <jopoulso@microsoft.com>,
	"Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Rakib Mullick <rakib.mullick@gmail.com>,
	Jork Loeser <Jork.Loeser@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 4.16 051/110] tick/broadcast: Use for_each_cpu() specially on UP kernels
Date: Mon, 21 May 2018 23:11:48 +0200
Message-Id: <20180521210509.649360269@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109796027859618?=
X-GMAIL-MSGID: =?utf-8?q?1601110391835874280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit 5596fe34495cf0f645f417eb928ef224df3e3cb4 upstream.

for_each_cpu() unintuitively reports CPU0 as set independent of the actual
cpumask content on UP kernels. This causes an unexpected PIT interrupt
storm on a UP kernel running in an SMP virtual machine on Hyper-V, and as
a result, the virtual machine can suffer from a strange random delay of 1~20
minutes during boot-up, and sometimes it can hang forever.

Protect if by checking whether the cpumask is empty before entering the
for_each_cpu() loop.

[ tglx: Use !IS_ENABLED(CONFIG_SMP) instead of #ifdeffery ]

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poulson <jopoulso@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: stable@vger.kernel.org
Cc: Rakib Mullick <rakib.mullick@gmail.com>
Cc: Jork Loeser <Jork.Loeser@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: KY Srinivasan <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Link: https://lkml.kernel.org/r/KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
Link: https://lkml.kernel.org/r/KL1P15301MB0006FA63BC22BEB64902EAA0BF930@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/tick-broadcast.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -612,6 +612,14 @@ static void tick_handle_oneshot_broadcas
 	now = ktime_get();
 	/* Find all expired events */
 	for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
+		/*
+		 * Required for !SMP because for_each_cpu() reports
+		 * unconditionally CPU0 as set on UP kernels.
+		 */
+		if (!IS_ENABLED(CONFIG_SMP) &&
+		    cpumask_empty(tick_broadcast_oneshot_mask))
+			break;
+
 		td = &per_cpu(tick_cpu_device, cpu);
 		if (td->evtdev->next_event <= now) {
 			cpumask_set_cpu(cpu, tmpmask);
