Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DABECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A562083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A562083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbeIXSmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:42:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbeIXSmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:42:46 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96326109C;
        Mon, 24 Sep 2018 12:40:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 162/235] pinctrl: mt7622: Fix probe fail by misuse the selector
Date:   Mon, 24 Sep 2018 13:52:28 +0200
Message-Id: <20180924113121.314356351@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 238262af08a20e5f1932fcf606b8b84370ac8b77 ]

After the commit acf137951367 ("pinctrl: core: Return selector to the
pinctrl driver") and the commit 47f1242d19c3 ("pinctrl: pinmux: Return
selector to the pinctrl driver"), it's necessary to add the fixes
needed for the pin controller drivers to use the appropriate returned
selector for a negative error number returned in case of the fail at
these functions. Otherwise, the driver would have a failed probe and
that causes boot message cannot correctly output and devices fail
to acquire their own pins.

Cc: Kevin Hilman <khilman@baylibre.com>
Fixes: acf137951367 ("pinctrl: core: Return selector to the pinctrl driver")
Fixes: 47f1242d19c3 ("pinctrl: pinmux: Return selector to the pinctrl driver")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1537,7 +1537,7 @@ static int mtk_build_groups(struct mtk_p
 		err = pinctrl_generic_add_group(hw->pctrl, group->name,
 						group->pins, group->num_pins,
 						group->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(hw->dev, "Failed to register group %s\n",
 				group->name);
 			return err;
@@ -1558,7 +1558,7 @@ static int mtk_build_functions(struct mt
 						  func->group_names,
 						  func->num_group_names,
 						  func->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(hw->dev, "Failed to register function %s\n",
 				func->name);
 			return err;


