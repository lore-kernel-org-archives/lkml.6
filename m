Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx483yg6p7e15JZjbdC7+3yAC8zGC4t4Ib1NykGew9G+c25vi5Gm+cxu8oHOVkBA5kCqohaNl
ARC-Seal: i=1; a=rsa-sha256; t=1524406348; cv=none;
        d=google.com; s=arc-20160816;
        b=g2cEh3PRBrv53VZ3V8WVutOwgW1L0C2FhxpwwIFcN6Drhtp4Y/AbkO5Y9o2IiU+1Wh
         rZKinWbwU0Sd1ECItoBVEB6IU55jpXsBQ3o5G/TGaoW7IjGNAP+YI+qsLZumYm42MxhO
         INJcqZU5Yxy+CYhIirlOoekG+y18zM6SjNlHBjYRJmcL54DjjaJefQmJQFY2VacTsvCB
         kE0cuCfOsHp5Ql7EaCDmAYTBpbgkmYWH5EBimWWS/YD4K7vTu8eVF4bgXnQZqdKzbjOf
         nu9Kufq5Kx6DbbohbpNIjUvwVsIQ8+cjU/xEwUfMOr3UsCkG0V2lUhgZ50uhd6hjtCZT
         vwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qntEC4cb7zfUZJOhA05wuTxwikFDajWdQ22pU6EutaE=;
        b=FhxQKp1WX3X4UvqhhvDLpIFX8NjRgfWE7DBOm+q65Faw9+UcE2RFz1nuX0goxx3XW4
         ZMaTzUdBA2o7f9YJBG2ns2Zca2Lcw4VT9JWVh9RZN9YVQjuFbhNZbZT898Q6KW6HIlxN
         0EccyrumiaB8vQ4CFfjpqYPZwU0HhTizWgpZ5HqG80WHDtXStl2xwJng8L9yW2YvMDIk
         ANlo5LJYyJ6G+modP0t+GR95Z0dfdsCJ0XJdnnELNw04pR+m0Fgme0KGPmLQwugemsga
         aDTSTsqeD6NYlbk5vbhk3CjTicqM4mU6YkCvIXee3WcJLMT6wOJv7WbZRErFrRznND8y
         Hb1A==
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
Subject: [PATCH 4.9 39/95] RDMA/ucma: Dont allow setting RDMA_OPTION_IB_PATH without an RDMA device
Date: Sun, 22 Apr 2018 15:53:08 +0200
Message-Id: <20180422135212.021833780@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455058285314563?=
X-GMAIL-MSGID: =?utf-8?q?1598455912027383826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1231,6 +1231,9 @@ static int ucma_set_ib_path(struct ucma_
 	if (!optlen)
 		return -EINVAL;
 
+	if (!ctx->cm_id->device)
+		return -EINVAL;
+
 	memset(&sa_path, 0, sizeof(sa_path));
 
 	ib_sa_unpack_path(path_data->path_rec, &sa_path);
