Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226gY8bY/6qs9IQb3SedX9dNzPbR/taT5LqYK1jdFnohIs3u/nOu6CbUAcvZgK03yKD3jzTS
ARC-Seal: i=1; a=rsa-sha256; t=1519676476; cv=none;
        d=google.com; s=arc-20160816;
        b=eW+zkCllyg7ckxw1DIIGFyUIjoqOm7xnUXoLtghQ4sdpz5KHl6nPtPAojA5MGKfxF4
         RvwWoJ6isX9IVDyCVTjbfAAG9qoaJyL2r/qDCHeNZmkZTWCQl9id/dvDwvvhyc7R6PLW
         cN+VimUUMC0puvz/2GCIbsOQzTz+eUj8FbSDATPI115224l/csCfGzlaHsLkEI7oztAe
         ZgTEkyRKcIAp/PG0fsOWycVc2ktOTZZ8NrpKFaALVrm9FxwXg545PoX4HP0IML2r0Pu1
         PY1Xd7frXMTa3o6exAKFGP9lpAmRy7Jqk2b3hVouHF4Vypq/K9z5tNUFDlUDH5xSsJAC
         +P8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X0ip+MVOEggWH8ebx0UDhoNg4PJk46KlotkObMeOe40=;
        b=crpn0oJ7ZZPV3CLtIzt8+ctpwK40gaDFfjJWvxl8tdeGnlderZpEw2EgDZj8NVW0u4
         Q60WKHwQU1fnNVnRQxWy+CblDVGF+n2vniD/XGLZj0ltv9iL5rI7PfVVP5KJg+pDI6a9
         7Hhchdu7dnazAhnO383/YXCWJ+qNKHi3u+fVTg8EN+4aFKf8NdDD/ZBOHCa3WNVqPSO4
         aseMQxicAwBBhe3XGyg/on+5DnGI0YeRwMMe+PAGIXhNxBRf0me9YEHZAsRqzw4qFKei
         vP08uXEmmMLPVzkqJb8gsoIKUxpxv+wn+8NVS0C3Q3f7RZhdaFbEGSTalVDu94CHlO26
         REXQ==
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
Subject: [PATCH 4.9 11/39] irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()
Date: Mon, 26 Feb 2018 21:20:32 +0100
Message-Id: <20180226201644.161641651@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495977277445952?=
X-GMAIL-MSGID: =?utf-8?q?1593496281173643082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -616,7 +616,7 @@ static void gic_raise_softirq(const stru
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	smp_wmb();
+	wmb();
 
 	for_each_cpu(cpu, mask) {
 		unsigned long cluster_id = cpu_logical_map(cpu) & ~0xffUL;
