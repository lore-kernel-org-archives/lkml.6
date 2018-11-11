Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7345C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0062084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS6zIcpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0062084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbeKLKDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbeKLIRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:16 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486D6216FD;
        Sun, 11 Nov 2018 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975241;
        bh=XtzlUuLEGGOwFqHNgGPNnLCrsvXeQwy6zaI4PBdgq14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CS6zIcpVo/vA65q+VV3y8AOxnrV4416vHNLHufhYqLEsSB7PegQ9+YRvAV9O3/t2D
         GM5VSl7oa2r5mhcpkQZxedt4R5GqKuHS1PdN1Jy8kWuBDczeVdot2wlJywEc58LLZj
         pJuzQ9ADMlyMR8rgZYQZHMZBWvp7Fe7rnccFoajk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/361] nvme: call nvme_complete_rq when nvmf_check_ready fails for mpath I/O
Date:   Sun, 11 Nov 2018 14:17:12 -0800
Message-Id: <20181111221631.792935768@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 783f4a4408e1251d17f333ad56abac24dde988b9 ]

When an io is rejected by nvmf_check_ready() due to validation of the
controller state, the nvmf_fail_nonready_command() will normally return
BLK_STS_RESOURCE to requeue and retry.  However, if the controller is
dying or the I/O is marked for NVMe multipath, the I/O is failed so that
the controller can terminate or so that the io can be issued on a
different path.  Unfortunately, as this reject point is before the
transport has accepted the command, blk-mq ends up completing the I/O
and never calls nvme_complete_rq(), which is where multipath may preserve
or re-route the I/O. The end result is, the device user ends up seeing an
EIO error.

Example: single path connectivity, controller is under load, and a reset
is induced.  An I/O is received:

  a) while the reset state has been set but the queues have yet to be
     stopped; or
  b) after queues are started (at end of reset) but before the reconnect
     has completed.

The I/O finishes with an EIO status.

This patch makes the following changes:

  - Adds the HOST_PATH_ERROR pathing status from TP4028
  - Modifies the reject point such that it appears to queue successfully,
    but actually completes the io with the new pathing status and calls
    nvme_complete_rq().
  - nvme_complete_rq() recognizes the new status, avoids resetting the
    controller (likely was already done in order to get this new status),
    and calls the multipather to clear the current path that errored.
    This allows the next command (retry or new command) to select a new
    path if there is one.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fabrics.c   |    7 +++++--
 drivers/nvme/host/multipath.c |    7 +++++++
 include/linux/nvme.h          |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -552,8 +552,11 @@ blk_status_t nvmf_fail_nonready_command(
 	    ctrl->state != NVME_CTRL_DEAD &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
-	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
-	return BLK_STS_IOERR;
+
+	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
+	blk_mq_start_request(rq);
+	nvme_complete_rq(rq);
+	return BLK_STS_OK;
 }
 EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
 
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -77,6 +77,13 @@ void nvme_failover_req(struct request *r
 			queue_work(nvme_wq, &ns->ctrl->ana_work);
 		}
 		break;
+	case NVME_SC_HOST_PATH_ERROR:
+		/*
+		 * Temporary transport disruption in talking to the controller.
+		 * Try to send on a new path.
+		 */
+		nvme_mpath_clear_current_path(ns);
+		break;
 	default:
 		/*
 		 * Reset the controller for any non-ANA error as we don't know
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1241,6 +1241,7 @@ enum {
 	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
 	NVME_SC_ANA_TRANSITION		= 0x303,
+	NVME_SC_HOST_PATH_ERROR		= 0x370,
 
 	NVME_SC_DNR			= 0x4000,
 };


