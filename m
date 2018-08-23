Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CADC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEB020A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEB020A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeHWLq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:46:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeHWLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:46:56 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9DE6AC74;
        Thu, 23 Aug 2018 08:18:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Protsenko <semen.protsenko@linaro.org>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 016/217] usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers
Date:   Thu, 23 Aug 2018 09:52:09 +0200
Message-Id: <20180823075506.282735750@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Pelletier <plr.vincent@gmail.com>

[ Upstream commit d52e4d0c0c428bf2ba35074a7495cdb28e2efbae ]

This bug happens only when the UDC needs to sleep during usb_ep_dequeue,
as is the case for (at least) dwc3.

[  382.200896] BUG: scheduling while atomic: screen/1808/0x00000100
[  382.207124] 4 locks held by screen/1808:
[  382.211266]  #0:  (rcu_callback){....}, at: [<c10b4ff0>] rcu_process_callbacks+0x260/0x440
[  382.219949]  #1:  (rcu_read_lock_sched){....}, at: [<c1358ba0>] percpu_ref_switch_to_atomic_rcu+0xb0/0x130
[  382.230034]  #2:  (&(&ctx->ctx_lock)->rlock){....}, at: [<c11f0c73>] free_ioctx_users+0x23/0xd0
[  382.230096]  #3:  (&(&ffs->eps_lock)->rlock){....}, at: [<f81e7710>] ffs_aio_cancel+0x20/0x60 [usb_f_fs]
[  382.230160] Modules linked in: usb_f_fs libcomposite configfs bnep btsdio bluetooth ecdh_generic brcmfmac brcmutil intel_powerclamp coretemp dwc3 kvm_intel ulpi udc_core kvm irqbypass crc32_pclmul crc32c_intel pcbc dwc3_pci aesni_intel aes_i586 crypto_simd cryptd ehci_pci ehci_hcd gpio_keys usbcore basincove_gpadc industrialio usb_common
[  382.230407] CPU: 1 PID: 1808 Comm: screen Not tainted 4.14.0-edison+ #117
[  382.230416] Hardware name: Intel Corporation Merrifield/BODEGA BAY, BIOS 542 2015.01.21:18.19.48
[  382.230425] Call Trace:
[  382.230438]  <SOFTIRQ>
[  382.230466]  dump_stack+0x47/0x62
[  382.230498]  __schedule_bug+0x61/0x80
[  382.230522]  __schedule+0x43/0x7a0
[  382.230587]  schedule+0x5f/0x70
[  382.230625]  dwc3_gadget_ep_dequeue+0x14c/0x270 [dwc3]
[  382.230669]  ? do_wait_intr_irq+0x70/0x70
[  382.230724]  usb_ep_dequeue+0x19/0x90 [udc_core]
[  382.230770]  ffs_aio_cancel+0x37/0x60 [usb_f_fs]
[  382.230798]  kiocb_cancel+0x31/0x40
[  382.230822]  free_ioctx_users+0x4d/0xd0
[  382.230858]  percpu_ref_switch_to_atomic_rcu+0x10a/0x130
[  382.230881]  ? percpu_ref_exit+0x40/0x40
[  382.230904]  rcu_process_callbacks+0x2b3/0x440
[  382.230965]  __do_softirq+0xf8/0x26b
[  382.231011]  ? __softirqentry_text_start+0x8/0x8
[  382.231033]  do_softirq_own_stack+0x22/0x30
[  382.231042]  </SOFTIRQ>
[  382.231071]  irq_exit+0x45/0xc0
[  382.231089]  smp_apic_timer_interrupt+0x13c/0x150
[  382.231118]  apic_timer_interrupt+0x35/0x3c
[  382.231132] EIP: __copy_user_ll+0xe2/0xf0
[  382.231142] EFLAGS: 00210293 CPU: 1
[  382.231154] EAX: bfd4508c EBX: 00000004 ECX: 00000003 EDX: f3d8fe50
[  382.231165] ESI: f3d8fe51 EDI: bfd4508d EBP: f3d8fe14 ESP: f3d8fe08
[  382.231176]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  382.231265]  core_sys_select+0x25f/0x320
[  382.231346]  ? __wake_up_common_lock+0x62/0x80
[  382.231399]  ? tty_ldisc_deref+0x13/0x20
[  382.231438]  ? ldsem_up_read+0x1b/0x40
[  382.231459]  ? tty_ldisc_deref+0x13/0x20
[  382.231479]  ? tty_write+0x29f/0x2e0
[  382.231514]  ? n_tty_ioctl+0xe0/0xe0
[  382.231541]  ? tty_write_unlock+0x30/0x30
[  382.231566]  ? __vfs_write+0x22/0x110
[  382.231604]  ? security_file_permission+0x2f/0xd0
[  382.231635]  ? rw_verify_area+0xac/0x120
[  382.231677]  ? vfs_write+0x103/0x180
[  382.231711]  SyS_select+0x87/0xc0
[  382.231739]  ? SyS_write+0x42/0x90
[  382.231781]  do_fast_syscall_32+0xd6/0x1a0
[  382.231836]  entry_SYSENTER_32+0x47/0x71
[  382.231848] EIP: 0xb7f75b05
[  382.231857] EFLAGS: 00000246 CPU: 1
[  382.231868] EAX: ffffffda EBX: 00000400 ECX: bfd4508c EDX: bfd4510c
[  382.231878] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bfd45020
[  382.231889]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  382.232281] softirq: huh, entered softirq 9 RCU c10b4d90 with preempt_count 00000100, exited with 00000000?

Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -219,6 +219,7 @@ struct ffs_io_data {
 
 	struct mm_struct *mm;
 	struct work_struct work;
+	struct work_struct cancellation_work;
 
 	struct usb_ep *ep;
 	struct usb_request *req;
@@ -1073,22 +1074,31 @@ ffs_epfile_open(struct inode *inode, str
 	return 0;
 }
 
+static void ffs_aio_cancel_worker(struct work_struct *work)
+{
+	struct ffs_io_data *io_data = container_of(work, struct ffs_io_data,
+						   cancellation_work);
+
+	ENTER();
+
+	usb_ep_dequeue(io_data->ep, io_data->req);
+}
+
 static int ffs_aio_cancel(struct kiocb *kiocb)
 {
 	struct ffs_io_data *io_data = kiocb->private;
-	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
+	struct ffs_data *ffs = io_data->ffs;
 	int value;
 
 	ENTER();
 
-	spin_lock_irq(&epfile->ffs->eps_lock);
-
-	if (likely(io_data && io_data->ep && io_data->req))
-		value = usb_ep_dequeue(io_data->ep, io_data->req);
-	else
+	if (likely(io_data && io_data->ep && io_data->req)) {
+		INIT_WORK(&io_data->cancellation_work, ffs_aio_cancel_worker);
+		queue_work(ffs->io_completion_wq, &io_data->cancellation_work);
+		value = -EINPROGRESS;
+	} else {
 		value = -EINVAL;
-
-	spin_unlock_irq(&epfile->ffs->eps_lock);
+	}
 
 	return value;
 }


