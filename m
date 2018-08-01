Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC07C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2952208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2952208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405894AbeHATIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405717AbeHATIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C006513C1;
        Wed,  1 Aug 2018 17:15:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 077/246] mwifiex: handle race during mwifiex_usb_disconnect
Date:   Wed,  1 Aug 2018 18:49:47 +0200
Message-Id: <20180801165015.399947188@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
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

From: Ganapathi Bhat <gbhat@marvell.com>

[ Upstream commit b817047ae70c0bd67b677b65d0d69d72cd6e9728 ]

Race condition is observed during rmmod of mwifiex_usb:

1. The rmmod thread will call mwifiex_usb_disconnect(), download
   SHUTDOWN command and do wait_event_interruptible_timeout(),
   waiting for response.

2. The main thread will handle the response and will do a
   wake_up_interruptible(), unblocking rmmod thread.

3. On getting unblocked, rmmod thread  will make rx_cmd.urb = NULL in
   mwifiex_usb_free().

4. The main thread will try to resubmit rx_cmd.urb in
   mwifiex_usb_submit_rx_urb(), which is NULL.

To fix, wait for main thread to complete before calling
mwifiex_usb_free().

Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/usb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -644,6 +644,9 @@ static void mwifiex_usb_disconnect(struc
 					 MWIFIEX_FUNC_SHUTDOWN);
 	}
 
+	if (adapter->workqueue)
+		flush_workqueue(adapter->workqueue);
+
 	mwifiex_usb_free(card);
 
 	mwifiex_dbg(adapter, FATAL,


