Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9HsDGR+5Gls6RQAAmS7hNA
	; Fri, 08 Jun 2018 17:19:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 52162607DC; Fri,  8 Jun 2018 17:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 87C40605A5;
	Fri,  8 Jun 2018 17:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87C40605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbeFHRT3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:19:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:29354 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752953AbeFHRT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:19:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 10:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="231034808"
Received: from nzou1-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.254.60])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2018 10:19:20 -0700
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org (open list:SPARSE CHECKER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 01/13] compiler.h, kasan: add __SANITIZE_ADDRESS__ check for __no_kasan_or_inline
Date: Fri,  8 Jun 2018 19:09:36 +0200
Message-Id: <20180608171216.26521-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add 'defined(__SANITIZE_ADDRESS__)' to check to determine whether
__no_kasan_or_inline should be 'no_kasan' or 'inline'.  Files that
compile with KASAN disabled may not link to KASAN, in which case
the __maybe_unused attribute added in the 'no_kasan' option can
cause linker errors due to unused functions that manually invoke
KASAN functions, e.g. read_word_at_a_time(), not being discarded.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c63601..e7a863a3ac8c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -188,7 +188,7 @@ void __read_once_size(const volatile void *p, void *res, int size)
 	__READ_ONCE_SIZE;
 }
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN) && defined(__SANITIZE_ADDRESS__)
 /*
  * We can't declare function 'inline' because __no_sanitize_address confilcts
  * with inlining. Attempt to inline it may cause a build failure.
-- 
2.17.0
