Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91915C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C40A2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C40A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeJBUjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:39:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeJBUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:58 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44CA4BF0;
        Tue,  2 Oct 2018 13:31:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 003/137] tsl2550: fix lux1_input error in low light
Date:   Tue,  2 Oct 2018 06:23:24 -0700
Message-Id: <20181002132458.642120445@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
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

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit ce054546cc2c26891cefa2f284d90d93b52205de ]

ADC channel 0 photodiode detects both infrared + visible light,
but ADC channel 1 just detects infrared. However, the latter is a bit
more sensitive in that range so complete darkness or low light causes
a error condition in which the chan0 - chan1 is negative that
results in a -EAGAIN.

This patch changes the resulting lux1_input sysfs attribute message from
"Resource temporarily unavailable" to a user-grokable lux value of 0.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/tsl2550.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -177,7 +177,7 @@ static int tsl2550_calculate_lux(u8 ch0,
 		} else
 			lux = 0;
 	else
-		return -EAGAIN;
+		return 0;
 
 	/* LUX range check */
 	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;


