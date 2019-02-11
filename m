Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49080222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894905;
	bh=INtSNUFjJaP8CghPEeRNdJdyynnJ0s3F7VOxGbqoK6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7HL/S0DCEw2y9i1bVT7F1cEYXSJklhrFmT5o5LtExW7X/ebu2HNuR4c7coBRkFBF
	 u5IfPt7EyeV34PGDcBpD6x3y7trBNoVm0JHOiFA8jiYe+ys+yu2kT+dEWiiiW3ypBV
	 HTe0TEirESI6Gt0aFEhXUo/ppYqn2JwwTZnRimnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfBKOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbfBKOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C296222A1;
        Mon, 11 Feb 2019 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894899;
        bh=INtSNUFjJaP8CghPEeRNdJdyynnJ0s3F7VOxGbqoK6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oegfMNgaTC3NvUVlMmzJnEwShfGtngbv+K93rFw/NVpqklScH/PbIQZXji6V/lNZv
         wpuXjGpbF12SDeh3rdmuxrEWL3Yi5k/VtgmMElml1Sm/fIESc9+yOlTbDkFsyKh+aj
         PJHDOvcHXNoOej0dcK9lDIJEtZHRsdAolFOqSgEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frank Rowand <frank.rowand@sony.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 026/352] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Mon, 11 Feb 2019 15:14:13 +0100
Message-Id: <20190211141848.009449972@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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
index 7625546caefd..17958043e7f7 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -270,6 +270,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
2.19.1



