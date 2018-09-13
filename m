Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0D9C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E689620652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E689620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeIMTOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:14:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeIMTOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:14:10 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E19CD36;
        Thu, 13 Sep 2018 14:04:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikita Lipski <mikita.lipski@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.18 172/197] drm/amd/display: Pass connector id when executing VBIOS CT
Date:   Thu, 13 Sep 2018 15:32:01 +0200
Message-Id: <20180913131848.445068290@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikita Lipski <mikita.lipski@amd.com>

commit 433149130c31de3f63b17b4ce08b45dab208f7e8 upstream.

[why]
Older ASICs require both phys_id and connector_id
to execute bios command table. If we are not passing the
right connector_id - it can lead to a black screen.

[how]
Set connector_obj_id when executing vbios command table

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -919,7 +919,7 @@ void dce110_link_encoder_enable_tmds_out
 	enum bp_result result;
 
 	/* Enable the PHY */
-
+	cntl.connector_obj_id = enc110->base.connector;
 	cntl.action = TRANSMITTER_CONTROL_ENABLE;
 	cntl.engine_id = enc->preferred_engine;
 	cntl.transmitter = enc110->base.transmitter;
@@ -961,7 +961,7 @@ void dce110_link_encoder_enable_dp_outpu
 	 * We need to set number of lanes manually.
 	 */
 	configure_encoder(enc110, link_settings);
-
+	cntl.connector_obj_id = enc110->base.connector;
 	cntl.action = TRANSMITTER_CONTROL_ENABLE;
 	cntl.engine_id = enc->preferred_engine;
 	cntl.transmitter = enc110->base.transmitter;


