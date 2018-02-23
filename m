Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226cWzgEOVnDJENaFxUgg5/aECkYllHunwCqBKT2q7AiDjGfQMc3OcJqXt4U2kMmTstgWDt8
ARC-Seal: i=1; a=rsa-sha256; t=1519412284; cv=none;
        d=google.com; s=arc-20160816;
        b=Swe7WP0pKpjqhzy85swpe+yCyDvk61B05suDXBNeMCde5J8NQWYv1Q7EODLiz6+kzz
         MCjJ9CrW3aVIIX7ZwqMyab3TZxfztTaR/BMN95v1PHObLoQbDHAPrnNGwQZNoh7vPsoh
         wIrP5q9s75PjeoS9QwWWk0SLmF/yPvRf3IuQYi2NF2CSfnA1aAp210oKYui9kWj+WsCA
         Km7TM30TU2O5fKt2AqDt6ZCWqqfkUrJeocAxFN+XAwJwQ0zkGbtsW8r8hcRiEi9oW+ug
         aN/UeE3xJEynq2DZijNJG36MjWElVXOo0zx40xlAevNsZJN6IL/GRnrfmrfGvnNqPX74
         Vq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lLmyjGkZ2Xi1g8eGi/E2ELJRbSWfOf2eEMLCkF8tziw=;
        b=nLSJTpAt916M9o7Aecm+48VrAGw3YAZk6hqWyycJaePgnxvok4X8rzBhaDbTGpbmjI
         jiFinf3JsXsLx2zuS9qZ+6G3MGmzef9h8E5ko4QqhWcgGDfUbRNFXJpfEPyXI0kjFh/C
         byTWVCj1IvbgDYMrBtUOInNbCqZaOLRAICVQwlNWkz0NYb/5u0EhElIUfTdPHvc/uoKH
         Pd93nY57CG2lAwvf5x2Vqv0LO0l4zzYio0mdTCPwODlHvYi8obF6LfrsWf1rwDsqg8or
         23FODZjC6t1wwlWIJai8+uGCjUTc3iMa5V0e1EmVK2DgsyZxzi5GHWfg/dviCLQzo924
         YBfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 06/45] media: pvrusb2: properly check endpoint types
Date: Fri, 23 Feb 2018 19:28:45 +0100
Message-Id: <20180223170716.269633850@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218769430627889?=
X-GMAIL-MSGID: =?utf-8?q?1593219255993415605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@google.com>

commit 72c27a68a2a3f650f0dc7891ee98f02283fc11af upstream.

As syzkaller detected, pvrusb2 driver submits bulk urb withount checking
the the endpoint type is actually blunk. Add a check.

usb 1-1: BOGUS urb xfer, pipe 3 != type 1
------------[ cut here ]------------
WARNING: CPU: 1 PID: 2713 at drivers/usb/core/urb.c:449 usb_submit_urb+0xf8a/0x11d0
Modules linked in:
CPU: 1 PID: 2713 Comm: pvrusb2-context Not tainted
4.14.0-rc1-42251-gebb2c2437d80 #210
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff88006b7a18c0 task.stack: ffff880069978000
RIP: 0010:usb_submit_urb+0xf8a/0x11d0 drivers/usb/core/urb.c:448
RSP: 0018:ffff88006997f990 EFLAGS: 00010286
RAX: 0000000000000029 RBX: ffff880063661900 RCX: 0000000000000000
RDX: 0000000000000029 RSI: ffffffff86876d60 RDI: ffffed000d32ff24
RBP: ffff88006997fa90 R08: 1ffff1000d32fdca R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1000d32ff39
R13: 0000000000000001 R14: 0000000000000003 R15: ffff880068bbed68
FS:  0000000000000000(0000) GS:ffff88006c600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001032000 CR3: 000000006a0ff000 CR4: 00000000000006f0
Call Trace:
 pvr2_send_request_ex+0xa57/0x1d80 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3645
 pvr2_hdw_check_firmware drivers/media/usb/pvrusb2/pvrusb2-hdw.c:1812
 pvr2_hdw_setup_low drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2107
 pvr2_hdw_setup drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2250
 pvr2_hdw_initialize+0x548/0x3c10 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2327
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:118
 pvr2_context_thread_func+0x361/0x8c0 drivers/media/usb/pvrusb2/pvrusb2-context.c:167
 kthread+0x3a1/0x470 kernel/kthread.c:231
 ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431
Code: 48 8b 85 30 ff ff ff 48 8d b8 98 00 00 00 e8 ee 82 89 fe 45 89
e8 44 89 f1 4c 89 fa 48 89 c6 48 c7 c7 40 c0 ea 86 e8 30 1b dc fc <0f>
ff e9 9b f7 ff ff e8 aa 95 25 fd e9 80 f7 ff ff e8 50 74 f3
---[ end trace 6919030503719da6 ]---

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -3648,6 +3648,12 @@ static int pvr2_send_request_ex(struct p
 				  hdw);
 		hdw->ctl_write_urb->actual_length = 0;
 		hdw->ctl_write_pend_flag = !0;
+		if (usb_urb_ep_type_check(hdw->ctl_write_urb)) {
+			pvr2_trace(
+				PVR2_TRACE_ERROR_LEGS,
+				"Invalid write control endpoint");
+			return -EINVAL;
+		}
 		status = usb_submit_urb(hdw->ctl_write_urb,GFP_KERNEL);
 		if (status < 0) {
 			pvr2_trace(PVR2_TRACE_ERROR_LEGS,
@@ -3672,6 +3678,12 @@ status);
 				  hdw);
 		hdw->ctl_read_urb->actual_length = 0;
 		hdw->ctl_read_pend_flag = !0;
+		if (usb_urb_ep_type_check(hdw->ctl_read_urb)) {
+			pvr2_trace(
+				PVR2_TRACE_ERROR_LEGS,
+				"Invalid read control endpoint");
+			return -EINVAL;
+		}
 		status = usb_submit_urb(hdw->ctl_read_urb,GFP_KERNEL);
 		if (status < 0) {
 			pvr2_trace(PVR2_TRACE_ERROR_LEGS,
