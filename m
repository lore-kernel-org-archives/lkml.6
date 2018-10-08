Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE669C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B739A2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+qtRwD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B739A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeJIBuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbeJIBuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:50:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781202087D;
        Mon,  8 Oct 2018 18:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023836;
        bh=l3e1hSppWsbconQqRwU8vyK+moobuDGLGAgU+nFxFCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+qtRwD54iU75GGdypbOsR1QHqwCr5oRVhuA6t4yZXhOj89E0GerOc21Y0o+IZwyR
         mKyZME5s9Gts/Oq+834qgOuNRK6ec5wIZVxW32fuqPe7/UIjuDky1GmRMEuRFftdwf
         iFUxPhpkHlkHzXeDeMTdAq9nF3RSsxMJqqSwQSWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuan-Chi Pang <fu3mo6goo@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 078/113] mac80211: mesh: fix HWMP sequence numbering to follow standard
Date:   Mon,  8 Oct 2018 20:31:19 +0200
Message-Id: <20181008175535.216280370@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuan-Chi Pang <fu3mo6goo@gmail.com>

[ Upstream commit 1f631c3201fe5491808df143d8fcba81b3197ffd ]

IEEE 802.11-2016 14.10.8.3 HWMP sequence numbering says:
If it is a target mesh STA, it shall update its own HWMP SN to
maximum (current HWMP SN, target HWMP SN in the PREQ element) + 1
immediately before it generates a PREP element in response to a
PREQ element.

Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mesh_hwmp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -552,6 +552,10 @@ static void hwmp_preq_frame_process(stru
 		forward = false;
 		reply = true;
 		target_metric = 0;
+
+		if (SN_GT(target_sn, ifmsh->sn))
+			ifmsh->sn = target_sn;
+
 		if (time_after(jiffies, ifmsh->last_sn_update +
 					net_traversal_jiffies(sdata)) ||
 		    time_before(jiffies, ifmsh->last_sn_update)) {


