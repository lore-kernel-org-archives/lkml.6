Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E93ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537F0214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zQAQx0+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537F0214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbeJSCIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730074AbeJSCIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:08:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E982148D;
        Thu, 18 Oct 2018 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886003;
        bh=3YJ9xM/q67rrbvodTr3yYiN9o879fjLqeULXE3gV96o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQAQx0+2zQJaYDbJaFH6346kV2Eu8MLA8akzBpkQwL2sMObAeYN8QLn2roS0PoJQe
         bXh2PUWNx05CTAVFVDXGpAoVu4YsEBnjkmBLyrdlSH4A7J2Cyx8qH+62Lw4irkG28v
         +P4NdJAq/iOUm/ws3BaweohCAD+9L/2PfECMVH2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.4 43/48] ARC: build: Get rid of toolchain check
Date:   Thu, 18 Oct 2018 19:55:18 +0200
Message-Id: <20181018175430.209323205@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
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

From: Alexey Brodkin <abrodkin@synopsys.com>

commit 615f64458ad890ef94abc879a66d8b27236e733a upstream.

This check is very naive: we simply test if GCC invoked without
"-mcpu=XXX" has ARC700 define set. In that case we think that GCC
was built with "--with-cpu=arc700" and has libgcc built for ARC700.

Otherwise if ARC700 is not defined we think that everythng was built
for ARCv2.

But in reality our life is much more interesting.

1. Regardless of GCC configuration (i.e. what we pass in "--with-cpu"
   it may generate code for any ARC core).

2. libgcc might be built with explicitly specified "--mcpu=YYY"

That's exactly what happens in case of multilibbed toolchains:
 - GCC is configured with default settings
 - All the libs built for many different CPU flavors

I.e. that check gets in the way of usage of multilibbed
toolchains. And even non-multilibbed toolchains are affected.
OpenEmbedded also builds GCC without "--with-cpu" because
each and every target component later is compiled with explicitly
set "-mcpu=ZZZ".

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/Makefile |   14 --------------
 1 file changed, 14 deletions(-)

--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -18,20 +18,6 @@ cflags-y	+= -fno-common -pipe -fno-built
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
 cflags-$(CONFIG_ISA_ARCV2)	+= -mcpu=archs
 
-is_700 = $(shell $(CC) -dM -E - < /dev/null | grep -q "ARC700" && echo 1 || echo 0)
-
-ifdef CONFIG_ISA_ARCOMPACT
-ifeq ($(is_700), 0)
-    $(error Toolchain not configured for ARCompact builds)
-endif
-endif
-
-ifdef CONFIG_ISA_ARCV2
-ifeq ($(is_700), 1)
-    $(error Toolchain not configured for ARCv2 builds)
-endif
-endif
-
 ifdef CONFIG_ARC_CURR_IN_REG
 # For a global register defintion, make sure it gets passed to every file
 # We had a customer reported bug where some code built in kernel was NOT using


