Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15934C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3288213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129979;
	bh=f+KK4wn6hMm0Nn/krVCJnuvZ0Ah+ECRQdggB5cMs39E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FHwVfLLRobqIcPaMx4ba6QiFPorUdz4XyJYfbPPQ0COuBBPaRqbTCSDbeunrCX4iG
	 izlgU0PBooXPeHkzOsZGhq5BGIarlp8Q5/17+GKuToYS8LYPtPPGmRcolUmZaPN5pU
	 JHtrMaJ21b7KwpejRSti+r0d2c+pU7xbOjyDJvfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfBYV0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbfBYV0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FAC820C01;
        Mon, 25 Feb 2019 21:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129975;
        bh=f+KK4wn6hMm0Nn/krVCJnuvZ0Ah+ECRQdggB5cMs39E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgGb+IdcdPMw9rmrgjvjazfUOHftxsIQ1XZxA66Za2qgh3TxFZ439z708x+wf4uOe
         Vua49zj41hRaZAkO0GSaJ6dwPzlrvQR3RzM0mHfHzVqVE84ApOlW0ZEGq7qaJjlQvA
         gluThlhfr5xRR7n3fZnOiaC1O5lWp23Br8LwjuVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=D0=AF=D1=80=D0=BE=D1=81=D0=BB=D0=B0=D0=B2=20=D0=A1=D0=B5=D0=BC=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
        <ukrkyi@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 127/152] gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
Date:   Mon, 25 Feb 2019 22:11:59 +0100
Message-Id: <20190225195051.982311390@linuxfoundation.org>
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


