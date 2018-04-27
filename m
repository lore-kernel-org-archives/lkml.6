Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrYsKv+IS8oSAWB+Y+J0XYdC9jZN1SSudu0hAjpQUXWDh1908bXtHow0TgInfk3R6vuC4kC
ARC-Seal: i=1; a=rsa-sha256; t=1524838135; cv=none;
        d=google.com; s=arc-20160816;
        b=OKeglv+w4c3pzfEhwrS2KxIVwu3s7PJlh+mCde4/LTg0gRf51ZXduhzEN2fHK2Ngii
         hsZEMzUACHl8KB0Me0Pz6LfS7MGrHdz4GgLK6Nnw3N2QVIE9+inXtdqEI8g7Rz+LnYLP
         N0wMfvX5T32S7pr4FoUMvOZMr8u0DgH6WL8E3LVBiWravkBimQQE+Yg10bSsrxFcCC8x
         5DC1tFbzhsQbO88tNIApZWGZyYOKEG2nRO5LHuKBJyFekbWPnQ8W3Gow8QDBTluUfJvm
         ZlPG6yDIRAd9oAAmb2FozZViHwrFzvnIscZ23075jlEnrMKM3K7rLhoVVAw4QDdEfydf
         g23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=UpA72rH1ALA4jfnlEqgU3RTsM7upV8eKOvd/NoBFtsA=;
        b=DWQnWR46JlwZP6qGJYMAQ8/LEPJa+6DImhjBbwNdGHNVIoTU5MGat66+kHEp2RBWhj
         vgQtTjO9xIDC5cB/tZnMOe1onwsWqRrni+jP7Fwt4NuSsdpN+EZdeoNxGHymb6VaishV
         dpIN393V/7wavfSd4GraFa2I7ApKGtm/QCOKM29ikCY1UkY6EYLN435dOHxw8O4wiygc
         rZf+MdnyrJJSF0nIWHm4OJ3A6tB6qHXWDt3PaTh0I9E4fTWy4jJ4ixA89yHQ39J5CW1t
         LYTqLkT1epf2A8FUCE7WaBwwspVye+zHish+TXZUh/s6o+qFn+cSYp4pmc0JxiXm//Tb
         sNEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AEA21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 40/80] virtio_net: fix adding vids on big-endian
Date: Fri, 27 Apr 2018 15:58:33 +0200
Message-Id: <20180427135734.984034440@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908672094030669?=
X-GMAIL-MSGID: =?utf-8?q?1598908672094030669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -123,7 +123,7 @@ struct control_buf {
 	struct virtio_net_ctrl_mq mq;
 	u8 promisc;
 	u8 allmulti;
-	u16 vid;
+	__virtio16 vid;
 	u64 offloads;
 };
 
@@ -1602,7 +1602,7 @@ static int virtnet_vlan_rx_add_vid(struc
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl->vid = vid;
+	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
@@ -1617,7 +1617,7 @@ static int virtnet_vlan_rx_kill_vid(stru
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl->vid = vid;
+	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
