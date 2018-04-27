Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrhSPOX7QvJWmviYFhEozYl+ZGYwY3rcU5hr3kc+xTS9W04C3rH+opzcAj9tWZ0EW91xwqt
ARC-Seal: i=1; a=rsa-sha256; t=1524838316; cv=none;
        d=google.com; s=arc-20160816;
        b=cZJ2jESbt2c9LvGGU6rGVxbOUR2YDUKlM8wS7TwDeJKs7pY7hUjA+tOA+ecJ2rd1KD
         L7JldsaCwclJZyKFN1/9sv/SoKYY3pjQxUjJ6LPVCWs9CuetKR525z4jYhtCXrVXVivK
         mxo5ukzHvbN1AsLDY8BgyF+dEWThw4Iz162UjdzpC0WIkcde9sY7pnwR2NhmMXKKCKBb
         P8k05AriR9GiTAE2lAZzBd6PhpNKHEUBWgZJg+GMc57/lWx1wPeKR42uFns0A+WgTrlV
         l21j6zot+X3b2IVqoF0dnz7gV1ZSVjVeDRp4VFxDAlGsWu+SdeiPE1qyXPyjqrNeV1+P
         hZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=p3KE5V0K+TlT2cYF0ADCVKLohmBTV4CPBYAZwvLmr/o=;
        b=vz5OlHa+3cz055buX/iRFp0Xwn4FfJrfKb4P9xHX55qZL/jQ1vZmMKttxov0j9RBzr
         JJeTFSpqAAeHMlemxhQEKSOrGmL/kr5yfMPsomDXSQy2NY2VGNvMXPHCMW5v9S2TFCJN
         lmG8ozgmw72zxBwEjtjeLRPEKy0yUz/+Ro7lt4UnC6TiPxkD4Q6Dl6qEZYTtfcQSobE0
         aenik+6AhyV5QdZWaleH1ueoBkJdCFMOaL54Lvy8v2/sNd7rWsytgAxsk31gHrdosNgd
         hgMrbIf72XzJddFS3WxuisP7/bdFYDOMWYBPyq1ofl93q48V0S8UwzAqweunvZA/18Dn
         uYjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9057321864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 59/81] virtio_net: fix adding vids on big-endian
Date: Fri, 27 Apr 2018 15:59:01 +0200
Message-Id: <20180427135746.822234626@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908672094030669?=
X-GMAIL-MSGID: =?utf-8?q?1598908862245897917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Michael S. Tsirkin" <mst@redhat.com>


[ Upstream commit d7fad4c840f33a6bd333dd7fbb3006edbcf0017a ]

Programming vids (adding or removing them) still passes
guest-endian values in the DMA buffer. That's wrong
if guest is big-endian and when virtio 1 is enabled.

Note: this is on top of a previous patch:
	virtio_net: split out ctrl buffer

Fixes: 9465a7a6f ("virtio_net: enable v1.0 support")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -154,7 +154,7 @@ struct control_buf {
 	struct virtio_net_ctrl_mq mq;
 	u8 promisc;
 	u8 allmulti;
-	u16 vid;
+	__virtio16 vid;
 	u64 offloads;
 };
 
@@ -1725,7 +1725,7 @@ static int virtnet_vlan_rx_add_vid(struc
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl->vid = vid;
+	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
@@ -1740,7 +1740,7 @@ static int virtnet_vlan_rx_kill_vid(stru
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl->vid = vid;
+	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
