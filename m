Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A6C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0443020673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0443020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLAMJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:09:14 -0500
Received: from anholt.net ([50.246.234.109]:42730 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLAMJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:09:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 14AE710A1578;
        Fri, 30 Nov 2018 16:58:02 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KODj7XBNvs-1; Fri, 30 Nov 2018 16:58:00 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4F36A10A03F9;
        Fri, 30 Nov 2018 16:58:00 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 5F4522FE36E1; Fri, 30 Nov 2018 16:57:59 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/6] drm/v3d: Document cache flushing ABI.
Date:   Fri, 30 Nov 2018 16:57:54 -0800
Message-Id: <20181201005759.28093-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, userspace doesn't do any L2T writes, but we should lay out
our expectations for how it works.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 include/uapi/drm/v3d_drm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index 35c7d813c66e..95b8f8e82ea5 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -52,6 +52,13 @@ extern "C" {
  *
  * This asks the kernel to have the GPU execute an optional binner
  * command list, and a render command list.
+ *
+ * The caches (L1T, slice, and L2T) will be flushed before the job
+ * executes.  The TLB writes are guaranteed to have been flushed by
+ * the time the render done IRQ happens, which is the trigger for
+ * out_sync.  Any dirtying of cachelines by the job (only possible
+ * using TMU writes) must be flushed by the caller using the CL's
+ * cache flush commands.
  */
 struct drm_v3d_submit_cl {
 	/* Pointer to the binner command list.
-- 
2.20.0.rc1

