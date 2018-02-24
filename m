Return-Path: <merlijn@wizzup.org>
X-Google-Smtp-Source: AG47ELvVBuNPLUiQpobUFnVzqqzMczZkI9q6r+bRy2E7KNchjt7D+pdoXFmgNyolj8tr5IcRidOc
ARC-Seal: i=1; a=rsa-sha256; t=1519505566; cv=none;
        d=google.com; s=arc-20160816;
        b=O+vr+pfqsyntN9GPyjtcL2TMY1wUDy7Dt3HXDM8AYR42xfWlv69BKKX+2IAnTgO7LD
         6FGry93YCvHfnTgGDJadAl7gwmpdJIkJvWVm8zKm78EZVYZJ7xMijof4Vt5qQpsLe0Y/
         oWjGahyD6g93vP/xFw8GPhOPdBH9GDx/Iip/rHfI1kIbJfJBTFkpqPFpqUoliyxIVae7
         yAh2qyfonDpfn9zNvCtEXLUsFYEmtKgyRztFHf21im/qffTvCQNCTcqEghLwBaTYMEA3
         RoWaBEx6Z01O7aIc/kYDN3zuCG8KMVaBhC+N/HskH6obpq6e8zKgGSvB/Z1VhkCmBJjy
         SAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=XzLKgbqkypEEyZiD9YPDCQEQ4AOhBnB7BTpdbfh0ij8=;
        b=ba+7BI086QGer+oEKlSb54fP9lvNDUJy6MVZSSOG5PVE9/JYvNQcR06XCRcNkocoDG
         dzh7WWbnemmHrubl0SLCGP4w97v2MRO2J1CB3G+aqcLeLPk7PoagIZzBPXoqBfN6Z31S
         CIV5di0NsOso0mDoFLDOwM8+Tw73azCqc1J8KhGXhVEXd2hLt+rvZ8o7ix+RzSM/EeAT
         5bvoGhC7jYXwphvfXOb6spyRx6u3buNsLefRENp5FceriJIvkB+wVJrH/9Onv/iKbtgr
         vntkumdIhozUz5nhyXnaLoQ/E6f186ImaBDmpIA96XeiDDV+qfdNYCtwrvGl/WLMsSTV
         ylmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 188.165.243.101 is neither permitted nor denied by best guess record for domain of merlijn@wizzup.org) smtp.mailfrom=merlijn@wizzup.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 188.165.243.101 is neither permitted nor denied by best guess record for domain of merlijn@wizzup.org) smtp.mailfrom=merlijn@wizzup.org
From: Merlijn Wajer <merlijn@wizzup.org>
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com,
	merlijn@wizzup.org,
	Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
Date: Sat, 24 Feb 2018 21:51:50 +0100
Message-Id: <20180224205151.12079-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593317068971908735?=
X-GMAIL-MSGID: =?utf-8?q?1593317068971908735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/usb/musb/musb_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index ea5013aa69e2..182611f76af3 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1760,6 +1760,8 @@ musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 	val = musb->a_wait_bcon;
 	vbus = musb_platform_get_vbus_status(musb);
 	if (vbus < 0) {
+		pm_runtime_get_sync(dev);
+
 		/* Use default MUSB method by means of DEVCTL register */
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 		if ((devctl & MUSB_DEVCTL_VBUS)
@@ -1767,6 +1769,9 @@ musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 			vbus = 1;
 		else
 			vbus = 0;
+
+		pm_runtime_put_sync(dev);
+
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-- 
2.16.2
