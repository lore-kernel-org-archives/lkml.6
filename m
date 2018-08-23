Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF20C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28BE208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28BE208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbeHWMhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:37:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHWMhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:37:24 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0780CA0;
        Thu, 23 Aug 2018 09:08:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roland Dreier <roland@purestorage.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 297/324] nvme: fix handling of metadata_len for NVME_IOCTL_IO_CMD
Date:   Thu, 23 Aug 2018 09:56:03 +0200
Message-Id: <20180823075010.927381785@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Roland Dreier <roland@purestorage.com>

[ Upstream commit 9b382768135ee3ff282f828c906574a8478e036b ]

The old code in nvme_user_cmd() passed the userspace virtual address
from nvme_passthru_cmd.metadata as the length of the metadata buffer
as well as the address to nvme_submit_user_cmd().

Fixes: 63263d60 ("nvme: Use metadata for passthrough commands")
Signed-off-by: Roland Dreier <roland@purestorage.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1209,7 +1209,7 @@ static int nvme_user_cmd(struct nvme_ctr
 	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
+			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata_len,
 			0, &cmd.result, timeout);
 	nvme_passthru_end(ctrl, effects);
 


