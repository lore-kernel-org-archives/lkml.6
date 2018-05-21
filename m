Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpqQ2nGLU++RxM2kWTTam1EQKcK9KS6oPpdPXbFGe6WoCgN+c9IdxVzFzESBv3JZR5rxMNX
ARC-Seal: i=1; a=rsa-sha256; t=1526937355; cv=none;
        d=google.com; s=arc-20160816;
        b=RLNBDNXkPPFwyU/1tfVnv//JNgvT5+9hByyRMoOH51CUVee+U3oI7Z0bddiUJL/nJ1
         UisjHrb69v5szehrrw4NEG1USdMS5ieml1BSuUxvI4SDIg6SsvC4qfBUFcgY6Ob1ph6l
         FdeZXZy7CEQer6Phb3dpqACJylIYfIbj+xEZ4Re23sa9T/kQApdXrfMzYPEmUuOxBJ9X
         rI3iIMQ7gIBYUlfcMAk0Xf5pmHZkjd+oVq6a6Iz4QodZlIPBkj6g6wA5peqjwdkDXJdm
         3KnVn87X71z84vgh3Jy1A24Jkn/+o/jQNyd9oCgGsMaKdVjYH2qniCVKmqx/q/AKqBsd
         98Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BbZxDJtRXvZTly09K3Xh9AhvucYTNm+nE4L9Yf4Y5fU=;
        b=r4T1Qp4TX4mA/UDyBRKlndWwDVQUcZRKUGAnoN9R/AEm/REcvEGuhjYbFxooDSsMvM
         ug1x3BsuDhsFQLcRaEQlSqBtrsQ3KtdYOb1LrSx3g5oraFPaERAuLaQ3DuyCsUW6AT61
         +ZmfLPvSAYLeFtWyhnitITnfIrWYff9tSoKDXVX13ZkGiu4KnDCoiDxvZfVnHWdZ8cmp
         9U0Ueb6+V5tRFMuvXlqSENsJ0adKnAIUoARFTbmiO7zTgX7M2EoDNG8zKjAX9NW1aH5R
         Aj8To5vwy4HmocOxtHZBy3HenhkysIjcDsREPSctf/cI7nS29EjGNukXqNidR4uNiQ/G
         +21Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BHp89pas;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BHp89pas;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kyle Huey <khuey@kylehuey.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 50/87] x86/process: Optimize TIF checks in __switch_to_xtra()
Date: Mon, 21 May 2018 23:11:26 +0200
Message-Id: <20180521210424.913943908@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109864314882948?=
X-GMAIL-MSGID: =?utf-8?q?1601109864314882948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Huey <me@kylehuey.com>

commit af8b3cd3934ec60f4c2a420d19a9d416554f140b upstream

Help the compiler to avoid reevaluating the thread flags for each checked
bit by reordering the bit checks and providing an explicit xor for
evaluation.

With default defconfigs for each arch,

x86_64: arch/x86/kernel/process.o
text       data     bss     dec     hex
3056       8577      16   11649    2d81	Before
3024	   8577      16	  11617	   2d61	After

i386: arch/x86/kernel/process.o
text       data     bss     dec     hex
2957	   8673	      8	  11638	   2d76	Before
2925	   8673       8	  11606	   2d56	After

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: http://lkml.kernel.org/r/20170214081104.9244-2-khuey@kylehuey.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

[dwmw2: backported to make TIF_RDS handling simpler.
        No deferred TR reload.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/process.c |   54 ++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -192,48 +192,56 @@ int set_tsc_mode(unsigned int val)
 	return 0;
 }
 
+static inline void switch_to_bitmap(struct tss_struct *tss,
+				    struct thread_struct *prev,
+				    struct thread_struct *next,
+				    unsigned long tifp, unsigned long tifn)
+{
+	if (tifn & _TIF_IO_BITMAP) {
+		/*
+		 * Copy the relevant range of the IO bitmap.
+		 * Normally this is 128 bytes or less:
+		 */
+		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
+		       max(prev->io_bitmap_max, next->io_bitmap_max));
+	} else if (tifp & _TIF_IO_BITMAP) {
+		/*
+		 * Clear any possible leftover bits:
+		 */
+		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
+	}
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 		      struct tss_struct *tss)
 {
 	struct thread_struct *prev, *next;
+	unsigned long tifp, tifn;
 
 	prev = &prev_p->thread;
 	next = &next_p->thread;
 
-	if (test_tsk_thread_flag(prev_p, TIF_BLOCKSTEP) ^
-	    test_tsk_thread_flag(next_p, TIF_BLOCKSTEP)) {
+	tifn = READ_ONCE(task_thread_info(next_p)->flags);
+	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
+	switch_to_bitmap(tss, prev, next, tifp, tifn);
+
+	propagate_user_return_notify(prev_p, next_p);
+
+	if ((tifp ^ tifn) & _TIF_BLOCKSTEP) {
 		unsigned long debugctl = get_debugctlmsr();
 
 		debugctl &= ~DEBUGCTLMSR_BTF;
-		if (test_tsk_thread_flag(next_p, TIF_BLOCKSTEP))
+		if (tifn & _TIF_BLOCKSTEP)
 			debugctl |= DEBUGCTLMSR_BTF;
-
 		update_debugctlmsr(debugctl);
 	}
 
-	if (test_tsk_thread_flag(prev_p, TIF_NOTSC) ^
-	    test_tsk_thread_flag(next_p, TIF_NOTSC)) {
-		/* prev and next are different */
-		if (test_tsk_thread_flag(next_p, TIF_NOTSC))
+	if ((tifp ^ tifn) & _TIF_NOTSC) {
+		if (tifn & _TIF_NOTSC)
 			hard_disable_TSC();
 		else
 			hard_enable_TSC();
 	}
-
-	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
-		/*
-		 * Copy the relevant range of the IO bitmap.
-		 * Normally this is 128 bytes or less:
-		 */
-		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(prev->io_bitmap_max, next->io_bitmap_max));
-	} else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
-		/*
-		 * Clear any possible leftover bits:
-		 */
-		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
-	}
-	propagate_user_return_notify(prev_p, next_p);
 }
 
 /*
