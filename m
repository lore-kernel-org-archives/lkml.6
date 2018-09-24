Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C3DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6830A2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6830A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeIXRqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:46:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbeIXRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:46:35 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C98B1072;
        Mon, 24 Sep 2018 11:44:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 101/105] rtc: bq4802: add error handling for devm_ioremap
Date:   Mon, 24 Sep 2018 13:34:27 +0200
Message-Id: <20180924113122.740704052@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
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

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 7874b919866ba91bac253fa219d3d4c82bb944df ]

When devm_ioremap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling devm_ioremap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-bq4802.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -164,6 +164,10 @@ static int bq4802_probe(struct platform_
 	} else if (p->r->flags & IORESOURCE_MEM) {
 		p->regs = devm_ioremap(&pdev->dev, p->r->start,
 					resource_size(p->r));
+		if (!p->regs){
+			err = -ENOMEM;
+			goto out;
+		}
 		p->read = bq4802_read_mem;
 		p->write = bq4802_write_mem;
 	} else {


