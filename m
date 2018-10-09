Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BFBC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A4921479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A4921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJIRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:47:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46055 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeJIRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:47:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99AUp9u999982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 03:30:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99AUpp4999979;
        Tue, 9 Oct 2018 03:30:51 -0700
Date:   Tue, 9 Oct 2018 03:30:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-cf089611f4c446285046fcd426d90c18f37d2905@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, bp@suse.de, mingo@kernel.org,
        lijiang@redhat.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, lijiang@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, bp@suse.de, mingo@kernel.org
In-Reply-To: <710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com>
References: <710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] proc/vmcore: Fix i386 build error of missing
 copy_oldmem_page_encrypted()
Git-Commit-ID: cf089611f4c446285046fcd426d90c18f37d2905
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

Commit-ID:  cf089611f4c446285046fcd426d90c18f37d2905
Gitweb:     https://git.kernel.org/tip/cf089611f4c446285046fcd426d90c18f37d2905
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 8 Oct 2018 10:05:20 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 9 Oct 2018 11:57:28 +0200

proc/vmcore: Fix i386 build error of missing copy_oldmem_page_encrypted()

Lianbo reported a build error with a particular 32-bit config, see Link
below for details.

Provide a weak copy_oldmem_page_encrypted() function which architectures
can override, in the same manner other functionality in that file is
supplied.

Reported-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: x86@kernel.org
Link: http://lkml.kernel.org/r/710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com
---
 fs/proc/vmcore.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 42c32d06f7da..91ae16fbd7d5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -187,6 +187,16 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
+/*
+ * Architectures which support memory encryption override this.
+ */
+ssize_t __weak
+copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+			   unsigned long offset, int userbuf)
+{
+	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
+}
+
 /*
  * Copy to either kernel or user space
  */
