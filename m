Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DF8C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87739208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="yETdzH5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87739208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933134AbeFQIxt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 04:53:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:43784 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932897AbeFQIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 04:53:48 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 3D58A5C115F;
        Sun, 17 Jun 2018 10:53:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529225627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=S56oTnM0X/4dVHOuywLQSLm+dJWcEKccpa86jm+E5wo=;
        b=yETdzH5NGoIxHRhPY4dteMm9flecqoVrf4bbfmkHGUhUC7Mawt9eZPMoPLTTmn0j7gKHNU
        uVN7UE1/g/W4hr2eOXhjj8J24wIUc2D6GGIU+FWR1wfheKqD0+0vv3kzkgipLf4JahTpvg
        nJO2ZEgVPSrvaenRn3aWZg0wJVFUirg=
From:   Stefan Agner <stefan@agner.ch>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: don't initialize result
Date:   Sun, 17 Jun 2018 10:53:38 +0200
Message-Id: <20180617085343.10760-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrong enum type is used to initialize the result, leading to a
warning when using clang:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1998:26: warning:
      implicit conversion from enumeration type 'enum ddc_result' to different
      enumeration type 'enum dc_status' [-Wenum-conversion]
        enum dc_status result = DDC_RESULT_UNKNOWN;
                       ~~~~~~   ^~~~~~~~~~~~~~~~~~
1 warning generated.

Initialization of result is unnecessary anyway, just drop the
initialization.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7857cb42b3e6..1dbfbfc0fd45 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1995,7 +1995,7 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 {
 	union hpd_irq_data hpd_irq_dpcd_data = {{{{0}}}};
 	union device_service_irq device_service_clear = { { 0 } };
-	enum dc_status result = DDC_RESULT_UNKNOWN;
+	enum dc_status result;
 	bool status = false;
 	/* For use cases related to down stream connection status change,
 	 * PSR and device auto test, refer to function handle_sst_hpd_irq
-- 
2.17.1

