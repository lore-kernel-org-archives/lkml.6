Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521807016-2-5762523172220107334
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RHS_DOB 1.514,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807015; b=hZH2oWAaH3qAn0ZvVOV+aoenkuJs85lk5pG5THT7TB4+HqG
    VceYQmm3geGJmYtT86iEOSkUY+sbgaz7sbY9Le2C6DowaK7ds67iHpKVEHtnU33v
    FiYcptV8ODPzpYQvmJ0vkjdhVOjqloEqtD8wppDwmC35yoNu0rnq/geCV/elwSm1
    qsxOdczh+LjyaZ0iSMJHZOp2BhAyMv/kPNm67miu6ALHondwSldETMS9RysZqMUb
    kwnwjVX4gbR4vhf3yZpegNbc6c93L9fjNYEYm/KujwiXrTH21KbjATa1WCC3ipmZ
    KID/lqNMsunh46FP4+r1N1dDn7CyE7yfS2M9MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807015; bh=9Sw85v2ToTODisOn9QDm4F0Hk9
    +BMCJw16au3wTXE+U=; b=POR/2yA3an3tPqAVcH8Nr5aaFepulOItJ/72r39p7n
    tnoyoBFVkcPnGHh5NklBN/63cgzxo3h3u3wDvAnofr8CH+K14r6xhwqZuGomypAI
    XOdrM4pJoKUvjwmzfhZ5HY6NdVZm5S/eJ0lo3n61IJtAcK2hNjMHflNoREpiq5MM
    FRkG9+JgPjr73gj8wlYgHbJvWgQveek5cwVe4gfeu6Me7XeYswFpzk1d9GNHsEWa
    BTeGMSBL9AcnLVRXzajTKXTtFJ36/bb8UTAIcJIvReP5k77Vajm0gFDLXjCGqz5A
    keENBK1nursReX656iSx+/bnWPCFd8aCbaNq3coGsObw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeCWJ6K (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35580 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbeCWJ6I (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 37/84] media: s5p-mfc: Fix lock contention - request_firmware() once
Date: Fri, 23 Mar 2018 10:53:51 +0100
Message-Id: <20180323095417.520409897@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>


[ Upstream commit f45ce9877561044090010e0eb0fad644232ded04 ]

Driver calls request_firmware() whenever the device is opened for the
first time. As the device gets opened and closed, dev->num_inst == 1
is true several times. This is not necessary since the firmware is saved
in the fw_buf. s5p_mfc_load_firmware() copies the buffer returned by
the request_firmware() to dev->fw_buf.

fw_buf sticks around until it gets released from s5p_mfc_remove(), hence
there is no need to keep requesting firmware and copying it to fw_buf.

This might have been overlooked when changes are made to free fw_buf from
the device release interface s5p_mfc_release().

Fix s5p_mfc_load_firmware() to call request_firmware() once and keep state.
Change _probe() to load firmware once fw_buf has been allocated.

s5p_mfc_open() and it continues to call s5p_mfc_load_firmware() and init
hardware which is the step where firmware is written to the device.

This addresses the mfc_mutex contention due to repeated request_firmware()
calls from open() in the following circular locking warning:

[  552.194115] qtdemux0:sink/2710 is trying to acquire lock:
[  552.199488]  (&dev->mfc_mutex){+.+.}, at: [<bf145544>] s5p_mfc_mmap+0x28/0xd4 [s5p_mfc]
[  552.207459]
               but task is already holding lock:
[  552.213264]  (&mm->mmap_sem){++++}, at: [<c01df2e4>] vm_mmap_pgoff+0x44/0xb8
[  552.220284]
               which lock already depends on the new lock.

[  552.228429]
               the existing dependency chain (in reverse order) is:
[  552.235881]
               -> #2 (&mm->mmap_sem){++++}:
[  552.241259]        __might_fault+0x80/0xb0
[  552.245331]        filldir64+0xc0/0x2f8
[  552.249144]        call_filldir+0xb0/0x14c
[  552.253214]        ext4_readdir+0x768/0x90c
[  552.257374]        iterate_dir+0x74/0x168
[  552.261360]        SyS_getdents64+0x7c/0x1a0
[  552.265608]        ret_fast_syscall+0x0/0x28
[  552.269850]
               -> #1 (&type->i_mutex_dir_key#2){++++}:
[  552.276180]        down_read+0x48/0x90
[  552.279904]        lookup_slow+0x74/0x178
[  552.283889]        walk_component+0x1a4/0x2e4
[  552.288222]        link_path_walk+0x174/0x4a0
[  552.292555]        path_openat+0x68/0x944
[  552.296541]        do_filp_open+0x60/0xc4
[  552.300528]        file_open_name+0xe4/0x114
[  552.304772]        filp_open+0x28/0x48
[  552.308499]        kernel_read_file_from_path+0x30/0x78
[  552.313700]        _request_firmware+0x3ec/0x78c
[  552.318291]        request_firmware+0x3c/0x54
[  552.322642]        s5p_mfc_load_firmware+0x54/0x150 [s5p_mfc]
[  552.328358]        s5p_mfc_open+0x4e4/0x550 [s5p_mfc]
[  552.333394]        v4l2_open+0xa0/0x104 [videodev]
[  552.338137]        chrdev_open+0xa4/0x18c
[  552.342121]        do_dentry_open+0x208/0x310
[  552.346454]        path_openat+0x28c/0x944
[  552.350526]        do_filp_open+0x60/0xc4
[  552.354512]        do_sys_open+0x118/0x1c8
[  552.358586]        ret_fast_syscall+0x0/0x28
[  552.362830]
               -> #0 (&dev->mfc_mutex){+.+.}:
               -> #0 (&dev->mfc_mutex){+.+.}:
[  552.368379]        lock_acquire+0x6c/0x88
[  552.372364]        __mutex_lock+0x68/0xa34
[  552.376437]        mutex_lock_interruptible_nested+0x1c/0x24
[  552.382086]        s5p_mfc_mmap+0x28/0xd4 [s5p_mfc]
[  552.386939]        v4l2_mmap+0x54/0x88 [videodev]
[  552.391601]        mmap_region+0x3a8/0x638
[  552.395673]        do_mmap+0x330/0x3a4
[  552.399400]        vm_mmap_pgoff+0x90/0xb8
[  552.403472]        SyS_mmap_pgoff+0x90/0xc0
[  552.407632]        ret_fast_syscall+0x0/0x28
[  552.411876]
               other info that might help us debug this:

[  552.419848] Chain exists of:
                 &dev->mfc_mutex --> &type->i_mutex_dir_key#2 --> &mm->mmap_sem

[  552.431200]  Possible unsafe locking scenario:

[  552.437092]        CPU0                    CPU1
[  552.441598]        ----                    ----
[  552.446104]   lock(&mm->mmap_sem);
[  552.449484]                                lock(&type->i_mutex_dir_key#2);
[  552.456329]                                lock(&mm->mmap_sem);
[  552.462222]   lock(&dev->mfc_mutex);
[  552.465775]
                *** DEADLOCK ***

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c        |    6 ++++++
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |    3 +++
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c   |    5 +++++
 3 files changed, 14 insertions(+)

--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1309,6 +1309,12 @@ static int s5p_mfc_probe(struct platform
 		goto err_dma;
 	}
 
+	/*
+	 * Load fails if fs isn't mounted. Try loading anyway.
+	 * _open() will load it, it it fails now. Ignore failure.
+	 */
+	s5p_mfc_load_firmware(dev);
+
 	mutex_init(&dev->mfc_mutex);
 	init_waitqueue_head(&dev->queue);
 	dev->hw_lock = 0;
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
@@ -290,6 +290,8 @@ struct s5p_mfc_priv_buf {
  * @mfc_cmds:		cmd structure holding HW commands function pointers
  * @mfc_regs:		structure holding MFC registers
  * @fw_ver:		loaded firmware sub-version
+ * @fw_get_done		flag set when request_firmware() is complete and
+ *			copied into fw_buf
  * risc_on:		flag indicates RISC is on or off
  *
  */
@@ -336,6 +338,7 @@ struct s5p_mfc_dev {
 	struct s5p_mfc_hw_cmds *mfc_cmds;
 	const struct s5p_mfc_regs *mfc_regs;
 	enum s5p_mfc_fw_ver fw_ver;
+	bool fw_get_done;
 	bool risc_on; /* indicates if RISC is on or off */
 };
 
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
@@ -55,6 +55,9 @@ int s5p_mfc_load_firmware(struct s5p_mfc
 	 * into kernel. */
 	mfc_debug_enter();
 
+	if (dev->fw_get_done)
+		return 0;
+
 	for (i = MFC_FW_MAX_VERSIONS - 1; i >= 0; i--) {
 		if (!dev->variant->fw_name[i])
 			continue;
@@ -82,6 +85,7 @@ int s5p_mfc_load_firmware(struct s5p_mfc
 	}
 	memcpy(dev->fw_buf.virt, fw_blob->data, fw_blob->size);
 	wmb();
+	dev->fw_get_done = true;
 	release_firmware(fw_blob);
 	mfc_debug_leave();
 	return 0;
@@ -93,6 +97,7 @@ int s5p_mfc_release_firmware(struct s5p_
 	/* Before calling this function one has to make sure
 	 * that MFC is no longer processing */
 	s5p_mfc_release_priv_buf(dev, &dev->fw_buf);
+	dev->fw_get_done = false;
 	return 0;
 }
 
