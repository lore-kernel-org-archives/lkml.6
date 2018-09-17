Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3495BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62092146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62092146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbeIREnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:43:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeIREnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:43:04 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 962F9CAC;
        Mon, 17 Sep 2018 23:13:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 126/158] thermal: rcar_thermal: avoid NULL dereference in absence of IRQ resources
Date:   Tue, 18 Sep 2018 00:42:36 +0200
Message-Id: <20180917211717.021908943@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Simon Horman <horms+renesas@verge.net.au>

[ Upstream commit 542cdf4068049458e1411b120bd5a4bbe3ddc49a ]

Ensure that the base address used by a call to rcar_thermal_common_write()
may be NULL if the SOC supports interrupts for use with the thermal device
but none are defined in DT as is the case for R-Car H1 (r8a7779). Guard
against this condition to prevent a NULL dereference when the device is
probed.

Tested on:
* R-Mobile APE6 (r8a73a4) / APE6EVM
* R-Car H1 (r8a7779) / Marzen
* R-Car H2 (r8a7790) / Lager
* R-Car M2-W (r8a7791) / Koelsch
* R-Car M2-N (r8a7793) / Gose
* R-Car D3 ES1.0 (r8a77995) / Draak

Fixes: 1969d9dc2079 ("thermal: rcar_thermal: add r8a77995 support")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/rcar_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -598,7 +598,7 @@ static int rcar_thermal_probe(struct pla
 			enr_bits |= 3 << (i * 8);
 	}
 
-	if (enr_bits)
+	if (common->base && enr_bits)
 		rcar_thermal_common_write(common, ENR, enr_bits);
 
 	dev_info(dev, "%d sensor probed\n", i);


