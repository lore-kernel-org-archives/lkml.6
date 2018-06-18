Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C57C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0AF20652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0AF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964823AbeFRIT0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:19:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeFRITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CFB5DC7F;
        Mon, 18 Jun 2018 08:19:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, dann frazier <dann.frazier@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 061/279] net: hns: Avoid action name truncation
Date:   Mon, 18 Jun 2018 10:10:46 +0200
Message-Id: <20180618080611.356876150@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: dann frazier <dann.frazier@canonical.com>

[ Upstream commit f4ea89110df237da6fbcaab76af431e85f07d904 ]

When longer interface names are used, the action names exposed in
/proc/interrupts and /proc/irq/* maybe truncated. For example, when
using the predictable name algorithm in systemd on a HiSilicon D05,
I see:

  ubuntu@d05-3:~$  grep enahisic2i0-tx /proc/interrupts | sed 's/.* //'
  enahisic2i0-tx0
  enahisic2i0-tx1
  [...]
  enahisic2i0-tx8
  enahisic2i0-tx9
  enahisic2i0-tx1
  enahisic2i0-tx1
  enahisic2i0-tx1
  enahisic2i0-tx1
  enahisic2i0-tx1
  enahisic2i0-tx1

Increase the max ring name length to allow for an interface name
of IFNAMSIZE. After this change, I now see:

  $ grep enahisic2i0-tx /proc/interrupts | sed 's/.* //'
  enahisic2i0-tx0
  enahisic2i0-tx1
  enahisic2i0-tx2
  [...]
  enahisic2i0-tx8
  enahisic2i0-tx9
  enahisic2i0-tx10
  enahisic2i0-tx11
  enahisic2i0-tx12
  enahisic2i0-tx13
  enahisic2i0-tx14
  enahisic2i0-tx15

Signed-off-by: dann frazier <dann.frazier@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -87,7 +87,7 @@ do { \
 
 #define HNAE_AE_REGISTER 0x1
 
-#define RCB_RING_NAME_LEN 16
+#define RCB_RING_NAME_LEN (IFNAMSIZ + 4)
 
 #define HNAE_LOWEST_LATENCY_COAL_PARAM	30
 #define HNAE_LOW_LATENCY_COAL_PARAM	80


