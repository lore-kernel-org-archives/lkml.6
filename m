Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0239C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8646213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eolR8L6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8646213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbeK3Bdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731925AbeK3Bds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D17382145D;
        Thu, 29 Nov 2018 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501695;
        bh=ONtAe6aUfrZ7Zr2CyZPEHSkDvC8UE5LuBhFAMeQiEus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eolR8L6Wa1KwcdECbfzvSHEk3TLWCsL8fFjwrpYDEjK8ZnBY5fJ6fsYVNlWgW+m7U
         0mmfKi3VvKSXHAF1xV6dNs7BhCwM5I0AKGCqUSqGxe2RFU3B2maxubJ8L6xfsp3eUH
         ZOqZKBLJbcc0xMFipNrzWQOeuHiscSeYuYTi8ADc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastien Boisvert <sebhtml@videotron.qc.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Elenie Godzaridis <arangradient@gmail.com>,
        stable@vger.kerenl.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 088/100] include/linux/pfn_t.h: force ~ to be parsed as an unary operator
Date:   Thu, 29 Nov 2018 15:12:58 +0100
Message-Id: <20181129140106.419461294@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastien Boisvert <sebhtml@videotron.qc.ca>

commit 4d54954a197175c0dcb3c82af0c0740d0c5f827a upstream.

Tracing the event "fs_dax:dax_pmd_insert_mapping" with perf produces this
warning:

      [fs_dax:dax_pmd_insert_mapping] unknown op '~'

It is printed in process_op (tools/lib/traceevent/event-parse.c) because
'~' is parsed as a binary operator.

perf reads the format of fs_dax:dax_pmd_insert_mapping ("print fmt") from
/sys/kernel/debug/tracing/events/fs_dax/dax_pmd_insert_mapping/format .

The format contains:

~(((u64) ~(~(((1UL) << 12)-1)))
         ^
         \ interpreted as a binary operator by process_op().

This part is generated in the declaration of the event class
dax_pmd_insert_mapping_class in include/trace/events/fs_dax.h :

		__print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
			PFN_FLAGS_TRACE),

This patch adds a pair of parentheses in the declaration of PFN_FLAGS_MASK
to make sure that '~' is parsed as a unary operator by perf.

The part of the format that was problematic is now:

~(((u64) (~(~(((1UL) << 12)-1))))

Now, all the '~' are parsed as unary operators.

Link: http://lkml.kernel.org/r/20181021145939.8760-1-sebhtml@videotron.qc.ca
Signed-off-by: Sebastien Boisvert <sebhtml@videotron.qc.ca>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Elenie Godzaridis <arangradient@gmail.com>
Cc: <stable@vger.kerenl.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/pfn_t.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -10,7 +10,7 @@
  * PFN_DEV - pfn is not covered by system memmap by default
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
  */
-#define PFN_FLAGS_MASK (((u64) ~PAGE_MASK) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
+#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
 #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
 #define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
 #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))


