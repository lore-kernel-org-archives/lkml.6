Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B915BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8019A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8019A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLCWYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:24:46 -0500
Received: from anholt.net ([50.246.234.109]:54156 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCWYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:24:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C214D10A1570;
        Mon,  3 Dec 2018 14:24:42 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id TR4QQcM8khiP; Mon,  3 Dec 2018 14:24:39 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B5F6810A0D70;
        Mon,  3 Dec 2018 14:24:39 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id D02522FE2D16; Mon,  3 Dec 2018 14:24:38 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/6] drm/v3d: Document cache flushing ABI.
Date:   Mon,  3 Dec 2018 14:24:33 -0800
Message-Id: <20181203222438.25417-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, userspace doesn't do any L2T writes, but we should lay out
our expectations for how it works.

v2: Explicitly mention the VCD cache flushing requirements and that
    we'll flush the other caches before each of the CLs.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 include/uapi/drm/v3d_drm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index 35c7d813c66e..ea70669d2138 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -52,6 +52,14 @@ extern "C" {
  *
  * This asks the kernel to have the GPU execute an optional binner
  * command list, and a render command list.
+ *
+ * The L1T, slice, L2C, L2T, and GCA caches will be flushed before
+ * each CL executes.  The VCD cache should be flushed (if necessary)
+ * by the submitted CLs.  The TLB writes are guaranteed to have been
+ * flushed by the time the render done IRQ happens, which is the
+ * trigger for out_sync.  Any dirtying of cachelines by the job (only
+ * possible using TMU writes) must be flushed by the caller using the
+ * CL's cache flush commands.
  */
 struct drm_v3d_submit_cl {
 	/* Pointer to the binner command list.
-- 
2.20.0.rc1

