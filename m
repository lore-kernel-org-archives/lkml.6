Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226M+sICNe0QwUH337XCzBp5w9i7Wv7K3300wEQW4kL7OaMdmn89Q9i/D59nvlB82luYAdm4
ARC-Seal: i=1; a=rsa-sha256; t=1518709034; cv=none;
        d=google.com; s=arc-20160816;
        b=dd/jIZo3thw58NyAtBAbp+IsO2NmmLyFdgKzQ9CWHSmfu7r3/iS4JOobp4lBrShgpr
         h7IfmXitnCx8OEvaDSHZVa+bOm5TO+3OKjwtwGKXnjI5fP+HeweFwtnmihVIs6UpeJuI
         q62epAbT0LqL5C9P6K6Zp6cuaW1fuzih7G37OWj5hF0v2RhqpMUsFzR1pk9/7YGpuQyf
         qEDVEeZXAuv61OQAmb0lnVdJtuxZ64wQiWT6jv5WSiFzZfS+4TO6k8vH7TI8uu4Hd+0k
         3Cl5/DXK/oPmrGA/YR9t46rNBJaj/VoA26S1TuP5BXQBgHtKOz3hwWgN0rry/hU63jOj
         S73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FHUMVWLzilAYh9y6rU6Z2dyBcw/GHaix8DABTJnOC1E=;
        b=bpZgkqUeb1qRQqJ0qTZtDjwTooyi/svpNESHTIqUq75pTVlTQV0Lu0qWoG/5QxmUku
         SOnRgAsgr7/XtUBVjKqsmhSGtAcSvVXAIiBpjC44jaayRfXrZ1HI05Yd0EdL/HIM9qzJ
         /SzQfSFGqtkNXsATBSDrer4qW7QwqiV85TKRV7Ejsseh/cN7qCscLg9dVhkbHbqnpiPS
         en6jDDKBaA4qdKhtNC4Al4Rm6mzz/ua9V4mVPFC/0afG118N8YZM9IvnQt8NmD2NT6Ki
         9YAag7l0e2gaLp9DMZw9Rs6vbRrIeTOTLqGpx2h577Dtqj490OfdHY9VcS070BUcZPMO
         YUhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.14 168/195] alpha: fix formating of stack content
Date: Thu, 15 Feb 2018 16:17:39 +0100
Message-Id: <20180215151714.404552925@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481311738634732?=
X-GMAIL-MSGID: =?utf-8?q?1592481844684769134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 4b01abdb32fc36abe877503bfbd33019159fad71 upstream.

Since version 4.9, the kernel automatically breaks printk calls into
multiple newlines unless pr_cont is used. Fix the alpha stacktrace code,
so that it prints stack trace in four columns, as it was initially
intended.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/traps.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -160,11 +160,16 @@ void show_stack(struct task_struct *task
 	for(i=0; i < kstack_depth_to_print; i++) {
 		if (((long) stack & (THREAD_SIZE-1)) == 0)
 			break;
-		if (i && ((i % 4) == 0))
-			printk("\n       ");
-		printk("%016lx ", *stack++);
+		if ((i % 4) == 0) {
+			if (i)
+				pr_cont("\n");
+			printk("       ");
+		} else {
+			pr_cont(" ");
+		}
+		pr_cont("%016lx", *stack++);
 	}
-	printk("\n");
+	pr_cont("\n");
 	dik_show_trace(sp);
 }
 
