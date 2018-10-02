Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5265DC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159B22083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159B22083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbeJBUNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbeJBUNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:37 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B40A8BF0;
        Tue,  2 Oct 2018 13:30:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 180/228] bus: ti-sysc: Fix no_console_suspend handling
Date:   Tue,  2 Oct 2018 06:24:37 -0700
Message-Id: <20181002132510.636922772@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4f3530f4a41d49c41015020cd9a5ed5c95b5d2db ]

If no_console_suspend is set, we should keep console enabled during suspend.
Lets fix this by only producing a warning if we can't idle hardware during
suspend.

Fixes: ef55f8215a78 ("bus: ti-sysc: Improve suspend and resume handling")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/ti-sysc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1175,10 +1175,10 @@ static int sysc_child_suspend_noirq(stru
 	if (!pm_runtime_status_suspended(dev)) {
 		error = pm_generic_runtime_suspend(dev);
 		if (error) {
-			dev_err(dev, "%s error at %i: %i\n",
-				__func__, __LINE__, error);
+			dev_warn(dev, "%s busy at %i: %i\n",
+				 __func__, __LINE__, error);
 
-			return error;
+			return 0;
 		}
 
 		error = sysc_runtime_suspend(ddata->dev);


