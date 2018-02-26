Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nwe/Yz1tuADmaZEkIk7ZrmlyjS1sROzf47gbaC+hk2LRedao4EO5Y2LKxpoYoeabpWTHN
ARC-Seal: i=1; a=rsa-sha256; t=1519676200; cv=none;
        d=google.com; s=arc-20160816;
        b=GLgTDVpzh4wFLCMSEhQtTRNN4qR2QXCSKQm4lwVttQE/VALMJNe0/mxuRaP+bS6p1Y
         5K2vHpnYzQRd8vI6iFluAVNUUWd2GW1l/vEvXOzE2yaGu9BhPqCn2vcxKffc2nmnfyIq
         FpdtVqZCYTUszKcgO47GMo/mtFMFxiFCyn+1kJwiZhAqFvxWugvoVK6YlrUfQHYCMc17
         pDOywrks5clisgC1ncRc6rcEC0qi0e5+eiD2JVyTnZy8+2jEFYJeVsJa5kBBgJRpu3/9
         yPyeHCiWc0ZAHcRMbxIdO3HCaDXprUANVH8LJPWquwFUZ3HkgBJPsLZA+E/NQ+twsHRT
         zJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rt0qKS4Q3nOASU0AtBTOO6s+ACnIFBPxdunht9rUJP0=;
        b=GKwir0eiLWbf3kaWeB4xCRHroKx059NMjWR9eXz6aG3+rUe8lbpDRSYp/Z49VX+XLZ
         G9U2H4LfqkoEawzsr0YG3nAngF6aWlBseoEtmEAdyumhPTRvOBGLWcekcACBkPt1On/M
         Vc8f+imlypFcJlq2YMHZivlyXQC8z6dmedOFmrPIFW3YbTpfNlTfek+omYs1JKfW7Rb6
         0y1vIZ8E0S1gUGCzlVFCqOxcp4BK0F8at1RvbN3b70rHvdd5WhQ4TGDG1IHmO5QkVQpC
         pjF8ntRm3WB7O8Q5FdlX1wGsPWXFGq+N/xJMplQvvWaC5jOd1H7vmyMFfUCg6XRAYOuD
         BxzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.4 12/22] irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()
Date: Mon, 26 Feb 2018 21:16:12 +0100
Message-Id: <20180226201559.270689771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495977277445952?=
X-GMAIL-MSGID: =?utf-8?q?1593495991322037530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shanker Donthineni <shankerd@codeaurora.org>

commit 21ec30c0ef5234fb1039cc7c7737d885bf875a9e upstream.

A DMB instruction can be used to ensure the relative order of only
memory accesses before and after the barrier. Since writes to system
registers are not memory operations, barrier DMB is not sufficient
for observability of memory accesses that occur before ICC_SGI1R_EL1
writes.

A DSB instruction ensures that no instructions that appear in program
order after the DSB instruction, can execute until the DSB instruction
has completed.

Cc: stable@vger.kernel.org
Acked-by: Will Deacon <will.deacon@arm.com>,
Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -604,7 +604,7 @@ static void gic_raise_softirq(const stru
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	smp_wmb();
+	wmb();
 
 	for_each_cpu(cpu, mask) {
 		unsigned long cluster_id = cpu_logical_map(cpu) & ~0xffUL;
