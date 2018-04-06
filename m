Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Fv5PnCNqINbd61ilakvLIEohPHmwRdXD4LRhunxaBmdgQoCMyYAD8ExQBRUZgzd6gJ1Ih
ARC-Seal: i=1; a=rsa-sha256; t=1523021646; cv=none;
        d=google.com; s=arc-20160816;
        b=M8GBzJ4THm085pdRP3xl4f/2/VsaWwGDY3qJwPgJNDR23bDheNnZGdmsOSaRzBxbAs
         5pld4bsebw1AebwFy8GhqIsXAcYHiCkPWPCiZKQK2XWK2GPHIdSTHl74nBp+1iEJEDrT
         j9wsWr62CJbqKbfk+x4hmCMcHtU8NoOyzgsnXcCIWl8T8rQzN5W2PCXAze7VBmwYgSBS
         7uJnc11vvvdPOuL0z/pzYbyD75OSSGaf6eJurht8xwNP6FTHEKKqs/o+KdXfm/bIUVbf
         iGJzsapwUrAkcR5Pptn320pWirfZMbNTYyvb1TDCj8as+JtnK7xioU4l2TzKoGYKozQB
         slEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H+C8Azqyd7rrPUEQRzrjg8s5AIeJ9WFt0Jj8w5jk7nk=;
        b=sCAoZ2fzywPkCcZv/S/HXVRSG/fMsAFUsrIwfhD0R8Wiw4+VQZVtGTNAJFoRrGNuNA
         MSCEmT8JlG91cjTtAp17W2x/7gWYZT/bRqFFrWgX/hFQSIDfntF3wKwklu1NtItGJqov
         J0AdzPenR6HYUwXOnkr4iZoskBg8kwlZ185S1chB5/dapyxnGCIibtXyt+5AYnydfnZA
         0TSiJdAgI1NcX02XQmPHx58E66mAy0mmbaZlR0Za3H7GwOQQ0CP7qa+XSvzC/87tCGw/
         q1Hlk21AOeKSYGYkBwXMIn2mTn8W5HRafpTTcQExkeEDNRAmtBLMzn8wqMjEyjSct1ZG
         74aA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+71655d44855ac3e76366@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@mellanox.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 040/102] RDMA/ucma: Check that device exists prior to accessing it
Date: Fri,  6 Apr 2018 15:23:21 +0200
Message-Id: <20180406084337.314603101@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003722828039513?=
X-GMAIL-MSGID: =?utf-8?q?1597003946279638807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit c8d3bcbfc5eab3f01cf373d039af725f3b488813 upstream.

Ensure that device exists prior to accessing its properties.

Reported-by: <syzbot+71655d44855ac3e76366@syzkaller.appspotmail.com>
Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1317,7 +1317,7 @@ static ssize_t ucma_notify(struct ucma_f
 {
 	struct rdma_ucm_notify cmd;
 	struct ucma_context *ctx;
-	int ret;
+	int ret = -EINVAL;
 
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
@@ -1326,7 +1326,9 @@ static ssize_t ucma_notify(struct ucma_f
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ret = rdma_notify(ctx->cm_id, (enum ib_event_type) cmd.event);
+	if (ctx->cm_id->device)
+		ret = rdma_notify(ctx->cm_id, (enum ib_event_type)cmd.event);
+
 	ucma_put_ctx(ctx);
 	return ret;
 }
