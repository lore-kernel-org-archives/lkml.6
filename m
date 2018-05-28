Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034358AbeE1P3s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032857AbeE1KTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:19:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 126/268] usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
Date: Mon, 28 May 2018 12:01:40 +0200
Message-Id: <20180528100216.382360273@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Merlijn Wajer <merlijn@wizzup.org>

[ Upstream commit df6b074dbe248d8c43a82131e8fd429e401841a5 ]

Without pm_runtime_{get,put}_sync calls in place, reading
vbus status via /sys causes the following error:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
pgd = b333e822
[fa0ab060] *pgd=48011452(bad)

[<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
[<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
[<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
[<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
[<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
[<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
[<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
[<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)

Solution was suggested by Tony Lindgren <tony@atomide.com>.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/musb/musb_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1775,6 +1775,7 @@ musb_vbus_show(struct device *dev, struc
 	int		vbus;
 	u8		devctl;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	val = musb->a_wait_bcon;
 	vbus = musb_platform_get_vbus_status(musb);
@@ -1788,6 +1789,7 @@ musb_vbus_show(struct device *dev, struc
 			vbus = 0;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return sprintf(buf, "Vbus %s, timeout %lu msec\n",
 			vbus ? "on" : "off", val);
