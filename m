Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8197AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427622089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427622089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeJBUL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeJBULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:24 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B103C47;
        Tue,  2 Oct 2018 13:28:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Regnery <tobias.regnery@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 090/228] brcmsmac: fix wrap around in conversion from constant to s16
Date:   Tue,  2 Oct 2018 06:23:07 -0700
Message-Id: <20181002132505.452827609@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit c9a61469fc97672a08b2f798830a55ea6e03dc4a ]

The last value in the log_table wraps around to a negative value
since s16 has a value range of -32768 to 32767. This is not what
the table intends to represent. Use the closest positive value
32767.

This fixes a warning seen with clang:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c:216:2: warning:
      implicit conversion from 'int' to 's16' (aka 'short') changes
value from 32768
      to -32768 [-Wconstant-conversion]
        32768
        ^~~~~
1 warning generated.

Fixes: 4c0bfeaae9f9 ("brcmsmac: fix array out-of-bounds access in qm_log10")
Cc: Tobias Regnery <tobias.regnery@gmail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c
@@ -213,7 +213,7 @@ static const s16 log_table[] = {
 	30498,
 	31267,
 	32024,
-	32768
+	32767
 };
 
 #define LOG_TABLE_SIZE 32       /* log_table size */


