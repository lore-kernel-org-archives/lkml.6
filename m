Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqc3h5JM65fN0bWNVY1oqUMMd62awUm7xhsv/1kI3Pd+/ha2RmGX9pxCBpjkRg/Yai054LP
ARC-Seal: i=1; a=rsa-sha256; t=1525116485; cv=none;
        d=google.com; s=arc-20160816;
        b=jAYmQWoLchyLl0MQFYkoeGtXM2UbiS+Sh4QVNGLOB3rWyw1qlw2jk2nyLmSvA0If3O
         COeLIXtGmjZ6FCcN8ut9RULZ3q58Q8z6QShVSkhnVajF3EAD5VYqCUwWdOoZssNF9g8N
         AkqWuaiHH127xI5BaoRbAK+J8k4hyjLYfcVENlFASTWSKjxVCWvpDgH9mC996mKX5u8l
         s45kQiImF7y6ygMWvDg97B/gg93+HuCrHEDfSEd9zgp9V6PBPVaZspzDUGiO1tHHvmQT
         RmxnVquVIFZreAdTfguu4pUAIxs+7lo4oxndSvKvTIThj+JzuDpfbcy8KtueeneurK1C
         OtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=uEviXIEgEG6jcyycmsGEGgH2r7VKFIhoKcYQhefil7E=;
        b=RRKX416m3DJYycgprXaPyNhWF0QbSsGBvhvpk957GjmyvxXEaxTwrch4cYnrGKsAMD
         RpaEZS6vDUCwYdV3pgYNuNr5w7b6rJWzI21GwlhgeIGUtOfeySvZRptdyjPfi+O7QPrw
         IxBsAhx4rci6BRmJUp1Ni42mHrHxNDUzwdDv2q5qxrZ4ZGldTNPamlHfXZJFrdvHhxsD
         XIIsKd3M/MCo31hIJO5P88eQhcS9tQaWBRNqo8gb+S+a57QMM0ipvEmL46d0HA0mwaSr
         M3YACXIK+x7ybDnAwPUbgT+EGEzcr0Krin7UOKUTlA6knYXYNnyzs9gpLB8nk6CcJYDh
         hzjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6541E22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.16 029/113] virtio_console: reset on out of memory
Date: Mon, 30 Apr 2018 12:24:00 -0700
Message-Id: <20180430184016.306577052@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200493836963780?=
X-GMAIL-MSGID: =?utf-8?q?1599200544530136853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 5c60300d68da32ca77f7f978039dc72bfc78b06b upstream.

When out of memory and we can't add ctrl vq buffers,
probe fails. Unfortunately the error handling is
out of spec: it calls del_vqs without bothering
to reset the device first.

To fix, call the full cleanup function in this case.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/virtio_console.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2090,6 +2090,7 @@ static int virtcons_probe(struct virtio_
 
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
+	INIT_LIST_HEAD(&portdev->list);
 
 	virtio_device_ready(portdev->vdev);
 
@@ -2107,8 +2108,15 @@ static int virtcons_probe(struct virtio_
 		if (!nr_added_bufs) {
 			dev_err(&vdev->dev,
 				"Error allocating buffers for control queue\n");
-			err = -ENOMEM;
-			goto free_vqs;
+			/*
+			 * The host might want to notify mgmt sw about device
+			 * add failure.
+			 */
+			__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+					   VIRTIO_CONSOLE_DEVICE_READY, 0);
+			/* Device was functional: we need full cleanup. */
+			virtcons_remove(vdev);
+			return -ENOMEM;
 		}
 	} else {
 		/*
@@ -2139,11 +2147,6 @@ static int virtcons_probe(struct virtio_
 
 	return 0;
 
-free_vqs:
-	/* The host might want to notify mgmt sw about device add failure */
-	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
-			   VIRTIO_CONSOLE_DEVICE_READY, 0);
-	remove_vqs(portdev);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
