Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED632C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA218263BD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA218263BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935152AbeFZBJj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:09:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935093AbeFZBJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:09:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EB8A401EF1D;
        Tue, 26 Jun 2018 01:09:31 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-29.rdu2.redhat.com [10.10.122.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B02B8111DCEB;
        Tue, 26 Jun 2018 01:09:30 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Monk Liu <Monk.Liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/amdgpu: Add amdgpu_atpx_get_dhandle()
Date:   Mon, 25 Jun 2018 21:09:06 -0400
Message-Id: <20180626010916.20300-4-lyude@redhat.com>
In-Reply-To: <20180626010916.20300-1-lyude@redhat.com>
References: <20180626010916.20300-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 01:09:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 01:09:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it seems that some vendors are storing the ATIF ACPI methods under
the same handle that ATPX lives under instead of the device's own
handle, we're going to need to be able to retrieve this handle later so
we can probe for ATIF there.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e7e70518748a..06401f0cde6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1819,6 +1819,12 @@ static inline bool amdgpu_atpx_dgpu_req_power_for_displays(void) { return false;
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
index 717cc5a90313..8a46073f0778 100644
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

