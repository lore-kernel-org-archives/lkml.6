Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuydvZMMFjNqfiCLhDERhnOgXlWzOOSWYR6hixMvSk1WVqDk2Nl8wn1unUUmmILZK18itr+
ARC-Seal: i=1; a=rsa-sha256; t=1519981286; cv=none;
        d=google.com; s=arc-20160816;
        b=oNdrc/2I7mdm7tsD3OZ70qepjV03/FzRuDB8YvdVYQ0bt5TXE8jV+mjIJOw0lZhBEO
         RxaDgExjEp8TI7Xlb+FjNsYBCWdkYRFTtix6YVKo4G6nIfyZpUgXZUsp3qD21SWFILzj
         AchUmA0d2tNNwbrmao5A+R84pt98ZY1rHg5Gr7fmfWQmxz9UlVkhsoJrYNZn660Hw+wO
         z/K3OKFoKesSQD5VrI5XSc9amJszkharJhnVUM1l38uLlwlFM+/ygN15cxqh34O9aU1v
         qyMPkbpyw6gJ0UnP05NBZrS6VnFYcmpD4FU5jIU4e5gwL38N7eq8TrP7G9dn+HwdwDEQ
         LVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8jDSFGu57EC/cH3MMWgihtdKh6YOmrrdRdPMf+r4P5I=;
        b=xqeYS+K91oyBhhcRUXVgp99tFLsdhYNdFHp5OY81CORfDJzahNHSgzQ7lSjlm3Fzjt
         E/lMa+GkLs8scIaEFbSdvxOZMSx2A2XUEZB2OVxM18Ns9vou8mYyzevGo8FsWpX9evTn
         /RCBwRYYu0uFu9jPqe11Mhe2ARquTIQkSXzRGZTvd74uerFm5J9sAH+0e5P60n2/BwtX
         YKgqYNxHKE/FogiCulCEYpgYasUSW2uPUbU9ecJQWYS1eNUhJFrpnAImjiuur2LpOjsB
         +zT7arbOvc1WLUZ8LliFJDY9hEqyBwghVEbyWksIHbcB+m7HET9TnUlb7mPwXddigt8V
         4pkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Bryan Tan <bryantan@vmware.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 047/115] RDMA/vmw_pvrdma: Call ib_umem_release on destroy QP path
Date: Fri,  2 Mar 2018 09:50:50 +0100
Message-Id: <20180302084505.785880970@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815897550624784?=
X-GMAIL-MSGID: =?utf-8?q?1593815897550624784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan Tan <bryantan@vmware.com>


[ Upstream commit 17748056ce123ee37fb7382bc698fc721e3c4a09 ]

The QP cleanup did not previously call ib_umem_release,
resulting in a user-triggerable kernel resource leak.

Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Aditya Sarwade <asarwade@vmware.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Bryan Tan <bryantan@vmware.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -406,6 +406,13 @@ static void pvrdma_free_qp(struct pvrdma
 	atomic_dec(&qp->refcnt);
 	wait_event(qp->wait, !atomic_read(&qp->refcnt));
 
+	if (!qp->is_kernel) {
+		if (qp->rumem)
+			ib_umem_release(qp->rumem);
+		if (qp->sumem)
+			ib_umem_release(qp->sumem);
+	}
+
 	pvrdma_page_dir_cleanup(dev, &qp->pdir);
 
 	kfree(qp);
