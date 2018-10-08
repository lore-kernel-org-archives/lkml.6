Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D9EC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857592089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz0n6Ohb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857592089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJIBqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJIBqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:46:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9E720C0A;
        Mon,  8 Oct 2018 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023596;
        bh=4nelSMHemThQ1qwDyfJxHx9Bvc385uUdRBSTtSVmPy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iz0n6Ohb0LHyj1GyDfuZf/H/dpMLexS0iHgeJqe1BsVjpFOh1cZP0huN0mo4pX45Z
         7SIP4IgqxS08+9umM1JMgsvWQy88DsDpfq+AUlAFBV73WdGuNlGW3jdwc4uVfUQ0Xf
         F5lxoPKlRamtF/HnSsTNxoTAHJ3B82jzDS7+bOPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 002/113] tsl2550: fix lux1_input error in low light
Date:   Mon,  8 Oct 2018 20:30:03 +0200
Message-Id: <20181008175530.982421952@linuxfoundation.org>
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


