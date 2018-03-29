Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48CFlIKHNiAjFSNYfAOgNvyl201M81nXPZM+i1SKjtw8jds/jGH1EnPcj6Dxj+pC2nBf8By
ARC-Seal: i=1; a=rsa-sha256; t=1522346567; cv=none;
        d=google.com; s=arc-20160816;
        b=qxsJ6ifd+qg65KNITgKpK4O2Fgdc/6I5UZ5vp4TXxCio8qeoYAJEsK+0XDSQ5k3eIk
         tuyEayjgJaZrlwiCj/26LuXpcLIs+rsw8Y1yFZoWyYjnr1Q6Qj0KNyMwNmR7aA266to2
         yYpiNUo4s44DuSzfRbhfDTHkChNHycA18d7vLVeTuVWO9KloToFrbHwjs+HMDDm7oGDB
         nMxmO7Bm3Ta2V5Se/bTqFguvWL/xzA+u7umZ2eBDDKipMTpiD6ZMY7PEsgmdFudD0RXe
         BxFnwPK6guOK+3N+QVhDe9wUCsYuZU4lS2sWZeEas55JGEBQBSZKzMfafqu69A/m27MG
         1OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gEc2qmgAtF4G0LtTjfOXD2l5yo49bV0kVnpzOCen52k=;
        b=KpduRguWyvrbZb4+/ILzAXQeWv7WrSvfwX6QAN9RxhOIiBEYwjE+sOWzq8soC8Ptcr
         kESAWYPKLlr3VotKmUkZ+j+zlsfwuzPyRmqpnjGWICNeSZv53iBUIW8cf86tqJkujtpf
         bNypLp8e+vm9eaxg3kD2v5eTtbTkHRHLhFNgRGLo155tu+QmKEbBgA3KbU/jJ4aMHL6G
         A5e5p0U0VSQR52y8QEI40yTpr8K4A5wnnQirjq9WxkB96XbCurD1q4h86Hfqt5vc9xH9
         p1rKDtzBdbvogKMBwIxW1voSBzwsbRReCwkkfgdvtdYT5cZy1PHF96ktxwvHGU+zXa+v
         FQ2Q==
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
Subject: [PATCH 4.15 30/47] soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
Date: Thu, 29 Mar 2018 20:00:11 +0200
Message-Id: <20180329175731.634203572@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296074802248802?=
X-GMAIL-MSGID: =?utf-8?q?1596296074802248802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2443,39 +2443,21 @@ struct cgr_comp {
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
