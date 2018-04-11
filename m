Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/oxVcc6mJuJCY8jg/qgBVpy9dJSn2WIyNSSRI3AFSGkgcljRm/ppY4TJUBnM9/J+Uae/wD
ARC-Seal: i=1; a=rsa-sha256; t=1523472137; cv=none;
        d=google.com; s=arc-20160816;
        b=hWE7pKOfs7spDrheR0jDx9gOIxOpz78lhLAeDqEEIziWJ2X5xrsxdJQ2Ok2FhfURaS
         lrCFXZWXMSjJblzumChsV94cVgM1AzXzQuAozOIkt//FcpBABdKi0lUZjGzB9ugat6aX
         0Vy5PrGlr37X7GQNwX2eKJa9kq0FOpPNjSRGdSRehbwD0h67w5Ng6ItDoTDtO12GVNSp
         XQ3Pia7yIclBYMDWOyt8ZvXyQ/m9u82d4/L/1+vd3tCNdYPwT1/TdB8tQL5EKvb0QQQs
         MqTxWojOMVf5WPo3FfPfX2c61GNdr+Gw8jhI/AVifTpFf+FeOhBXobkeyHZCsRxmoQ4d
         IcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2nnVntPkIa7GYdoOsao72hMu38+GUpD3G4l19i/08jw=;
        b=B1Ugm26c2jksyN4EN5sdX4vAmhwf0+ttzPwN+SFlRDFLT2BGraUDYEi/huUOeBEE+C
         vgQ72+U81qpY4pLjvD8jdy2sRPgJJDjqfINKj7l3o4kPKzXchW0Yc0uJK3+x/SajQeDe
         vlLMjXVFeEmV/CxYhguwPSVJh8u5M+K7Q2g/7rqFtBzQvka2gEwqnuw5Zazljhcdrt/q
         7gnbI+7wth2jzGdOCWUcs5Omad70jNn6UUjbGGmrFEznjN79azloVRRLwKEdshh9e+nI
         Nt/MZ/vLzGLC8JhP9FqAJQCC+FNi/2uBI8Z8o2dQpzaaO9sEjel1333ead9uSGGoF2im
         17Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 3.18 101/121] random: use lockless method of accessing and updating f->reg_idx
Date: Wed, 11 Apr 2018 20:36:44 +0200
Message-Id: <20180411183502.925371527@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476320315000318?=
X-GMAIL-MSGID: =?utf-8?q?1597476320315000318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 92e75428ffc90e2a0321062379f883f3671cfebe upstream.

Linus pointed out that there is a much more efficient way of avoiding
the problem that we were trying to address in commit 9dfa7bba35ac0:
"fix race in drivers/char/random.c:get_reg()".

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -863,15 +863,15 @@ static void add_interrupt_bench(cycles_t
 static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	__u32 *ptr = (__u32 *) regs;
-	unsigned long flags;
+	unsigned int idx;
 
 	if (regs == NULL)
 		return 0;
-	local_irq_save(flags);
-	if (f->reg_idx >= sizeof(struct pt_regs) / sizeof(__u32))
-		f->reg_idx = 0;
-	ptr += f->reg_idx++;
-	local_irq_restore(flags);
+	idx = READ_ONCE(f->reg_idx);
+	if (idx >= sizeof(struct pt_regs) / sizeof(__u32))
+		idx = 0;
+	ptr += idx++;
+	WRITE_ONCE(f->reg_idx, idx);
 	return *ptr;
 }
 
