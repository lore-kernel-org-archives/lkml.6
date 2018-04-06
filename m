Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Vy67Lu+avx3z8NvpIIcv1KE3+rMl0b1bCsUGnvX7lVj4An6Bf1CUz1sVNb1Mh/GTV+cth
ARC-Seal: i=1; a=rsa-sha256; t=1523021879; cv=none;
        d=google.com; s=arc-20160816;
        b=U4ME2eKiO2qJfLhrBP6iHdIlBWdoOYUkkiZQA6hxjCCmvs4jDcnx69rOM8FAMMHfUQ
         jty4pfgTquKfHb8LxhUuMNcJGpjHxCwr0Qzvrs8TBLb/giuhtSzhkFC1pSmUFIMIcD1L
         Wjnr+yonkLycl29DrKvMXHdh9WXz0Xk4I+yByEUq/piVCraI4o8M1SLPfWzt1+qr2OQo
         sOUKhyJtTerLiTsSOzU1MN5IvcRXlnjAKXIaPWT/6lJ63SETXn4GhEyRYDwRQTC6Xp5F
         rTVdaS3DVmzm9SGGv7Wz9nuRgD1eqENu6sV3BdQ3xEzJuR91jxhMf0gFSXsN0qNk9V2V
         tCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3K7Td3TbuRqEAyNu6OGnZTe9PbPKV6lVwGAKiHh3g9Y=;
        b=0CQLR1Wowg+/947zbraVFr+jegMX+gWXIk0d94Eh8/F5CEqD+5J6VqmE6sVZ+zm5LZ
         SbNShdncx7mXDgwYk52vL+mr/U4mMigstp9WdOls6qCqwUw8sxZjZktN0AuQUGr+Z6yH
         1ACQoTPd04CJqltAMVkcv0tRK/ebzdI8z/UP87MwOith6fZbpY7SaKzyHN/el30Ou5+I
         YXWWxjDygZkTSFEmVMmMF1uwMVg5CSd4lfVVbPVwEDxm3InN45fsYBsqMhNEyc6IANek
         y/dNUzL4YmGOiRggifgJaKuixcjiBr/AI5tMA1axHnPloltwyavwdNdJqyo4EvJ//N04
         zjKw==
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
Subject: [PATCH 4.14 20/67] RDMA/ucma: Fix use-after-free access in ucma_close
Date: Fri,  6 Apr 2018 15:23:50 +0200
Message-Id: <20180406084344.041922579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003714922293729?=
X-GMAIL-MSGID: =?utf-8?q?1597004190370671973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -497,6 +497,9 @@ err1:
 	mutex_lock(&mut);
 	idr_remove(&ctx_idr, ctx->id);
 	mutex_unlock(&mut);
+	mutex_lock(&file->mut);
+	list_del(&ctx->list);
+	mutex_unlock(&file->mut);
 	kfree(ctx);
 	return ret;
 }
