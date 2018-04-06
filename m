Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/P2MlBsYcBpRatiticIzcQfIdgsKJZNJ5tNOeVnvhjXPE7uvKnKIbWx4i2C92HRVuPzQ++
ARC-Seal: i=1; a=rsa-sha256; t=1523021892; cv=none;
        d=google.com; s=arc-20160816;
        b=M/2Rq7worI5lhdwLePV8OJ9SxGw/OhsQV8ahyoQnuRbOCzwVp1oWk3aC30plRVRjuR
         l5hQHUvpXitIiOpOHgWUhopA/8eVUclGOlvVurZnrvaoPkM8vEOjsEDnOeBpMlEQ/rON
         gq+cfw2dakSs0eHv1CR4ccj/axmYtGyWsWGvGC40scMiAS3d6t00QqAHuvooVjspi/GU
         A5Dnvzk+e6ByZXijgeYExJeH9HmbIrLjKmhtpdcazrrtM3oEh3qiro7gbHrCWtWELQTG
         yFgtDCY9ELgudHctMZVlIPlQ/H8S8hBR2I+hRcqDh3fPGttBL5PHORxwqOY6EZjJFCpY
         bj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hbua7y/H/kIhEj94l0bHbgl13Qqxn3zRO4Ps5vnCErU=;
        b=Cx0aZwpnF6DvkJpR4ORYsZu3X4m/GBND7L0S76gEqj6yNl1TFZ0fmBluQpkpJ7b6uG
         8vd4k1+9K8B9+q4P/zBKqplikaILJjwLuBFZJHSjwrV0QyxNiJmdIKuO/jf7IxC2eAsF
         YHEUtKWRnfQ9iCjtSEkWVmYOwE9k7iaGrfxlMa4heB8ixstLgOT9VNzsp3ucKJwYp9ae
         N5QoeXhual5LPV7+dK5+hSMZtxKo8K6R5SG2P1N0U1loGwzEe+IQ2qWuTsKJF/muwqJU
         9wBczqEeqlmclKwwI0vHYJ0qVty6FNJoPZVuFBTcXxHaimwWmb6ALHHjnXtB6fAHR2jL
         y3HQ==
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
Subject: [PATCH 4.14 24/67] RDMA/ucma: Check that device exists prior to accessing it
Date: Fri,  6 Apr 2018 15:23:54 +0200
Message-Id: <20180406084344.595753875@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003722828039513?=
X-GMAIL-MSGID: =?utf-8?q?1597004204184908048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1335,7 +1335,7 @@ static ssize_t ucma_notify(struct ucma_f
 {
 	struct rdma_ucm_notify cmd;
 	struct ucma_context *ctx;
-	int ret;
+	int ret = -EINVAL;
 
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
@@ -1344,7 +1344,9 @@ static ssize_t ucma_notify(struct ucma_f
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ret = rdma_notify(ctx->cm_id, (enum ib_event_type) cmd.event);
+	if (ctx->cm_id->device)
+		ret = rdma_notify(ctx->cm_id, (enum ib_event_type)cmd.event);
+
 	ucma_put_ctx(ctx);
 	return ret;
 }
