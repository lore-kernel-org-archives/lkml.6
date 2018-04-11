Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+LEvBEGf8Me5qSleZXEi6B5HKjok5yXBViSPsrj2vmbjxi4mrCe+qE63LE34fBEP14nSyx
ARC-Seal: i=1; a=rsa-sha256; t=1523473508; cv=none;
        d=google.com; s=arc-20160816;
        b=dlg2b/qgP+1LzdRS4D/bM/NmxDmvbx1bJ8BE0bpke8Xk5aqEnX+IsTFkV7EZ0AuOwT
         7MCrYzZ6R7/cLY0UEWKRwD6VIK8egyOAgllf2U4nZrJCDWNnzINo7xhaiTysk46GvgeC
         N+Ub1EVvVUh/uCp0MQmcU8O+opVCsWHcGj0Q8FBz2rUx/BPWaL4Lpo/2cEIzgu7PLo+G
         yaikuII608bPIO1aFtpyYfxWtSrerwGlQqeRNhmWtuel1N0QMRts/oJEjdSgXjvFe6wv
         rchvLaTOXonKOkkRWwLj+V2WNezWpkBK1RDfF0IL5pQksoQudS5zzb8zkWfKSmYOflhQ
         id+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E0SybvlfR6IUH3fDSD6D1WuriZM20LjHf291kmmZLyA=;
        b=oWR19jwtgYkmW+v679sDDy6ZW6nlqzKU2oGrU1JqP6ZXXPtJFgeV7Dxk07aZSBGwYI
         e+uAkUOOXv7XJmoXS3cfhlJdrWMtbZ0iOQWUT666WNc6R6V3yaXnJl3dDxgAqHgH25Ey
         1ljIAyxTQWGdE310KkPRE0Eo7gRTgC9kLvZ00jZDrlmz6JXfpwUpe3Ed1E/RsyW0A1P3
         r1zGcxC9G5LQwx7BreEHGr/OiKxxVLYMbkNgJ2qEFaW0ETN6GGHLi2sgmwAPA+FmJrra
         XriBCjpFvMda/GrFk7c8mNpssuYyoVpZkA6vhnX43y9gnPEqy99Pqc6W3QjhJu8iGVax
         Osnw==
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
Subject: [PATCH 4.9 273/310] virtio_net: check return value of skb_to_sgvec in one more location
Date: Wed, 11 Apr 2018 20:36:52 +0200
Message-Id: <20180411183634.368768129@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476317763826801?=
X-GMAIL-MSGID: =?utf-8?q?1597477757093731838?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -529,7 +529,12 @@ static int add_recvbuf_small(struct virt
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
