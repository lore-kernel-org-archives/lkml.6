Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpnYPF9qtSTcCI3oz8kQ9F1gm7ZcoBOrDpaJ11tm9xlKniScI5RmyTwi7exp+4bPcuzXflr
ARC-Seal: i=1; a=rsa-sha256; t=1525116380; cv=none;
        d=google.com; s=arc-20160816;
        b=j3aKuU5unWayICovYtIlUQmCOKToGtwjN9VuqsqqVKOEQRcpEW+zeylfe6psDq3GLO
         AENk9mSRHbAo13AMXVmAzvdAib2LsQ/LnTmaiXU6RsGBtJwFdStpSVL1uGua5oT1Ea5l
         lpkS6W/LWxXbUGi6zFlgvHe55zpUor9T33JKH+IgPU3lPBQEuYFhVNXNfQUvcwLTaEeI
         LQLyWsSnJl9DCM7Nq5UsP1dXRsjnlwOKqZ36cseXMhjmlE4YYpu2oAZRb0imYdQ5HBa1
         kqOMjWYhDZ2WJJ4+RVRmoIF2rOkmHtnvQUcXOXwC4WVWMzjC36Y9X7b3OBK/AU3P5Ipq
         NPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=KIKUXR/ZdfgDzY4Cyyi/SIPMwI5mtEKTlQcvMM+MV+w=;
        b=XXJA77+R7/Dx04ogrGYIPijCrBy7quFoe8/7B/W4oBeK27mW8CFIVmtn/DyYvFZy/K
         kgVkg4n6COJBEIU+ewd6A5mLxg5xa4r7IuH/N0bk5no+g1kPA+eZoRfRTHxpdoQcwVxX
         uB6l6T7DXgZfjqeC4Nncv7JDqO2ChhlgnFu7KxIesYXA3VmWjZdvgQr310qschcpw1b0
         3c+ypjr1i5xOYMh87pPGaVmBRlJNUAD6qUn6RS+pDn9h2JLXEnQDiyc9FHVaEcV7V49M
         o0ea4whgBnAtX6uAxRUJA0YbG273UlR3+oFrjjaMcRL69bkTD7Avbg0Qk0QaX3424B7C
         G1wA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FA022DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.9 17/61] virtio: add ability to iterate over vqs
Date: Mon, 30 Apr 2018 12:24:20 -0700
Message-Id: <20180430183952.653413630@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200278542184373?=
X-GMAIL-MSGID: =?utf-8?q?1599200433931659215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -143,6 +143,9 @@ int virtio_device_freeze(struct virtio_d
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 
+#define virtio_device_for_each_vq(vdev, vq) \
+	list_for_each_entry(vq, &vdev->vqs, list)
+
 /**
  * virtio_driver - operations for a virtio I/O driver
  * @driver: underlying device driver (populate name and owner).
