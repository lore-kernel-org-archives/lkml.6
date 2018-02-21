Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2248goOLpvXCIFoD2yl87SUGUNXzii/37OSFNl/nuJJCEAGuy9sckIL5ZPvxh24MpGveyr2r
ARC-Seal: i=1; a=rsa-sha256; t=1519217947; cv=none;
        d=google.com; s=arc-20160816;
        b=TmvRjCHyzfnDAIFs5PMqjh+6dK07dwSPcHLaGjWZhv3Y6pt5YTpZxbTv3TMCa84Yud
         l73NKVKxqyRGS94427GQ2Bc6w8N7KywsJoyEWIWVqnglru1z7pFPaWt4Hr+4xZ40iw3a
         yfaCXPhO3/C1K1Xhgkrw8Bd7wjMJRrHyPmwolrymp1QlOqInFW++7I7DMaKXI2CHucEh
         54HMrVhBMfpGiuIGzr6/uLx6qvQdZwo32JVkTP6/53flwUncgr2dc9qS6QgxIgjLme3d
         z+cIqnNUWY3zl3GCeIOF4BZvtEI5qkHB7OouTKtBbwfM7wmfOOZse44h9LlljtXqjMS7
         Widg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AxoKYY8xBb9S9RlkrS8pZb3msP7Dx4hwi54jW05z6Uw=;
        b=y3I6MNZzn/2R/PHtts2ll4sBsNfFf0l03RPQ2Cel+X9syyQj0+hH0RMtMAgSRanOsq
         ftw+Uyiu2N3/++UyfT+0SgwgAJ2JmXa3cdNV41fBpK3fDNu4+DiwVu4uRJd5Y2uTB8lz
         GEBcoZMeD+akzG1Rb1QDlE5uuDMpaoSbndhnGi7paY5dGSWe+thIbtNcEebtg6qr06YP
         07WbdMp9fBNm7KdF5kg8qx4+NnoPe3RUJqBZ6v/yANY5f5/Lpi9PkRejOOwMtuVICQhr
         /Sqo3QGZ/K1n4Fji4NCU3ublHk4TQ3Yum8uAJFksOsGsSQnCpsyAwZu9qeEtsD2PwpDq
         /9Jw==
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
Subject: [PATCH 4.14 006/167] IB/core: Fix two kernel warnings triggered by rxe registration
Date: Wed, 21 Feb 2018 13:46:57 +0100
Message-Id: <20180221124524.979876308@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015479048169875?=
X-GMAIL-MSGID: =?utf-8?q?1593015479048169875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -446,7 +446,6 @@ int ib_register_device(struct ib_device
 	struct ib_udata uhw = {.outlen = 0, .inlen = 0};
 	struct device *parent = device->dev.parent;
 
-	WARN_ON_ONCE(!parent);
 	WARN_ON_ONCE(device->dma_device);
 	if (device->dev.dma_ops) {
 		/*
@@ -455,16 +454,25 @@ int ib_register_device(struct ib_device
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
@@ -1262,7 +1262,6 @@ int ib_device_register_sysfs(struct ib_d
 	int ret;
 	int i;
 
-	WARN_ON_ONCE(!device->dev.parent);
 	ret = dev_set_name(class_dev, "%s", device->name);
 	if (ret)
 		return ret;
