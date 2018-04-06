Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48nOjx7sXn4tfvbaQSqwTKqp3FarJ5v8cpy2uMnY12pS0YfQnG0qEnKgMOmhbM3co4BfoWw
ARC-Seal: i=1; a=rsa-sha256; t=1523021425; cv=none;
        d=google.com; s=arc-20160816;
        b=FvV5WPyHa+6GWy3QW//VWlCB/CMDOTTP9Z0wqvIH1vEwinF5sUA7Cg2vv964UBJqTc
         iQJlbZe9sIoo8NyUIX+/MER4zGA3uQQgJAvY42TH2zzHlnYSMJv6EnmikgZTL07KrGni
         W8h1TIyfCsMqo+lnpTDiCm7B28ik4yJCUnXqiYht/ZaejXXqErtuZpfMwpqAbpNYHWB/
         369dEDxfthpWzvGWdICcuk51FKeo8QQ++JjGuilM7/fvrjvZ/6m5ss32AbP9Fwb5RTJ4
         1FVX8/U7EtoCCMQ17xV+BepoJhTrcvj+6eYrViDrbYg4iWKd+I43aTGDSsDp0XmXRZmx
         KGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0zWCJ7Sl96FASVEOjjlZq58wTaUMpi+UkEGLF+Gb/MU=;
        b=XtUhN+r6a+dS6l/S7819ZtvjO82CcA15e0W77GcwaKeLl7lLZS+1T1K94ys9k54nsV
         jJRkZaFcLC3kIhu/0WCqVZ6aLcYvPTn/r9N1GLrLSmsRaI778iELOanlVvMJEZOlZWF2
         nuuRndh0trgWFJ80sMN+oXhDRT0/nu3xj1XaWkxqk6laaiH5qy21+fWe6eSSswOnfdkC
         UgJJkgB+9CSGjkHzwrhBK/e1TOByjW8KqInSHCX7pfUYlhbzc91TpmX42fdF6zWT7Wz8
         gClBwVvyBli2+3o+/y2u8k2qyYoQ4vc9QuUWxMiEUNXvsHsStqzUgGqFHtT84Ahl9JJb
         a7Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+dcfd344365a56fbebd0f@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@mellanox.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 31/72] RDMA/ucma: Fix use-after-free access in ucma_close
Date: Fri,  6 Apr 2018 15:23:32 +0200
Message-Id: <20180406084307.774007716@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003714922293729?=
X-GMAIL-MSGID: =?utf-8?q?1597003714922293729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit ed65a4dc22083e73bac599ded6a262318cad7baf upstream.

The error in ucma_create_id() left ctx in the list of contexts belong
to ucma file descriptor. The attempt to close this file descriptor causes
to use-after-free accesses while iterating over such list.

Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Reported-by: <syzbot+dcfd344365a56fbebd0f@syzkaller.appspotmail.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -494,6 +494,9 @@ err1:
 	mutex_lock(&mut);
 	idr_remove(&ctx_idr, ctx->id);
 	mutex_unlock(&mut);
+	mutex_lock(&file->mut);
+	list_del(&ctx->list);
+	mutex_unlock(&file->mut);
 	kfree(ctx);
 	return ret;
 }
