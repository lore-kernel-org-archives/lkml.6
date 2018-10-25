Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10684ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430820870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPBMu4jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C430820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeJYWtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeJYWtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:01 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC78820854;
        Thu, 25 Oct 2018 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476964;
        bh=fGcguVREpC4h5QJpOQF3U868aKHV1gVM99OwZJtkxjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPBMu4jo0GvpRDLP/eoKHZ7ByTQYtlLmwJou2yn5/+X4WgbPqKPuPBEXVSoSPMHD9
         XqAqilBD53qHV6NFCZQDLIpRROxHBctmm6OGLZHwu+ym/CJa6rJXwHM/GBdkHGrNrb
         qYhHHfsEqowM2oQEiGfN8Ggxrz4ycMTYDoLKyuIE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 68/98] mm/frame_vector.c: release a semaphore in 'get_vaddr_frames()'
Date:   Thu, 25 Oct 2018 10:13:53 -0400
Message-Id: <20181025141423.213774-68-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 1f704fd0d14043e76e80f6b8b2251b9b2cedcca6 ]

A semaphore is acquired before this check, so we must release it before
leaving.

Link: http://lkml.kernel.org/r/20171211211009.4971-1-christophe.jaillet@wanadoo.fr
Fixes: b7f0554a56f2 ("mm: fail get_vaddr_frames() for filesystem-dax mappings")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/frame_vector.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index 375a103d7a56..d73eed0443f6 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -61,8 +61,10 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 	 * get_user_pages_longterm() and disallow it for filesystem-dax
 	 * mappings.
 	 */
-	if (vma_is_fsdax(vma))
-		return -EOPNOTSUPP;
+	if (vma_is_fsdax(vma)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
 		vec->got_ref = true;
-- 
2.17.1

