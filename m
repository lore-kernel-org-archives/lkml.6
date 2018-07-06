Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A9BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C50023FE7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C50023FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeGFFsZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:48:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59794 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933177AbeGFFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:48:16 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 082CDB14;
        Fri,  6 Jul 2018 05:48:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.17 28/46] drm/amdgpu: Dont default to DC support for Kaveri and older
Date:   Fri,  6 Jul 2018 07:46:49 +0200
Message-Id: <20180706054525.936593740@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
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

From: Harry Wentland <harry.wentland@amd.com>

commit d9fda248046ac035f18a6e663f2f9245b4bf9470 upstream.

We've had a number of users report failures to detect and light up
display with DC with LVDS and VGA. These connector types are not
currently supported with DC. I'd like to add support but unfortunately
don't have a system with LVDS or VGA available.

In order not to cause regressions we should probably fallback to the
non-DC driver for ASICs that support VGA and LVDS.

These ASICs are:
 * Bonaire
 * Kabini
 * Kaveri
 * Mullins

ASIC support can always be force enabled with amdgpu.dc=1

v2: Keep Hawaii on DC
v3: Added Mullins to the list

Cc: stable@vger.kernel.org
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2080,10 +2080,18 @@ bool amdgpu_device_asic_has_dc_support(e
 	switch (asic_type) {
 #if defined(CONFIG_DRM_AMD_DC)
 	case CHIP_BONAIRE:
-	case CHIP_HAWAII:
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
+		/*
+		 * We have systems in the wild with these ASICs that require
+		 * LVDS and VGA support which is not supported with DC.
+		 *
+		 * Fallback to the non-DC driver here by default so as not to
+		 * cause regressions.
+		 */
+		return amdgpu_dc > 0;
+	case CHIP_HAWAII:
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
 	case CHIP_POLARIS11:


