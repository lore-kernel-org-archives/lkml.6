Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5b7F4iAD2ffHWvKuGXk2Mk1Dw+L/f/Msejl2Vqgi0mYeg5ovB3QYtYBtqUdIkjC3fF44A
ARC-Seal: i=1; a=rsa-sha256; t=1523473132; cv=none;
        d=google.com; s=arc-20160816;
        b=P1SScoT0Up0RA8a/MOm6xHPnkxjhyy+JJE3C5EqYT5D020TWRN4rEs4+H8GRM8Uya2
         HBfZeC1peoonPWI/61VKsrszNQfT7KoHP0oVH5pZ2HLDHeO4dtLZ59u4U1DMuvq75yk1
         BRQW4Jka3Hey7LvudchBXXYHDrjrnwSbILthQLREWDt4cyH9VPjgjUSK7UJbqBIUQl+c
         ZqvaeJ03kB416fVQKRvl/uxvXwJmosNL0Zqmqpno08aIEoJ2iV0hLubmDuZfaxrxXZu3
         XRiouch1HPFyorSZ7oxkaGtZSXzFskXuIS30yYBr1G9FyRUol3kLZG8P28rD6x1mOIx4
         lRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B6+SiMLXUdxlgogPl2D88TSNzZKmoolEsk39vNBCxi8=;
        b=ideALcffr0A9phAvLyK8hOoJGvmLbLM2D7uzLJTAZ55zZmkaYWfhuXWJcUxL9I8yxr
         mEmLrsnek1aaReGpKMmWI+Oo4T7ZGAjgShczMkaiUal2UcI3LkCN13YT3b5j4xtGTSg5
         K03J+8kRHgky2NtA8Li1Rh212ZWQv+x1zmWlqYtFvs2xZBS19OCd990FCYReZe55ok4p
         lieGNk65cYhNe9LFIBtAtxMc2dGD5Et7XGabk7imzU/L/IhQTGJMjFhNN8grVlrO9cOI
         H/7G1mJrl/D/E1AAXluTwy8pt8KH8NX+jT5jqOw0ItOG9tWRnxbpuhZJiZD8SToM43+h
         BPpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Schmitz <schmitzmic@gmail.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 106/310] fix race in drivers/char/random.c:get_reg()
Date: Wed, 11 Apr 2018 20:34:05 +0200
Message-Id: <20180411183626.773044501@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476151458318513?=
X-GMAIL-MSGID: =?utf-8?q?1597477363631884122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Schmitz <schmitzmic@gmail.com>


[ Upstream commit 9dfa7bba35ac08a63565d58c454dccb7e1bb0a08 ]

get_reg() can be reentered on architectures with prioritized interrupts
(m68k in this case), causing f->reg_index to be incremented after the
range check. Out of bounds memory access past the pt_regs struct results.
This will go mostly undetected unless access is beyond end of memory.

Prevent the race by disabling interrupts in get_reg().

Tested on m68k (Atari Falcon, and ARAnyM emulator).

Kudos to Geert Uytterhoeven for helping to trace this race.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1115,12 +1115,16 @@ static void add_interrupt_bench(cycles_t
 static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	__u32 *ptr = (__u32 *) regs;
+	unsigned long flags;
 
 	if (regs == NULL)
 		return 0;
+	local_irq_save(flags);
 	if (f->reg_idx >= sizeof(struct pt_regs) / sizeof(__u32))
 		f->reg_idx = 0;
-	return *(ptr + f->reg_idx++);
+	ptr += f->reg_idx++;
+	local_irq_restore(flags);
+	return *ptr;
 }
 
 void add_interrupt_randomness(int irq, int irq_flags)
