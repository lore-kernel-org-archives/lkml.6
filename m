Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFABFC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7521476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NctQ5nT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA7521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbeJKXE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:26 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93128213A2;
        Thu, 11 Oct 2018 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272204;
        bh=fHvPjRjQTCRw8cXgBnBg12+iTTozuIDv2pBdvXdISx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NctQ5nT8HWmfGmW0D5EoX5rMtj1kckgWoEX5KXaFHwncLHjz0MJOgRRlJGutaLKLn
         y0qF9bIzMW+zREtWUolhOQk7X331Ee53lNhCTvyzZk1AvLfLB2JzGvpPkojG5OYYt0
         LzgWa3xqOG6XgP7tAOoR5GcD9cHlVtf4gh77GHLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 008/120] net: hp100: fix always-true check for link up state
Date:   Thu, 11 Oct 2018 17:33:09 +0200
Message-Id: <20181011152549.866323752@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit a7f38002fb69b44f8fc622ecb838665d0b8666af ]

The operation ~(p100_inb(VG_LAN_CFG_1) & HP100_LINK_UP) returns a value
that is always non-zero and hence the wait for the link to drop always
terminates prematurely.  Fix this by using a logical not operator instead
of a bitwise complement.  This issue has been in the driver since
pre-2.6.12-rc2.

Detected by CoverityScan, CID#114157 ("Logical vs. bitwise operator")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hp/hp100.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/hp/hp100.c
+++ b/drivers/net/ethernet/hp/hp100.c
@@ -2637,7 +2637,7 @@ static int hp100_login_to_vg_hub(struct
 		/* Wait for link to drop */
 		time = jiffies + (HZ / 10);
 		do {
-			if (~(hp100_inb(VG_LAN_CFG_1) & HP100_LINK_UP_ST))
+			if (!(hp100_inb(VG_LAN_CFG_1) & HP100_LINK_UP_ST))
 				break;
 			if (!in_interrupt())
 				schedule_timeout_interruptible(1);


