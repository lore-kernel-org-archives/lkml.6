Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuznWvKNXomZUlRSJmv0u8NgB+1dQ0j9oB45pH8SksO5Bc0OrtP0rrg+Z6Gx6f+3jzdLq/7
ARC-Seal: i=1; a=rsa-sha256; t=1520641188; cv=none;
        d=google.com; s=arc-20160816;
        b=XJEvUXQdrG3G2/brYuTlaezSy2DN0m/+hY3d7ywUbPaG943WRoKk5ERVc40A8pfY2k
         LxSrUkW+qVYvrDiLA5KzvEbWgsBlV7xCnm18c6o37V6CAnrMSCAVgpu9R/l04dTrlt3C
         EARc91oupC5t2hiP7tgRfpkE6QnbLQy5bd7N18HQJZt2kxV0PcEIGcS7hYfQ3Iuc0deH
         03cyeqN+IYwTGignr4AMQx3M6qYJxmYhRkRnU6iYRsR0RmRHEtQ6O0V9Jj0O9irA3Z8R
         IukyppAiPz+7cjdmm8NhZn6OfQfaWEI69p2SDrIDE3IxzMgSP8uw6SLLgLvrRFfhzry3
         9EEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0UF01T9h9FkYMj52e2fY7ZoofrR15b85ZLMS0kynsnI=;
        b=gluRpXzG6xXH7ndPjV+RjWtuIDX7sRRlBTvylzweCK4Z9ThE1eBLeRVSyKqVc5ljkO
         amQlRvyimjhMfvU8R/y5+ftf7yZar3YKvh4cUOKsewGwvJcnFnN/puvEmQ9S/fU7bGid
         4fqaf81yv4SebBA9N4t6ICXOsAUNuusyaD6R8MSitRpQno4ADZuawFuz4yk1KAG/a+Nh
         +PH6PZ2RmmKjCnxlvOJALe58wh3E4dSnQcu2foyv3DJal3hBAzbcZAbr4Xc2rSVsedFR
         bxH8Lv7Dh0cc5U0I5+sVMgQz0RUAP4Mkf23p8vuukM3ptpYbGewAhyRg7/rJIBQDw/gH
         v2jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.4 14/36] x86/apic/vector: Handle legacy irq data correctly
Date: Fri,  9 Mar 2018 16:18:30 -0800
Message-Id: <20180310001808.021236165@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507855707423265?=
X-GMAIL-MSGID: =?utf-8?q?1594507855707423265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Thomas Gleixner <tglx@linutronix.de>

The backport of upstream commit 45d55e7bac40 ("x86/apic/vector: Fix off by
one in error path") missed to fixup the legacy interrupt data which is not
longer available upstream.

Handle legacy irq data correctly by clearing the legacy storage to prevent
use after free.

Fixes: 7fd133539289 ("x86/apic/vector: Fix off by one in error path") - 4.4.y
Fixes: c557481a9491 ("x86/apic/vector: Fix off by one in error path") - 4.9.y
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/apic/vector.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -91,8 +91,12 @@ out_data:
 	return NULL;
 }
 
-static void free_apic_chip_data(struct apic_chip_data *data)
+static void free_apic_chip_data(unsigned int virq, struct apic_chip_data *data)
 {
+#ifdef	CONFIG_X86_IO_APIC
+	if (virq  < nr_legacy_irqs())
+		legacy_irq_data[virq] = NULL;
+#endif
 	if (data) {
 		free_cpumask_var(data->domain);
 		free_cpumask_var(data->old_domain);
@@ -316,11 +320,7 @@ static void x86_vector_free_irqs(struct
 			apic_data = irq_data->chip_data;
 			irq_domain_reset_irq_data(irq_data);
 			raw_spin_unlock_irqrestore(&vector_lock, flags);
-			free_apic_chip_data(apic_data);
-#ifdef	CONFIG_X86_IO_APIC
-			if (virq + i < nr_legacy_irqs())
-				legacy_irq_data[virq + i] = NULL;
-#endif
+			free_apic_chip_data(virq + i, apic_data);
 		}
 	}
 }
@@ -361,7 +361,7 @@ static int x86_vector_alloc_irqs(struct
 		err = assign_irq_vector_policy(virq + i, node, data, info);
 		if (err) {
 			irq_data->chip_data = NULL;
-			free_apic_chip_data(data);
+			free_apic_chip_data(virq + i, data);
 			goto error;
 		}
 	}
