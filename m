Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F4FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001F12084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001F12084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGRWE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:04:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbeGRWE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:04:28 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 642B0D37;
        Wed, 18 Jul 2018 21:24:15 +0000 (UTC)
Date:   Wed, 18 Jul 2018 14:24:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Coly Li <colyli@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Noah Massey <noah.massey@gmail.com>
Subject: Re: [PATCH v4 3/3] lib/test_crc: Add test cases for crc calculation
Message-Id: <20180718142414.1cab5d98b1f4b01102cd429a@linux-foundation.org>
In-Reply-To: <20180718165545.1622-4-colyli@suse.de>
References: <20180718165545.1622-1-colyli@suse.de>
        <20180718165545.1622-4-colyli@suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 00:55:45 +0800 Coly Li <colyli@suse.de> wrote:

> This patch adds a kernel module to test the consistency of multiple crc
> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
> 
> The test results are printed into kernel message, which look like,
> 
> test_crc: crc64_be: FAILED (0x03d4d0d85685d9a1, expected 0x3d4d0d85685d9a1f)
> 
> kernel 0day system has framework to check kernel message, then the above
> result can be handled by 0day system. If crc calculation inconsistency
> happens, it can be detected quite soon.
> 
> lib/test_crc.c is a testing frame work for many crc consistency
> testings. For now, there is only one test caes for crc64_be().

Some tweaks.



From: Andrew Morton <akpm@linux-foundation.org>
Subject: lib-test_crc-add-test-cases-for-crc-calculation-fix

make two globals static, regularize code layout, remove unneeded initialization

Cc: Coly Li <colyli@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/test_crc.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff -puN lib/test_crc.c~lib-test_crc-add-test-cases-for-crc-calculation-fix lib/test_crc.c
--- a/lib/test_crc.c~lib-test_crc-add-test-cases-for-crc-calculation-fix
+++ a/lib/test_crc.c
@@ -25,8 +25,8 @@ struct crc_test_record {
 	void	(*handler)(struct crc_test_record *rec);
 };
 
-int failed_tests;
-int total_tests;
+static int failed_tests;
+static int total_tests;
 
 static void chk_and_msg(const char *name, u64 crc, u64 expval)
 {
@@ -68,9 +68,6 @@ static int __init test_crc_init(void)
 {
 	int i;
 
-	failed_tests = 0;
-	total_tests = 0;
-
 	pr_info("Kernel CRC consistency testing:\n");
 	for (i = 0; test_data[i].name; i++)
 		test_data[i].handler(&test_data[i]);
@@ -85,7 +82,9 @@ static int __init test_crc_init(void)
 }
 late_initcall(test_crc_init);
 
-static void __exit test_crc_exit(void) { }
+static void __exit test_crc_exit(void)
+{
+}
 module_exit(test_crc_exit);
 
 MODULE_DESCRIPTION("CRC consistency testing driver");
_

