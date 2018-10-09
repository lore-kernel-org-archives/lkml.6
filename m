Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C6C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047AC214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047AC214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIWsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:48:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:48:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99FUov01091779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:30:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99FUouf1091776;
        Tue, 9 Oct 2018 08:30:50 -0700
Date:   Tue, 9 Oct 2018 08:30:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bjorn Helgaas <tipbot@zytor.com>
Message-ID: <tip-51fbf14f2528a8c6401290e37f1c893a2412f1d3@git.kernel.org>
Cc:     lijiang@redhat.com, brijesh.singh@amd.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        mingo@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
        mingo@redhat.com, bp@suse.de, vgoyal@redhat.com, tiwai@suse.de,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, akpm@linux-foundation.org,
          gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
          mingo@kernel.org, lijiang@redhat.com, brijesh.singh@amd.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          bhelgaas@google.com, tiwai@suse.de, bp@suse.de,
          vgoyal@redhat.com, mingo@redhat.com
In-Reply-To: <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Git-Commit-ID: 51fbf14f2528a8c6401290e37f1c893a2412f1d3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  51fbf14f2528a8c6401290e37f1c893a2412f1d3
Gitweb:     https://git.kernel.org/tip/51fbf14f2528a8c6401290e37f1c893a2412f1d3
Author:     Bjorn Helgaas <bhelgaas@google.com>
AuthorDate: Thu, 27 Sep 2018 09:21:55 -0500
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 9 Oct 2018 17:18:31 +0200

x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one error

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
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Brijesh Singh <brijesh.singh@amd.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Lianbo Jiang <lijiang@redhat.com>
CC: Takashi Iwai <tiwai@suse.de>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: baiyaowei@cmss.chinamobile.com
CC: bhe@redhat.com
CC: dan.j.williams@intel.com
CC: dyoung@redhat.com
CC: kexec@lists.infradead.org
Link: http://lkml.kernel.org/r/153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com
---
 arch/x86/include/asm/kexec.h | 2 +-
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
