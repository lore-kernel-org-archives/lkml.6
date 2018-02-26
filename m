Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs7tZyWtlQHarBUjHsekKOFHMucLJd5ekMIMlBJ2mPmTg+/wToEnbplsjwP/ZQzaIF2nmr9
ARC-Seal: i=1; a=rsa-sha256; t=1519676926; cv=none;
        d=google.com; s=arc-20160816;
        b=L36EUcllq7JaySYs+mQV8A3Y3qI9ztIORwZab9OR5AUSkuRtD/L1X74BazCdhD9lQQ
         d3CaYo9sn0y2DANiHgJRMjGBYyHbBJJktmTkvJPsqeMcOzn/yNvbgB4Efi76ivPHyPkU
         ZkGEe6uTaBo50UgCNbxmx3m5oQCAE0qD/F8951vkurfsyl+fcx4waBpVQDuOcfgf2p3F
         IE/vx6v5RVIC26uIxIpHH/Q3MkT+0GgfKLfdtVZ4ezeXVZX3/DFo9nmoE0bHxqlNgDJ8
         +noVKUCe/br7r0xyeLis53zs1oyE43y5cXSZWyCWaXONHHni7jOws4J8FnWhztH6K8VY
         WL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D82LDh4KiRUMxHOOMIwKTbdap0RiKfhPrtSOCxJyIQw=;
        b=cebl3vfRJzRRyHikJ4KQ0YkxxCaqxdcqyXSm44pTQFCxGv6zNYwwOgqOI0+1A0xnJg
         EU6OANB4m8UlczQ4JqQTpOZDThlwQ8+FUVKxWEMRbAH6FD5SgR1T5ieiWrqyWBmGAnDQ
         VYBGWfESB3LeDd29D6g8XLuFRLp0XaaSq+n/B70ZjIAQwVu+WbrhXqsHgxuorY71qG+H
         TLO8A9Y+YtFZk9beZAOs4XU1EbChiMgq6d2vlh+nnvHkobiwOgxnHb912N0y5jThFYdd
         o6L1sfpeWPaQXUwglVJDpyp4N4eN7vtR8Qfdl4kGjXaKFegSUocCi2iWGciN/zEP/EWF
         RY4g==
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
Subject: [PATCH 4.15 32/64] irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()
Date: Mon, 26 Feb 2018 21:22:09 +0100
Message-Id: <20180226202154.827569198@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495977277445952?=
X-GMAIL-MSGID: =?utf-8?q?1593496753228582105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -688,7 +688,7 @@ static void gic_raise_softirq(const stru
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	smp_wmb();
+	wmb();
 
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
