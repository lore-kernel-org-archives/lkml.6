Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvq5BhKdcxzBzgWZwpuyAnYTJLJrcyX1FRKy9JgzjTlttslbUSYN/uuV3rYzKEcJuxjsI48
ARC-Seal: i=1; a=rsa-sha256; t=1519676657; cv=none;
        d=google.com; s=arc-20160816;
        b=s84OUkBN2knrmIaUWEDwgv7ol6dMyoppuWXb3LwnfaY4SbR04OAERkgownppUoP3KD
         OAYC9bHZtnubp3xa857N7t+5a73IT7EtV/89Ce6WeAFIS/T9w861QLGkLpYIq8ndkJeL
         YKolrxjLVWsiSq7X7qSlNfWgczWRHdg+672gN3f8PJeAL+H4k2WdDVO6WjgfycCKPSVy
         7FY4M4ayAkmEMr5l1PXyuZLIHUAX7+gPZS40Mz3h2C6c3qQo51xyceyQC1SHS+f7VHYL
         b9bfki+5zUS/CdCHBiIBWEjBVhbIE+fStxBLjDzLGuZxbpDh3OO5NxwmqQZwmrfQd1l4
         z5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0wxtoiZ4YQWuB4svPjema8NjFMnkGuVte95+v84hiBs=;
        b=S4SbvHwsea/xiWRmKw8obVa+8xo+TfFtT6UHSUF0QBa+p9OBxf3S3P4AnTwSnGtutB
         kjrab3GzZC3x97lPZX+kUWHRM51W+vxT/nQTvFK4YtHbV0zm4KSQaz8XIgrraLVvg79S
         dW4c359uFTCfMGtwEvj0D8b9m3Ve/rv6IRykZIGxRDJ/gIvNQEmiDZnPxu/lTxIXz+H1
         e4ICVdrQIVuyszJUN27BkpmeHClxuHWDdNbc5cjn2lJP4JixiV5EGr7z6rRIVGnYM8Fi
         UAzLgBmmG8SBNXqRQLtHD1yb82ORL9PfACBDyRKl/1yNodo7BAaVUiYyx6ORg+xTcYAA
         Ol0Q==
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
Subject: [PATCH 4.14 28/54] irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()
Date: Mon, 26 Feb 2018 21:22:05 +0100
Message-Id: <20180226202145.795099218@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495977277445952?=
X-GMAIL-MSGID: =?utf-8?q?1593496469937655652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -660,7 +660,7 @@ static void gic_raise_softirq(const stru
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	smp_wmb();
+	wmb();
 
 	for_each_cpu(cpu, mask) {
 		unsigned long cluster_id = cpu_logical_map(cpu) & ~0xffUL;
