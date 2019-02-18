Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED5E21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497552;
	bh=HKnBnwM4k3YnaPWA7ew+ORd+X52onrZwJdOxjqXlzTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DOr2qvPPM+cA8IgNVNOCQ2BS68HboyEtjpmMQmtwCKO+XogTHazNFT0Z8VzL5ozku
	 +nR9yhZ3ukQlQLKx5GaqZ793Eyp3Uy7q6elbIFlxZbYCB3nnI8smJtIbqKb4KOCRUX
	 FxhK/yM5hjpYXiztVaxmurT0x/MPGJ6Q332reXNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbfBRNpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730711AbfBRNpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F7A21900;
        Mon, 18 Feb 2019 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497548;
        bh=HKnBnwM4k3YnaPWA7ew+ORd+X52onrZwJdOxjqXlzTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0faVECVc7nBm70kPQpUPXKtT1Y5h7HHL2hXZOqbF0y01S/bJoUF5PyFYU8PP/fN3
         41lWYE6jLOF15D0a03Nxydwg9W8em/wgfTsdrHcEwUKtou+FzrZbwdoZUjXmcDzUI7
         ZGUfmU2ttzvTfsemLFCf3JG+xmrXX6sfwivcb+fU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 26/92] nvme-multipath: zero out ANA log buffer
Date:   Mon, 18 Feb 2019 14:42:29 +0100
Message-Id: <20190218133457.191134294@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c7055fd15ff46d92eb0dd1c16a4fe010d58224c8 ]

When nvme_init_identify() fails the ANA log buffer is deallocated
but _not_ set to NULL. This can cause double free oops when this
controller is deleted without ever being reconnected.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9901afd804ce..2b1d1f066efa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -586,6 +586,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return 0;
 out_free_ana_log_buf:
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 out:
 	return error;
 }
@@ -593,5 +594,6 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 }
 
-- 
2.19.1



