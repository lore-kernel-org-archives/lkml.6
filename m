Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D86C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B1021104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5B+YfOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B1021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeKZVtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbeKZVtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:49:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004302089F;
        Mon, 26 Nov 2018 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229717;
        bh=f4DlPEs0jyd99gZkIHJpwacyGxY/o7lO1slSg7pmmnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5B+YfOV/tehANJER+7X/ICdT63U5dNb9YpW5ZpbgI88JHO5iDO82alt1F+d54ubG
         dPCG5EsQ8Q18hJIC2kk/qTpsUoI1nEGD1JbhkdyEJzqJe9Ri4HDmKn5UTbBCa/gQY8
         MSyG5W2ziUethPvahK13GerZZVeIJi4D7b1zQcWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 09/70] kbuild: consolidate redundant sed script ASM offset generation
Date:   Mon, 26 Nov 2018 11:50:24 +0100
Message-Id: <20181126105047.796897385@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 7dd47b95b0f54f2057d40af6e66d477e3fe95d13 upstream.

This part ended up in redundant code after touched by multiple
people.

[1] Commit 3234282f33b2 ("x86, asm: Fix CFI macro invocations to
deal with shortcomings in gas") added parentheses for defined
expressions to support old gas for x86.

[2] Commit a22dcdb0032c ("x86, asm: Fix ancient-GAS workaround")
split the pattern into two to avoid parentheses for non-numeric
expressions.

[3] Commit 95a2f6f72d37 ("Partially revert patch that encloses
asm-offset.h numbers in brackets") removed parentheses from numeric
expressions as well because parentheses in MN10300 assembly have a
special meaning (pointer access).

Apparently, there is a conflict between [1] and [3].  After all,
[3] took precedence, and a long time has passed since then.

Now, merge the two patterns again because the first one is covered
by the other.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.lib |    1 -
 1 file changed, 1 deletion(-)

--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -395,7 +395,6 @@ cmd_xzmisc = (cat $(filter-out FORCE,$^)
 # Default sed regexp - multiline due to syntax constraints
 define sed-offsets
 	"/^->/{s:->#\(.*\):/* \1 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:; \
 	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
 	s:->::; p;}"
 endef


