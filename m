Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D18FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF2320874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218713;
	bh=BB5r19SIE5YXVuMbo8imAO1mjlTAWrkxQTPaxW0abL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sq+4JazY+GLilrbtkwgYvx4kxwrJBaX/ie4HFc5c2rOljVJIwGrFljm8fRSqvs25A
	 WjwnJKPQLnTb0bkINW4tIgVLf3SgFhcJV+YiAnmailsEcfqu0+o8GzpX9K6wfWhMcb
	 kdqbXtvSD6xgvAeskGYFh4DkNezzrVUyZgEquV/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391718AbfAKO60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389192AbfAKOeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C7C2184A;
        Fri, 11 Jan 2019 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217276;
        bh=BB5r19SIE5YXVuMbo8imAO1mjlTAWrkxQTPaxW0abL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRkaadM76jrckGtqabyYHEHWSMRWYe5i8lmmvn/MiYYfa2PjtApASb+2oEVFjgyxJ
         e7Cc61Wqy6CIWJc15ZVC01Osi20NbwfW77lelJyTjHzrAC15cp+n1dsmCyp+rRIedF
         1SIVqqXzuU9vqAe1AT6ItN+vSOKwVj+W/U4/vR3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 071/105] ftrace: Build with CPPFLAGS to get -Qunused-arguments
Date:   Fri, 11 Jan 2019 15:14:42 +0100
Message-Id: <20190111131108.967916316@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

When building to record the mcount locations the kernel uses
KBUILD_CFLAGS but not KBUILD_CPPFLAGS. This means it lacks
-Qunused-arguments when building with clang, resulting in a lot of
noisy warnings.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Fix conflicts due to lack of 87a32e624037 and d503ac531a52]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.build |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -242,7 +242,7 @@ else
 sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
-	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
+	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl


