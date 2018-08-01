Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE189C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2C7208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2C7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407680AbeHATV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:21:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436607AbeHATSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48E5EE27;
        Wed,  1 Aug 2018 16:53:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>,
        Rex Zhu <rezhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 018/336] drm/amd/powerplay: Set higher SCLK&MCLK frequency than dpm7 in OD (v2)
Date:   Wed,  1 Aug 2018 18:45:53 +0200
Message-Id: <20180801165029.683351853@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit 5c16f36f6f003b4415237acca59384a074cd8030 ]

Fix the issue that SCLK&MCLK can't be set higher than dpm7 when
OD is enabled in SMU7.

v2: fix warning (Alex)

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Rex Zhu<rezhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3715,14 +3715,17 @@ static int smu7_trim_dpm_states(struct p
 static int smu7_generate_dpm_level_enable_mask(
 		struct pp_hwmgr *hwmgr, const void *input)
 {
-	int result;
+	int result = 0;
 	const struct phm_set_power_state_input *states =
 			(const struct phm_set_power_state_input *)input;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	const struct smu7_power_state *smu7_ps =
 			cast_const_phw_smu7_power_state(states->pnew_state);
 
-	result = smu7_trim_dpm_states(hwmgr, smu7_ps);
+	/*skip the trim if od is enabled*/
+	if (!hwmgr->od_enabled)
+		result = smu7_trim_dpm_states(hwmgr, smu7_ps);
+
 	if (result)
 		return result;
 


