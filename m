Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5588C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C00720700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108125;
	bh=hqiuZuyPhhv87MtciiDhzbF+lroxyx6vVeli4pmvq78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C8WJfc+KbzjWwxv1nk68lz3+qOaLIDKBKaQnDbnxhmmzf8XJ2o6SAMCGSfGIbmjeR
	 8wy5WkxsiavlCkVPsupZmS4QSF9SizOY4e4syYQ8mI42pMoM7p+IAGxlj32llF318Z
	 vFyofj4gaT43krxaGcH3CG5tgK/QlwHKfQ40ALh8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C00720700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLFOzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729850AbeLFOoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5F22146D;
        Thu,  6 Dec 2018 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107445;
        bh=hqiuZuyPhhv87MtciiDhzbF+lroxyx6vVeli4pmvq78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCDC5b6Gmri8FR6U53FCWiriqRFlE3KjGGQy9S17xvSDDg2QVcuYNdyiLsQSss0Gz
         dzrVQSByy4ltFP3efDEKUi6p+q9hVYjnSyAt4eijhngQK1yU0PXJ8PJfa3U66Q8OsV
         szSnjFN3bDLU1afuI6JomCjBdDigdoT1aVGV6+bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.9 001/101] Kbuild: suppress packed-not-aligned warning for default setting only
Date:   Thu,  6 Dec 2018 15:38:00 +0100
Message-Id: <20181206143011.481021359@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiongfeng Wang <xiongfeng.wang@linaro.org>

commit 321cb0308a9e76841394b4bbab6a1107cfedbae0 upstream.

gcc-8 reports many -Wpacked-not-aligned warnings. The below are some
examples.

./include/linux/ceph/msgr.h:67:1: warning: alignment 1 of 'struct
ceph_entity_addr' is less than 8 [-Wpacked-not-aligned]
 } __attribute__ ((packed));

./include/linux/ceph/msgr.h:67:1: warning: alignment 1 of 'struct
ceph_entity_addr' is less than 8 [-Wpacked-not-aligned]
 } __attribute__ ((packed));

./include/linux/ceph/msgr.h:67:1: warning: alignment 1 of 'struct
ceph_entity_addr' is less than 8 [-Wpacked-not-aligned]
 } __attribute__ ((packed));

This patch suppresses this kind of warnings for default setting.

Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Makefile.extrawarn |    3 +++
 1 file changed, 3 insertions(+)

--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -10,6 +10,8 @@
 # are not supported by all versions of the compiler
 # ==========================================================================
 
+KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
+
 ifeq ("$(origin W)", "command line")
   export KBUILD_ENABLE_EXTRA_GCC_CHECKS := $(W)
 endif
@@ -25,6 +27,7 @@ warning-1 += -Wold-style-definition
 warning-1 += $(call cc-option, -Wmissing-include-dirs)
 warning-1 += $(call cc-option, -Wunused-but-set-variable)
 warning-1 += $(call cc-option, -Wunused-const-variable)
+warning-1 += $(call cc-option, -Wpacked-not-aligned)
 warning-1 += $(call cc-disable-warning, missing-field-initializers)
 warning-1 += $(call cc-disable-warning, sign-compare)
 


