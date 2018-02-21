Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224LOkSsW/VovdA/Gu2xl43sQa6ir2JNp+OvACiEQ33CdN3u2+myg5cKog1LEx933qe8TBJX
ARC-Seal: i=1; a=rsa-sha256; t=1519217913; cv=none;
        d=google.com; s=arc-20160816;
        b=bpwMpyaSysV3EpkRvz1ICncHchROGrzSNsu5mQBLgg+74webscspKBo1wH2RyGT6z1
         q45lyBWrksn2LBhYIOxSBBwYQ3D+hCwG/ES7XnFmAVWr2NS8xWh0ux3jJH1miEvwdFwp
         sp6FyzQ99oeiyFt8RWg+uBMZCYCEkN2eJW+P79qkvisrzr1gad4daajETFAMGycbzVzu
         WETkmF2dOmtEO6/hSw+hRzt7ziEqGJl9JYF8siQ6rVNY70mWcG7/K/Pxi8ndk5z1bQ8r
         1C18wdhDIPpYsiAxVGu0LyyTF6Y3Zv919NIwDi28UNALTYdpzEuTEUe+KfltKY6oLiCV
         96EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P8y8mXqEDVjhKjP5llXPF16yFWedFwygKHNvKPfUkG0=;
        b=PQyX5PUnuV5ajcG6hwRUJaZSrOHKOxGfiWQZNaAiflNSSFFwm2XJ3VSZpk+Qx6+N18
         kHuNwSmhEcOb74FPULNEtvHHeoeQUuv99edaaRwLAO2u7xR1+/zGhpcJYBUckt4PWBn8
         W1jieWqovR6xll61dBEPb7gGl0Y5otHKx2nrogb2Hq6DUcb3vLT2JvNISUBtBdUkXCBH
         Sr50hjh9MXXLGkOZ+wWRTw049ZC21E9gZXvlO0TlIQwRyCmIkMA78H7bO0CfK0ovO428
         h7HTsN0x75dAheoPn2D2MRpPIgOdDEFPi6mxao7N3RvLZGOQghI3wklXN115Oryae6Ie
         /fdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 022/167] powerpc/xive: Use hw CPU ids when configuring the CPU queues
Date: Wed, 21 Feb 2018 13:47:13 +0100
Message-Id: <20180221124525.830492356@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015443174391988?=
X-GMAIL-MSGID: =?utf-8?q?1593015443174391988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cédric Le Goater <clg@kaod.org>

commit 8e036c8d30a2cd9d8fc7442fbf6824e0a3e986e7 upstream.

The CPU event notification queues on sPAPR should be configured using
a hardware CPU identifier.

The problem did not show up on the Power Hypervisor because pHyp
supports 8 threads per core which keeps CPU number contiguous. This is
not the case on all sPAPR virtual machines, some use SMT=1.

Also improve error logging by adding the CPU number.

Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/sysdev/xive/spapr.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -356,7 +356,8 @@ static int xive_spapr_configure_queue(u3
 
 	rc = plpar_int_get_queue_info(0, target, prio, &esn_page, &esn_size);
 	if (rc) {
-		pr_err("Error %lld getting queue info prio %d\n", rc, prio);
+		pr_err("Error %lld getting queue info CPU %d prio %d\n", rc,
+		       target, prio);
 		rc = -EIO;
 		goto fail;
 	}
@@ -370,7 +371,8 @@ static int xive_spapr_configure_queue(u3
 	/* Configure and enable the queue in HW */
 	rc = plpar_int_set_queue_config(flags, target, prio, qpage_phys, order);
 	if (rc) {
-		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
+		pr_err("Error %lld setting queue for CPU %d prio %d\n", rc,
+		       target, prio);
 		rc = -EIO;
 	} else {
 		q->qpage = qpage;
@@ -389,8 +391,8 @@ static int xive_spapr_setup_queue(unsign
 	if (IS_ERR(qpage))
 		return PTR_ERR(qpage);
 
-	return xive_spapr_configure_queue(cpu, q, prio, qpage,
-					  xive_queue_shift);
+	return xive_spapr_configure_queue(get_hard_smp_processor_id(cpu),
+					  q, prio, qpage, xive_queue_shift);
 }
 
 static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *xc,
@@ -399,10 +401,12 @@ static void xive_spapr_cleanup_queue(uns
 	struct xive_q *q = &xc->queue[prio];
 	unsigned int alloc_order;
 	long rc;
+	int hw_cpu = get_hard_smp_processor_id(cpu);
 
-	rc = plpar_int_set_queue_config(0, cpu, prio, 0, 0);
+	rc = plpar_int_set_queue_config(0, hw_cpu, prio, 0, 0);
 	if (rc)
-		pr_err("Error %ld setting queue for prio %d\n", rc, prio);
+		pr_err("Error %ld setting queue for CPU %d prio %d\n", rc,
+		       hw_cpu, prio);
 
 	alloc_order = xive_alloc_order(xive_queue_shift);
 	free_pages((unsigned long)q->qpage, alloc_order);
