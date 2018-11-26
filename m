Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B9AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2DE2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzVomuNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2DE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeKZWAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZWAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:00:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E7720645;
        Mon, 26 Nov 2018 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230380;
        bh=WGRc9f0fNtoAKrQlOaQNzJ6dgUv1//++lL4Jwr9AHlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzVomuNjZJIW83O0t+Y0Jt2O5lH8i3OsllC8QNUJZx9hfAJ34QjPMHbMpIR7cxIAo
         XVSAREh+10LbGqPiRfs4avu08CJa6C7vvyuD8nqiA2ok1ay98jwkNCP3Jy8DVe5HEi
         f0cImhfrra1hkK9caFpkQMoWR+hP2dq1JQn1Z3CE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bruce Allan <bruce.w.allan@intel.com>,
        Chinh T Cao <chinh.t.cao@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/118] ice: Change req_speeds to be u16
Date:   Mon, 26 Nov 2018 11:51:13 +0100
Message-Id: <20181126105104.805674384@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ffe498237b36ee42624e139b21efa05da4ff1f48 ]

Since the req_speeds field in struct ice_link_status is a u8,
req_speeds & ICE_AQ_LINK_SPEED_40GB always returns 0. This was caught
by a coverity scan.

Fix this by changing req_speeds to be u16.

Reported-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 97c366e0ca59..ba11b5898833 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -83,12 +83,12 @@ struct ice_link_status {
 	u64 phy_type_low;
 	u16 max_frame_size;
 	u16 link_speed;
+	u16 req_speeds;
 	u8 lse_ena;	/* Link Status Event notification */
 	u8 link_info;
 	u8 an_info;
 	u8 ext_info;
 	u8 pacing;
-	u8 req_speeds;
 	/* Refer to #define from module_type[ICE_MODULE_TYPE_TOTAL_BYTE] of
 	 * ice_aqc_get_phy_caps structure
 	 */
-- 
2.17.1



