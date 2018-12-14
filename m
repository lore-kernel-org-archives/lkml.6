Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A62AC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2233F2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790949;
	bh=LcxgURKP8ecxQvJ6vhrteXiSKxbym/MCtdS756/soSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QN7BxndNXTXlb1n3L6uVKdTew2VrQjgN2VWlBf2mOtwKFKCG1VVQAXxyESq5ES06C
	 kJmATspqpk7wIOJUewSU6R2p8QL6Wr596Zkj1SA5ENzIhCG6IiSrj5KePxZKM7YorO
	 71V3jfzkBGrYHBgTF99IfkV9hphsYFWncFHraiTE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2233F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbeLNMHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbeLNMHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5630B21479;
        Fri, 14 Dec 2018 12:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789224;
        bh=LcxgURKP8ecxQvJ6vhrteXiSKxbym/MCtdS756/soSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsrhgNdYqrJCrT/SSGdbz+BNtotX1e0zh94OMgnC+6qR5qLpYOmrO4wEiMQRxqA6r
         SyfJpVARvoAH3ZuXz6oNNm66QJLhQR/0N/CbEIeFIz2BZKKNophYHXiF4Ogvrpxm4w
         i2jg8cPSsof79MITYpl9WtFOQo28xQ7deM2JVE2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 120/142] nvme: warn when finding multi-port subsystems without multipathing enabled
Date:   Fri, 14 Dec 2018 13:00:05 +0100
Message-Id: <20181214115751.832120373@linuxfoundation.org>
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

[ Upstream commit 14a1336e6fff47dd1028b484d6c802105c58e2ee ]

Without CONFIG_NVME_MULTIPATH enabled a multi-port subsystem might
show up as invididual devices and cause problems, warn about it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..60220de2db52 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -537,6 +537,9 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 static inline int nvme_mpath_init(struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
+	if (ctrl->subsys->cmic & (1 << 3))
+		dev_warn(ctrl->device,
+"Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
 }
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
-- 
2.19.1



