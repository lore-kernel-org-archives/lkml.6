Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0A5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE11214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc3AIrn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE11214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeKVFon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732079AbeKVFom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:44:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF7E214D9;
        Wed, 21 Nov 2018 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827349;
        bh=kFNNdj59aPtMtfXGk+05hHReCFkTpES9SenQcitscAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qc3AIrn9VRfPH++LszDcUUMn+nSzzKoinqtZcdnyCRGNKJ4+YJVk/JI0Awb2R4bkp
         vhcHGAS+n5p3PrQpps55hN0RHbcCcTXumiihWDA8yJgYMLBR25v2MnQc0Wj8vIyzJv
         WhV1hA5oNVVMjfn75i64jOMOVcFc6wfjMekKkaQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Raghuram Chary J <RaghuramChary.Jallipalli@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 17/21] usbnet: smsc95xx: disable carrier check while suspending
Date:   Wed, 21 Nov 2018 20:07:01 +0100
Message-Id: <20181121183422.852780736@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 7b900ead6cc66b2ee873cb042dfba169aa68b56c ]

We need to make sure, that the carrier check polling is disabled
while suspending. Otherwise we can end up with usbnet_read_cmd()
being issued when only usbnet_read_cmd_nopm() is allowed. If this
happens, read operations lock up.

Fixes: d69d169493 ("usbnet: smsc95xx: fix link detection for disabled autonegotiation")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Raghuram Chary J <RaghuramChary.Jallipalli@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/smsc95xx.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1600,6 +1600,8 @@ static int smsc95xx_suspend(struct usb_i
 		return ret;
 	}
 
+	cancel_delayed_work_sync(&pdata->carrier_check);
+
 	if (pdata->suspend_flags) {
 		netdev_warn(dev->net, "error during last resume\n");
 		pdata->suspend_flags = 0;
@@ -1842,6 +1844,11 @@ done:
 	 */
 	if (ret && PMSG_IS_AUTO(message))
 		usbnet_resume(intf);
+
+	if (ret)
+		schedule_delayed_work(&pdata->carrier_check,
+				      CARRIER_CHECK_DELAY);
+
 	return ret;
 }
 


