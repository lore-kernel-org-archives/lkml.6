Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75048ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F524208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F524208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeGMJiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:38:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeGMJiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:38:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fduJW-00048P-4y; Fri, 13 Jul 2018 09:24:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: gadget: remove redundant variable maxpacket
Date:   Fri, 13 Jul 2018 10:24:33 +0100
Message-Id: <20180713092433.10921-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable maxpacket is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'maxpacket' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/dwc3/ep0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index c77ff50a88a2..8efde178eef4 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -973,15 +973,12 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
 		   req->request.length && req->request.zero) {
-		u32	maxpacket;
 
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
 				&req->request, dep->number);
 		if (ret)
 			return;
 
-		maxpacket = dep->endpoint.maxpacket;
-
 		/* prepare normal TRB */
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 					 req->request.length,
-- 
2.17.1

