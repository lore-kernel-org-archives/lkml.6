Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu0Q9IeEKh/SwQtkNZZIcBSdwZNzLnFCPaoMtHpc6Rr7wIE4WjIxgcUee31xYAF2ZKgeB/0
ARC-Seal: i=1; a=rsa-sha256; t=1521214194; cv=none;
        d=google.com; s=arc-20160816;
        b=cLhf1Q7WYOSAlZbDF79/PgOtN7wIS6Sp9HG8YGj7xnI+TIH3yWhWsyFf0UnurV8Xj8
         AiiGYIHdmxhhhiGLx8gJdOUUp5nF7Z2D4hC2+fWBV7zvKY4SuZEysuTeAgX5iSz+R56o
         xQkxmM4cUpZKR5ZboMCzi3DtqQKjsarJGSpWYCyYgMIfpZc/goSj28tsVnWbAQgHgEiw
         c6Cul0gLl6Sx6xhITv9EQokSEWF90fSJJ2Fv24Fmnt+kBN1XvuHRru7+2O2cvTl9YL4Q
         0aUWcQ5VboP3B4jUnLMZQP8rdUe63L/IP9T8GXcfAX/DBovkECdp6GgDEHoFmDeEQn5E
         wqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aSaJCvzUq4EYO+0gQwRSq157nKm5qimArNfKXsV5bQ0=;
        b=WOV86xbPPvyr2JQbdANjYw/4jsM/hRpppL8o0d+U+ymTZzryBaP+c188HRRDS7gX83
         3yut6/c3fdSadfeeNhZq3WqiXqQVLk6kALbWPFZhn+JmGurjxLGn5UYd67lYecGutr6t
         Eb/fEQxcHB9znvUyLmc6wmXuvDKc1Tw9uCNZ2ojr/1vXRny+mhqlleD4OjVgWK3kGpbr
         H4qpd4CqDi6cqSrREyUZLZ5HBN8NSBInnf0QuocgE+3asEPCLBkZiScXGHiniUKpbeaO
         dqVzlglvTB68wc/1FyWouI+uj3WXgdyU30r3jJTQ/O2wNc3AGJfQfW/e8fr6C6fDrVM9
         XUDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+0df1ab766f8924b1edba@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 02/86] RDMA/ucma: Check that user doesnt overflow QP state
Date: Fri, 16 Mar 2018 16:22:25 +0100
Message-Id: <20180316152317.340375859@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108502540055357?=
X-GMAIL-MSGID: =?utf-8?q?1595108695403292341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit a5880b84430316e3e1c1f5d23aa32ec6000cc717 upstream.

The QP state is limited and declared in enum ib_qp_state,
but ucma user was able to supply any possible (u32) value.

Reported-by: syzbot+0df1ab766f8924b1edba@syzkaller.appspotmail.com
Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1139,6 +1139,9 @@ static ssize_t ucma_init_qp_attr(struct
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (cmd.qp_state > IB_QPS_ERR)
+		return -EINVAL;
+
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
