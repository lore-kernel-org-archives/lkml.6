Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4126C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD0E21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+8GwPZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD0E21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbeJKXHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B5C2087A;
        Thu, 11 Oct 2018 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272389;
        bh=cyzr15EHlcvz9mFwASs4995w1We+Mv6So6c1uNyHsrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+8GwPZuw51gq9fRVv29d40UBz6aIdBXTm1TEVt+vveWa0FKyc+V/5J629MJ1S3yP
         PFwuMj2uNIRhZOa3xLLLucrpjQRS+ScVIGmfWNaKeJwljI14obaYhQw6kmv7GsPQ2g
         z8DMVUauNhmmfoGv0vTbb5MQWYDeK524Q7LbAeJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 065/120] thermal: of-thermal: disable passive polling when thermal zone is disabled
Date:   Thu, 11 Oct 2018 17:34:06 +0200
Message-Id: <20181011152552.485489835@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 152395fd03d4ce1e535a75cdbf58105e50587611 ]

When thermal zone is in passive mode, disabling its mode from
sysfs is NOT taking effect at all, it is still polling the
temperature of the disabled thermal zone and handling all thermal
trips, it makes user confused. The disabling operation should
disable the thermal zone behavior completely, for both active and
passive mode, this patch clears the passive_delay when thermal
zone is disabled and restores it when it is enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/of-thermal.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -209,10 +209,13 @@ static int of_thermal_set_mode(struct th
 
 	mutex_lock(&tz->lock);
 
-	if (mode == THERMAL_DEVICE_ENABLED)
+	if (mode == THERMAL_DEVICE_ENABLED) {
 		tz->polling_delay = data->polling_delay;
-	else
+		tz->passive_delay = data->passive_delay;
+	} else {
 		tz->polling_delay = 0;
+		tz->passive_delay = 0;
+	}
 
 	mutex_unlock(&tz->lock);
 


