Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A317C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BE520823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfBUPue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:50:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:50434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbfBUPua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:50:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 21 Feb 2019 07:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="136108167"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2019 07:50:27 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
Subject: [GIT PULL v1 5/7] intel_th: Don't reference unassigned outputs
Date:   Thu, 21 Feb 2019 17:50:04 +0200
Message-Id: <20190221155006.76832-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
References: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an output port driver is removed, also remove references to it from
any masters. Failing to do this causes a NULL ptr dereference when
configuring another output port:

> BUG: unable to handle kernel NULL pointer dereference at 000000000000000d
> RIP: 0010:master_attr_store+0x9d/0x160 [intel_th_gth]
> Call Trace:
> dev_attr_store+0x1b/0x30
> sysfs_kf_write+0x3c/0x50
> kernfs_fop_write+0x125/0x1a0
> __vfs_write+0x3a/0x190
> ? __vfs_write+0x5/0x190
> ? _cond_resched+0x1a/0x50
> ? rcu_all_qs+0x5/0xb0
> ? __vfs_write+0x5/0x190
> vfs_write+0xb8/0x1b0
> ksys_write+0x55/0xc0
> __x64_sys_write+0x1a/0x20
> do_syscall_64+0x5a/0x140
> entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: b27a6a3f97b9 ("intel_th: Add Global Trace Hub driver")
CC: stable@vger.kernel.org # v4.4+
Reported-by: Ammy Yi <ammy.yi@intel.com>
---
 drivers/hwtracing/intel_th/gth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index 8426b7970c14..cc287cf6eb29 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -607,6 +607,7 @@ static void intel_th_gth_unassign(struct intel_th_device *thdev,
 {
 	struct gth_device *gth = dev_get_drvdata(&thdev->dev);
 	int port = othdev->output.port;
+	int master;
 
 	if (thdev->host_mode)
 		return;
@@ -615,6 +616,9 @@ static void intel_th_gth_unassign(struct intel_th_device *thdev,
 	othdev->output.port = -1;
 	othdev->output.active = false;
 	gth->output[port].output = NULL;
+	for (master = 0; master < TH_CONFIGURABLE_MASTERS; master++)
+		if (gth->master[master] == port)
+			gth->master[master] = -1;
 	spin_unlock(&gth->gth_lock);
 }
 
-- 
2.20.1

