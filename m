Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB25C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E362533C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E362533C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031148AbeGAQiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:38:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031539AbeGAQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:38:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A428ACD;
        Sun,  1 Jul 2018 16:38:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.17 006/220] x86/mce: Improve error message when kernel cannot recover
Date:   Sun,  1 Jul 2018 18:20:30 +0200
Message-Id: <20180701160908.562327665@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Tony Luck <tony.luck@intel.com>

commit c7d606f560e4c698884697fef503e4abacdd8c25 upstream.

Since we added support to add recovery from some errors inside the kernel in:

commit b2f9d678e28c ("x86/mce: Check for faults tagged in EXTABLE_CLASS_FAULT exception table entries")

we have done a less than stellar job at reporting the cause of recoverable
machine checks that occur in other parts of the kernel. The user just gets
the unhelpful message:

	mce: [Hardware Error]: Machine check: Action required: unknown MCACOD

doubly unhelpful when they check the manual for the reported IA32_MSR_STATUS.MCACOD
and see that it is listed as one of the standard recoverable values.

Add an extra rule to the MCE severity table to catch this case and report it
as:

	mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel

Fixes: b2f9d678e28c ("x86/mce: Check for faults tagged in EXTABLE_CLASS_FAULT exception table entries")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org # 4.6+
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/4cc7c465150a9a48b8b9f45d0b840278e77eb9b5.1527283897.git.tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce-severity.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -160,6 +160,11 @@ static struct severity {
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
 		USER
 		),
+	MCESEV(
+		PANIC, "Data load in unrecoverable area of kernel",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
+		KERNEL
+		),
 #endif
 	MCESEV(
 		PANIC, "Action required: unknown MCACOD",


