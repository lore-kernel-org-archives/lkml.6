Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/VjrS7zh0U9I+L7KXwQUy1+6pS8F0ZoMQK/pE/J+1AcABl1i5ttbhnOkHFrwhvpUHzSpdl
ARC-Seal: i=1; a=rsa-sha256; t=1524405577; cv=none;
        d=google.com; s=arc-20160816;
        b=B/HctLzFHu8fH/dzXSmgY/6s1g9fDY0A6liu+tCoFn/KzfX1+jb2TzVp9AnJMbLslJ
         mET/uF2w8jda1ovKcJIgHIFVTKKpRlK9R8tImjOeeJG+7IrcfC3jvwEjfVjpCN8VYNqV
         yTWx8vUKhyYTXmX2KcI0w+KOuazoOeEpmFVlYTr42uP/zpvMr4kAWlOE35D3IoQ7D94I
         hQHCNqhfoiAWm7OxwdXKc1T0qcYEoCvvhzNj3jUMus+T4AF5kzP+ok4zNBvEjyJkQtrP
         oPAo+yFtGzoyCXjYx9mzR+/zFbnumBph2PnH9WwtO24vOwV2E+MnBwKn2SMsIo/Ur3GB
         B6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3kDRmMcU9DzvgKMFeFK4kkQQO7AuynrwZJWf6IMGyt4=;
        b=useJZMiwBOawiNb+6m1ji2N2+l7b4v1YNIuWWHllb+gw+e4eWxIZhMxwtASpmReR1r
         OB64+5vGoox0JkGwm76BaHOfxgQHh7UP2LDdvRdUWLZMgd+pX7wQLpUP3LkR3Hmr2R2e
         2PxGv61FNV98EvdmR+pQdrE9LMTpCif6hBFfhCF/EpqHEnvAAhBWAyR4slmIZL02VYE2
         3aEg2yUnZ7hU+qyUrycZ9UzeLVS1SfjGx5pqlNGWQ+Suc3xrzeMEQzqcL6sOPyloco5m
         IdmmNWAlq4+NNkv+B1t2jX7Fw9U3uKMZLYYm9X53mBjGz/iRtaOPNlGu8fuhBclF+m5T
         N56w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 117/196] drivers/infiniband/ulp/srpt/ib_srpt.c: fix build with gcc-4.4.4
Date: Sun, 22 Apr 2018 15:52:17 +0200
Message-Id: <20180422135110.298687910@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455103090453749?=
X-GMAIL-MSGID: =?utf-8?q?1598455103090453749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Morton <akpm@linux-foundation.org>

commit 06892cc190550807d332c95a0114c7e175584012 upstream.

gcc-4.4.4 has issues with initialization of anonymous unions:

drivers/infiniband/ulp/srpt/ib_srpt.c: In function 'srpt_zerolength_write':
drivers/infiniband/ulp/srpt/ib_srpt.c:854: error: unknown field 'wr_cqe' specified in initializer
drivers/infiniband/ulp/srpt/ib_srpt.c:854: warning: initialization makes integer from pointer without a cast

Work aound this.

Fixes: 2a78cb4db487 ("IB/srpt: Fix an out-of-bounds stack access in srpt_zerolength_write()")
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srpt/ib_srpt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -841,8 +841,9 @@ static int srpt_zerolength_write(struct
 	struct ib_send_wr *bad_wr;
 	struct ib_rdma_wr wr = {
 		.wr = {
+			.next		= NULL,
+			{ .wr_cqe	= &ch->zw_cqe, },
 			.opcode		= IB_WR_RDMA_WRITE,
-			.wr_cqe		= &ch->zw_cqe,
 			.send_flags	= IB_SEND_SIGNALED,
 		}
 	};
