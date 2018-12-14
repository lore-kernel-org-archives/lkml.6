Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8454CC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABDF2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790952;
	bh=isQwEs0DvhaAqNQwOpr/yOGvX4J1VhSo7w40vMPoLx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njIZ0QsMYgU08bAPiNIxxQdJ5GMT/Nqsc0NrmmxxRGFEd30nuFZQZNyWBA7BPePBR
	 iXxkbkhwuz0rgMIilZu7g1U4BoSeOMujTsgR9TybmlWAcUO4e3G4z30yoSQ8wTeae3
	 Lhffhk47ELZyL/OILzIDK101IMfUnrmewTREnomk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABDF2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbeLNMfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731044AbeLNMHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3CD021486;
        Fri, 14 Dec 2018 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789227;
        bh=isQwEs0DvhaAqNQwOpr/yOGvX4J1VhSo7w40vMPoLx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLJEuytNHRxvRYIQvejO0w2DAqsAVFNKouRhoMUhI2w5eoTok+oj6SRfERn65zJBb
         Njb9ug1V+F5nNh7dJ7zJVZ9JtZknXuvdM4tnckqbbJe8pO8pKLezA1qw1iCfbfbGGH
         Ff6dZ2wI0Jw4KF6br/FWBVbFVZ2kXIAQQfBt00j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 121/142] nvme: flush namespace scanning work just before removing namespaces
Date:   Fri, 14 Dec 2018 13:00:06 +0100
Message-Id: <20181214115751.869327188@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f6c8e432cb0479255322c5d0335b9f1699a0270c ]

nvme_stop_ctrl can be called also for reset flow and there is no need to
flush the scan_work as namespaces are not being removed. This can cause
deadlock in rdma, fc and loop drivers since nvme_stop_ctrl barriers
before controller teardown (and specifically I/O cancellation of the
scan_work itself) takes place, but the scan_work will be blocked anyways
so there is no need to flush it.

Instead, move scan_work flush to nvme_remove_namespaces() where it really
needs to flush.

Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed by: James Smart <jsmart2021@gmail.com>
Tested-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0ba301f7e8b4..b7b2659e02fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3308,6 +3308,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(ns_list);
 
+	/* prevent racing with ns scanning */
+	flush_work(&ctrl->scan_work);
+
 	/*
 	 * The dead states indicates the controller was not gracefully
 	 * disconnected. In that case, we won't be able to flush any data while
@@ -3463,7 +3466,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
-	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
-- 
2.19.1



