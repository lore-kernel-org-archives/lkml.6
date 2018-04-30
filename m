Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr586qYHBUgdkc5rorUpQftrZLpG1G/xF+7z/EHP02yoVlI/2PVCcobmoLVkvxAZrQk1o+F
ARC-Seal: i=1; a=rsa-sha256; t=1525116232; cv=none;
        d=google.com; s=arc-20160816;
        b=LKTzfVCFO/Y07IVvgSdYJ7F5WX8jBkZHLSzcMLW8eZ/S2nhvk9nxEd86Pt68u4fK/e
         NkAKtKRcp9EcZjQ5/5LUPe6rglS/WJzST6BQCYH5n7NzMmjZgpkfbtAbS+oHkLsRvF3F
         gXbbCZTuVRb6lx2EeIJSibr3goqgc3CTofryo3sxFj7dBVQ/6AGsr6rV9Fwqa36+VqD2
         nrO5HDpXdzVecy6Gx6ADPoiZAMTbjLUKZFCB9xcSaaLm8wF00hLPhU5KaKrQVIFcqRHR
         O5t3HvQW5+Ex2uuoyRmAdj2V93L1Oz1nuYUMmrPzj2f68z7gZaN5Z76paK80Ak/zkuwD
         JAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=i4oOrj95TBvc6iS1XAKWpwTFbFOZSdCOMq1zLkt9828=;
        b=ZhJ6sqFUlvj9frMAoYZxikxGk3Q6CehHbnrK74LwHhfiV8RFlzQnWPQ+FruDtWh1zN
         IbdZbVKPN8yFJy5Q/Mp4+O/mo9jJ6ZiH9LzSpmh65Wb3Uhzf/rvK/MCav9lCloO3LStz
         RCbUiDKF7n+vV9Ft4jnhMiDwUrO1TW1O6FJccU4E5moe7pVyyArirp6alfZFbNA1pr25
         iI32Vd8WHl0uuNaE5RwWCLMfW2Y35KwKzCik5Z/oSBhlWDTgXKVV9CAQP7rpaRBr+J4c
         BgRgpoXQ9VqjY7oWTMkAXwFxCTO83eWl7ZNbc4K2poNLkHm38e94q/WSa6pvG81Xci9u
         yp8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B44022DBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3.18 11/25] virtio: add ability to iterate over vqs
Date: Mon, 30 Apr 2018 12:23:18 -0700
Message-Id: <20180430183911.285094449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200278542184373?=
X-GMAIL-MSGID: =?utf-8?q?1599200278542184373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 24a7e4d20783c0514850f24a5c41ede46ab058f0 upstream.

For cleanup it's helpful to be able to simply scan all vqs and discard
all data. Add an iterator to do that.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/virtio.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -122,6 +122,9 @@ int virtio_device_freeze(struct virtio_d
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 
+#define virtio_device_for_each_vq(vdev, vq) \
+	list_for_each_entry(vq, &vdev->vqs, list)
+
 /**
  * virtio_driver - operations for a virtio I/O driver
  * @driver: underlying device driver (populate name and owner).
