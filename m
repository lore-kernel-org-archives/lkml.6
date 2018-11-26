Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA6C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B75D21473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg9e5/eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B75D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeKZVwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbeKZVwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:52:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E5820817;
        Mon, 26 Nov 2018 10:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229936;
        bh=HYFe9nK2aObKMcXlupMlGwpVBT9IUMRlLqCSsy7N1pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tg9e5/eCzImCPlrgxIp9hRrBscBpBe3Qds7Kdyc/eN6QAQ2NunjgtFekkGAA1NszO
         6rJrBhGQh9nPOQG7oYmT7OJMZXVu7kfuvx7hvin9sA30WfJLr0ZsZgwMDlQkTfnTRA
         h2kXqTbgRgyDwTpjecaDswEk1xXwG+H7U4g8GJXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Cooper Chiou <cooper.chiou@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>, Lee@vger.kernel.org,
        Shawn C <shawn.c.lee@intel.com>
Subject: [PATCH 4.14 10/62] drm/edid: Add 6 bpc quirk for BOE panel.
Date:   Mon, 26 Nov 2018 11:50:51 +0100
Message-Id: <20181126105051.765873474@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d1191ebed072..ed01e3aae0e8 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -120,6 +120,9 @@ static const struct edid_quirk {
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



