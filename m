Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49PGCM5jbDT6LcnDtG0dg2dBg/Pwk17LQ3+eV/xnoox4rWqKr7pr5xoMr22fzxamRaHdFoi
ARC-Seal: i=1; a=rsa-sha256; t=1523473170; cv=none;
        d=google.com; s=arc-20160816;
        b=Wxhg8DJ/pqLK/1ZT+nH5g/hRHkjGe7mytqINH4wCniXGmJ57E+kO1BBX9iKmmJSDCr
         3ynK+q2m5jMv9NqBg+IgzpjUDoFXsK7J+jOBRkYN/LuIlwkLOSk66WireGjPoAcTIDDJ
         QOmswUQpQpzDDn9eG5FVkzHwoKhwq33eGPXdiAaF0Pw4gzAsGzHMR6banUZH7UNGRX+l
         1RdzW3bdo7XbQV7d8T2prZiXIuuhloJTCtULmWwF9x7GiEMBYNM8FWp4971ohR+ysh4M
         r0tBDUBueXfW7l4EAuS/eQv9iNbKQqxfPrZbUcNCSIa3Xec9JHpRLUVMt8mIrlvk40bE
         0aZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2mpKMYs9xawPqW8v7hJ/bee01n9tYRTtqpzQG+lwPuc=;
        b=sR5LKJrJYUu7FWj3+fcvtFZUeU5o8dUQbyEfe9K/0wQ1dwaUchZq9NacVkBdF9gng9
         vb+XPYF8Y5btxfwQFE3s6iJwX23puvzXZno41ECtQNRIakeYf/M6u2k0t0W560PktzRq
         gcY1rha3jdZrjvWK9qHlh7gD7wRuAU4cdnVC3NQGgucZToPgFzy9hIj4tmXQRt++uwSR
         RU+VnuA1KbRHenZGHyq1KgIAvtV1BaH2D2JCiLqTbMWnSf6HyMakQht7k1Tfn2pgkwLB
         AgokhXgi8cvKNneoz2vKU7m9SNNcMHKIRd15Eno09N4dsSskc4jw61Bq0AYqfbPBOUUw
         55Sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ivan Mikhaylov <ivan@de.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 153/310] powerpc/[booke|4xx]: Dont clobber TCR[WP] when setting TCR[DIE]
Date: Wed, 11 Apr 2018 20:34:52 +0200
Message-Id: <20180411183629.008582849@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476288698962416?=
X-GMAIL-MSGID: =?utf-8?q?1597477402782358723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mikhaylov <ivan@de.ibm.com>


[ Upstream commit 6e2f03e292ef46eed2b31b0a344a91d514f9cd81 ]

Prevent a kernel panic caused by unintentionally clearing TCR watchdog
bits. At this point in the kernel boot, the watchdog may have already
been enabled by u-boot. The original code's attempt to write to the TCR
register results in an inadvertent clearing of the watchdog
configuration bits, causing the 476 to reset.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/time.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -719,12 +719,20 @@ static int __init get_freq(char *name, i
 static void start_cpu_decrementer(void)
 {
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	unsigned int tcr;
+
 	/* Clear any pending timer interrupts */
 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
 
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
-#endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
+	tcr = mfspr(SPRN_TCR);
+	/*
+	 * The watchdog may have already been enabled by u-boot. So leave
+	 * TRC[WP] (Watchdog Period) alone.
+	 */
+	tcr &= TCR_WP_MASK;	/* Clear all bits except for TCR[WP] */
+	tcr |= TCR_DIE;		/* Enable decrementer */
+	mtspr(SPRN_TCR, tcr);
+#endif
 }
 
 void __init generic_calibrate_decr(void)
