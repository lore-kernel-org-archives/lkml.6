Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqSEiraSp+3GMC3ndNdM7uBZOL6XDgDWFLF+7HS7EaTEymW+aBSaRoePMfPYTecwK/7bOXz
ARC-Seal: i=1; a=rsa-sha256; t=1525116346; cv=none;
        d=google.com; s=arc-20160816;
        b=OKDX39qZXMQ37aiwAkw9t9golHBYnwkRr5n9/lrBIgF/QUA45oz1oIL2S3ZZ9s/7pH
         IvihDTVHXDa2w7Fd3zwRn6BXGhl2CZPvsuRyExp9/9B9T+Lz1Zr67b2p2fK64olHQzYK
         +8BFziAmQYEMXfQTylIo0WmHeCkMSPpD1afzB4a7nJVeAJ2WHwrMd1JZN+p7ijgZ11Uw
         fSBm9k8x5NwNM52tizOQLDoZL87iSwB7t25IWRXNi+3KSYrhx3cQkihg86ly3WbjeI7F
         Y7I0bEu+8e3fa07ZMMpe369tQHjlHcEksFvnd16FjJAFxlARxvdMjF+ILpUMIOFqoQwI
         OVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qmtnGdj7beFgh8VlYDHfxlSvMOVG6Ra7EKR/Ql+9a+c=;
        b=YfliD8SX8Ed8CxDlVnSUHfLZTMBOneKNXOLdvlnH4UHOl+FTqshD8PAxCO7GaNMDNx
         wpHD7pjl/A+OTxyD1BC+ZDYUeYJovpNHj34EHyWS9JL25NePGKnxANbWsi/lgRKDMBlD
         TCLhn1Nj+SBh9dL4FI8M7p4qhoNNRnYurEoVY5TDiXbqAM1A0gRF8Et3bH1u43YtGwIK
         aVVL4hF3+Hib28avw9zHIgZqSYW5WIs2m7bNToTqyZCQSVVG13PYd8zi27kICwP/fGtE
         K29ub7xAKbNP55TxjdxotPl2zEobROlzImvPKchHcMq4B++2QJXVUlkQtxsMUEHVvUli
         HMww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E6F21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.4 13/44] virtio: add ability to iterate over vqs
Date: Mon, 30 Apr 2018 12:24:24 -0700
Message-Id: <20180430190946.877993030@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200278542184373?=
X-GMAIL-MSGID: =?utf-8?q?1599200398866966511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -124,6 +124,9 @@ int virtio_device_freeze(struct virtio_d
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 
+#define virtio_device_for_each_vq(vdev, vq) \
+	list_for_each_entry(vq, &vdev->vqs, list)
+
 /**
  * virtio_driver - operations for a virtio I/O driver
  * @driver: underlying device driver (populate name and owner).
