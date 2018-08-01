Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18516C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA88220840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA88220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbeHAUSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:18:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404225AbeHATDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1250EF7D;
        Wed,  1 Aug 2018 16:57:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 044/336] media: arch: sh: migor: Fix TW9910 PDN gpio
Date:   Wed,  1 Aug 2018 18:46:19 +0200
Message-Id: <20180801165030.767818051@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

[ Upstream commit 2b787b66bcb03ec3bd97e950464e0452f459e2ca ]

The TW9910 PDN gpio (power down) is listed as active high in the chip
manual. It turns out it is actually active low as when set to physical
level 0 it actually turns the video decoder power off.

Without this patch applied:
tw9910 0-0045: Product ID error 1f:2

With this patch applied:
tw9910 0-0045: tw9910 Product ID b:0

Fixes: commit "186c446f4b840bd77b79d3dc951ca436cb8abe79"

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/boards/mach-migor/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -359,7 +359,7 @@ static struct gpiod_lookup_table ov7725_
 static struct gpiod_lookup_table tw9910_gpios = {
 	.dev_id		= "0-0045",
 	.table		= {
-		GPIO_LOOKUP("sh7722_pfc", GPIO_PTT2, "pdn", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sh7722_pfc", GPIO_PTT2, "pdn", GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP("sh7722_pfc", GPIO_PTT3, "rstb", GPIO_ACTIVE_LOW),
 	},
 };


