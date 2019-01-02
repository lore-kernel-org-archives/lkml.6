Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E18218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GjnBYCRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfABOfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:35:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfABOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cPQ2g3+veurSy3q3emnkvDRSorEYoRaPIhtKTF/98+w=; b=GjnBYCRUXU8Lm0EJnxHR1pBQRq
        yeRlk+cXsiVBV8qJPnN57KdzycC1pjnhtiwCK7NvQwI0V7GUjxw6sU661bgUUovPIadymRXKnf+fn
        /1vegpDN9s/DVhecTlLvSGMn4acmbWpQQ9OPtn2+1RPICPggtwkDqZpv7ZJuR/p/E66enoE+TWppb
        AEaCQnWyIdhZPbFgOQ6upabqSUff6rjPFrO2o6UNt9rwWDBdoe0XWJRQI2nOSHIseDddVHys0tLY+
        an5A//jYAMw0wDoztJnSKc9x1CcNPLcSNPU+VqjnYAKEduYkVjR7kltslLYDPjU8/Q9IAK8n1ehkX
        GaVhKIPQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gehbv-0008Dq-KJ; Wed, 02 Jan 2019 14:35:07 +0000
Date:   Wed, 2 Jan 2019 06:35:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Display CHECK files like CC files
Message-ID: <20190102143507.GI6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with O= and C=1, this output looks weird:

  CC      fs/file_table.o
  CHECK   ../fs/file_table.c
  CC      fs/open.o
  CHECK   ../fs/open.c
  CC      fs/super.o
  CHECK   ../fs/super.c
  CC      fs/read_write.o
  CHECK   ../fs/read_write.c

Use $@ like CC instead of $< to produce the same output for both CHECK and CC.

Signed-off-by: Matthew Wilcox <willy@infradead.org>

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60f6c5a..f36b03396d9a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -74,10 +74,10 @@ __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
 
 # Linus' kernel sanity checking tool
 ifeq ($(KBUILD_CHECKSRC),1)
-  quiet_cmd_checksrc       = CHECK   $<
+  quiet_cmd_checksrc       = CHECK   $@
         cmd_checksrc       = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 else ifeq ($(KBUILD_CHECKSRC),2)
-  quiet_cmd_force_checksrc = CHECK   $<
+  quiet_cmd_force_checksrc = CHECK   $@
         cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 endif
 
