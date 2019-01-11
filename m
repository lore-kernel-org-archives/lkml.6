Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D738AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBB8206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218611;
	bh=TJEPmVOH+ntqnQI/+bfhEn8QJhFPrLThUtKoM+GGlbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=quvNexLE5pxTmftRlwwNeVlOo70QLqNczLzfJCdjQvQyPglwfrhjnps3Q8O/DdkbS
	 p02DCLZkot7vCYOkZYOdPiNqI5yhgl8K37nX+ZmfEzYjDt4q+vu38HMHmZBIcmt1Pf
	 4M3zWHgXTtSO8GJMl7rLbcpebKVVkeJcxkcEnUyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbfAKOfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389931AbfAKOeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF712133F;
        Fri, 11 Jan 2019 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217270;
        bh=TJEPmVOH+ntqnQI/+bfhEn8QJhFPrLThUtKoM+GGlbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6aapS0jQnDkJIzFv/N0sUfQss1ZuiOdFWF/PElp7Q1iRhKd0jlaSJibIiaEkDSgM
         2ZXEFoaUQcgfcBPobT93qm6DoHKTYDFROhEUwDfdArw2Ha2M4SIabcCbjcz1OWWVBS
         duZpHZqyO3FMYblf03/AYbsFXB/seAZDIEOoQ5/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 069/105] powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer
Date:   Fri, 11 Jan 2019 15:14:40 +0100
Message-Id: <20190111131108.798178199@linuxfoundation.org>
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

From: Nicholas Piggin <npiggin@gmail.com>

commit 6977f95e63b9b3fb4a5973481a800dd9f48a1338 upstream.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[nc: Adjust context due to lack of f2910f0e6835 and 2a056f58fd33]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Makefile |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -236,7 +236,12 @@ endif
 
 # Work around a gcc code-gen bug with -fno-omit-frame-pointer.
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
-KBUILD_CFLAGS		+= -mno-sched-epilog
+# Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
+ifneq ($(cc-name),clang)
+KBUILD_CFLAGS		+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
+endif
 endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405


