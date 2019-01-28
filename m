Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE038C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D512082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691236;
	bh=FiUeQ9WN+QmxxHZXyoaHNstdzpqLULB+glHW3Mnej4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjOm1ptBr+sXemhuOijfXgXhr3ulRr9GK1BO9cOf5yhMijmBimpJ/C3b2kayPKnI2
	 SsKDUNnmx4Dcwch5wIbg5Kx0Ta/zCgYv2mW2CwaHpdX9ipopzuHcTVgB6pojcr2drJ
	 zrozEe71YZbcIsTUUeCSOclqjkDepW72YPlACBnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfA1QAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730447AbfA1QA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D222175B;
        Mon, 28 Jan 2019 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691229;
        bh=FiUeQ9WN+QmxxHZXyoaHNstdzpqLULB+glHW3Mnej4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZ/941Jlui3bvo+dqBNZff9N9dPXB/w4URcLIi7ovyhMX9KPOeKrXB/hBRpFSzbBE
         /bMtbpY7daZtpQkSk6FSDr8Da/WRWEbzbYgm/NZ6vGB2aNIs/ZWd6u9uxr5wFzjgsg
         /QUcdoZmrOZ8CzenmGMKAyutnY+knOhVWRzyVVkQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frank Rowand <frank.rowand@sony.com>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 023/258] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Mon, 28 Jan 2019 10:55:29 -0500
Message-Id: <20190128155924.51521-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

[ Upstream commit 5b3f5c408d8cc59b87e47f1ab9803dbd006e4a91 ]

The previous commit, "of: overlay: add missing of_node_get() in
__of_attach_node_sysfs" added a missing of_node_get() to
__of_attach_node_sysfs().  This results in a refcount imbalance
for nodes attached with dlpar_attach_node().  The calling sequence
from dlpar_attach_node() to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

For more detailed description of the node refcount, see
commit 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow
during DLPAR remove").

Tested-by: Alan Tull <atull@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..e3010b14aea5 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
2.19.1

