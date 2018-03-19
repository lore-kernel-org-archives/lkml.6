Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsrojziKsoV4m9cH7al/QnztiMgRD3Hkh2/+DauCTcpxYU1RnZT2Tv1ca6gWRY9YPVl/3IB
ARC-Seal: i=1; a=rsa-sha256; t=1521483610; cv=none;
        d=google.com; s=arc-20160816;
        b=0s3JhWDMtMujVBgCN8XLdxYWka/mRXgqEKUn3l32TXsT9qhA9pUYWL03lkAOVlkZOQ
         KWDPadAfQXjCwLOg4okB8ChQbHZsNBHbA57t/yDoklQgpkQmAg8Cr0dYb/rwB2ZDtCvw
         tYtvMgDEOL/DJqoAT2gwPprGYnlT7V7AEISHWKWJaW+5dfg2DY0x2VkknTlxutnqOzdr
         /PV9zzipuvWYgIJPP5XrCRuYbOsqroPhdzWJDd+LMgeV6Qh/7UAz/7IxCtax2GAdD7N+
         Dk1iJiMMuPtytUooF+q7dPSsiMa57NdMEliufaYiFkMUcftRx1/y88QIrXEPWVidZut3
         Gw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yjWWWnpUjp5bmJ5DMJojYvxrRlNz83tjkpdVQVPOmhU=;
        b=sCMNgvbpsyrdTnmOSf+aaR07U7WiMLHW9laqqIACkjxP+6m7t2eMLUhS2YaBA7xueE
         vbJie/L3AinVAxbYFPpvgI2f3uCG6As+8+eQqDvMSlBNN6NFI1tnZo9owIUnlksLlcKa
         a5B388rfhaCTGVRk+tNMQVQNldF5p9grcYMO88thINvRS42t7/cLNoHV3PRm28kfYwws
         zdHRACS57pXpfq/tc3w1Em7C7UZeEf9R0/38uZp8xf0GU20Q+75iG0mrQ9vt9WptpMQE
         BkYKL0YaMW4kkbKjVvHS6YFQDdX+v8VLEAK2rHhOd5tl7zTK8XiaOSxwAmnEqtQhpCNy
         y8BQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anton Sviridenko <anton@corp.bluecherry.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 051/241] [media] solo6x10: release vb2 buffers in solo_stop_streaming()
Date: Mon, 19 Mar 2018 19:05:16 +0100
Message-Id: <20180319180753.329206833@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390735713545619?=
X-GMAIL-MSGID: =?utf-8?q?1595391198623295653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Sviridenko <anton@corp.bluecherry.net>


[ Upstream commit 6e4c8480bd2eb95309ad3c875e11d2cad98f9188 ]

Fixes warning that appears in dmesg after closing V4L2 userspace
application that plays video from the display device
(first device from V4L2 device nodes provided by solo, usually /dev/video0
when no other V4L2 devices are present). Encoder device nodes are not
affected. Can be reproduced by starting and closing

ffplay -f video4linux2  /dev/video0

[ 8130.281251] ------------[ cut here ]------------
[ 8130.281256] WARNING: CPU: 1 PID: 20414 at drivers/media/v4l2-core/videobuf2-core.c:1651 __vb2_queue_cancel+0x14b/0x230
[ 8130.281257] Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat solo6x10 x86_pkg_temp_thermal vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O)
[ 8130.281264] CPU: 1 PID: 20414 Comm: ffplay Tainted: G           O    4.10.0-gentoo #1
[ 8130.281264] Hardware name: ASUS All Series/B85M-E, BIOS 2301 03/30/2015
[ 8130.281265] Call Trace:
[ 8130.281267]  dump_stack+0x4f/0x72
[ 8130.281270]  __warn+0xc7/0xf0
[ 8130.281271]  warn_slowpath_null+0x18/0x20
[ 8130.281272]  __vb2_queue_cancel+0x14b/0x230
[ 8130.281273]  vb2_core_streamoff+0x23/0x90
[ 8130.281275]  vb2_streamoff+0x24/0x50
[ 8130.281276]  vb2_ioctl_streamoff+0x3d/0x50
[ 8130.281278]  v4l_streamoff+0x15/0x20
[ 8130.281279]  __video_do_ioctl+0x25e/0x2f0
[ 8130.281280]  video_usercopy+0x279/0x520
[ 8130.281282]  ? v4l_enum_fmt+0x1330/0x1330
[ 8130.281285]  ? unmap_region+0xdf/0x110
[ 8130.281285]  video_ioctl2+0x10/0x20
[ 8130.281286]  v4l2_ioctl+0xce/0xe0
[ 8130.281289]  do_vfs_ioctl+0x8b/0x5b0
[ 8130.281290]  ? __fget+0x72/0xa0
[ 8130.281291]  SyS_ioctl+0x74/0x80
[ 8130.281294]  entry_SYSCALL_64_fastpath+0x13/0x94
[ 8130.281295] RIP: 0033:0x7ff86fee6b27
[ 8130.281296] RSP: 002b:00007ffe467f6a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 8130.281297] RAX: ffffffffffffffda RBX: 00000000d1a4d788 RCX: 00007ff86fee6b27
[ 8130.281297] RDX: 00007ffe467f6a14 RSI: 0000000040045613 RDI: 0000000000000006
[ 8130.281298] RBP: 000000000373f8d0 R08: 00000000ffffffff R09: 00007ff860001140
[ 8130.281298] R10: 0000000000000243 R11: 0000000000000246 R12: 0000000000000000
[ 8130.281299] R13: 00000000000000a0 R14: 00007ffe467f6530 R15: 0000000001f32228
[ 8130.281300] ---[ end trace 00695dc96be646e7 ]---

Signed-off-by: Anton Sviridenko <anton@corp.bluecherry.net>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/solo6x10/solo6x10-v4l2.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/media/pci/solo6x10/solo6x10-v4l2.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
@@ -341,6 +341,17 @@ static void solo_stop_streaming(struct v
 	struct solo_dev *solo_dev = vb2_get_drv_priv(q);
 
 	solo_stop_thread(solo_dev);
+
+	spin_lock(&solo_dev->slock);
+	while (!list_empty(&solo_dev->vidq_active)) {
+		struct solo_vb2_buf *buf = list_entry(
+				solo_dev->vidq_active.next,
+				struct solo_vb2_buf, list);
+
+		list_del(&buf->list);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	}
+	spin_unlock(&solo_dev->slock);
 	INIT_LIST_HEAD(&solo_dev->vidq_active);
 }
 
