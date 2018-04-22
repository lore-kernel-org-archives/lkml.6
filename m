Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+WD9oO7HMU7T9tGVzyyBRb3m7RexJXwhKUXEEpCC+pVBy9s9eLtx6lj1m8GL2xMQJ5+GbW
ARC-Seal: i=1; a=rsa-sha256; t=1524405535; cv=none;
        d=google.com; s=arc-20160816;
        b=SQ3CoMumChtGUBltIZQk9u4E+eP5eTmLwal6sIRMJMdQg0tTz+ITMDhgStJOp3ntx+
         jNMNxEH+5GfPmBbmPbqZ97NtS5Z3iRml2FRhTIB96uVLpGtM2WbVnIieXOmJNmCUIzlv
         LRXlWy7XQpbfrw8MENFa5Vfz3uVXtJVvf2LWJOtYRCkqedQEFmJ1DSI9Ktogpe9Ti3Hc
         5iA0fPQhF0g7DVbSgxdDhluWoIH0NTXgQd7UXVWiBrHt7LH3dWBIv6pFHLApSvQFk5PB
         9ZM7vr0RvwziKZ9+z1j2VlBUKeXB4GxbHxFKdq5urIAoR9M5XFbpa/k5G1LLdd9n0H1N
         +0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SQpwGU8mtXe0xjQehYcwfU9mONQDwphfiBfzEkGUFL4=;
        b=adp/8pTAlyILausN1fMODregbqJY1UYSDKAZMBC2N3pmjQh1mGi4Y+c7TE3Z+eDqVz
         Gp02LpoaKGMH+VHt6RV2+kPaN0AbjRs7ZHSoh7hH3B59/mi4fGjc/JjtTDDcSodQTWCP
         b447w+dQVYvpek23r+YVzj/Lu7UH05N0neapLIz1Ajgy2K+yup5KMwEI+2jd8ZK6E2Hu
         aiCqvXxAJhPhor6lrDswKS8mRJPsdP1uoo3Kv8DhzTL6SspOCB0JRAbblS/CxDBBTPaQ
         ctyYlgEfo3fZ1l++K98U0RYzLBoAwHMSJkiKWkYpBaYGyP7+2EXaJN+1gcg4irCxQ16g
         Uf7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a67bc93e14682d92fc2f@syzkaller.appspotmail.com,
	Roland Dreier <roland@purestorage.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.16 102/196] RDMA/ucma: Dont allow setting RDMA_OPTION_IB_PATH without an RDMA device
Date: Sun, 22 Apr 2018 15:52:02 +0200
Message-Id: <20180422135109.531229931@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455058285314563?=
X-GMAIL-MSGID: =?utf-8?q?1598455058285314563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roland Dreier <roland@purestorage.com>

commit 8435168d50e66fa5eae01852769d20a36f9e5e83 upstream.

Check to make sure that ctx->cm_id->device is set before we use it.
Otherwise userspace can trigger a NULL dereference by doing
RDMA_USER_CM_CMD_SET_OPTION on an ID that is not bound to a device.

Cc: <stable@vger.kernel.org>
Reported-by: <syzbot+a67bc93e14682d92fc2f@syzkaller.appspotmail.com>
Signed-off-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1241,6 +1241,9 @@ static int ucma_set_ib_path(struct ucma_
 	if (!optlen)
 		return -EINVAL;
 
+	if (!ctx->cm_id->device)
+		return -EINVAL;
+
 	memset(&sa_path, 0, sizeof(sa_path));
 
 	sa_path.rec_type = SA_PATH_REC_TYPE_IB;
