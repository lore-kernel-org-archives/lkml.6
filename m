Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D664C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C878214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C878214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeKUGuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:50:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeKUGuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:50:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3DBD3082DDB;
        Tue, 20 Nov 2018 20:19:30 +0000 (UTC)
Received: from jlaw-desktop.bos.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43F5568D4A;
        Tue, 20 Nov 2018 20:19:30 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC PATCH 1/1] scripts/recordmcount.{c,pl}: support -ffunction-sections .text.* section names
Date:   Tue, 20 Nov 2018 15:19:18 -0500
Message-Id: <1542745158-25392-2-git-send-email-joe.lawrence@redhat.com>
In-Reply-To: <1542745158-25392-1-git-send-email-joe.lawrence@redhat.com>
References: <1542745158-25392-1-git-send-email-joe.lawrence@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 20 Nov 2018 20:19:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -ffunction-sections, the compiler will place each
function into its own ELF section, prefixed with ".text".  For example,
a simple test module with functions test_module_do_work() and
test_module_wq_func():

  % objdump --section-headers test_module.o | awk '/\.text/{print $2}'
  .text
  .text.test_module_do_work
  .text.test_module_wq_func
  .init.text
  .exit.text

Adjust the recordmcount scripts to look for ".text" as a section name
prefix.  This will ensure that those functions will be included in the
__mcount_loc relocations:

  % objdump --reloc --section __mcount_loc test_module.o
  OFFSET           TYPE              VALUE
  0000000000000000 R_X86_64_64       .text.test_module_do_work
  0000000000000008 R_X86_64_64       .text.test_module_wq_func
  0000000000000010 R_X86_64_64       .init.text

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/recordmcount.c  |  2 +-
 scripts/recordmcount.pl | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 895c40e8679f..a50a2aa963ad 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -397,7 +397,7 @@ static uint32_t w2nat(uint16_t const x)
 static int
 is_mcounted_section_name(char const *const txtname)
 {
-	return strcmp(".text",           txtname) == 0 ||
+	return strncmp(".text",          txtname, 5) == 0 ||
 		strcmp(".init.text",     txtname) == 0 ||
 		strcmp(".ref.text",      txtname) == 0 ||
 		strcmp(".sched.text",    txtname) == 0 ||
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index f599031260d5..68841d01162c 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -142,6 +142,11 @@ my %text_sections = (
      ".text.unlikely" => 1,
 );
 
+# Acceptable section-prefixes to record.
+my %text_section_prefixes = (
+     ".text." => 1,
+);
+
 # Note: we are nice to C-programmers here, thus we skip the '||='-idiom.
 $objdump = 'objdump' if (!$objdump);
 $objcopy = 'objcopy' if (!$objcopy);
@@ -519,6 +524,14 @@ while (<IN>) {
 
 	# Only record text sections that we know are safe
 	$read_function = defined($text_sections{$1});
+	if (!$read_function) {
+	    foreach my $prefix (keys %text_section_prefixes) {
+	        if (substr($1, 0, length $prefix) eq $prefix) {
+	            $read_function = 1;
+	            last;
+	        }
+	    }
+	}
 	# print out any recorded offsets
 	update_funcs();
 
-- 
1.8.3.1

