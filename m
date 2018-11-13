Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56160C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E628223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="So7mKQIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E628223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbeKMPry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732220AbeKMPrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:53 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362F022520;
        Tue, 13 Nov 2018 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088286;
        bh=b7NrWvlsSEDlYbYwD8VxzSkYqIuhmB6weCYjkGYZCNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=So7mKQIc/zkszrZPyTG2d1tetLmoxYJ+beiPzikhyww5u2jDWd2g3cLtf8nmgyJjJ
         M0Sdz3Ppux8pGjX9E49nA7PZIUy1CWmKUO8EXqMHusB1w4YKZI8wZkPr/y/vttDyRU
         dVMnebYytJSR+HwtOBhLmgH7gKAfRukrm48UgPt0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Lee, Shawn C" <shawn.c.lee@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Cooper Chiou <cooper.chiou@intel.com>, Lee@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.18 19/39] drm/edid: Add 6 bpc quirk for BOE panel.
Date:   Tue, 13 Nov 2018 00:50:33 -0500
Message-Id: <20181113055053.78352-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lee, Shawn C" <shawn.c.lee@intel.com>

[ Upstream commit 922dceff8dc1fb4dafc9af78139ba65671408103 ]

BOE panel (ID: 0x0771) that reports "DFP 1.x compliant TMDS".
But it's 6bpc panel only instead of 8 bpc.

Add panel ID to edid quirk list and set 6 bpc as default to
work around this issue.

Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Cooper Chiou <cooper.chiou@intel.com>
Signed-off-by: Lee, Shawn C <shawn.c.lee@intel.com>>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1540792173-7288-1-git-send-email-shawn.c.lee@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index d74d9a8cde2a..e20bfbc50ade 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -122,6 +122,9 @@ static const struct edid_quirk {
 	/* SDC panel of Lenovo B50-80 reports 8 bpc, but is a 6 bpc panel */
 	{ "SDC", 0x3652, EDID_QUIRK_FORCE_6BPC },
 
+	/* BOE model 0x0771 reports 8 bpc, but is a 6 bpc panel */
+	{ "BOE", 0x0771, EDID_QUIRK_FORCE_6BPC },
+
 	/* Belinea 10 15 55 */
 	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
 	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
-- 
2.17.1

