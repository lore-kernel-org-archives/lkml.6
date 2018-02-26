Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225b5tcCxssi3DEWOhJKXcA1LJXVeSa8pcg0UnH9DYK3E2wrlOYDb8WJSisWg2YmkPTTbl6S
ARC-Seal: i=1; a=rsa-sha256; t=1519676186; cv=none;
        d=google.com; s=arc-20160816;
        b=Z49bdjRwmK7+hKVTulasFuRKkU2nyNj1bOwKm++ckWBvOgSzFf8urz+9fqDWOSHvdg
         61PZ63BOTyd+AVXyfECQnXvncu1k9IK8x/V+KW8XW/Mws7XlrQzA4BVPzUmU8Ya2VaKP
         W6SEdJCoyP2Ik3SUKFk0jg0ugeGjIP3ET54HA2P7xO1kOd2umgakEdEkKkuhYT9kVP93
         zqABZDEFxiN8J/V1W5IKpctW+5waADUMqszct0MA6EpkPF09wxi5zjxY1hs+jIXxFe8x
         A1GFqc3t2RNc9Inxq1b9l7qa75xPBgzVAvCruchEFGs24dQ1A+ytCZcGIDoRLxSdLnzk
         HSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A1BMaD+t/H0fbRdKym9HCL9pUco4oWpnxHGxH6VV41g=;
        b=eLVmq3f2jDqk3vb/fdxns+eFYfhFnajoDUzbbzcJKqpKmY5NBJMCcXVkRECCl/V6Jf
         fUdnE9SWYvNs258BYuxVU2+fNl0xN9821L5FV96hsO1O4IV1y0W1EBRvKpSXiY743vQf
         H1i69NLyV+3Xug36e9yEZRc+jYP18lyNkvJ5o31EuxRQ/SBx6lNkh788B05aXIjNy6iY
         Ko7qECZShDGwGR7QLzAi4wMiF1540RkDQ6vreuknk9Aj8cqA2U4F6pwNeQNfaGhfW/0D
         eeaZN2ZtGDWfzI4Khh+6VgnvqrWCgRjbytCBQpr7dFU6JKk+j4tnsHV3gnAO0EjTu1+T
         dJfQ==
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
Subject: [PATCH 3.18 09/13] irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()
Date: Mon, 26 Feb 2018 21:15:37 +0100
Message-Id: <20180226201527.643920145@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495977277445952?=
X-GMAIL-MSGID: =?utf-8?q?1593495977277445952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -503,7 +503,7 @@ static void gic_raise_softirq(const stru
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	smp_wmb();
+	wmb();
 
 	for_each_cpu_mask(cpu, *mask) {
 		u64 cluster_id = cpu_logical_map(cpu) & ~0xffUL;
