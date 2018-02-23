Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226z++gFVwbmfkODFK0SFsITt1pzD5lo5zGKn/CD1s8Uksi6WdUIi0038lAr3zjU7eeC63oB
ARC-Seal: i=1; a=rsa-sha256; t=1519412314; cv=none;
        d=google.com; s=arc-20160816;
        b=Ff+WvlxRDi12V9J4gadHn/y/3VlShU/VpGtG/PNEdZV+btIWUMA3IDMJDA1nrM4JHe
         NskTcbvr05E5e+OGP6R4wJPs1qYsSokohIHMcOwFWtAFqjOIhei+I08YA2RC8gT2im9X
         v55k+sUbHmf7XmVwyg31BzF1gdiFZY88l7uxDgsqtRW5d4GADFIiWeG7Y7v9NRJJg7Im
         eV+oIBIsR7XopOqXY4Z394w3DWQ8eCBsBy+24TNS2KC9lIffzvrTKJ7xRPVmptQfUXzF
         wa3pWOyhJapgTHAr/kSd2H6mNqzvtyPd7mIC/k0dDuSv483v2Pf8Ys9gTMhRITLbjWaF
         P0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O5V7N8Ed5Xtz5exDTpXs3CrNVVNTYkgWjuNfQyhgpv0=;
        b=hl/CuX1B/R85nS9idKBZJtTUktUU7vq3Rmoa6keTUW5T7zt9ZHYp2914HTGX8iaoWH
         OTWcWJ7q2gi2UxadwombQyFTuNQjfu4bPqNsQT+2jVs064ewg1Kt7Ngsl941vONbS0h/
         QVuG6sn5TpVH+dlH9iQGOl9EBqj4cn56l4Ur90KTttM1H+n61JZ1Vtubi4y6c8nRzil1
         zZFA/heQh1phZWdivlXgl8/9v8BzcskW+jPd4dn3pxd8bRMEWTNyOGi3fr4Nv/wge3vQ
         S0cVenyIxQ7zSafDSAGEtov6BpbAuv7PU8UvtcfkJRoWoxqhCJ81IllFzEIkxKqJzzmb
         HV1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhengjun Xing <zhengjun.xing@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.15 37/45] xhci: Fix NULL pointer in xhci debugfs
Date: Fri, 23 Feb 2018 19:29:16 +0100
Message-Id: <20180223170721.223556618@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219286865806156?=
X-GMAIL-MSGID: =?utf-8?q?1593219286865806156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit fa2dfd0ec22e0069c84dfae162972cbbc7c75488 upstream.

Commit dde634057da7 ("xhci: Fix use-after-free in xhci debugfs") causes a
null pointer dereference while fixing xhci-debugfs usage of ring pointers
that were freed during hibernate.

The fix passed addresses to ring pointers instead, but forgot to do this
change for the xhci_ring_trb_show function.

The address of the ring pointer passed to xhci-debugfs was of a temporary
ring pointer "new_ring" instead of the actual ring "ring" pointer. The
temporary new_ring pointer will be set to NULL later causing the NULL
pointer dereference.

This issue was seen when reading xhci related files in debugfs:

cat /sys/kernel/debug/usb/xhci/*/devices/*/ep*/trbs

[  184.604861] BUG: unable to handle kernel NULL pointer dereference at (null)
[  184.613776] IP: xhci_ring_trb_show+0x3a/0x890
[  184.618733] PGD 264193067 P4D 264193067 PUD 263238067 PMD 0
[  184.625184] Oops: 0000 [#1] SMP
[  184.726410] RIP: 0010:xhci_ring_trb_show+0x3a/0x890
[  184.731944] RSP: 0018:ffffba8243c0fd90 EFLAGS: 00010246
[  184.737880] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000295d6
[  184.746020] RDX: 00000000000295d5 RSI: 0000000000000001 RDI: ffff971a6418d400
[  184.754121] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  184.762222] R10: ffff971a64c98a80 R11: ffff971a62a00e40 R12: ffff971a62a85500
[  184.770325] R13: 0000000000020000 R14: ffff971a6418d400 R15: ffff971a6418d400
[  184.778448] FS:  00007fe725a79700(0000) GS:ffff971a6ec00000(0000) knlGS:0000000000000000
[  184.787644] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  184.794168] CR2: 0000000000000000 CR3: 000000025f365005 CR4: 00000000003606f0
[  184.802318] Call Trace:
[  184.805094]  ? seq_read+0x281/0x3b0
[  184.809068]  seq_read+0xeb/0x3b0
[  184.812735]  full_proxy_read+0x4d/0x70
[  184.817007]  __vfs_read+0x23/0x120
[  184.820870]  vfs_read+0x91/0x130
[  184.824538]  SyS_read+0x42/0x90
[  184.828106]  entry_SYSCALL_64_fastpath+0x1a/0x7d

Fixes: dde634057da7 ("xhci: Fix use-after-free in xhci debugfs")
Cc: <stable@vger.kernel.org> # v4.15
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-debugfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -211,7 +211,7 @@ static void xhci_ring_dump_segment(struc
 static int xhci_ring_trb_show(struct seq_file *s, void *unused)
 {
 	int			i;
-	struct xhci_ring	*ring = s->private;
+	struct xhci_ring	*ring = *(struct xhci_ring **)s->private;
 	struct xhci_segment	*seg = ring->first_seg;
 
 	for (i = 0; i < ring->num_segs; i++) {
@@ -387,7 +387,7 @@ void xhci_debugfs_create_endpoint(struct
 
 	snprintf(epriv->name, sizeof(epriv->name), "ep%02d", ep_index);
 	epriv->root = xhci_debugfs_create_ring_dir(xhci,
-						   &dev->eps[ep_index].new_ring,
+						   &dev->eps[ep_index].ring,
 						   epriv->name,
 						   spriv->root);
 	spriv->eps[ep_index] = epriv;
