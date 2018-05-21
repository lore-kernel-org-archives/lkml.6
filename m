Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZonzAqIl9bEF0Gk2BpzokT9FoQCsjpG2OIJhy1b7eC/ZOmduGNUVvQbly5+ouf9mALFNhYG
ARC-Seal: i=1; a=rsa-sha256; t=1526937657; cv=none;
        d=google.com; s=arc-20160816;
        b=SQAo22o74eqEGJXuIMtONAUVE67mSWUenyjgGiyZXqyIFowcGborm+ifHfA5LJfCHN
         npj8skgfcUGuqKYMADrQVs5AB0qArIfWQRxpMMiTFffs3xFvOsn1danaL0wqLNXWrKev
         rR2wx03TCSacrW14sC8Zh9sF0Mic6t7/13nYIKzIKxTJ9iF6hB3QNDHJ8cE7dF4L8F+M
         pTuLs+tZFqhNs7dTfzHunnt33MN09f+pEHqss1TcxF4pJRZ5lfTQOwCtZFqWx2D59BrO
         W+0mJLsDJQ8qCeY7EK989Q+vaI2w7WTYEiqUePqBRx1+bsOSe2/0UtJYi4jI14t33lX1
         PwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GQb4EyIl+nBMPlaF7dv5T/s+2TKGmrRidhFuZB59pqc=;
        b=GjvqUW7AV2ZwLC6k78xum7mfy1aUFi1I0pvlai7T1JsJA4+6h+pPEWnLT5KH8CaakV
         GLBSqCwTil6MsLQcBrTWEfhOVV4LNoUChpvmInUkOPnRj2L7iut3y8D8jbRkKBLbT2cG
         8GjATC/HYgW45WMCWRwuCsX6bi0X9oXgSp9litPxZbuRYWCdk6FXy8DIQ+2JHBmO1j1S
         W0mWPidOfwr440i13US+GWfFlCN4/ILMpG4Q/KJDZFiDS7RqI5/LMpXp67Qf8ZXnniQN
         yldr+ALteARMtMXkDnfXsoJcfD4+tSuaq6I8xOp445J66paUQHpBHsAMrAtwpxaxHF+u
         7EJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HAeE7Dx8;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HAeE7Dx8;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 31/95] s390: remove indirect branch from do_softirq_own_stack
Date: Mon, 21 May 2018 23:11:21 +0200
Message-Id: <20180521210454.500621061@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109880764209307?=
X-GMAIL-MSGID: =?utf-8?q?1601110180678570582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit 9f18fff63cfd6f559daa1eaae60640372c65f84b upstream.

The inline assembly to call __do_softirq on the irq stack uses
an indirect branch. This can be replaced with a normal relative
branch.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/irq.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -176,10 +176,9 @@ void do_softirq_own_stack(void)
 		new -= STACK_FRAME_OVERHEAD;
 		((struct stack_frame *) new)->back_chain = old;
 		asm volatile("   la    15,0(%0)\n"
-			     "   basr  14,%2\n"
+			     "   brasl 14,__do_softirq\n"
 			     "   la    15,0(%1)\n"
-			     : : "a" (new), "a" (old),
-			         "a" (__do_softirq)
+			     : : "a" (new), "a" (old)
 			     : "0", "1", "2", "3", "4", "5", "14",
 			       "cc", "memory" );
 	} else {
