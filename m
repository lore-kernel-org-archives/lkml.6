Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/AFYesGumwtZuDa1oK1kgUusc6mPDjy07qZsE56IPmxsB6uwArlVE5SfPwQpgID6bxG51D
ARC-Seal: i=1; a=rsa-sha256; t=1523472593; cv=none;
        d=google.com; s=arc-20160816;
        b=nKedQ11KGyENyTa9Ob9tam8Tt3vjpW4rygtEf4klc/qqxdZPfHZ2QjZNmaEROhKL1j
         CsrbRbzMuge6LBTBeP2dDT1Vt2rtnxcYx8JdRE/vM8IQ74VXqvuiudO8bbdcshj61ROh
         6O0+TghKQDmST8CYbDuRGdnx8nuJnVT4OzPmSwcwi8rD5E0AH5q1MSpwukvlHFWLSFyV
         Jwiz7yvyyfgOHUUGFbNRgqGk8JRR23Dm2nIXcoR2bmKxmgj8ZxirDOb2fn8GkdEhC2P0
         1XuqAlq2rVHv+8vG08E9AayFKrlaBGKTualouj/dtjyllXzW4/FWitVwx9TPHzSi6AYO
         4DRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9OW29X7R8cUZj/vW8SUJeLndBTuSyujuUKo4Bfcxjrc=;
        b=rvgqubzU36fHk10Q0UO5oqjME80vmvEU+p4eVWGdZJe9fzHCZTrqk9ZJqd2q5typ3I
         ywctMzpfw+wb5ZVf7gtWls0iQvuPF1BncGqjjmUATckyg4ntmhUkS0q3A30k1S6Q9Aoa
         0EX3xREeobkB7nNiDqhi5A+WJPcyDig2HDmknxBfPV6hZARrMyim8BYmnzMhrc5Y4Dfn
         OQSWUOqTAM+PdMcB8x6EynvYqoYiA+pP0vtnP+63Dh/DGGiGoTOXFvM24KWL2MERRryz
         ifq4hIDxY5nDScq9yQg9btvFKV9iMQvTH99x1Ap19g6opIaFKGWMxKuLqN9+gN7SAQ/x
         MaGg==
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
Subject: [PATCH 4.4 097/190] powerpc/[booke|4xx]: Dont clobber TCR[WP] when setting TCR[DIE]
Date: Wed, 11 Apr 2018 20:35:43 +0200
Message-Id: <20180411183556.235689998@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476288698962416?=
X-GMAIL-MSGID: =?utf-8?q?1597476798589761983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -686,12 +686,20 @@ static int __init get_freq(char *name, i
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
