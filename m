Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A98ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C9A2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C9A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbeIREl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:41:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeIREl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:41:58 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34212C49;
        Mon, 17 Sep 2018 23:12:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Robert Schlabbach <Robert.Schlabbach@gmx.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 106/158] media: em28xx: explicitly disable TS packet filter
Date:   Tue, 18 Sep 2018 00:42:16 +0200
Message-Id: <20180917211716.185882797@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Robert Schlabbach <Robert.Schlabbach@gmx.net>

[ Upstream commit 157eb9a0b75e97ad390c6e50c7381b0a0e02fe97 ]

The em28xx driver never touched the EM2874 register bits that control
the transport stream packet filters, leaving them at whatever default
the firmware has set. E.g. the Pinnacle 290e disables them by default,
while the Hauppauge WinTV dualHD enables discarding NULL packets by
default.

However, some applications require NULL packets, e.g. to determine the
load in DOCSIS segments, so discarding NULL packets is undesired for
such applications.

This patch simply extends the bit mask when starting or stopping the
transport stream packet capture, so that the filter bits are cleared.
It has been verified that this makes the Hauppauge WinTV dualHD pass
an unfiltered DVB-C stream including NULL packets, which it didn't
before.

Signed-off-by: Robert Schlabbach <Robert.Schlabbach@gmx.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -655,12 +655,12 @@ int em28xx_capture_start(struct em28xx *
 			rc = em28xx_write_reg_bits(dev,
 						   EM2874_R5F_TS_ENABLE,
 						   start ? EM2874_TS1_CAPTURE_ENABLE : 0x00,
-						   EM2874_TS1_CAPTURE_ENABLE);
+						   EM2874_TS1_CAPTURE_ENABLE | EM2874_TS1_FILTER_ENABLE | EM2874_TS1_NULL_DISCARD);
 		else
 			rc = em28xx_write_reg_bits(dev,
 						   EM2874_R5F_TS_ENABLE,
 						   start ? EM2874_TS2_CAPTURE_ENABLE : 0x00,
-						   EM2874_TS2_CAPTURE_ENABLE);
+						   EM2874_TS2_CAPTURE_ENABLE | EM2874_TS2_FILTER_ENABLE | EM2874_TS2_NULL_DISCARD);
 	} else {
 		/* FIXME: which is the best order? */
 		/* video registers are sampled by VREF */


