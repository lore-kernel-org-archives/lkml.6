Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99371C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FF5208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FF5208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeJBUM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:12:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeJBUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:54 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CE6BC11;
        Tue,  2 Oct 2018 13:29:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Pan <harry.pan@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 4.18 151/228] usb: core: safely deal with the dynamic quirk lists
Date:   Tue,  2 Oct 2018 06:24:08 -0700
Message-Id: <20181002132509.315095917@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Pan <harry.pan@intel.com>

commit 16c4cb19fa85c648a803752eb63cac0ef69231c2 upstream.

Applying dynamic usbcore quirks in early booting when the slab is
not yet ready would cause kernel panic of null pointer dereference
because the quirk_count has been counted as 1 while the quirk_list
was failed to allocate.

i.e.,
[    1.044970] BUG: unable to handle kernel NULL pointer dereference at           (null)
[    1.044995] IP: [<ffffffffb0953ec7>] usb_detect_quirks+0x88/0xd1
[    1.045016] PGD 0
[    1.045026] Oops: 0000 [#1] PREEMPT SMP
[    1.046986] gsmi: Log Shutdown Reason 0x03
[    1.046995] Modules linked in:
[    1.047008] CPU: 0 PID: 81 Comm: kworker/0:3 Not tainted 4.4.154 #28
[    1.047016] Hardware name: Google Coral/Coral, BIOS Google_Coral.10068.27.0 12/04/2017
[    1.047028] Workqueue: usb_hub_wq hub_event
[    1.047037] task: ffff88017a321c80 task.stack: ffff88017a384000
[    1.047044] RIP: 0010:[<ffffffffb0953ec7>]  [<ffffffffb0953ec7>] usb_detect_quirks+0x88/0xd1

To tackle this odd, let's balance the quirk_count to 0 when the kcalloc
call fails, and defer the quirk setting into a lower level callback
which ensures that the kernel memory management has been initialized.

Fixes: 027bd6cafd9a ("usb: core: Add "quirks" parameter for usbcore")
Signed-off-by: Harry Pan <harry.pan@intel.com>
Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -58,6 +58,7 @@ static int quirks_param_set(const char *
 	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
 			     GFP_KERNEL);
 	if (!quirk_list) {
+		quirk_count = 0;
 		mutex_unlock(&quirk_mutex);
 		return -ENOMEM;
 	}
@@ -154,7 +155,7 @@ static struct kparam_string quirks_param
 	.string = quirks_param,
 };
 
-module_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0644);
+device_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0644);
 MODULE_PARM_DESC(quirks, "Add/modify USB quirks by specifying quirks=vendorID:productID:quirks");
 
 /* Lists of quirky USB devices, split in device quirks and interface quirks.


