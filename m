Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+bCQkYhSXpi0neKgxoXEyAaTCwA/vqJW2dR+sL6iIA8Qq+BH98SVzhyrzNmBJ9lcPhJwg
ARC-Seal: i=1; a=rsa-sha256; t=1523021433; cv=none;
        d=google.com; s=arc-20160816;
        b=eTHbHTMD2hY2ftRxrtRg7Ct1ONFypKZ/q0cSuz81NLVWyt67ew0Ty1yZHZsWd86LqV
         RCWjxcOsFvWXVhXz/D5uVDNrjJnO5D7T8Csr3TKcY0hoW4rqF3BZX/27Yl7jjhyG2mcY
         H4ww3V+9NjhEsq3Qxz8KPIMsvPwiizK6GNi0ieTB9XCJeuG8bC1whnjDVL91Rvnw7cwd
         iGYJFw3pWoQl6i3aTDhAuKhHMwd6TI3MPeXy+Fmil6XObleGsoJQ7fQC5QRtFUtHjFr6
         j543lLnwi1OzPswIvE0S+bAWwZ870XCdUdjcL4+61zbw/PE/gQg/SQ3zOEDAHnzTVtUI
         hDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MsCfwKWXEq2UcuuYYwiXU5+buWxafs+vr13Pc9sHoR8=;
        b=kMIwMEtIg0mLr1Rm9hljvVFmJ5gb+t40FEHybqNWz8Ny2HaAro23gPLB7ReJui/bbA
         9QYjJP9eYdBG6Ib/AstIlx8AyeTX2Pyc3tOeHb2iRxVT4e/oRzSUAyzZ+qy0hn7KXBCk
         XJn+qrDmP+2jFJ77LS0a/ZxKdKqoGFeWLv8sLgzl3QVe+aTm11kGShmXA0O4dffacfem
         Rtfa8MkO2BRCoRtMEuv/G4Mn1YItkAdqbVxZ1R8JEOnr2rji0FYYjGq6rRz1mWZDziOv
         7PVGiiOCyHa1ycNRr5fTeeSNIGnHQmcMU8+AYyauJNVYNmP6BJfjwsL0zeNyHWpwsNYb
         TCGQ==
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
Subject: [PATCH 4.4 34/72] RDMA/ucma: Check that device exists prior to accessing it
Date: Fri,  6 Apr 2018 15:23:35 +0200
Message-Id: <20180406084307.999654474@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003722828039513?=
X-GMAIL-MSGID: =?utf-8?q?1597003722828039513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1316,7 +1316,7 @@ static ssize_t ucma_notify(struct ucma_f
 {
 	struct rdma_ucm_notify cmd;
 	struct ucma_context *ctx;
-	int ret;
+	int ret = -EINVAL;
 
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
@@ -1325,7 +1325,9 @@ static ssize_t ucma_notify(struct ucma_f
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ret = rdma_notify(ctx->cm_id, (enum ib_event_type) cmd.event);
+	if (ctx->cm_id->device)
+		ret = rdma_notify(ctx->cm_id, (enum ib_event_type)cmd.event);
+
 	ucma_put_ctx(ctx);
 	return ret;
 }
