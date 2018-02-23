Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226CHnuk0npFnps7I1nRoDNHfdx6lQRwZymGayIVL/49uwlpQoOBye06fi8zJNwgxX9DuYoe
ARC-Seal: i=1; a=rsa-sha256; t=1519411820; cv=none;
        d=google.com; s=arc-20160816;
        b=KBxu6TCXv4wvGy0IHudDcWeZ3MWxJx6xrnN7VEt6dIQhhGQ36+D+BCO5n36Q1a3kVk
         qxKeSpgTRc8FErnPuiSw7sBtJuZL8Dap2dwRrhcLXwnjCWVH981JWghQl903qnOVb7Xy
         XMyFQqoGrM61yzQbKRZ3GUAlsjpmTa7kl9GhA6M/TuQ0ZhqaahM0byuGoi7Zoa3Magl/
         QDGVcOv7ASqry0qBGDCBAuiWkTTcj2wS1YAz8mTcrztaCIL+ZknCVDXH1RgnFCNwbT1k
         ru3IkZpfmLTuATZlUGGrC5gfKdwchsLwoN1HwzB1aT7zHSO8Y5Auzgb8pbXHYGqtxfQB
         D7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eNtW0hTmRBw98vzDVcop4QJA9RPx5p5NUxXukg3wX1M=;
        b=bwhpYzOqvFgJlvIg4c8L0N9bx6bsBg8Lv8qo95DqLMbWOfgVD0MlthJ/8PwnJNvHCx
         DAYe4t+8oKgaXTdL+Qvq9d4qQCjo2VRKuHx0zZnoc+Bmut9tvLMxRspgS+dC+tzfbnag
         yG+p2zE9EZy5xhUwypSv1WfEOvDKUuwlytSWtnbmNk6Q1FWkIT95Zd6ft3VkUyDv20c5
         yNynMRoFC3oJZr30PY3QDfJhw2ZFZY/JfvVTvNfCInY8fbW4j0/NZijsjvxWPbl+iS0c
         EuIvFnjHQowecqpMGjEknKGD8Dnw7OuR4XUFrOu9w4I74Hzbspw0Ofqwvp6UEEZ+aj3l
         VdVw==
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
Subject: [PATCH 4.14 028/159] media: pvrusb2: properly check endpoint types
Date: Fri, 23 Feb 2018 19:25:36 +0100
Message-Id: <20180223170746.619596635@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218769430627889?=
X-GMAIL-MSGID: =?utf-8?q?1593218769430627889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3642,6 +3642,12 @@ static int pvr2_send_request_ex(struct p
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
@@ -3666,6 +3672,12 @@ status);
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
