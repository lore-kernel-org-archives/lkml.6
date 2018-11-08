Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AD0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B434921019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGrBI3l5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B434921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeKIHmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbeKIHmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:52 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7595520844;
        Thu,  8 Nov 2018 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714722;
        bh=iUDu25NN232zrLOhWQJhLf5sIa6tvFCCtQ6y+a8Xga8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGrBI3l5+LrOMPXJdV8xMz5nvgPf16cG4e5Qq1UGcW0iVGhrWacHzxzI0wdztVPOa
         hoZy719FT3rB164CbiilF7IFxioBvuym4sv3ftecwmN4CQ7ittIyy/TyZEMpA7Kd2S
         VUeHMlMBgbX2idqzUakN2B1RtkCBcRsLIL2m5Ki0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aditya Shankar <aditya.shankar@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 084/171] staging: wilc1000: Fix problem with wrong vif index
Date:   Thu,  8 Nov 2018 13:50:54 -0800
Message-Id: <20181108215133.574744598@linuxfoundation.org>
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

[ Upstream commit 0e490657c7214cce33fbca3d88227298c5c968ae ]

The vif->idx value is always 0 for two interfaces.

wl->vif_num = 0;

loop {
     ...

     vif->idx = wl->vif_num;
     ...
     wl->vif_num = i;
      ....
     i++;
     ...
}

At present, vif->idx is assigned the value of wl->vif_num
at the beginning of this block and device is initialized
based on this index value.
In the next iteration, wl->vif_num is still 0 as it is only updated
later but gets assigned to vif->idx in the beginning. This causes problems
later when we try to reference a particular interface and also while
configuring the firmware.

This patch moves the assignment to vif->idx from the beginning
of the block to after wl->vif_num is updated with latest value of i.

Fixes: commit 735bb39ca3be ("staging: wilc1000: simplify vif[i]->ndev accesses")
Cc: <stable@vger.kernel.org>
Signed-off-by: Aditya Shankar <aditya.shankar@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wilc1000/linux_wlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index 07d6e4824a9d..2e5e3b368532 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -1260,11 +1260,12 @@ int wilc_netdev_init(struct wilc **wilc, struct device *dev, int io_type,
 		else
 			strcpy(ndev->name, "p2p%d");
 
-		vif->idx = wl->vif_num;
 		vif->wilc = *wilc;
 		vif->ndev = ndev;
 		wl->vif[i] = vif;
 		wl->vif_num = i;
+		vif->idx = wl->vif_num;
+
 		ndev->netdev_ops = &wilc_netdev_ops;
 
 		{
-- 
2.17.1



