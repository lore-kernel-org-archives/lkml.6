Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+G2RkdBqWoJoTh4zsjei5V5hGPsXbB73/CzuIpHt/qXO9BfMDV2l44/mlxLQp9DW/jygty
ARC-Seal: i=1; a=rsa-sha256; t=1523472107; cv=none;
        d=google.com; s=arc-20160816;
        b=jdB/lVLrln6y37obiBJuvoD+0TzWhQvOP6VJ1ZxaUoI/UOQDtHjuCJ3HB5dW28tBeo
         TPvKr5dTFhBZ8HrDd8k8Mk+0Jay+j2rN1gyyQiopcsS89KThhWulw9diaAX5gN/usKht
         G/ieBRABttr5XhkfPrpqMcHb+FoXJQASUxhrzSMtwsrCBC0OwoBFub5O1pIQFzwmG7uK
         k5BmLeddpba7cHwXe0ButZwBQccrUpzFlwDbhzPGnGOP/6DYy9DNoliTQ4Qme5w7uYjJ
         u3hP+UcFWvjVLolkZOv0exCUcMTPNMmtwP01QrnKEWc6SKs4Fg8EBeO0+3v+MN5IcJXO
         0hdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tD9aUFMjyshzs5sQPJSiBbeUMMMn2jKQUC/FmvAb0Mc=;
        b=KPceT6cYF/gkWaYbaRG7uIFQ2JKZQIWzQAB3QN9UFdz4vLzfiN/g+rkRuujfwcFTcB
         LxkQa/jUtX8ugv+4Wp4hWBawbAkQZggy55ILyQAYiAEhuxFdeawkA5Qo1quU+SZr4VYQ
         n+xbv30YWmdYgoZ4UONCuCk8nUNmEdij4HTAGPKql0PjvJWDGDCGJfsLn8mQU5ea6ONq
         WwEbpQFWlKdeVeG/QiSZuv2+otqids/hgwQVFyQpRjdhDEPk1RTCOv0cbr2QKoMUMDCT
         Yo2z37ccjHaeqO4QYjJw4QsJw7QCWqMYnqDbiuunbzzSyYT2ckMcmQ0vKDHWccbel+j/
         D9IA==
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
Subject: [PATCH 3.18 055/121] powerpc/[booke|4xx]: Dont clobber TCR[WP] when setting TCR[DIE]
Date: Wed, 11 Apr 2018 20:35:58 +0200
Message-Id: <20180411183459.654096592@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476288698962416?=
X-GMAIL-MSGID: =?utf-8?q?1597476288698962416?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -646,12 +646,20 @@ static int __init get_freq(char *name, i
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
