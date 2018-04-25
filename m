Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493RMmRHI7AdUYEtWiC/5Jw6p3GNZIUwtlunc4oO4bfuF7/qJNFYIJFiP/ys++lVcWhLGeE
ARC-Seal: i=1; a=rsa-sha256; t=1524652948; cv=none;
        d=google.com; s=arc-20160816;
        b=GDHavsQ0h7lOBIMul6cYzdcBRux+b7+pFMXU/vgSd2j1TwMLSV1DFFzHvRVyz5aPuq
         HKAeC+QfeZXqpZ0RXZPeJHJN5BTomNILWzJRLnm0E3VqKJt8nxfxVUMot6oMSU5/c6XS
         IvJh+dIsFnA+dJobuJb5lGomS4vebRbr3udTZtXKejeyNFx3s2hONTBemXtjqgmUSxgx
         huio7SdGzAcmFBS+aMAtWNF6ERtOLX7VJM/qchkFOMl9osGpHycH0iWm86pv2y3tKrzS
         plCScOMU67s6PE8SMw5AJz/BPZ0kxEBVk7jAq4PYgSLhwmIrCOXrqE76o20uyq9JfoCP
         yZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H3Tjm+pldsUojv9NTuVO8PdhUoLdw7q3+cMg7OzTAB4=;
        b=Tyd3B7/qL9ZddR2+hPTHQhrotVKR01dK7GTzVSKzb5P9TxmsHexCotxFFHumCHjild
         PcqmPtNDo1D32HouJ9WfTbf7mTRlvL2gaB7Wzgh4SJ0HmD6V+7DOZ2GDpABwlInbgCw/
         dQHWeKQHqawqhT+HebVpIudsOwt8oO0JQGjixS1SjdonTs06mcvyXG0rkp2yISINvAZN
         H+0q6HrOdYmvcJWKr2V/k2JyKBw8uH1ETSwk0DWa820hnFjf9p1Noz09XX5d+hSJVkyu
         0XTUdiErppQgT47s7ZEkz7X7a90dUciraItLaMlV1bNZOGRJhAHR0npw/+rrlRiJXA56
         ijLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andi Kleen <ak@linux.intel.com>,
	Nicolas Pitre <nico@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Borislav Petkov <bpetkov@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 128/183] x86/dumpstack: Avoid uninitlized variable
Date: Wed, 25 Apr 2018 12:35:48 +0200
Message-Id: <20180425103247.573344833@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714489958346277?=
X-GMAIL-MSGID: =?utf-8?q?1598714489958346277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit ebfc15019cfa72496c674ffcb0b8ef10790dcddc ]

In some configurations, 'partial' does not get initialized, as shown by
this gcc-8 warning:

arch/x86/kernel/dumpstack.c: In function 'show_trace_log_lvl':
arch/x86/kernel/dumpstack.c:156:4: error: 'partial' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    show_regs_if_on_stack(&stack_info, regs, partial);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This initializes it to false, to get the previous behavior in this case.

Fixes: a9cdbe72c4e8 ("x86/dumpstack: Fix partial register dumps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Link: https://lkml.kernel.org/r/20180202145634.200291-1-arnd@arndb.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/dumpstack.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -109,7 +109,7 @@ void show_trace_log_lvl(struct task_stru
 	struct stack_info stack_info = {0};
 	unsigned long visit_mask = 0;
 	int graph_idx = 0;
-	bool partial;
+	bool partial = false;
 
 	printk("%sCall Trace:\n", log_lvl);
 
