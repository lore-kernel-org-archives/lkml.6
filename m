Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49PuamnCXvBqQUuToOXMOc5cScK7Qv1kB4bvEhIMBYHtaNsvFTPaqoidJoGOlkhqrxUK0js
ARC-Seal: i=1; a=rsa-sha256; t=1522346722; cv=none;
        d=google.com; s=arc-20160816;
        b=dO8SxFk+zLlAWg8MZPQ37eKlgpr7d+YHXVM5xc1NP/pzUGhVwlvo6hbX0OqimPAC9E
         WNTydNumKJijXD6R12fgiUYOTStGY3CYi6VxZOKntRAbX3lnT2XxVKJlyddeEdvRtmIO
         Db2WrvO/G5PNoBeDUKNoWFH1zBdXs9VXg+ndijRchcYP4QwAuXn3UdDc5a481ZRHFml2
         PZsGSXhOFw9qQeuDWmNMTMUXSnnJJ0EirziTErFRcW5lDbqFfYGlhF7rND/kGcOni1A5
         9sEaro3VtKHiNPiv9P9xKy7hYzgBnzZh6sU71uPRNSTInWgru7ihCj5faiCZ6f9kn+45
         RJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KDMIbCttQbwz42eC8DXpJ1QFn5/6mqW3k/60DU26CLg=;
        b=STUYQu15yU8ppT4ARO6VDP1YFfgusGAdcXn0oM4zgkSmZOFhUjeHMbqMwZmYTV0Imz
         TTf/mF5J+6XwHzGsvcMvpQlE+Zeq2qapp3a5htEH5zmOUcji/vWxqumSK2l6wRcRXUUH
         DK3mtIXYuO5xIbJdOef7vWqGrtn+CyZrPg1f309tsnXcCuHQjkXz+CBhCxoGHhNFpk6v
         QYeP7hzEE5aQ+6mefAvpwkObVPm2eW2z2GAXY3TMGYkJOIlbRD6OkkchDRYfmdGva/uW
         XgMU31n42KmO7KC2Z2uQfh6x4oZk7ls0oaBM2K+5H2kD1ayi3FE7HO68oV44PFEE7rPU
         ZlTA==
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
Subject: [PATCH 4.14 35/43] soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
Date: Thu, 29 Mar 2018 20:00:30 +0200
Message-Id: <20180329175733.942516176@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296074802248802?=
X-GMAIL-MSGID: =?utf-8?q?1596296236524115930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2414,39 +2414,21 @@ struct cgr_comp {
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
