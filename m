Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cjGSEkPzG1vfYwAAmS7hNA
	; Sat, 09 Jun 2018 15:34:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B8036608CD; Sat,  9 Jun 2018 15:34:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9f3MD/F"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2C05F606FA;
	Sat,  9 Jun 2018 15:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C05F606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbeFIPeu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932915AbeFIPeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:34:46 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB752208A4;
        Sat,  9 Jun 2018 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558486;
        bh=LicJT2BDhL/8JMW+JcB7C2kpbiVhu87UwJKXDLbXLBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9f3MD/FmbncqyPcsPdI9mfDx/byselZV4sedpuMIoM2M6a6HyI+6ZgUYpnhMBuzW
         9E7JyN99loeJVQl+Q9Y6QHXQjQ3qIeXKHZj2o12STnsh+ICDQGB3UwUGq16AkOINnv
         kAp4VjxicmB2OCuEG364WHRRf8xkgXfkvZmK1N48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suresh Reddy <suresh.reddy@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/41] be2net: Fix error detection logic for BE3
Date: Sat,  9 Jun 2018 17:29:39 +0200
Message-Id: <20180609152926.854290746@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suresh Reddy <suresh.reddy@broadcom.com>

[ Upstream commit d2c2725c2cdbcc108a191f50953d31c7b6556761 ]

Check for 0xE00 (RECOVERABLE_ERR) along with ARMFW UE (0x0)
in be_detect_error() to know whether the error is valid error or not

Fixes: 673c96e5a ("be2net: Fix UE detection logic for BE3")
Signed-off-by: Suresh Reddy <suresh.reddy@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/emulex/benet/be_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3294,7 +3294,9 @@ void be_detect_error(struct be_adapter *
 				if ((val & POST_STAGE_FAT_LOG_START)
 				     != POST_STAGE_FAT_LOG_START &&
 				    (val & POST_STAGE_ARMFW_UE)
-				     != POST_STAGE_ARMFW_UE)
+				     != POST_STAGE_ARMFW_UE &&
+				    (val & POST_STAGE_RECOVERABLE_ERR)
+				     != POST_STAGE_RECOVERABLE_ERR)
 					return;
 			}
 
