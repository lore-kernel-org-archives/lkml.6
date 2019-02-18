Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D918C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6051921908
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498743;
	bh=N4T1vwEkO1TuFpuEdKFVnTeYlONgTCOoPObgJg/bVvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FRwKSPUlqbIv+/hHfmelVQdQqqcGxUHF/EA4AfEehQy44tcJpg5yKvFSJo5O2Ze3g
	 Z9Q1weXP6lrtiUrwZSAheYZ1X1mwPL/0pnLBWHiJryaM8E+F2o0hcifsB2pqASxE81
	 zYYTnJtc4zn72OG3sEmInEvSihrRQtELA7crYy1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390214AbfBROFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbfBROFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52F421901;
        Mon, 18 Feb 2019 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498737;
        bh=N4T1vwEkO1TuFpuEdKFVnTeYlONgTCOoPObgJg/bVvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLm88CHTtLEEpOW2TTlPsG9vHvPaCbJiaUZ1d+pVuXmcxLMcTfMk6qF05PFqHT0L8
         nHAGj0pI6M0tu9N52hsn1jtQ64zhgUqN2jXCwWvpJ3BzQDXfVOUkHKqnOO18lDQHnP
         lvf51s7WOwuZtF5baE9+QsHlENYFwqTotXPKgWtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W . Rozycki" <macro@linux-mips.org>
Subject: [PATCH 4.4 105/143] MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds
Date:   Mon, 18 Feb 2019 14:43:53 +0100
Message-Id: <20190218133532.870013216@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 67fc5dc8a541e8f458d7f08bf88ff55933bf9f9d upstream.

When generating vdso-o32.lds & vdso-n32.lds for use with programs
running as compat ABIs under 64b kernels, we previously haven't included
the compiler flags that are supposedly common to all ABIs - ie. those in
the ccflags-vdso variable.

This is problematic in cases where we need to provide the -m%-float flag
in order to ensure that we don't attempt to use a floating point ABI
that's incompatible with the target CPU & ABI. For example a toolchain
using current gcc trunk configured --with-fp-32=xx fails to build a
64r6el_defconfig kernel with the following error:

  cc1: error: '-march=mips1' requires '-mfp32'
  make[2]: *** [arch/mips/vdso/Makefile:135: arch/mips/vdso/vdso-o32.lds] Error 1

Include $(ccflags-vdso) for the compat VDSO .lds builds, just as it is
included for the native VDSO .lds & when compiling objects for the
compat VDSOs. This ensures we consistently provide the -msoft-float flag
amongst others, avoiding the problem by ensuring we're agnostic to the
toolchain defaults.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Cc: linux-mips@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Maciej W . Rozycki <macro@linux-mips.org>
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/vdso/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -107,7 +107,7 @@ $(obj)/%-o32.o: $(src)/%.c FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
-$(obj)/vdso-o32.lds: KBUILD_CPPFLAGS := -mabi=32
+$(obj)/vdso-o32.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) -mabi=32
 $(obj)/vdso-o32.lds: $(src)/vdso.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
 
@@ -143,7 +143,7 @@ $(obj)/%-n32.o: $(src)/%.c FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
-$(obj)/vdso-n32.lds: KBUILD_CPPFLAGS := -mabi=n32
+$(obj)/vdso-n32.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) -mabi=n32
 $(obj)/vdso-n32.lds: $(src)/vdso.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
 


