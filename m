Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB936C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22D72064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22D72064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbeJBUTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:19:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbeJBUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:47 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38F65B4A;
        Tue,  2 Oct 2018 13:36:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 51/94] gpio: Fix wrong rounding in gpio-menz127
Date:   Tue,  2 Oct 2018 06:25:05 -0700
Message-Id: <20181002132504.045653439@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

[ Upstream commit 7279d9917560bbd0d82813d6bf00490a82c06783 ]

men_z127_debounce() tries to round up and down, but uses functions which
are only suitable when the divider is a power of two, which is not the
case. Use the appropriate ones.

Found by static check. Compile tested.

Fixes: f436bc2726c64 ("gpio: add driver for MEN 16Z127 GPIO controller")
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-menz127.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -56,9 +56,9 @@ static int men_z127_debounce(struct gpio
 		rnd = fls(debounce) - 1;
 
 		if (rnd && (debounce & BIT(rnd - 1)))
-			debounce = round_up(debounce, MEN_Z127_DB_MIN_US);
+			debounce = roundup(debounce, MEN_Z127_DB_MIN_US);
 		else
-			debounce = round_down(debounce, MEN_Z127_DB_MIN_US);
+			debounce = rounddown(debounce, MEN_Z127_DB_MIN_US);
 
 		if (debounce > MEN_Z127_DB_MAX_US)
 			debounce = MEN_Z127_DB_MAX_US;


