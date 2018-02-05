Return-Path: <william.wu@rock-chips.com>
X-Google-Smtp-Source: AH8x224MjTZeTUenmM0gNsq0j+gfsc1PgqAvf/Uy3Px7p1WMQ17Yb4CZmtlGUsi2jB8FtQem1/8Q
ARC-Seal: i=1; a=rsa-sha256; t=1517830515; cv=none;
        d=google.com; s=arc-20160816;
        b=qTRGlapWx39prNAoy61yzhcjnQrQRayOjdMZRglps0ArIzyGvES2E59zsx9WOsSCuH
         oqUh0bcOj9IjDMFaA4mPKaYratW265ZyI5fPWaJSPXOR0iXkT+yo5JL5fv4S+DsDk+5r
         5FBEUO63d9qVuQOiJW92zynLep8mWyVh3edrLogm96x95pXsZCWyzVoXQYg2XO+UgXYt
         3QagO0/fhqQlOWz5hBgql+I/e40szKLL1NELULN9kmgWrthgRVhz8Udj15kiKOQY+M+J
         YcyI687wzb0l8sEelu5wHtvWvhifqqcP8gtQOJuujAWjJxhed2zLd6L5QaR5TE3TxO9u
         R/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=+UYfe7aJZ2fUusMqxZ4Q4meiXl9jw7oe5eQjcmnJzSg=;
        b=RlX5NC8fbfPdOT/ChDaXkXE8UIKTwTBwMUDicbN/Gat+bMMGg6p9RwAjQa+HvzZCZD
         7RmcLnpJcbfPf5+Lzs9aQm7YboFD4Tryf4i+LvOJiOq2O9JNPvkdX3DyPdOZ7cp7bAIt
         YJ3XsWGqnoZtbCRCeSxHKhLMLNx3haXm1mjEUgC4hEEpQOuj9G6KyS9tw5a8yisssrY+
         xrndK2v/hE+FjcdPpU/RJnlrxYMEN2rRPf07C8f1DSRuu+7oE4jF/FH2DJFCXTjTycAE
         1Vj9kQPERhMKomYmwRvVwstZO1I2GV/e9hNmu2a/tg46hIMHVn4FXpPQn2yl/OmHj9Td
         w0iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of william.wu@rock-chips.com designates 211.150.80.17 as permitted sender) smtp.mailfrom=william.wu@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of william.wu@rock-chips.com designates 211.150.80.17 as permitted sender) smtp.mailfrom=william.wu@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <a17e057ec68785e625566dee0e70e0b0>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: gregkh@linuxfoundation.org,
	felipe.balbi@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	frank.wang@rock-chips.com,
	huangtao@rock-chips.com,
	daniel.meng@rock-chips.com,
	william.wu@rock-chips.com,
	fml@rock-chips.com
Subject: [PATCH] usb: gadget: f_fs: get the correct address of comp_desc
Date: Mon,  5 Feb 2018 19:33:38 +0800
Message-Id: <1517830418-2648-1-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591560649991441165?=
X-GMAIL-MSGID: =?utf-8?q?1591560649991441165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Refer to the USB 3.0 spec '9.6.7 SuperSpeed Endpoint Companion',
the companion descriptor follows the standard endpoint descriptor.
This descriptor is only defined for SuperSpeed endpoints. The
f_fs driver gets the address of the companion descriptor via
'ds + USB_DT_ENDPOINT_SIZE', and actually, the ds variable is
a pointer to the struct usb_endpoint_descriptor, so the offset
of the companion descriptor which we get is USB_DT_ENDPOINT_SIZE *
sizeof(struct usb_endpoint_descriptor), the wrong offset is 63
bytes. This cause out-of-bound with the following error log if
CONFIG_KASAN and CONFIG_SLUB_DEBUG is enabled on Rockchip RK3399
Evaluation Board.

android_work: sent uevent USB_STATE=CONNECTED
configfs-gadget gadget: super-speed config #1: b
==================================================================
BUG: KASAN: slab-out-of-bounds in ffs_func_set_alt+0x230/0x398
Read of size 1 at addr ffffffc0ce2d0b10 by task irq/224-dwc3/364

CPU: 4 PID: 364 Comm: irq/224-dwc3 Not tainted 4.4.112 #6
Hardware name: Rockchip RK3399 Evaluation Board v3 (Android) (DT)
Call trace:
[<ffffff900808c4a4>] dump_backtrace+0x0/0x244
[<ffffff900808c6fc>] show_stack+0x14/0x1c
[<ffffff90084f0ff4>] dump_stack+0xa4/0xcc
[<ffffff900822d054>] print_address_description+0xa4/0x308
[<ffffff900822d5bc>] kasan_report+0x258/0x29c
[<ffffff900822bb28>] __asan_load1+0x44/0x4c
[<ffffff9008b6eec4>] ffs_func_set_alt+0x230/0x398
[<ffffff9008b56e5c>] composite_setup+0xdcc/0x1ac8
[<ffffff9008b5aaa4>] android_setup+0x124/0x1a0
[<ffffff9008aa22b4>] dwc3_ep0_delegate_req+0x48/0x68
[<ffffff9008aa3248>] dwc3_ep0_interrupt+0x758/0x1174
[<ffffff9008a9f688>] dwc3_thread_interrupt+0x204/0xe68
[<ffffff9008126c04>] irq_thread_fn+0x44/0x94
[<ffffff9008126e44>] irq_thread+0x128/0x22c
[<ffffff90080d39c4>] kthread+0x11c/0x130
[<ffffff90080832a0>] ret_from_fork+0x10/0x30

Allocated by task 1:
[<ffffff900808bf0c>] save_stack_trace_tsk+0x0/0x134
[<ffffff900808c054>] save_stack_trace+0x14/0x1c
[<ffffff900822c188>] kasan_kmalloc.part.3+0x48/0xf4
[<ffffff900822c3c8>] kasan_kmalloc+0x8c/0xa0
[<ffffff9008229990>] __kmalloc+0x208/0x268
[<ffffff9008b71258>] ffs_func_bind+0x4b4/0x918
[<ffffff9008b55168>] usb_add_function+0xd8/0x1d4
[<ffffff9008b5b204>] configfs_composite_bind+0x48c/0x570
[<ffffff9008b5dc80>] udc_bind_to_driver+0x6c/0x170
[<ffffff9008b5de28>] usb_udc_attach_driver+0xa4/0xd0
[<ffffff9008b5c110>] gadget_dev_desc_UDC_store+0xd4/0x120
[<ffffff90082d6014>] configfs_write_file+0x1a0/0x1f8
[<ffffff9008237960>] __vfs_write+0x64/0x174
[<ffffff9008238560>] vfs_write+0xe4/0x1e8
[<ffffff90082392fc>] SyS_write+0x68/0xc8
[<ffffff90080832f0>] el0_svc_naked+0x24/0x28

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffffffc0ce2d0900
which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 528 bytes inside of
 1024-byte region [ffffffc0ce2d0900, ffffffc0ce2d0d00)
The buggy address belongs to the page:
page:ffffffbdc338b400 count:1 mapcount:-2145648611 mapping:          (null) index:0x0
flags: 0x4080(slab|head)
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffffc0ce2d0a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc0ce2d0a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffffc0ce2d0b00: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffffffc0ce2d0b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffffc0ce2d0c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Disabling lock debugging due to kernel taint
android_work: sent uevent USB_STATE=CONFIGURED

This patch adds struct usb_endpoint_descriptor * -> u8 * type conversion
for ds variable, then we can get the correct address of comp_desc
with offset USB_DT_ENDPOINT_SIZE bytes.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/gadget/function/f_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6756472..f13ead0 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1882,8 +1882,8 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 		ep->ep->desc = ds;
 
 		if (needs_comp_desc) {
-			comp_desc = (struct usb_ss_ep_comp_descriptor *)(ds +
-					USB_DT_ENDPOINT_SIZE);
+			comp_desc = (struct usb_ss_ep_comp_descriptor *)
+				     ((u8 *)ds + USB_DT_ENDPOINT_SIZE);
 			ep->ep->maxburst = comp_desc->bMaxBurst + 1;
 			ep->ep->comp_desc = comp_desc;
 		}
-- 
2.0.0
