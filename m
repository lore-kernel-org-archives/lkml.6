Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA6DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845A92083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845A92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbeIXSpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:45:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbeIXSpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:45:15 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9237E1099;
        Mon, 24 Sep 2018 12:43:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 198/235] lightnvm: pblk: enable line minor version detection
Date:   Mon, 24 Sep 2018 13:53:04 +0200
Message-Id: <20180924113124.029901597@linuxfoundation.org>
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

From: Matias Bjørling <mb@lightnvm.io>

[ Upstream commit 99b8dad1b6e52721904220322a947f7b75056303 ]

When recovering a line, an extra check was added when debugging was
active, such that minor version where also checked. Unfortunately,
this used the ifdef NVM_DEBUG, which is not correct.

Instead use the proper DEBUG def, and now that it compiles, also fix
the variable.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Fixes: d0ab0b1ab991f ("lightnvm: pblk: check data lines version on recovery")
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/lightnvm/pblk-recovery.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -742,9 +742,10 @@ static int pblk_recov_check_line_version
 		return 1;
 	}
 
-#ifdef NVM_DEBUG
+#ifdef CONFIG_NVM_PBLK_DEBUG
 	if (header->version_minor > EMETA_VERSION_MINOR)
-		pr_info("pblk: newer line minor version found: %d\n", line_v);
+		pr_info("pblk: newer line minor version found: %d\n",
+				header->version_minor);
 #endif
 
 	return 0;


