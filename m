Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D946C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1367E20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgG+N8kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1367E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKIHdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbeKIHdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:39 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4222089A;
        Thu,  8 Nov 2018 21:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714172;
        bh=JBuBtnGOQevxA6UIRXQUUAqdywB8btiS0m72H66gZHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgG+N8kNrUm2l4Ic2JA+GHo+7MEP/cH1HT8Kd8Jygo6/DIepKf5Z6sQyPQUG9W6OB
         gQtlB9DOGEzmUV9MbvgdeWyzVcwfX5cPt0/3wcieimQEPVZqd8Caljz5VN9XN0aUhk
         WCOBw6y99FKM1PdX7rIaKYHXHeiuyV+p/CFIgluw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhilash Kesavan <a.kesavan@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Kevin Hilman <khilman@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 078/144] drivers: bus: check cci device tree node status
Date:   Thu,  8 Nov 2018 13:50:49 -0800
Message-Id: <20181108215100.936726705@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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

[ Upstream commit 896ddd600ba4a3426aeb11710ae9c28dd7ce68ce ]

The arm-cci driver completes the probe sequence even if the cci node is
marked as disabled. Add a check in the driver to honour the cci status
in the device tree.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/arm-cci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7af78df241f2..99cad3ac38f2 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -976,6 +976,9 @@ static int cci_probe(void)
 	if (!np)
 		return -ENODEV;
 
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
 	cci_config = of_match_node(arm_cci_matches, np)->data;
 	if (!cci_config)
 		return -ENODEV;
-- 
2.17.1



