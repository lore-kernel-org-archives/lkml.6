Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/GSR6hlbaEwmQpRlkqLWQ1FJiGsL5PdHPAwx7XMRpuKHF7vRwbx9OQT1qUbzhISNvBJPql
ARC-Seal: i=1; a=rsa-sha256; t=1523472651; cv=none;
        d=google.com; s=arc-20160816;
        b=Fp0kVSTmIkNGWS0YGEk+4xPkt2BOCvFvo3fT7mPaV50ihjBAiKnQvNCIX1WDuroAvr
         NEYlppToq5Ee/mLHn4nTCe9PQK1+Xfqs5tXasDOQiGtj0TqFz//9R6X9u/jpfOW+sAvR
         Ze0bCkBCmA2kXc11lSsus5WuCn0ySoXQMXy5oVVk7rDOR/qgdH8LpiJWzzxt8wWi9sss
         6DAmiGhB+S+UR8RreCkqETGPUM8lkcrCQBvvudiqWFdk1OJ2bZnuSNFx8JlFVxFkc1c3
         fdt0jTyII8laxYso+eiEaGpRu+SQyzYYLm1AZ76uMG8q7iryu5baKbDWZ+NFFEmFlDei
         97ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eH9XPFBrRXJHsLXOoLBKTGRgQpWTT2Ju42KRr6NWD/w=;
        b=HfMg4GsxTkD3hiCtqoPeizmzXBpD+pdo3X+lpzN3RZ2r+39f+mEU4Ddrv5zr0vqZNZ
         bvjrqNxTzQtjB5fxZTb90TYqpsxL34Vuf5pPOSYNYi1kokeeheTfYpwg/LYf9D6tE380
         bs54oMDH/VXH8MzQwFAWbta6/yymUNIoq6xm/ymdn2OQBTsLPl6lFqE9riNc16E1Xydr
         wSNFmj4PlK0UnsYcSyqgoWl5kRKW/qz/l4kRhMSFgThGrsveD7af3RvCLykYw+IwTMVM
         wlOuybZzjUC5k+CD2R70K9ye4oVaWuHR7EI86VUEYGYU7PtNqEe80DHkTPamqRBcoIZp
         nqaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 162/190] virtio_net: check return value of skb_to_sgvec in one more location
Date: Wed, 11 Apr 2018 20:36:48 +0200
Message-Id: <20180411183602.014063947@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476317763826801?=
X-GMAIL-MSGID: =?utf-8?q?1597476859239251128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

Kernels that do not have f6b10209b90d ("virtio-net: switch to use
build_skb() for small buffer") will have an extra call to skb_to_sgvec
that is not handled by e2fcad58fd23 ("virtio_net: check return value of
skb_to_sgvec always"). Since the former does not appear to be stable
material, just fix the call up directly.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/virtio_net.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -556,7 +556,12 @@ static int add_recvbuf_small(struct virt
 	hdr = skb_vnet_hdr(skb);
 	sg_init_table(rq->sg, 2);
 	sg_set_buf(rq->sg, hdr, vi->hdr_len);
-	skb_to_sgvec(skb, rq->sg + 1, 0, skb->len);
+
+	err = skb_to_sgvec(skb, rq->sg + 1, 0, skb->len);
+	if (unlikely(err < 0)) {
+		dev_kfree_skb(skb);
+		return err;
+	}
 
 	err = virtqueue_add_inbuf(rq->vq, rq->sg, 2, skb, gfp);
 	if (err < 0)
