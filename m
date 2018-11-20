Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D97C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1B4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XonVZplY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1B4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeKTTHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:07:00 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12774 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKTTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:07:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3c82f0002>; Tue, 20 Nov 2018 00:39:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 00:39:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 00:39:03 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 08:39:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 08:39:02 +0000
Received: from amhetre.nvidia.com (Not Verified[10.24.229.42]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bf3c8240004>; Tue, 20 Nov 2018 00:39:02 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <tj@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <vdumpa@nvidia.com>,
        <Snikam@nvidia.com>, Bo Yan <byan@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH] kernfs: Add check for NULL pointer before writing to it.
Date:   Tue, 20 Nov 2018 14:08:39 +0530
Message-ID: <1542703119-20353-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542703152; bh=+T7KucmlIW5PUrJxv2ZCUBeUgYTASCM/6lummfHH+gc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=XonVZplYv2ptDJTejUkhZl6pZtykVE+IwVOPZq4mir5vPHNVw5px/vWk+zO2wTnEE
         tnVQ4J2Q2F/wV51GJxRtyo+DngjUr0By5Tvlwy5+rfqfXJpv3rMD4hLwlVwqarLJVn
         w0L7/nusfSldUc7z+SE8zGOGh+wYssOjS9EGRFI/4sRypcQ3aRkMoVcLtXGgmzHjhb
         9lE+biIenJRaNB766Bad2EPBuld9IcW+xUyft6LoAATR+6AbdHD/jMAiayMhK5efu5
         pQgLuMR/2+uivQULRnPesuSIUWD9OXerdCWf5HOvF/qhKWYiLq1TWj44COlmqP7KHb
         ca0gb0DOrKCBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Yan <byan@nvidia.com>

The strlcpy function returns the length of source pointer when the
requested size is 0. This behavior is relied upon for sched tracing.
We can't simply return when buf is 0, but we have to protect against the
scenario when buf is 0 and requested size is non-zero, in which case the
strlcpy would lead to illegal memory access.
This issue is reported by coverity as strlcpy might end up using a NULL
buffer and non-zero buf_length value.
To avoid this, add check and return -EINVAL in this case.

Signed-off-by: Bo Yan <byan@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 fs/kernfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4ca0b5c..76c85a5 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -129,6 +129,9 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	size_t depth_from, depth_to, len = 0;
 	int i, j;
 
+	if (WARN_ON(!buf && buflen > 0))
+		return -EINVAL;
+
 	if (!kn_to)
 		return strlcpy(buf, "(null)", buflen);
 
-- 
2.7.4

