Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA6ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E072133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVg6Dp4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E072133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeKIHdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeKIHdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:53 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C91E21019;
        Thu,  8 Nov 2018 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714186;
        bh=FNBcTtkXgKtguCkxwBgzwvuwpNHW/bg3SgJGVkTxnSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVg6Dp4CQwMv98QLGv7CQe8p7s76y9S9mzXcIyPq0gn9heZAStu+7E3qcwsVGCqHK
         e5LbtFwy+TeJpWKGbd2he9AgVaoAlKCVbS286wg7pW6/Fm44vLqS5BXkvZBgxGkpBT
         YfDCwiN8TCmFlXCdsrcVxcJEuhOqLjIz0zyakOkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 110/144] igb: Unpair the queues when changing the number of queues
Date:   Thu,  8 Nov 2018 13:51:21 -0800
Message-Id: <20181108215105.837628150@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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

[ Upstream commit 37a5d163fb447b39f7960d0534de30e88ad395bb ]

By the commit 72ddef0506da ("igb: Fix oops caused by missing queue
pairing"), the IGB_FLAG_QUEUE_PAIRS flag can now be set when changing the
number of queues by "ethtool -L", but it is never cleared unless the igb
driver is reloaded.
This patch clears it if queue pairing becomes unnecessary as a result of
"ethtool -L".

Signed-off-by: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ffad88e8a29..84049078c4f0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2941,6 +2941,8 @@ void igb_set_flag_queue_pairs(struct igb_adapter *adapter,
 		 */
 		if (adapter->rss_queues > (max_rss_queues / 2))
 			adapter->flags |= IGB_FLAG_QUEUE_PAIRS;
+		else
+			adapter->flags &= ~IGB_FLAG_QUEUE_PAIRS;
 		break;
 	}
 }
-- 
2.17.1



