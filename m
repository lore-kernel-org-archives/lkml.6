Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290A42073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfACGGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 01:06:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:50787 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfACGGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 01:06:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 22:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,433,1539673200"; 
   d="scan'208";a="264035070"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2019 22:06:07 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
Cc:     borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        wei.w.wang@intel.com, pasic@linux.ibm.com
Subject: [PATCH v1 2/2] virtio-balloon: improve update_balloon_size_func
Date:   Thu,  3 Jan 2019 13:31:02 +0800
Message-Id: <1546493462-32244-3-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to update the balloon actual register when there is no
ballooning request. This patch avoids update_balloon_size when diff is 0.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/virtio/virtio_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9a82a11..4884b85 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -435,9 +435,12 @@ static void update_balloon_size_func(struct work_struct *work)
 			  update_balloon_size_work);
 	diff = towards_target(vb);
 
+	if (!diff)
+		return;
+
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
-	else if (diff < 0)
+	else
 		diff += leak_balloon(vb, -diff);
 	update_balloon_size(vb);
 
-- 
2.7.4

