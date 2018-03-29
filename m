Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+js5UO8zrXUvbDBJHX4ovih0zePCzhiDbW9c2/aj/M3o8RsOJUIqehiGXSFK417XW+Hze2
ARC-Seal: i=1; a=rsa-sha256; t=1522346808; cv=none;
        d=google.com; s=arc-20160816;
        b=WeEv5foKgzrwMhVxAGw1IFkOvdlU50PdmUPiE04a8ZXaqyFKMChqixoLi6gvWnmUUm
         9qo07s8Y9na841tCdnt/f0bs52PcvtnXdnxCTNY65Yjp6NDgXCoJLdF7xMqKeW6U40Ya
         QbEQprvSj7+XqFfLl5+e8La03EDys/h+bQboN88ds4hp2T/niNNDPWpTc0FhazdJkow5
         iHc1Wu+YuG0UFFSWpE4pGDBkS52qfAlKgyJEmdrduHDGmgV2yGTuXTvoQ6ypiA9bjhFQ
         AAipJARNt6M3yIN8tSX7kFZYkEMx2sBQ9xSAbcaCvhKTY4E17mB22oqXB/3/Jc2s4URz
         ZYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pTt8rmg3rSVh1DKzvq8MxC7QOmTNtGX8xM/VFIDFjIE=;
        b=MBhJJly5LYL1NSKzr0JMB5571I4D65ISIL3sUBwAbVUn/ExEVjfe+Su0MCifTmeye4
         6/8c4+2J5BD7QFOyPZqHdjrrxcCbjE3uIoKWW+A54Li5AiOFLxWdenakEy584icmU4eW
         uxiVBWfXCUVIsaZumaoUenyjdlRQ+WLYvsyzviWUyH6wMWBLjZ6mkCt9WMclIszEDLnh
         X+2n5NjeZben2cSvJq9C8EN8xiE0abSjsRTReDp87Ol7dRblvaDDLLTr0+hnYtAqO0c4
         rVtR60Pyo7qoNX/cGeHJs0METNNxY/sb9zRFINxaeYvp/Nk0yh0w1O1tA6np1BYwccuW
         Qf5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 21/28] soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
Date: Thu, 29 Mar 2018 20:00:40 +0200
Message-Id: <20180329175735.853650136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296074802248802?=
X-GMAIL-MSGID: =?utf-8?q?1596296327316221551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Madalin Bucur <madalin.bucur@nxp.com>


[ Upstream commit 96f413f47677366e0ae03797409bfcc4151dbf9e ]

The wait_for_completion() call in qman_delete_cgr_safe()
was triggering a scheduling while atomic bug, replacing the
kthread with a smp_call_function_single() call to fix it.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/fsl/qbman/qman.c |   28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2429,39 +2429,21 @@ struct cgr_comp {
 	struct completion completion;
 };
 
-static int qman_delete_cgr_thread(void *p)
+static void qman_delete_cgr_smp_call(void *p)
 {
-	struct cgr_comp *cgr_comp = (struct cgr_comp *)p;
-	int ret;
-
-	ret = qman_delete_cgr(cgr_comp->cgr);
-	complete(&cgr_comp->completion);
-
-	return ret;
+	qman_delete_cgr((struct qman_cgr *)p);
 }
 
 void qman_delete_cgr_safe(struct qman_cgr *cgr)
 {
-	struct task_struct *thread;
-	struct cgr_comp cgr_comp;
-
 	preempt_disable();
 	if (qman_cgr_cpus[cgr->cgrid] != smp_processor_id()) {
-		init_completion(&cgr_comp.completion);
-		cgr_comp.cgr = cgr;
-		thread = kthread_create(qman_delete_cgr_thread, &cgr_comp,
-					"cgr_del");
-
-		if (IS_ERR(thread))
-			goto out;
-
-		kthread_bind(thread, qman_cgr_cpus[cgr->cgrid]);
-		wake_up_process(thread);
-		wait_for_completion(&cgr_comp.completion);
+		smp_call_function_single(qman_cgr_cpus[cgr->cgrid],
+					 qman_delete_cgr_smp_call, cgr, true);
 		preempt_enable();
 		return;
 	}
-out:
+
 	qman_delete_cgr(cgr);
 	preempt_enable();
 }
