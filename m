Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226mGX85ZAiMErFpJL+ess7q9eD5wQVfNO+ZjUdh0Gtcu1eV1fM6D9CG1N12az7RnhNtENiz
ARC-Seal: i=1; a=rsa-sha256; t=1518708526; cv=none;
        d=google.com; s=arc-20160816;
        b=Y8zo92fgXWcsNaQn/8o1YRt3XkOWlV2koI+WvyFSXHf8Ea2M79dmZcdaPo4SJaFm6Q
         RwcHuT1mqjQVutg2wPyUhPkFKo4g35yGvrOROM+tN4Sl8xI+q2QKN30nI6h8sEFntUyL
         6tPzvN26MWPbLUYCHvncDZU54oCR4jIqa3lf32Q8L6yzet5Dtgiv3/V6KawQnbUKjgW9
         YlYp0xgxm4v53aojJbGRWZTSgNT7BuLX9Cu3/rtcSliQ7sSNGu/NbYdDk6Kz3BnQuCuz
         jOVauoQZWAAMpn1LtgyYyk+CuBxuZXZ22c7OAyu7i40q6HQI0cQGWrAFmUPAIKJKwAdc
         0APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rea52mB/ZYsLOmO5oZ62L8Xa7Jkxh0lWP6z9aef1c6Q=;
        b=XHVsCjkMBqvIW4KzavaRGpXSWYXcrjF7mvMX5MSXwDc7NmYqabfuDlcLIrlPyQemdO
         SdezRi+B3TJzEa/gnlBTIIdZX2keq80PdP8H5Rf1ZC5YgWtTwsq+coP0IRd+DNKnmAOg
         ZHWFZBUNZFHzaTtgBQJjeEhIKBF18PUI3p6GAvgb1P2jimkzhenkVxfbvfidSFDz7jfg
         xAIdKZ2EYIa8ISM3mAPTo9AJ9MJiKWRfIqbB/i0VjS5xAZwz1qSiX/NBMqQ+NilD/D4X
         KCn9i3+IA6Hd5TI1m22l7fhtgl0ulTCKjSxtfY+E7/7rfUlEGl1Lr3VvpEyB1+JcUTVk
         o53w==
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
Subject: [PATCH 4.9 74/88] alpha: fix formating of stack content
Date: Thu, 15 Feb 2018 16:17:41 +0100
Message-Id: <20180215151232.755550520@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481311738634732?=
X-GMAIL-MSGID: =?utf-8?q?1592481311738634732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -158,11 +158,16 @@ void show_stack(struct task_struct *task
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
 
