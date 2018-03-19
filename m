Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtWvbcbm+qek+9pwgmjFK1wjZ72TSlQ89pRXry/7CcGYT7ITzUbEXjvHyj+qSwys1nYCz0r
ARC-Seal: i=1; a=rsa-sha256; t=1521484257; cv=none;
        d=google.com; s=arc-20160816;
        b=u51ryyS+P2Qxo2yYquXmO4GBfvP2C4mDb2tqroDC8ZBIr6+LlkoPY5vdiKMhFuQ+jU
         NaoICppV4A7ysyYPxndTpdKU16/ePK+nz9u30jaWzGmxft1dziOPo3+GKr7DmDJSByDO
         dcvo18ipFxwjjpLHwdE6xhr6p/uR/UjbWdaNBEimH2sJkD/ts1wBzUJN9ueDX8JFOMQu
         6LJXPV0wI2FXYxjBmSv89lqrv3zOgnLqpRu8g34uFXfX1wqLnfF5ytncymWovnH2nlpF
         y60lWry32YoxMfLfoslmivV4hD86PuxdtxPZLnpJ7N+BSoXkYcblaIBp95cfaYWQrKV2
         7kDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7aKn6AMJzX80FyHNG5nWTpVnWwkklnobAseqq6adDHc=;
        b=F3cQjY4NLy7NZW6sYjwXilBZNwe93d3XfLfME4xcbtbEmF3p/AM9O+HzYYHPvt8pHq
         EQk/WBsENZzfdLpNzCY93PEMb109RQc/uroj0PN1dTLNZAN3NEXocY6w6bKXn9+Iqpod
         VVdlnki7UHAVopQrdKBMQIq0+DAO3mpjxYmesrsHRncVZpoG6hbEh83DUpkgGrj+mjTB
         GrbrZ1v4UO+L1mrNQ7mT6KN/9wFBFhN5TbbaQelXJMhIo7R+Qzt66sjR2nUcQFGLPIac
         pUpxhiUpvtNhC0LXJpKvWNKmYgmaNkEMUd9ZckZV7fmycEgHAudvySMGEYVcUWqnV8OW
         zT4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	linux-rdma@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 28/41] RDMAVT: Fix synchronization around percpu_ref
Date: Mon, 19 Mar 2018 19:08:28 +0100
Message-Id: <20180319180734.083478211@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391876679897241?=
X-GMAIL-MSGID: =?utf-8?q?1595391876679897241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 74b44bbe80b4c62113ac1501482ea1ee40eb9d67 upstream.

rvt_mregion uses percpu_ref for reference counting and RCU to protect
accesses from lkey_table.  When a rvt_mregion needs to be freed, it
first gets unregistered from lkey_table and then rvt_check_refs() is
called to wait for in-flight usages before the rvt_mregion is freed.

rvt_check_refs() seems to have a couple issues.

* It has a fast exit path which tests percpu_ref_is_zero().  However,
  a percpu_ref reading zero doesn't mean that the object can be
  released.  In fact, the ->release() callback might not even have
  started executing yet.  Proceeding with freeing can lead to
  use-after-free.

* lkey_table is RCU protected but there is no RCU grace period in the
  free path.  percpu_ref uses RCU internally but it's sched-RCU whose
  grace periods are different from regular RCU.  Also, it generally
  isn't a good idea to depend on internal behaviors like this.

To address the above issues, this patch removes the fast exit and adds
an explicit synchronize_rcu().

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: linux-rdma@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rdmavt/mr.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -489,11 +489,13 @@ static int rvt_check_refs(struct rvt_mre
 	unsigned long timeout;
 	struct rvt_dev_info *rdi = ib_to_rvt(mr->pd->device);
 
-	if (percpu_ref_is_zero(&mr->refcount))
-		return 0;
-	/* avoid dma mr */
-	if (mr->lkey)
+	if (mr->lkey) {
+		/* avoid dma mr */
 		rvt_dereg_clean_qps(mr);
+		/* @mr was indexed on rcu protected @lkey_table */
+		synchronize_rcu();
+	}
+
 	timeout = wait_for_completion_timeout(&mr->comp, 5 * HZ);
 	if (!timeout) {
 		rvt_pr_err(rdi,
