Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49AzB1FIruZiq3xWWzFXpI1DUMz/ZFQ7ZdKFOikN18E3Ll7qvQz7NdG+O5oHWnbiF2NsbdT
ARC-Seal: i=1; a=rsa-sha256; t=1523472654; cv=none;
        d=google.com; s=arc-20160816;
        b=I8R/gyTnWxyEjg+jry9KpQ4Gr0pc0m0doIu0DkqLXcRSUJV3W/Y9vY+Es+2oLrcEiR
         fjwJEaKegCwI/XBdg0RnMCOoe1NGC+be/khl2WVpNVGIHg4/UJBwHfOjh89yKHp3R+Cp
         1qPpTL2iMqKRoaefoee25qsTDfDmH8VwZ1eC8zWZmxyYSYRMkx2es4BgbppQKoEGMamk
         EkwQzS7esZr1HN1CiYR/VZaQC65EJrQI8iAZQlQojtNHmRVnbwrnWNI6lqes0nid0dmU
         RwsM8xiQ8J8zJ7eXol6pHDNsLHmAJInIUhSEZ2/DtBuOKG+tU+dyAX/LXF6tdhXRMAyf
         84IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Is0Y+eesSpLQum9mMxHpkh3ytAOB9pY+VBP5sGmzZl8=;
        b=Yn6bj3VSDcNWxEeLIHBFQXO0ytlE8cI+g92g3Nr89DajlWRRnimvlJoYNZaZjpBpNf
         qMGN56+DWwukN+GLQ9os/9/Su+m+K1V/zuhKcAsN1nrEj1zygy7KRn0meGxnIl8kLrEH
         GULO4bmKQwvfGa6iCJ43goGwPrM2324mvPGdahUUrTylo8leppZcxoPxNMO7Oh4oVl63
         7B9BuNlCtP/ZaxmLNyWsBxGRY83hGKtJzHOXdcyBbAmx5ja+AjjAXjgGvIbGLsM0D4O6
         NVV30ALjPEFRt9ROicx3uov6qMj17qFH0ojRS2f1saZUTskO9Hgmu5JeeA8PTs6ArX3Y
         lCsw==
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
Subject: [PATCH 4.4 163/190] random: use lockless method of accessing and updating f->reg_idx
Date: Wed, 11 Apr 2018 20:36:49 +0200
Message-Id: <20180411183602.061844479@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476320315000318?=
X-GMAIL-MSGID: =?utf-8?q?1597476861931413950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -886,15 +886,15 @@ static void add_interrupt_bench(cycles_t
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
 
