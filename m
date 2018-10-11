Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB70C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B36213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA4P8dCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B36213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbeJKXN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:13:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F182085B;
        Thu, 11 Oct 2018 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272771;
        bh=qw5/CVHSH22aLLQV97YD1mza+c7suQr2s6TvJGVfhHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PA4P8dCV19E+BUcwMTgahcpha3MZoFks1tHRoLVlmJFLVTGXkPZKOG0s9Wux7bGu3
         A/7nYh/de8B2ZdGS2TnWi5s0DZLhACBm2mE1MEXGB0wyt+42SgjuQV7xBdjgKfyK+0
         cxHMasHWTobsOnhS53izsyeYGS378m3ygA/B4oEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <james.smart@broadcom.com>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.14 32/45] nvme_fc: fix ctrl create failures racing with workq items
Date:   Thu, 11 Oct 2018 17:39:59 +0200
Message-Id: <20181011152510.306498191@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

commit cf25809bec2c7df4b45df5b2196845d9a4a3c89b upstream.

If there are errors during initial controller create, the transport
will teardown the partially initialized controller struct and free
the ctlr memory.  Trouble is - most of those errors can occur due
to asynchronous events happening such io timeouts and subsystem
connectivity failures. Those failures invoke async workq items to
reset the controller and attempt reconnect.  Those may be in progress
as the main thread frees the ctrl memory, resulting in NULL ptr oops.

Prevent this from happening by having the main ctrl failure thread
changing state to DELETING followed by synchronously cancelling any
pending queued work item. The change of state will prevent the
scheduling of resets or reconnect events.

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/fc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2868,6 +2868,10 @@ nvme_fc_init_ctrl(struct device *dev, st
 	}
 
 	if (ret) {
+		nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
+		cancel_work_sync(&ctrl->ctrl.reset_work);
+		cancel_delayed_work_sync(&ctrl->connect_work);
+
 		/* couldn't schedule retry - fail out */
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: Connect retry failed\n", ctrl->cnum);


