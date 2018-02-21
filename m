Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Y+9UdYvF2xo4qc3jBAX8McZlt07gINL7gU5QGpOnz3e37fDhYw2LZJTZ7xkacPP5d01vJ
ARC-Seal: i=1; a=rsa-sha256; t=1519218385; cv=none;
        d=google.com; s=arc-20160816;
        b=ahroB6osOLH+96eU94HNULFB/JCq46FAWRYzIml0y9AJBYDs3DRk+JWX9ZdBaC+bFr
         HNiKu5uaKBUqvCYCUGkFAjQl0xLfKUTQA8KY4I0b6lVwlb5fudH+7YibVmPLIl8Z1FOs
         LQin6e2pb4h7TK14XQUfpIgq+Cj3nbu7tQRx3g0ZDdwYOWAO3xu5Umb1xsMsXG7KD74W
         EPX6udYsm5sKh8in5uxx3YLG+mkv6LH1odiWOMW/r8CHf/wiE4V76znfcTbjvo0fUwuI
         GSS/UTg3yDjR2sA52yBPoV5q5oaYS3hYQVlt3LypKeGLJKpepWausaDMNaSGet7hJq/L
         xOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Eovgu+mKMmTpLJN6JyfK+GALL5Yc44JUAIhk2zqBYY0=;
        b=gSJzg7tan9ePmhicBHWi9Ccflx8Do04gGiKmgS8UJZyugNzDZsQ0F4eYdm3A3ePSFU
         OlzuZE6MAKtOoCQe+BD8132wrXr2u3Kk2MMNFn2QfbMyKbj3H5URbG8bQJ/2zQHmcZH3
         8H5BYl23GSwgb0tmgvc0VhZENZpqw8zg4xt/AmO8GLVCQeb/EcdaQRhAKg7FMeWQV+vb
         T2prJ6rkRXIXoHY5X5fj7UvOpxaLAGnaip2G2TE7ANCwMKypkNkzZlFM5MAN6tIbe7cv
         6plNj/Six8CSUyWRmHSl8pRWhCJoCqPKPD9twypG4N1NE1a8C9ZHWJG7nP6Y12aeI2Gi
         Wc3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 005/163] IB/core: Fix two kernel warnings triggered by rxe registration
Date: Wed, 21 Feb 2018 13:47:14 +0100
Message-Id: <20180221124530.260315131@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015479048169875?=
X-GMAIL-MSGID: =?utf-8?q?1593015938211079050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 02ee9da347873699603d9ce0112a80b5dd69dea1 upstream.

Eliminate the WARN_ONs that create following two warnings when
registering an rxe device:

WARNING: CPU: 2 PID: 1005 at drivers/infiniband/core/device.c:449 ib_register_device+0x591/0x640 [ib_core]
CPU: 2 PID: 1005 Comm: run_tests Not tainted 4.15.0-rc4-dbg+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
RIP: 0010:ib_register_device+0x591/0x640 [ib_core]
Call Trace:
 rxe_register_device+0x3c6/0x470 [rdma_rxe]
 rxe_add+0x543/0x5e0 [rdma_rxe]
 rxe_net_add+0x37/0xb0 [rdma_rxe]
 rxe_param_set_add+0x5a/0x120 [rdma_rxe]
 param_attr_store+0x5e/0xc0
 module_attr_store+0x19/0x30
 sysfs_kf_write+0x3d/0x50
 kernfs_fop_write+0x116/0x1a0
 __vfs_write+0x23/0x120
 vfs_write+0xbe/0x1b0
 SyS_write+0x44/0xa0
 entry_SYSCALL_64_fastpath+0x23/0x9a

WARNING: CPU: 2 PID: 1005 at drivers/infiniband/core/sysfs.c:1279 ib_device_register_sysfs+0x11d/0x160 [ib_core]
CPU: 2 PID: 1005 Comm: run_tests Tainted: G        W        4.15.0-rc4-dbg+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
RIP: 0010:ib_device_register_sysfs+0x11d/0x160 [ib_core]
Call Trace:
 ib_register_device+0x3f7/0x640 [ib_core]
 rxe_register_device+0x3c6/0x470 [rdma_rxe]
 rxe_add+0x543/0x5e0 [rdma_rxe]
 rxe_net_add+0x37/0xb0 [rdma_rxe]
 rxe_param_set_add+0x5a/0x120 [rdma_rxe]
 param_attr_store+0x5e/0xc0
 module_attr_store+0x19/0x30
 sysfs_kf_write+0x3d/0x50
 kernfs_fop_write+0x116/0x1a0
 __vfs_write+0x23/0x120
 vfs_write+0xbe/0x1b0
 SyS_write+0x44/0xa0
 entry_SYSCALL_64_fastpath+0x23/0x9a

The code should accept either a parent pointer or a fully specified DMA
specification without producing warnings.

Fixes: 99db9494035f ("IB/core: Remove ib_device.dma_device")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/device.c |   20 ++++++++++++++------
 drivers/infiniband/core/sysfs.c  |    1 -
 2 files changed, 14 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -462,7 +462,6 @@ int ib_register_device(struct ib_device
 	struct ib_udata uhw = {.outlen = 0, .inlen = 0};
 	struct device *parent = device->dev.parent;
 
-	WARN_ON_ONCE(!parent);
 	WARN_ON_ONCE(device->dma_device);
 	if (device->dev.dma_ops) {
 		/*
@@ -471,16 +470,25 @@ int ib_register_device(struct ib_device
 		 * into device->dev.
 		 */
 		device->dma_device = &device->dev;
-		if (!device->dev.dma_mask)
-			device->dev.dma_mask = parent->dma_mask;
-		if (!device->dev.coherent_dma_mask)
-			device->dev.coherent_dma_mask =
-				parent->coherent_dma_mask;
+		if (!device->dev.dma_mask) {
+			if (parent)
+				device->dev.dma_mask = parent->dma_mask;
+			else
+				WARN_ON_ONCE(true);
+		}
+		if (!device->dev.coherent_dma_mask) {
+			if (parent)
+				device->dev.coherent_dma_mask =
+					parent->coherent_dma_mask;
+			else
+				WARN_ON_ONCE(true);
+		}
 	} else {
 		/*
 		 * The caller did not provide custom DMA operations. Use the
 		 * DMA mapping operations of the parent device.
 		 */
+		WARN_ON_ONCE(!parent);
 		device->dma_device = parent;
 	}
 
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1276,7 +1276,6 @@ int ib_device_register_sysfs(struct ib_d
 	int ret;
 	int i;
 
-	WARN_ON_ONCE(!device->dev.parent);
 	ret = dev_set_name(class_dev, "%s", device->name);
 	if (ret)
 		return ret;
