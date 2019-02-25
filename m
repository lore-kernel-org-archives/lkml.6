Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC701C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3787213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129976;
	bh=wXX9XeGJvkeeeg8erZdFSy4vUxDMqE5vEcpUGrtohiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fONkuO2For7zO4YhaWN36c1Vat6dDRzQxrY9X3Hee+juO+O3NEL4GYBNQaldqct2c
	 QghVI7bW0pW79MknMlwR1Zf8pnkhIIL7nsBv7naribQSRgt6jBvqZBq1T7kbQhz8f0
	 tHnfrq3ue+5UKIWXsM6wP96FZiGlx8hZ1iEHTFtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfBYV0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730173AbfBYV0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7234B2084D;
        Mon, 25 Feb 2019 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129972;
        bh=wXX9XeGJvkeeeg8erZdFSy4vUxDMqE5vEcpUGrtohiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bf0/d7TsikRijlIOkXDPVpVilsT/MV1Nc7uPalp6MPtsOOMQOKC254eanNizH1FG6
         r231tkbJu7HrnzYpe+HUscJrt7B5DABYYWkNIdM45natL2y5UBVdu9Vm0AgNQhjbqO
         U5j2J+81rrlp7AxiqJOesUWvmirTnKJfe2ULfDJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 126/152] drm/amdgpu: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
Date:   Mon, 25 Feb 2019 22:11:58 +0100
Message-Id: <20190225195051.869450047@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit d33158530660bc89be3cc870a2152e4e9a76cac7 upstream.

Based on a similar patch from Rafael for radeon.

When using ATPX to control dGPU power, the state is not retained
across suspend and resume cycles by default.  This can probably
be loosened for Hybrid Graphics (_PR3) laptops where I think the
state is properly retained.

Fixes: c62ec4610c40 ("PM / core: Fix direct_complete handling for devices with no callbacks")
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -159,6 +159,7 @@ int amdgpu_driver_load_kms(struct drm_de
 	}
 
 	if (amdgpu_device_is_px(dev)) {
+		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_set_active(dev->dev);


