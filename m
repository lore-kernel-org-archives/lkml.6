Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTnbQ7bcBtrtJiig0KFahCzwPoOVVcxvxOq0IzODgXpYV72Xk1x8B/AW+r68FyMBnT+tMZ
ARC-Seal: i=1; a=rsa-sha256; t=1520641306; cv=none;
        d=google.com; s=arc-20160816;
        b=a20UqGoFWS0sgAXCSzWc1qi3iwGGvLWmshlQuqMr3Cacj5/yM56XSV/CbPkYMx2+aK
         HBH2nrHciUu0e3ZFQkFW3n2iFIiJluGEA0dXmZO5IxvNLV4HIBQlzskLieXzyd3gkrK4
         2wzwJACugBSwA5rVz/e1EvrJn9xP/f1NDVJNkMD1dPi37ZWyeYGblNKoLTmMPF2ssOiD
         Ty07ziXtXQ1K/T4CEmTK7FgM3IHQ3HBTH3Nyv95GdeSob2YDlxkACZOVJyVViWaHDTfC
         7af7bY2AHGPcxot+8MXztGiaiGW2OqjNgNQkS513LQy18lkabNAIx349Z418el8tCRqs
         wJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=amcnU8ubN3K3RF+BLiWCjmIhwmiv9BGc9z3sHVLM1J0=;
        b=abPxnQOJdP84l27z/9l0TgVGBumWdd/5x1i9p/jOOWNSfCfRaSplcE0TQazbA++oQM
         xzuscNR3hQApxyCldF1vkyQoXrlWRlE+Lt2ddurH5oSe69cDAB/cj4MSOvh9mTvOEeYn
         tNlU/O289VNNbxQ2WQsargpZFq7TyYXoLRRB2WdhqiXYlwoKH2/dg+1HPuE7c8IKy36l
         FGoMwRm9yL52B0xQdRhT1orVnVK92k2fHZISCXPA2x9+L+MBbT4QHWqR415oBAu7jRgt
         S04l1ClBp4Sc1eGAGHBXG2WgQLJ4OzvPRnMCqcYUNK16Aucb/LIHZR13/YdLikdyO8Eb
         mA7A==
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
Subject: [PATCH 4.9 32/65] x86/apic/vector: Handle legacy irq data correctly
Date: Fri,  9 Mar 2018 16:18:32 -0800
Message-Id: <20180310001827.461127419@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507855707423265?=
X-GMAIL-MSGID: =?utf-8?q?1594507978929458689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -93,8 +93,12 @@ out_data:
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
@@ -318,11 +322,7 @@ static void x86_vector_free_irqs(struct
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
@@ -363,7 +363,7 @@ static int x86_vector_alloc_irqs(struct
 		err = assign_irq_vector_policy(virq + i, node, data, info);
 		if (err) {
 			irq_data->chip_data = NULL;
-			free_apic_chip_data(data);
+			free_apic_chip_data(virq + i, data);
 			goto error;
 		}
 	}
