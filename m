Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C84DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6C320818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4UwkJYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6C320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbeKLITd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbeKLITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:32 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0249621104;
        Sun, 11 Nov 2018 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975376;
        bh=68QMokmbiY/LM0rXGpnW3RSFySDS5u7GT7j2ser+juE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4UwkJYeV2EdFGxE0B86uOfth9ptzg5Gr8jQzSyScgKlZ4cokt4s0fWk6O1LZZCqn
         5ioW/sXoWYgGLd9RUFjPJUhvp2fbpqLWMPenpIrmU2ARmsm7ZBcK1S14bzMraPbqhB
         GBUKvVAzdBiyutx6/AU2gvhg5/IO2soVM6ZTFgsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 044/350] nvme: remove ns sibling before clearing path
Date:   Sun, 11 Nov 2018 14:18:28 -0800
Message-Id: <20181111221709.010151015@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit 48f78be3326052a7718678ff9a78d6d884a50323 ]

The code had been clearing a namespace being deleted as the current
path while that namespace was still in the path siblings list. It is
possible a new IO could set that namespace back to the current path
since it appeared to be an eligable path to select, which may result in
a use-after-free error.

This patch ensures a namespace being removed is not eligable to be reset
as a current path prior to clearing it as the current path.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3119,8 +3119,8 @@ static void nvme_ns_remove(struct nvme_n
 	}
 
 	mutex_lock(&ns->ctrl->subsys->lock);
-	nvme_mpath_clear_current_path(ns);
 	list_del_rcu(&ns->siblings);
+	nvme_mpath_clear_current_path(ns);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	down_write(&ns->ctrl->namespaces_rwsem);


