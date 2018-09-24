Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED82C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CC82083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CC82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbeIXSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:46:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388911AbeIXSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:46:26 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45C1B1099;
        Mon, 24 Sep 2018 12:44:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 217/235] remoteproc: qcom: q6v5-pil: fix modem hang on SDM845 after axis2 clk unvote
Date:   Mon, 24 Sep 2018 13:53:23 +0200
Message-Id: <20180924113125.212385752@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Sibi Sankar <sibis@codeaurora.org>

[ Upstream commit 7cbb540a3a68e4d4a8bef2d9451afb1635b5d2d3 ]

GCC_MSS_AXIS2 clock is used for disabling boot IMEM (a part of
AP boot up). With Boot IMEM disable now a part TZ/ATF, AXIS2
clock is no longer required post AP boot up and expected to
remain untouched. However if the clock is turned ON after Q6
is brought out of reset and later turned off, it results in
modem hang. When Q6 attempts a power collapse the internal
handshaking to check if AXIS2 is idle never goes through since
it is turned off preventing the RSC from getting triggered,
leaving modem in a funky state. Hence removing AXIS2 clk
enable/disable from the driver.

Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1370,7 +1370,6 @@ static const struct rproc_hexagon_res sd
 	.hexagon_mba_image = "mba.mbn",
 	.proxy_clk_names = (char*[]){
 			"xo",
-			"axis2",
 			"prng",
 			NULL
 	},


