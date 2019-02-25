Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61565C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C15720652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130780;
	bh=WxxZoOTv+3ju1FEgM4Dx8QJknMpyNVmfMrHXIVZNSlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTsBy+N2A683AY5LCoc7cd++yQwZJpxT7uo9858JWSWHmG6cb/hRtooGCpJBoRgNG
	 ze2lwEnvamb39nIbrkeCnIuwpr42+FOo4gCeJBVhz7pdZXKJ3ALdjYLpR1OJMbr52g
	 bHw2hPqVCS1bkUH/EvzxxOKYbJBaAsK5WsUhRKCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbfBYVfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732618AbfBYVft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9525621841;
        Mon, 25 Feb 2019 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130549;
        bh=WxxZoOTv+3ju1FEgM4Dx8QJknMpyNVmfMrHXIVZNSlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYaVzo0rdBwA/zpwNa3iQ56da2eEWLRmCpHUsC3jGVosInwCeEMbq6a16uN1Zh7sP
         esxPa2UUUaGja0pOsmb1m6SbeVo8Pv8vlFtlhmwOLk8SJEyON9Yjw46/mr1I+se2hH
         eyeRln89t2p4WGrVkSpB3OSemkhd3sIRCLCLv9/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=D0=AF=D1=80=D0=BE=D1=81=D0=BB=D0=B0=D0=B2=20=D0=A1=D0=B5=D0=BC=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
        <ukrkyi@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.20 157/183] gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
Date:   Mon, 25 Feb 2019 22:12:10 +0100
Message-Id: <20190225195121.444774739@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 450d007d199e632a1a4c4b91302deacd7d56815f upstream.

On HP ProBook 4540s, if PM-runtime is enabled in the radeon driver
and the direct-complete optimization is used for the radeon device
during system-wide suspend, the system doesn't resume.

Preventing direct-complete from being used with the radeon device by
setting the DPM_FLAG_NEVER_SKIP driver flag for it makes the problem
go away, which indicates that direct-complete is not safe for the
radeon driver in general and should not be used with it (at least
for now).

This fixes a regression introduced by commit c62ec4610c40
("PM / core: Fix direct_complete handling for devices with no
callbacks") which allowed direct-complete to be applied to
devices without PM callbacks (again) which in turn unlocked
direct-complete for radeon on HP ProBook 4540s.

Fixes: c62ec4610c40 ("PM / core: Fix direct_complete handling for devices with no callbacks")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201519
Reported-by: Ярослав Семченко <ukrkyi@gmail.com>
Tested-by: Ярослав Семченко <ukrkyi@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_kms.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -172,6 +172,7 @@ int radeon_driver_load_kms(struct drm_de
 	}
 
 	if (radeon_is_px(dev)) {
+		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_set_active(dev->dev);


