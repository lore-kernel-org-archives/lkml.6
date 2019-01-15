Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15260C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA112085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfAOLor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:44:47 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25872 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727976AbfAOLor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:44:47 -0500
X-IronPort-AV: E=Sophos;i="5.56,481,1539619200"; 
   d="scan'208";a="52060888"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Jan 2019 19:44:44 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id DF3BB4BAD9B7;
        Tue, 15 Jan 2019 19:44:41 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 19:44:40 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: question about head_64.S
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
Date:   Tue, 15 Jan 2019 19:45:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: DF3BB4BAD9B7.ABC03
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have been digging into this file for a while, and I still have 2
questions unclear, hope to get your help.

1.
At the entry of startup_64, we set all the data segment registers to 0,
according to commit 08da5a2ca("x86_64: Early segment setup for VT"), it
is said to accelerate the decompression under VT. I don't know Intel VT,
but I did test under physical machine and virtual machine(with KVM, and
intel VT enabled in BIOS) with following patch:

diff --git a/arch/x86/boot/compressed/head_64.S
b/arch/x86/boot/compressed/head_64.S
index 58f6a467f1fa..595f3c300173 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -260,12 +260,12 @@ ENTRY(startup_64)
         */

        /* Setup data segments. */
-       xorl    %eax, %eax
-       movl    %eax, %ds
-       movl    %eax, %es
-       movl    %eax, %ss
-       movl    %eax, %fs
-       movl    %eax, %gs
+//     xorl    %eax, %eax
+//     movl    %eax, %ds
+//     movl    %eax, %es
+//     movl    %eax, %ss
+//     movl    %eax, %fs
+//     movl    %eax, %gs

I don't see any obvious booting time difference, is there anything I missed?
Also, I don't find explicit document saying we should zero these
registers under VT.

2.
Why gdt64 has following definition?:

gdt64:
	.word	gdt_end - gdt
	.long	0
	.word	0
	.quad   0

obviously, gdt64 stores the GDTR content under x86_64, which is 10 bytes
long, so why not just:

gdt64:
	.word	gdt_end - gdt
	.quad   0

With above modification, it can boot.
-- 
Sincerely,
Cao jin


