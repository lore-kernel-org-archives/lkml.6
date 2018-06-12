Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BA8F9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6736B2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vbkH03re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6736B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934789AbeFLU46 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:56:58 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:31588 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934350AbeFLU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528837007; x=1560373007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LUwFf+Ae7TN++/Wj+Px8atzbQJwwwOGW+JAVCXV9Dic=;
  b=vbkH03re156tWJH7CQPVKodPhOaCFoCJooVrn9MyoAjvdOxRld3es1JW
   yI2+zeP8fNRL7i4qyTj+Whw6vDPwiwOAoMucGpik0UelPKhSZiHlGCvZW
   35N4wI+WDv5egseEsSuN9xzp0wKIITy2bPmkFdAWNXn+gu8MokxjHsRZw
   U=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="682679292"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:43 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKufg2102858
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:41 GMT
Received: from EX13D10UWA003.ant.amazon.com (10.43.160.248) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:39 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D10UWA003.ant.amazon.com (10.43.160.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:38 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 12 Jun 2018 20:56:38 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <anchalag@amazon.com>, <fllinden@amazon.com>, <vallish@amazon.com>,
        <guruanb@amazon.com>, <eduval@amazon.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: [RFC PATCH 11/12] x86/xen: close event channels for PIRQs in system core suspend callback
Date:   Tue, 12 Jun 2018 20:56:18 +0000
Message-ID: <20180612205619.28156-12-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

Close event channels allocated for devices which are backed by PIRQ and
still active when suspending the system core. Normally, the devices are
emulated legacy devices, e.g. PS/2 keyboard, floppy controller and etc.

Without this, in PM hibernation, information about the event channel
remains in hibernation image, but there is no guarantee that the same
event channel numbers are assigned to the devices when restoring the
system. This may cause conflict like the following and prevent some
devices from being restored correctly.

[  102.330821] ------------[ cut here ]------------
[  102.333264] WARNING: CPU: 0 PID: 2324 at
drivers/xen/events/events_base.c:878 bind_evtchn_to_irq+0x88/0xf0
...
[  102.348057] Call Trace:
[  102.348057]  [<ffffffff813001df>] dump_stack+0x63/0x84
[  102.348057]  [<ffffffff81071811>] __warn+0xd1/0xf0
[  102.348057]  [<ffffffff810718fd>] warn_slowpath_null+0x1d/0x20
[  102.348057]  [<ffffffff8139a1f8>] bind_evtchn_to_irq+0x88/0xf0
[  102.348057]  [<ffffffffa00cd420>] ? blkif_copy_from_grant+0xb0/0xb0 [xen_blkfront]
[  102.348057]  [<ffffffff8139a307>] bind_evtchn_to_irqhandler+0x27/0x80
[  102.348057]  [<ffffffffa00cc785>] talk_to_blkback+0x425/0xcd0 [xen_blkfront]
[  102.348057]  [<ffffffff811e0c8a>] ? __kmalloc+0x1ea/0x200
[  102.348057]  [<ffffffffa00ce84d>] blkfront_restore+0x2d/0x60 [xen_blkfront]
[  102.348057]  [<ffffffff813a0078>] xenbus_dev_restore+0x58/0x100
[  102.348057]  [<ffffffff813a1ff0>] ?  xenbus_frontend_delayed_resume+0x20/0x20
[  102.348057]  [<ffffffff813a200e>] xenbus_dev_cond_restore+0x1e/0x30
[  102.348057]  [<ffffffff813f797e>] dpm_run_callback+0x4e/0x130
[  102.348057]  [<ffffffff813f7f17>] device_resume+0xe7/0x210
[  102.348057]  [<ffffffff813f7810>] ? pm_dev_dbg+0x80/0x80
[  102.348057]  [<ffffffff813f9374>] dpm_resume+0x114/0x2f0
[  102.348057]  [<ffffffff810c00cf>] hibernation_snapshot+0x15f/0x380
[  102.348057]  [<ffffffff810c0ac3>] hibernate+0x183/0x290
[  102.348057]  [<ffffffff810be1af>] state_store+0xcf/0xe0
[  102.348057]  [<ffffffff813020bf>] kobj_attr_store+0xf/0x20
[  102.348057]  [<ffffffff8127c88a>] sysfs_kf_write+0x3a/0x50
[  102.348057]  [<ffffffff8127c3bb>] kernfs_fop_write+0x10b/0x190
[  102.348057]  [<ffffffff81200008>] __vfs_write+0x28/0x120
[  102.348057]  [<ffffffff81200c19>] ? rw_verify_area+0x49/0xb0
[  102.348057]  [<ffffffff81200e62>] vfs_write+0xb2/0x1b0
[  102.348057]  [<ffffffff81202196>] SyS_write+0x46/0xa0
[  102.348057]  [<ffffffff81520cf7>] entry_SYSCALL_64_fastpath+0x1a/0xa9
[  102.423005] ---[ end trace b8d6718e22e2b107 ]---
[  102.425031] genirq: Flags mismatch irq 6. 00000000 (blkif) vs. 00000000 (floppy)

Note that we don't explicitly re-allocate event channels for such
devices in the resume callback. Re-allocation will occur when PM core
re-enable IRQs for the devices at later point.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 arch/x86/xen/suspend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index dae0f74..affa63d 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -105,6 +105,8 @@ static int xen_syscore_suspend(void)
 		xen_save_steal_clock(cpu);
 	}
 
+	xen_shutdown_pirqs();
+
 	xrfp.domid = DOMID_SELF;
 	xrfp.gpfn = __pa(HYPERVISOR_shared_info) >> PAGE_SHIFT;
 
-- 
2.7.4

