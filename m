Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJj+SAZxY5tKan/lT9va6Ovutu6cJ5nkmGF+5rOx4Tdx0+vtx7qFtefsnqEKb8s1kydfrU
ARC-Seal: i=1; a=rsa-sha256; t=1521483206; cv=none;
        d=google.com; s=arc-20160816;
        b=sDgPGDOCcvzjozL5D4FXJqKt180mORNXUJlsMVLF004pPAZobLrXM7HncXKICmHwD/
         qvGYG00Gtgdh81HZxM/yiYIPESwTn43K682HYOYxElZXxvoGbw90J6f6QkpSLRUe41+F
         1H3air2Jk1HfgN8Y5SUOSan+MKo2inKk3Z6cE02IrRKVPq9UNIvtLZWBoM+/7rd7qZ45
         mnNwGmxR1lXff7/lFZwj2WKD0Vl6wE6YtSQCtuJKsMWvi3JnGR2o30VR4X/6qJySY9OY
         6dPMwfOg3a44XZmzO4JJDkOF3i/XFQVbAEMoCpmfaxmkI1kkQ7Lr10SDY9bZRy8SJNZ9
         9VeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hNzUWJ+f9Zjq2t0n6CoenRVFsFmFAQa6lCkTtoSvV/Y=;
        b=EbNcFev19U1hMh0PpmkRr6uRD8/vCARTVltRA1dMXywqILQs54wT5w8Fux24YO6pbZ
         4kbDNdw4hhvr4IsHcv0gKxG8dgjGX44AwizcZksL6AoLdqpyb7uNj6KTnaUWPeSBeSbl
         xU5uYXEJHMIGnEdhkD1ABPNOTcFjDPY6Yu4BX28dG6Unlqh8LyfKW3VvRUHA7KODrefa
         bEVUw6DNEPM9Ru8hpQ29+gPGt37YRfSiNjryU8Rk2hGJJcwg4LkrMcXIJoJzbSJyvuhC
         +nHEnE3FHt8pQiwqQ5433MTPmCoLtNPO4hjZ4sdHIG8RmN4mXSgPoK8BWtr32ZESdURv
         hUYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 006/134] drm: qxl: Dont alloc fbdev if emulation is not supported
Date: Mon, 19 Mar 2018 19:04:49 +0100
Message-Id: <20180319171850.031988464@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390775258381600?=
X-GMAIL-MSGID: =?utf-8?q?1595390775258381600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>


[ Upstream commit 861078381ba56b56808113736000d9e7ead349c8 ]

If fbdev emulation is disabled, the QXL shutdown path will try to clean
a framebuffer that wasn't initialized, hitting the Oops below.  The
problem is that even when FBDEV_EMULATION is disabled we allocate the
qfbdev strutucture, but we don't initialize it.  The fix is to stop
allocating the memory, since it won't be used.  This allows the existing
verification in the cleanup hook to do it's job preventing the oops.

Now that we don't allocate the unused fbdev structure, we need to be
careful when dereferencing it in the PM suspend hook.

[   24.284684] BUG: unable to handle kernel NULL pointer dereference at 00000000000002e0
[   24.285627] IP: mutex_lock+0x18/0x30
[   24.286049] PGD 78cdf067
[   24.286050] PUD 7940f067
[   24.286344] PMD 0
[   24.286649]
[   24.287072] Oops: 0002 [#1] SMP
[   24.287422] Modules linked in: qxl
[   24.287806] CPU: 0 PID: 2328 Comm: bash Not tainted 4.10.0-rc5+ #97
[   24.288515] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
[   24.289681] task: ffff88007c4c0000 task.stack: ffffc90001b58000
[   24.290354] RIP: 0010:mutex_lock+0x18/0x30
[   24.290812] RSP: 0018:ffffc90001b5bcb0 EFLAGS: 00010246
[   24.291401] RAX: 0000000000000000 RBX: 00000000000002e0 RCX: 0000000000000000
[   24.292209] RDX: ffff88007c4c0000 RSI: 0000000000000001 RDI: 00000000000002e0
[   24.292987] RBP: ffffc90001b5bcb8 R08: fffffffffffffffe R09: 0000000000000001
[   24.293797] R10: ffff880078d80b80 R11: 0000000000011400 R12: 0000000000000000
[   24.294601] R13: 00000000000002e0 R14: ffffffffa0009c28 R15: 0000000000000060
[   24.295439] FS:  00007f30e3acbb40(0000) GS:ffff88007fc00000(0000) knlGS:0000000000000000
[   24.296364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.296997] CR2: 00000000000002e0 CR3: 0000000078c7b000 CR4: 00000000000006f0
[   24.297813] Call Trace:
[   24.298097]  drm_framebuffer_cleanup+0x1f/0x70
[   24.298612]  qxl_fbdev_fini+0x68/0x90 [qxl]
[   24.299074]  qxl_modeset_fini+0xd/0x30 [qxl]
[   24.299562]  qxl_pci_remove+0x22/0x50 [qxl]
[   24.300025]  pci_device_remove+0x34/0xb0
[   24.300507]  device_release_driver_internal+0x150/0x200
[   24.301082]  device_release_driver+0xd/0x10
[   24.301587]  unbind_store+0x108/0x150
[   24.301993]  drv_attr_store+0x20/0x30
[   24.302402]  sysfs_kf_write+0x32/0x40
[   24.302827]  kernfs_fop_write+0x108/0x190
[   24.303269]  __vfs_write+0x23/0x120
[   24.303678]  ? security_file_permission+0x36/0xb0
[   24.304193]  ? rw_verify_area+0x49/0xb0
[   24.304636]  vfs_write+0xb0/0x190
[   24.305004]  SyS_write+0x41/0xa0
[   24.305362]  entry_SYSCALL_64_fastpath+0x1a/0xa9
[   24.305887] RIP: 0033:0x7f30e31d9620
[   24.306285] RSP: 002b:00007ffc54b47e68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   24.307128] RAX: ffffffffffffffda RBX: 00007f30e3497600 RCX: 00007f30e31d9620
[   24.307928] RDX: 000000000000000d RSI: 0000000000da2008 RDI: 0000000000000001
[   24.308727] RBP: 000000000070bc60 R08: 00007f30e3498760 R09: 00007f30e3acbb40
[   24.309504] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000001
[   24.310295] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffc54b47f34
[   24.311095] Code: 0e 01 e9 7b fe ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 00
55 48 89 e5 53 48 89 fb e8 83 e8 ff ff 65 48 8b 14 25 40 c4 00 00 31 c0 <3e>
48 0f b1 13 48 85 c0 74 08 48 89 df e8 66 fd ff ff 5b 5d c3
[   24.313182] RIP: mutex_lock+0x18/0x30 RSP: ffffc90001b5bcb0
[   24.313811] CR2: 00000000000002e0
[   24.314208] ---[ end trace 29669c1593cae14b ]---

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Link: http://patchwork.freedesktop.org/patch/msgid/20170227203330.18542-1-krisman@collabora.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/qxl/qxl_fb.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -494,9 +494,11 @@ static const struct drm_fb_helper_funcs
 
 int qxl_fbdev_init(struct qxl_device *qdev)
 {
+	int ret = 0;
+
+#ifdef CONFIG_DRM_FBDEV_EMULATION
 	struct qxl_fbdev *qfbdev;
 	int bpp_sel = 32; /* TODO: parameter from somewhere? */
-	int ret;
 
 	qfbdev = kzalloc(sizeof(struct qxl_fbdev), GFP_KERNEL);
 	if (!qfbdev)
@@ -531,6 +533,8 @@ fini:
 	drm_fb_helper_fini(&qfbdev->helper);
 free:
 	kfree(qfbdev);
+#endif
+
 	return ret;
 }
 
@@ -546,6 +550,9 @@ void qxl_fbdev_fini(struct qxl_device *q
 
 void qxl_fbdev_set_suspend(struct qxl_device *qdev, int state)
 {
+	if (!qdev->mode_info.qfbdev)
+		return;
+
 	drm_fb_helper_set_suspend(&qdev->mode_info.qfbdev->helper, state);
 }
 
