Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADB3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DF520A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DF520A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbeGJSfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:35:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389507AbeGJSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:35:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A3F7E78;
        Tue, 10 Jul 2018 18:35:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.17 25/56] drm/amdgpu: Add amdgpu_atpx_get_dhandle()
Date:   Tue, 10 Jul 2018 20:25:07 +0200
Message-Id: <20180710182504.861243642@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 4aa5d5eb82bb237d0bb3a38b2a7555054d018081 upstream.

Since it seems that some vendors are storing the ATIF ACPI methods under
the same handle that ATPX lives under instead of the device's own
handle, we're going to need to be able to retrieve this handle later so
we can probe for ATIF there.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |    6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |    6 ++++++
 2 files changed, 12 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1819,6 +1819,12 @@ static inline bool amdgpu_atpx_dgpu_req_
 static inline bool amdgpu_has_atpx(void) { return false; }
 #endif
 
+#if defined(CONFIG_VGA_SWITCHEROO) && defined(CONFIG_ACPI)
+void *amdgpu_atpx_get_dhandle(void);
+#else
+static inline void *amdgpu_atpx_get_dhandle(void) { return NULL; }
+#endif
+
 /*
  * KMS
  */
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -90,6 +90,12 @@ bool amdgpu_atpx_dgpu_req_power_for_disp
 	return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
 }
 
+#if defined(CONFIG_ACPI)
+void *amdgpu_atpx_get_dhandle(void) {
+	return amdgpu_atpx_priv.dhandle;
+}
+#endif
+
 /**
  * amdgpu_atpx_call - call an ATPX method
  *


