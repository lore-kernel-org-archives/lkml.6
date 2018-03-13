Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvDupakugfE8xr3WkXfkN1XVbJuP7OsuzgosZ47Pep9k7y/0iz76Re9qD0cIh77Z6VsCmP2
ARC-Seal: i=1; a=rsa-sha256; t=1520954870; cv=none;
        d=google.com; s=arc-20160816;
        b=CjuD7x2ItgaVGaV/ml+3As00m8yRdHUihKwoyYn+VaNLHvJiHYxbrwRfXdZabBhGtK
         H5l3ESnKtRYudj5lhbF99cAEllKfkU0Yx9vlmNieI34nVbmn9WEZukrNntcgr8Ld3yIZ
         B4xkLY1Ct9RTUOTgI9fo10l95EUxwbg4/XUTOplre53xY/4tJZ70U1n7ErQYVsNcHs4V
         R9UC1pA67DuFCCHCPPc98kZpUT6ZRsASSl/Fxl005E36mC/nbEp6c4eG/5HBYQLpvsvE
         1CqMEgVhjCbma5SGQ9BgZGtrjc6oaSLYz0AvU9Ke9chHU2lekvSpVuqjLijAbprxHHf0
         gmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aJy5LXusBhvlmyw1cdGWDv7pe1RVe59D5JRUIexEfVw=;
        b=rRRBsPCKKLEofCcUrkk3QXsj+lCZ3+oBR9dCr6Pq50iTP1YeCdG3dda80YdT8PdmFL
         1SeBIMINlEsLX8Owq1RmwCWOiVvY3vNqcT+Cs9SQXZCn4C8bx4/t0Xq3YlXdJTCpGnyX
         CCdYWJFLov5XfwdtuHHoh2DTZpr5COmaX3do05aY12je45DZeQDWBY/FGVHD3KYvY3SS
         nUeQoTFpPc0a82fWGubES6BuFyTgfd3Px7j3KPH7ZrnFEQhUc69V4Vyg1xBAbD4jt7NP
         5B5qYqqDoUoj0TgDvkhrXRj5o+7NPAbUuWpp1eG4iwi4AsPv/eF+fnOIL4l7Ma6Szdc/
         q3HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+0df1ab766f8924b1edba@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.15 002/146] RDMA/ucma: Check that user doesnt overflow QP state
Date: Tue, 13 Mar 2018 16:22:49 +0100
Message-Id: <20180313152320.786113488@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836774596797457?=
X-GMAIL-MSGID: =?utf-8?q?1594836774596797457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1148,6 +1148,9 @@ static ssize_t ucma_init_qp_attr(struct
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (cmd.qp_state > IB_QPS_ERR)
+		return -EINVAL;
+
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
