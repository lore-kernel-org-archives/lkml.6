Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9144FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4588F208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gznwjcqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4588F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934943AbeFLQuG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934951AbeFLQsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:48:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47AB8208B7;
        Tue, 12 Jun 2018 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822090;
        bh=M3ks+pkVnOVDKcj1sJRwDklA/o3hqEs2YfAmJfTErFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gznwjcqIekOTJxN6Nyu9g3gwj91QQ69uIpUB5dOY+dWKsrdHwmO24wZt3FedlDLs+
         8aMWDSlvjqNjBn6lDUOwxeV63aOoVNLlcs+mgr71DZv7wLeo3fP1JeydFUWbgk6H62
         mrPZ6Lk0A6iNkBB1BQfX0a7uVUgxA1U00C0VWzTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 30/31] objtool: Fix gcov check for older versions of GCC
Date:   Tue, 12 Jun 2018 18:46:33 +0200
Message-Id: <20180612164621.996798847@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 867ac9d737094e46a6c33213f16dd1ec9e8bd5d5 upstream.

Objtool tries to silence 'unreachable instruction' warnings when it
detects gcov is enabled, because gcov produces a lot of unreachable
instructions and they don't really matter.

However, the 0-day bot is still reporting some unreachable instruction
warnings with CONFIG_GCOV_KERNEL=y on GCC 4.6.4.

As it turns out, objtool's gcov detection doesn't work with older
versions of GCC because they don't create a bunch of symbols with the
'gcov.' prefix like newer versions of GCC do.

Move the gcov check out of objtool and instead just create a new
'--no-unreachable' flag which can be passed in by the kernel Makefile
when CONFIG_GCOV_KERNEL is defined.

Also rename the 'nofp' variable to 'no_fp' for consistency with the new
'no_unreachable' variable.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 9cfffb116887 ("objtool: Skip all "unreachable instruction" warnings for gcov kernels")
Link: http://lkml.kernel.org/r/c243dc78eb2ffdabb6e927844dea39b6033cd395.1500939244.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[just Makefile.build as the other parts of this patch already applied - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Makefile.build |    3 +++
 1 file changed, 3 insertions(+)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -253,6 +253,9 @@ objtool_args = check
 ifndef CONFIG_FRAME_POINTER
 objtool_args += --no-fp
 endif
+ifdef CONFIG_GCOV_KERNEL
+objtool_args += --no-unreachable
+endif
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file


