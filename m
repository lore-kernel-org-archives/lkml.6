Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226kH/wyzDDGO8CG9mipLcmfLZeViAvTWAr8qY9P+5+S4Cw3PLoo1AAsr81QGTYripkqTktz
ARC-Seal: i=1; a=rsa-sha256; t=1519218492; cv=none;
        d=google.com; s=arc-20160816;
        b=gwua90qGzypIfm9QBoZPI1BeHEvXJCbN5obBLkfUHf3yKPcO+1vUgCn0rN50xR+j8w
         6QPaRp6GQvZioVjGQm7le3U5nxujWjuB7SDiX1+V1TVyxL3pSvsWo51uSItIXCiq7Uo7
         nZhSqonD/hkCqSzsX0/tQdFYdoGiYFsBDb0vbRGwHf6V0G6qx2MXDTTkc5sWg2AO6HYH
         porM00sBColcXg4TzRGHCyf1O9ZKmpQyKUw00Iu56qPbtAtDJYWUV5ilhXF0fx/Cp0ET
         9LVpHhNnktFPCsxo7lWqZToPDi7Drdq2kzxzTHxXkfhVqjufqdb5Oj0IQOnpa5dnRy+T
         u8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CsWYPUOvUnsvAJu/BoKlAEuLvySHcJskzN8FWNGOoIQ=;
        b=CGEe1JVi+1GEHmR0pf1KTbJkS+8b7PHxj1LhJULD/X2pL0ALaCsGzbNwtP9SiuHlS6
         jd3kxWmFQkK/eKwbcqr2MXSEFeXNt1J8o93l33oOy1dbtg3Z06LOxWOoDCUrKUfhphOo
         CybackRI99zxbqcS0HKUNTE2TWmZYnI4wG6vL4tsCWikF6d3WKYoPI2PPt22Bkft57fT
         bbw4hvqtE3/ysixOlsvASo/4m5a9zdaSqndlDlj6vZJZEExgwFYRHYsJ+shGYlN2LF3+
         OdBb6AXZLD6IZ9HTe3oZ7RFfC+DbmWS7uUuPkDdbW3w53l7R8gHw0ENMmGCRmtTXCKO7
         bJwA==
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
Subject: [PATCH 4.15 024/163] powerpc/xive: Use hw CPU ids when configuring the CPU queues
Date: Wed, 21 Feb 2018 13:47:33 +0100
Message-Id: <20180221124531.527849949@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015443174391988?=
X-GMAIL-MSGID: =?utf-8?q?1593016050093703730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
