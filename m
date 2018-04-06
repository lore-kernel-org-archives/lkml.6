Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Y3MBm4VFWOC96AOEDoqG8b0ObfbWpPiawhqFmFq+wkBfHaTWDZmBGAWABt+IbWUaTlIsC
ARC-Seal: i=1; a=rsa-sha256; t=1523022096; cv=none;
        d=google.com; s=arc-20160816;
        b=lBpK0zk0lVrrFP+btrB/qCHsNLfc5ftPAp7WPw9x2l/kV+6vjtAAUHWV4N32ROGAGk
         2iPr2j24e3zVjzl56Qlvan3PCMr1BovmQT/2cEXkdZIfrZmKBO1j0HzVw2ha48kHk/Ic
         zwlPdAVgVsUNgZBDocX5lAKAw/n3hBpJJJMavdyVFIUSrTZbjDSZhoa4rDEsed2jlq2n
         xX2BjxxHjKQunf0+7S3kVLisEDGuRHmiaM1fFyLY7wkAe+ily1C9j+GbIVP1fajExbrs
         qaI1fWzFld5SmNfhzq2QtECgnze/+OEGqTU8ea1H8iBCXmIH+U8AJNDGtffWoa1E2AzA
         fZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tICcy8FVDQ9pr70MPM+Kii9BtT6chlh2ydJOwG0wAhI=;
        b=U7/Ncj0/JSBt1+1pVoApmIgU7ORESGPEYgyaAN8BIwZ86sM1xq7v5cZLyy9qcVcTZU
         ZXG0CvIRE3gbKhOYwTjgkdnzihi63TqmjjzExgCyw8akhdJBYzdN5v6DlArAngl6Dkiu
         qyQlJELsbVzksQppupamR0nZzZFrL3X3WVPYYa5HUTw9b7t2Fn9iNkhkORdEngbuTR2t
         ofoq/AjhKfLCslaDcmpYRCP4Of2qbJ35XEmOzKMEdzxAZaVNnQCiC27AAmqkerYZqmPx
         XToT9zIkGC7LeOxpeO55vvODfyr9DE+eGPTyIH2pOUVgbOSSJc9XLnkMfbLDzNPVPIwa
         JvMw==
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
Subject: [PATCH 4.15 26/72] RDMA/ucma: Check that device exists prior to accessing it
Date: Fri,  6 Apr 2018 15:24:01 +0200
Message-Id: <20180406084351.535492166@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003722828039513?=
X-GMAIL-MSGID: =?utf-8?q?1597004417388814636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
