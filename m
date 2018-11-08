Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCEFC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2A320883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge4rcLlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2A320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbeKIHyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbeKIHot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:49 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BACD2147D;
        Thu,  8 Nov 2018 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714838;
        bh=4MnFavfp57ey5/UPNnM2kDY1JgEmIaYOGbMiMLo2qhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge4rcLlYhzjuZw+JdUgo7BaL3n6d99mv794BV63tmkuep2KUfzS5gNOQwLLrqy6CY
         OngZg1HHVBOprdRmDIdifpawDT8yXMHHjk2WoPrSDchhLSLN4aQ8LerkZ18ieongYG
         7rsqbx+vzj2a2ELF774VxwWjFnOng03MQtBUGb2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.9 160/171] drm/edid: Add 6 bpc quirk for BOE panel in HP Pavilion 15-n233sl
Date:   Thu,  8 Nov 2018 13:52:10 -0800
Message-Id: <20181108215138.435376870@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 0711a43b6d84ff9189adfbf83c8bbf56eef794bf upstream.

There's another panel that reports "DFP 1.x compliant TMDS" but it
supports 6bpc instead of 8 bpc.

Apply 6 bpc quirk for the panel to fix it.

BugLink: https://bugs.launchpad.net/bugs/1794387
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181002152911.4370-1-kai.heng.feng@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -107,6 +107,9 @@ static const struct edid_quirk {
 	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
 	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
 
+	/* BOE model on HP Pavilion 15-n233sl reports 8 bpc, but is a 6 bpc panel */
+	{ "BOE", 0x78b, EDID_QUIRK_FORCE_6BPC },
+
 	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
 	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
 


