Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+935tYSdnr9WIsjPgNp3KrRKUes2BNPOIrt3UvgtS5SSj9GI8uFY60DeY+ZW5A0fMijMIn
ARC-Seal: i=1; a=rsa-sha256; t=1523473386; cv=none;
        d=google.com; s=arc-20160816;
        b=LH4bFHgXr2/TTAI4gkxFfZDSDT+SUKN2vaoDduNv0uORvwHNy+oeVzNPgTnV767xj2
         XZSn6fxlK03gKXjV9p4CfjxXNUXHXZJ+pdpYtJxc9TBxLKYaxGkrmSMrEVJLZ2kYgGCZ
         nD7IkYeL2bWcz7lWFKV9kegO7MOTNuh9tTQXA81Ai5xkwVOCo3eh3vWmcV9BQW1XHQco
         32SnnuBoG3kyDeuMx8krzo3RAgw2LsDW/v3lXuoemRQtr4calxTiDnMIj7lLnDfMuegW
         cyrzymz8TD+3YYEz2vbQX7DKq8DzLyIc/GRJaTYICUoNXIB4Kc0m+2yJSGAQ3KtQMuR4
         bteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zJBBwdm45x+c52fFxWUbcvEO8wKJmJyl7BxY2gySr2g=;
        b=jPu/GwAUPbKZqeigIIQpkH7uMeEM7GQtNoXDLLHJCNGyOj4r8MiVBmmrA8KQ06pr8d
         scTsKS3o0EWsDQW+gJaz5vszRAdgiyge59ZvjUAZKjw+b15PDxVi0PntFy0FhrVVN9ww
         wz6hHobZB445oNZdQydZwKVRo2SXy5/7UAzKbQM2WIU0nVSr1QlZw6MmZfIHvDvPTpxG
         TaHQG30HmMyPGBsjWRWn1eFDznCNfn59o4f/D2PySDFBVLsF6vO565AlXNX8z8VysIHu
         jJ9pkQNLkAYBU57PbXxi5c2dzstl+wCOG6wn2QUdkM815zXhnDHMzDiU0S2y3caTqC8E
         7qDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rakesh Pandit <rakesh@tuxera.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 212/310] nvme-pci: fix multiple ctrl removal scheduling
Date: Wed, 11 Apr 2018 20:35:51 +0200
Message-Id: <20180411183631.682298716@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477629974601386?=
X-GMAIL-MSGID: =?utf-8?q?1597477629974601386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rakesh Pandit <rakesh@tuxera.com>


[ Upstream commit 82b057caefaff2a891f821a617d939f46e03e844 ]

Commit c5f6ce97c1210 tries to address multiple resets but fails as
work_busy doesn't involve any synchronization and can fail.  This is
reproducible easily as can be seen by WARNING below which is triggered
with line:

WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING)

Allowing multiple resets can result in multiple controller removal as
well if different conditions inside nvme_reset_work fail and which
might deadlock on device_release_driver.

[  480.327007] WARNING: CPU: 3 PID: 150 at drivers/nvme/host/pci.c:1900 nvme_reset_work+0x36c/0xec0
[  480.327008] Modules linked in: rfcomm fuse nf_conntrack_netbios_ns nf_conntrack_broadcast...
[  480.327044]  btusb videobuf2_core ghash_clmulni_intel snd_hwdep cfg80211 acer_wmi hci_uart..
[  480.327065] CPU: 3 PID: 150 Comm: kworker/u16:2 Not tainted 4.12.0-rc1+ #13
[  480.327065] Hardware name: Acer Predator G9-591/Mustang_SLS, BIOS V1.10 03/03/2016
[  480.327066] Workqueue: nvme nvme_reset_work
[  480.327067] task: ffff880498ad8000 task.stack: ffffc90002218000
[  480.327068] RIP: 0010:nvme_reset_work+0x36c/0xec0
[  480.327069] RSP: 0018:ffffc9000221bdb8 EFLAGS: 00010246
[  480.327070] RAX: 0000000000460000 RBX: ffff880498a98128 RCX: dead000000000200
[  480.327070] RDX: 0000000000000001 RSI: ffff8804b1028020 RDI: ffff880498a98128
[  480.327071] RBP: ffffc9000221be50 R08: 0000000000000000 R09: 0000000000000000
[  480.327071] R10: ffffc90001963ce8 R11: 000000000000020d R12: ffff880498a98000
[  480.327072] R13: ffff880498a53500 R14: ffff880498a98130 R15: ffff880498a98128
[  480.327072] FS:  0000000000000000(0000) GS:ffff8804c1cc0000(0000) knlGS:0000000000000000
[  480.327073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  480.327074] CR2: 00007ffcf3c37f78 CR3: 0000000001e09000 CR4: 00000000003406e0
[  480.327074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  480.327075] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  480.327075] Call Trace:
[  480.327079]  ? __switch_to+0x227/0x400
[  480.327081]  process_one_work+0x18c/0x3a0
[  480.327082]  worker_thread+0x4e/0x3b0
[  480.327084]  kthread+0x109/0x140
[  480.327085]  ? process_one_work+0x3a0/0x3a0
[  480.327087]  ? kthread_park+0x60/0x60
[  480.327102]  ret_from_fork+0x2c/0x40
[  480.327103] Code: e8 5a dc ff ff 85 c0 41 89 c1 0f.....

This patch addresses the problem by using state of controller to
decide whether reset should be queued or not as state change is
synchronizated using controller spinlock.  Also cancel_work_sync is
used to make sure remove cancels the reset_work and waits for it to
finish.  This patch also changes return value from -ENODEV to more
appropriate -EBUSY if nvme_reset fails to change state.

Fixes: c5f6ce97c1210 ("nvme: don't schedule multiple resets")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1263,7 +1263,7 @@ static bool nvme_should_reset(struct nvm
 	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
 
 	/* If there is a reset ongoing, we shouldn't reset again. */
-	if (work_busy(&dev->reset_work))
+	if (dev->ctrl.state == NVME_CTRL_RESETTING)
 		return false;
 
 	/* We shouldn't reset unless the controller is on fatal error state
@@ -1755,7 +1755,7 @@ static void nvme_reset_work(struct work_
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
 	int result = -ENODEV;
 
-	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
+	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
 		goto out;
 
 	/*
@@ -1765,9 +1765,6 @@ static void nvme_reset_work(struct work_
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
 
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
-		goto out;
-
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out;
@@ -1841,8 +1838,8 @@ static int nvme_reset(struct nvme_dev *d
 {
 	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
 		return -ENODEV;
-	if (work_busy(&dev->reset_work))
-		return -ENODEV;
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+		return -EBUSY;
 	if (!queue_work(nvme_workq, &dev->reset_work))
 		return -EBUSY;
 	return 0;
@@ -1944,6 +1941,7 @@ static int nvme_probe(struct pci_dev *pd
 	if (result)
 		goto release_pools;
 
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING);
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	queue_work(nvme_workq, &dev->reset_work);
@@ -1987,6 +1985,7 @@ static void nvme_remove(struct pci_dev *
 
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
+	cancel_work_sync(&dev->reset_work);
 	pci_set_drvdata(pdev, NULL);
 
 	if (!pci_device_is_present(pdev)) {
