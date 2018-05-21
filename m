Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpf60EBXqjBEBmD6B7t/rhPgp74OAon60ewW2kpD3LhFT2gQmEaL+gOzwlrg92RAJdh6mJx
ARC-Seal: i=1; a=rsa-sha256; t=1526937646; cv=none;
        d=google.com; s=arc-20160816;
        b=g29pcfqR5jDEMXHz3Zs0QghrXiqKlzNyoIHoDmRJRiA2xO4FHOt/ruRynRvStBM8Db
         JscZD0Pq+RoM9R0g+pjV1NPI8VM9QNaBc5uPDbqAEIzJ78fVnS3rrAZXywY4JvRejwfW
         I7a/PbWVx6sCPrXIlsIyhWOCEitvqPW06ydfzsj1MXM0A11KZxYmduecQag+XTzhKct1
         GtcB/mVR+KwJwv/kqZ2ma/xA94glc9m8OIJfUjPYdxX1dv1rO4PDOTbaaz6srG7ejuKk
         LFs3hLE1SAPTGiXwNSyBBSHohq8or3H0k2oU2tO5WSv6dL0/ajFDoIAABayVh4OA5twU
         XUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wC5CThO8YeFQ4U3xezCmvgYMCuzqPsVQfvNy7v2tltw=;
        b=r8eShzDEybAvZpE6jftJsGvd2gKhyAxi+NAPaZbVZNmjueZx826nncXtJAUWGXYKl1
         VGAVYzeyAMecuhdjN4buef/F2A4pPZHY23od/SiAm3JinNHWoY+sUCKuNAV7AodVrrV9
         15MZ3QjG55hDer0OCerWVV610lHBT2Z9wtwqmE3qFUmxMqSs+if6yKrPmQT8SLLMng0Z
         dh/BMx33z1YOR3oZdeRsEVfn9IsBMx7Y85+1QrXkAXeH0LwPn6gSil/a78u6N1YFgx6n
         F1hjngDyFjHILWer+IBKS96aH0PM5Rm+0hBmIvrKRO9l3+7HrRI5yBlOgGbl0z/WBGJ4
         O16w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UYg8yazA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UYg8yazA;
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
Subject: [PATCH 4.14 37/95] tick/broadcast: Use for_each_cpu() specially on UP kernels
Date: Mon, 21 May 2018 23:11:27 +0200
Message-Id: <20180521210455.517179176@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109796027859618?=
X-GMAIL-MSGID: =?utf-8?q?1601110169362997305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
