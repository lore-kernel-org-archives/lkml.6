Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E26C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151F02151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY/zhla2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151F02151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbeKVFpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbeKVFpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B536214D9;
        Wed, 21 Nov 2018 19:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827388;
        bh=14QBHg2WPpMB1PWAkLUVCzYusKiEFA1Educo0QEqDn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pY/zhla2r5X8ZlMjqnaDfq+ndG1S4enJR0XzbmaF5vThx7nGPEkfFY5xzzgCW88Rs
         3k/pm9Lafcq/LgepI6d1w0cXtl7JyeRfAdfKatWUg1iLBXgUZI63KsZTQGMnDTf1y/
         CMRiaDcq8Qv8etqtKZL0gJOzsN2PSrZDp95MGXuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Davidson <md@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 11/59] kbuild: clang: add -no-integrated-as to KBUILD_[AC]FLAGS
Date:   Wed, 21 Nov 2018 20:06:26 +0100
Message-Id: <20181121183508.705946990@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Davidson <md@google.com>

commit a37c45cd82e62a361706b9688a984a3a63957321 upstream.

The Linux Kernel relies on GCC's acceptance of inline assembly as an
opaque object which will not have any validation performed on the content.
The current behaviour in LLVM is to perform validation of the contents by
means of parsing the input if the MC layer can handle it.

Disable clangs integrated assembler and use the GNU assembler instead.

Wording-mostly-from: Saleem Abdulrasool <compnerd@compnerd.org>
Signed-off-by: Michael Davidson <md@google.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -725,6 +725,8 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # See modpost pattern 2
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
 KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
+KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 else
 
 # These warnings generated too much noise in a regular build.


