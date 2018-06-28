Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B99C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF0E2786F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF0E2786F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754876AbeF1TPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:15:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754322AbeF1TPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2101CC12A0;
        Thu, 28 Jun 2018 19:15:23 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A82401116717;
        Thu, 28 Jun 2018 19:15:22 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Monk Liu <Monk.Liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Huang Rui <ray.huang@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] drm/amdgpu: Add amdgpu_atpx_get_dhandle()
Date:   Thu, 28 Jun 2018 15:14:54 -0400
Message-Id: <20180628191505.10015-4-lyude@redhat.com>
In-Reply-To: <20180628191505.10015-1-lyude@redhat.com>
References: <20180628191505.10015-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 19:15:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 19:15:23 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handles for ACPI methods like ATPX and ATIF will live under the
integrated GPU's namespace on systems with more then one GPU. ATPX is
already detected regardless of the namespace it lives in, and it will
always be in the same namespace as ATIF. So we can make things easier on
ourselves by just adding some functions to retrieve said namespace so it
can be searched later for ATIF.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7df5d3d11aff..7dcbac8af9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1858,6 +1858,12 @@ static inline bool amdgpu_atpx_dgpu_req_power_for_displays(void) { return false;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index a3896412a019..b33f1680c9a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -90,6 +90,12 @@ bool amdgpu_atpx_dgpu_req_power_for_displays(void) {
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
-- 
2.17.1

