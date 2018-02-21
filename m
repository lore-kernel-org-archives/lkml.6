Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224srKbvhxR7vz+B8f7Vy0ZRiRli/S9YHWrH9gH1BAtAQLUTPIUm5rSsJMS1It2geeWF+Xrm
ARC-Seal: i=1; a=rsa-sha256; t=1519218433; cv=none;
        d=google.com; s=arc-20160816;
        b=KmraTRQLOZ+Ku2AabFTJhsWLZOHKYCOCXKim5MkKwXcfJ92Z5dk59U6CyspcwbGfOL
         t+EGGCG3mu1HfjpGldL8YwK+qfExF9M7E+P7+JZUiY6GF+Rl2WTG0U3hAaQ0oqwJcV5q
         hMWQXTJMZSyoxZgNOI8TrqWrM72FMOhekXZcjd/p8NCYaeIj2gUEZF8iE8A2DRMBJgQc
         qA5ni9u9PjLLMuiOrtpUEuGKAA6mbp8lQhhVKkxWEqkA3WNhsDERg9z60bWBV16Uf2D7
         sHbaUvv1ibeXVC5lr7Kpkh+lC+pytv1IR4SQORzWMQGeUbOO/oU2ilSV1YFNGMPI0Lew
         nXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KtNNQhcyP0rBNL3sDNc4g0QSSKhxfWdNiuoE3KmlCpY=;
        b=xmlbRUNlrl5TVrdXg1AXeJsSdaeSxxrers4raAb+JSVlC4lvmEjgcbuI0MLI2M9XAQ
         OTPZawMiTIsOiUorpBc9pRXQ8iQFzwjZefGSJp+1K7S6YMu3y78smsR4bmNevIe0qrLg
         QT2sUNOpmwdeSF4ma1O2dk/9E+EQP8sIpFtKl+2e4nO/nciLLmzoglsGOEkII7sj6ye/
         BsLge9a7raZfDe3tvVzj0v3KWU80JkAJMf4eIGk1AlRexak88N1MOd2+8ag8wHRWMEcL
         zZF6Y6zalEohvfUhXQLCFbVy/wSuNCEMXxu1T6jN9J4qcVJA6cIylSe4lLIp2m/KUDvn
         t6FA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 020/163] powerpc/kernel: Block interrupts when updating TIDR
Date: Wed, 21 Feb 2018 13:47:29 +0100
Message-Id: <20180221124531.267932292@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015988015098969?=
X-GMAIL-MSGID: =?utf-8?q?1593015988015098969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

commit 384dfd627f1ee67d028e6f14c6e9bf5a1e2a7a24 upstream.

clear_thread_tidr() is called in interrupt context as a part of delayed
put of the task structure (i.e as a part of timer interrupt). To prevent
a deadlock, block interrupts when holding vas_thread_id_lock to set/
clear TIDR for a task.

Fixes: ec233ede4c86 ("powerpc: Add support for setting SPRN_TIDR")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/process.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1509,14 +1509,15 @@ static int assign_thread_tidr(void)
 {
 	int index;
 	int err;
+	unsigned long flags;
 
 again:
 	if (!ida_pre_get(&vas_thread_ida, GFP_KERNEL))
 		return -ENOMEM;
 
-	spin_lock(&vas_thread_id_lock);
+	spin_lock_irqsave(&vas_thread_id_lock, flags);
 	err = ida_get_new_above(&vas_thread_ida, 1, &index);
-	spin_unlock(&vas_thread_id_lock);
+	spin_unlock_irqrestore(&vas_thread_id_lock, flags);
 
 	if (err == -EAGAIN)
 		goto again;
@@ -1524,9 +1525,9 @@ again:
 		return err;
 
 	if (index > MAX_THREAD_CONTEXT) {
-		spin_lock(&vas_thread_id_lock);
+		spin_lock_irqsave(&vas_thread_id_lock, flags);
 		ida_remove(&vas_thread_ida, index);
-		spin_unlock(&vas_thread_id_lock);
+		spin_unlock_irqrestore(&vas_thread_id_lock, flags);
 		return -ENOMEM;
 	}
 
@@ -1535,9 +1536,11 @@ again:
 
 static void free_thread_tidr(int id)
 {
-	spin_lock(&vas_thread_id_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vas_thread_id_lock, flags);
 	ida_remove(&vas_thread_ida, id);
-	spin_unlock(&vas_thread_id_lock);
+	spin_unlock_irqrestore(&vas_thread_id_lock, flags);
 }
 
 /*
