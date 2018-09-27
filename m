Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3646C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4EE216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMF/AHop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4EE216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeI0UkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeI0UkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:40:20 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9CE21531;
        Thu, 27 Sep 2018 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538058110;
        bh=IGYifjdq7PLyF9YCBvjqmzsSAaBorejftAxtkGDDm+M=;
        h=Subject:From:To:Cc:Date:From;
        b=lMF/AHopqCufRNLj1huc3VRh6irO9SRSVWn1+MkfiCzrW6umZmcSvahZeUVzcoIyR
         GF+XiPsk7Dor0V7o80lhyXd8yamhOvQvYIfx9e2Mf8h2inNg1W64aTmRdaZTHnkzWt
         YAd6+NWOccHOQDHP0hAtzsBFPtJ1AiX8ec8RbsCI=
Subject: [PATCH 0/3] find_next_iomem_res() fixes
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lianbo Jiang <lijiang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, bp@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com
Date:   Thu, 27 Sep 2018 09:21:49 -0500
Message-ID: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fix:

  - A kexec off-by-one error that we probably never see in practice (only
    affects a resource starting at exactly 640KB).

  - A corner case in walk_iomem_res_desc(), walk_system_ram_res(), etc that
    we probably also never see in practice (only affects a single byte
    resource at the very end of the region we're searching)

  - An issue in walk_iomem_res_desc() that apparently causes a kdump issue
    (see Lianbo's note at [1]).

I think we need to fix the kdump issue either by these patches
(specifically the last one) or by the patch Lianbo posted [2].

I'm hoping to avoid deciding and merging these myself, but I'm not
sure who really wants to own kernel/resource.c.

[1] https://lore.kernel.org/lkml/01551d06-c421-5df3-b19f-fc66f3639e4f@redhat.com
[2] https://lore.kernel.org/lkml/20180921073211.20097-2-lijiang@redhat.com

---

Bjorn Helgaas (3):
      x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one error
      resource: Include resource end in walk_*() interfaces
      resource: Fix find_next_iomem_res() iteration issue


 arch/x86/include/asm/kexec.h |    2 -
 kernel/resource.c            |   96 ++++++++++++++++++------------------------
 2 files changed, 43 insertions(+), 55 deletions(-)
