Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7D3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C1421476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxmOqQvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C1421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJQBEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701B02089E;
        Tue, 16 Oct 2018 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710003;
        bh=V3E3AclmgBQpHpElSz20n57Hi18gyfP3YalyhX8VoKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fxmOqQvo02Doj9v0ImqtEhv5S1A3YhwS/PFVEziFDes3dX/rNQlwMTKbHhgP5WEl4
         aMx2fO7kzy261ajwQIEnkf7VDXjcapRnQyoUhhaYqmUmmT4nXoufZ3YXcdEJ0Ua+IV
         urZAhzabpPHMRnTC7RFODPvPElnMW75ujjoDjfO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Danny Smith <dannys@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 070/135] ASoC: sigmadsp: safeload should not have lower byte limit
Date:   Tue, 16 Oct 2018 19:05:00 +0200
Message-Id: <20181016170519.563174456@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Danny Smith <danny.smith@axis.com>

[ Upstream commit 5ea752c6efdf5aa8a57aed816d453a8f479f1b0a ]

Fixed range in safeload conditional to allow safeload to up to 20 bytes,
without a lower limit.

Signed-off-by: Danny Smith <dannys@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/sigmadsp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -117,8 +117,7 @@ static int sigmadsp_ctrl_write(struct si
 	struct sigmadsp_control *ctrl, void *data)
 {
 	/* safeload loads up to 20 bytes in a atomic operation */
-	if (ctrl->num_bytes > 4 && ctrl->num_bytes <= 20 && sigmadsp->ops &&
-	    sigmadsp->ops->safeload)
+	if (ctrl->num_bytes <= 20 && sigmadsp->ops && sigmadsp->ops->safeload)
 		return sigmadsp->ops->safeload(sigmadsp, ctrl->addr, data,
 			ctrl->num_bytes);
 	else


