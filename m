Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E3621104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiX9Ex2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E3621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeKZVsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeKZVsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B457E21104;
        Mon, 26 Nov 2018 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229674;
        bh=ATFqqJQm4xNXVbA1fV+XurdPHlPOaf+Na9Z88jcesIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiX9Ex2UPctw2OV5BiXrqGe7kGQhCMsG1CGLXl+IZUTnAVXSah4Gr1N+vAb3jMdub
         JpLKofLJLlAEpB98aUhu47pATEIdrFJse8NsdbFo2y/P/sz0HsGlZumdKdk1vrsUT4
         W+9ET5gwhjV2UwPf1akqMPMCdy4JQh+hs2YEgbRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 28/70] arm64: Disable asm-operand-width warning for clang
Date:   Mon, 26 Nov 2018 11:50:43 +0100
Message-Id: <20181126105049.506839265@linuxfoundation.org>
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

From: Matthias Kaehlcke <mka@chromium.org>

clang raises 'asm-operand-widths' warnings in inline assembly code when
the size of an operand is < 64 bits and the operand width is unspecified.
Most warnings are raised in macros, i.e. the datatype of the operand may
vary.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

nc: I trimmed the original commit message since I'm not a part of CrOS
    and can't speak on their behalf.

    To fix these warnings, it requires a fairly intrusive backport of
    the sysreg conversion that Mark Rutland did in 4.9. I think
    disabling the warning is smarter, similar to commit d41d0fe374d4
    ("turn off -Wattribute-alias") in this tree.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Makefile |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -56,6 +56,10 @@ else
 TEXT_OFFSET := 0x00080000
 endif
 
+ifeq ($(cc-name),clang)
+KBUILD_CFLAGS += $(call cc-disable-warning, asm-operand-widths)
+endif
+
 # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - 3)) - (1 << 61)
 # in 32-bit arithmetic
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \


