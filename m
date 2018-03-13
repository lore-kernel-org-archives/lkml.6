Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELveR/6APcoiBaP5ChfmJRdbb7rqylCyOF2OJIpyHURKdy5Q+wXhrcs50s5avNNPdMTBkenp
ARC-Seal: i=1; a=rsa-sha256; t=1520955430; cv=none;
        d=google.com; s=arc-20160816;
        b=Pf3p50ni6qq7Xc0XG6V3JlwAg2pkeFM4j1+SLf5DU2bC5mRd8UfclX8CNIBDYRTXrL
         l9wuR7eD5MwPHCPjSPq5K+nrLCRB/Pb5XoeWLRO6G4MV6O/ycqCVKAaeimRoXc3rYbSY
         bC61gyO0XK5vijuHTTda4scG1VUFRtFzy2WVSJauB5Az1lDdZlmwpW9mIXZytdD+13fh
         QJHYPhTsbFvyWxbeqVigkPsG2YRRFvgswo1UvrInrzKsZ09DhgqCqZqkNETv/RIitSin
         XKEVYU2eohmo+zmp0y5YWqkUkmJjIsZcsUmjrPkNjRTyWiPAYr/juzG9ypk9BZ5mtiDD
         Lptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R8YgsgBaWgbdxX0LKqP8Hitgx2VafnHihGL6NU84JWA=;
        b=RQFaWlfaUSvCmvCR/q7AfHJAP3Ai5dFLzJ94ZPPXazxs6LqgZSc2E1PnJ1AqCjqAfB
         wGRRGJkFGkHWLM4cSSQVC1g6uaHk8irBHUUljRwvGqltSmLNoK1UDIgFsyTAyx/60FqT
         ytN9+N01NI4d8sJcFMupUvM+cDgfQMGYbNHFiXtbDspFi4O3HIh5/jslTHweJAHtU+nW
         G/3ggpkuIVUOGqY8bsbFpskbgbgygSuKkOoUW3MeV8pvUNbN1t9GCKMoVEdbfT8umh1O
         iSzkX+QDCqnEzBQLMRfd104+Mv88IKxIf31wQByyC2kiMlj5l5XqQHQeNUlNwOTCRg8d
         7GEg==
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
Subject: [PATCH 4.14 047/140] RDMA/ucma: Check that user doesnt overflow QP state
Date: Tue, 13 Mar 2018 16:24:10 +0100
Message-Id: <20180313152501.477111949@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836774596797457?=
X-GMAIL-MSGID: =?utf-8?q?1594837361069050752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
