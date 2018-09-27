Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C437C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8426216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="04P+cFTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8426216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeI0Uk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbeI0Uk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:40:27 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E3A216FC;
        Thu, 27 Sep 2018 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538058117;
        bh=owsN081jrijkcbcI16hU/Vz2MaPJONXQwVeDteQpONc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=04P+cFTBi8FyVyj6gAlY88K1IgvOekJv62zakqQXpTUCSCRPVLT9Exg5NqyoGEnDa
         qxNwJoYdEZDzXsd/Wt4R2xK55XaDlh4KVqXassNnCLCrl4wru7SFvVc50HWYEFUfxG
         Df6sRxz6J84T04896yt23970FPehjlznSBaQ0KUg=
Subject: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one error
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lianbo Jiang <lijiang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, bp@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com
Date:   Thu, 27 Sep 2018 09:21:55 -0500
Message-ID: <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The only use of KEXEC_BACKUP_SRC_END is as an argument to
walk_system_ram_res():

  int crash_load_segments(struct kimage *image)
  {
    ...
    walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
                        image, determine_backup_region);

walk_system_ram_res() expects "start, end" arguments that are inclusive,
i.e., the range to be walked includes both the start and end addresses.

KEXEC_BACKUP_SRC_END was previously defined as (640 * 1024UL), which is the
first address *past* the desired 0-640KB range.

Define KEXEC_BACKUP_SRC_END as (640 * 1024UL - 1) so the KEXEC_BACKUP_SRC
region is [0-0x9ffff], not [0-0xa0000].

Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/kexec.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index f327236f0fa7..5125fca472bb 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -67,7 +67,7 @@ struct kimage;
 
 /* Memory to backup during crash kdump */
 #define KEXEC_BACKUP_SRC_START	(0UL)
-#define KEXEC_BACKUP_SRC_END	(640 * 1024UL)	/* 640K */
+#define KEXEC_BACKUP_SRC_END	(640 * 1024UL - 1)	/* 640K */
 
 /*
  * CPU does not save ss and sp on stack if execution is already

