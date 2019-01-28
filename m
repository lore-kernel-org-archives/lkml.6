Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C27C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4B820844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693600;
	bh=wY8+m6TGwhTaUcA1GoEaCO4baxU0BNwkyMjt3pO12lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OUxU/EZew94pnVCdSLrh/9Sv45DAFLwtHI6p9OZwVjujbpqtN0Sf9yqZLTUR55TOs
	 cV6fI+Cvg3ttNqEx66MpTbSkOgmOrmRL+eyN0ayNQIZFcDFzvIYf1ZHKHkg2/WB907
	 16RYCAIe319sk6fYcXk0UnI+lhWB/t9w5BfXzZ1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbfA1QY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389671AbfA1QYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FA620879;
        Mon, 28 Jan 2019 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692657;
        bh=wY8+m6TGwhTaUcA1GoEaCO4baxU0BNwkyMjt3pO12lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsQSyoRrDBAmE/moEt6eVYzgL32/AGe2zpg2u/aZF8tY5qDXwpE+MF3VhSaccmb2Q
         dmAj/Wh2tDOShhJAluq+MA5HlVaVH+rhcLTPjhsIoZnJr1tHsABg4feLGxIvfADe6v
         5C2iRxpRggtY+0qRfC1z6nrnLL5woGMLV0nJcsIo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frank Rowand <frank.rowand@sony.com>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 10/80] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Mon, 28 Jan 2019 11:22:51 -0500
Message-Id: <20190128162401.58841-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
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
index 96536c969c9c..a8efed3b4691 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -280,6 +280,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
2.19.1

