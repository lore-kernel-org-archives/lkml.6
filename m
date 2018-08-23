Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7327B20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7327B20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbeHWMTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:19:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732508AbeHWMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:19:33 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 707A4C5C;
        Thu, 23 Aug 2018 08:50:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 141/324] dev-dax: check_vma: ratelimit dev_info-s
Date:   Thu, 23 Aug 2018 09:53:27 +0200
Message-Id: <20180823075002.994016216@linuxfoundation.org>
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

From: Jeff Moyer <jmoyer@redhat.com>

[ Upstream commit 5a14e91d559aee5bdb0e002e1153fd9c4338a29e ]

This is easily triggered from userspace, so let's ratelimit the
messages.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dax/device.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -189,14 +189,16 @@ static int check_vma(struct dev_dax *dev
 
 	/* prevent private mappings from being established */
 	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
-		dev_info(dev, "%s: %s: fail, attempted private mapping\n",
+		dev_info_ratelimited(dev,
+				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
 		return -EINVAL;
 	}
 
 	mask = dax_region->align - 1;
 	if (vma->vm_start & mask || vma->vm_end & mask) {
-		dev_info(dev, "%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
+		dev_info_ratelimited(dev,
+				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
 				current->comm, func, vma->vm_start, vma->vm_end,
 				mask);
 		return -EINVAL;
@@ -204,13 +206,15 @@ static int check_vma(struct dev_dax *dev
 
 	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) == PFN_DEV
 			&& (vma->vm_flags & VM_DONTCOPY) == 0) {
-		dev_info(dev, "%s: %s: fail, dax range requires MADV_DONTFORK\n",
+		dev_info_ratelimited(dev,
+				"%s: %s: fail, dax range requires MADV_DONTFORK\n",
 				current->comm, func);
 		return -EINVAL;
 	}
 
 	if (!vma_is_dax(vma)) {
-		dev_info(dev, "%s: %s: fail, vma is not DAX capable\n",
+		dev_info_ratelimited(dev,
+				"%s: %s: fail, vma is not DAX capable\n",
 				current->comm, func);
 		return -EINVAL;
 	}


