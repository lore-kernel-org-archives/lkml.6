Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED09C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C163D20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108342;
	bh=qea203T00d5QGpCpPcyqypRnZ+DGOeOW1WHFrfK76JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WLtlXD1IWKkvNvqpf6O/nkk3omeW/Av0dApwEQ6wMnjcIwuNwJ//8jVOJeKVtyCst
	 qx/zPu3snxLox0ib/3T7XYWwS0vz5MFwfBNNSwFWsLm5t9OIjFPtW7HnA20wZ0U7J0
	 KgPZbhzmnPFVTZjyKu+Ef0frBtghHyu1lk9Swhac=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C163D20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbeLFOlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730298AbeLFOlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815E520661;
        Thu,  6 Dec 2018 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107300;
        bh=qea203T00d5QGpCpPcyqypRnZ+DGOeOW1WHFrfK76JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNnTYCZm3ELYay5UQQZqqNL7Z0Bu4gbf32rjOxMztT0xxYk0xojgWi667RYmc9RBU
         /z3bRDMRUOqWHU0USS+PZK9vOu3kJfUwcEy6Y/DZRUFwOB2nZ4X1lekrp5pstLje5y
         YF5wQaQnSFbO3SzHQUoC/2fuk2x7SU9N0MC0r3VM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.14 01/55] Kbuild: suppress packed-not-aligned warning for default setting only
Date:   Thu,  6 Dec 2018 15:38:35 +0100
Message-Id: <20181206143001.831278160@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -11,6 +11,8 @@
 # are not supported by all versions of the compiler
 # ==========================================================================
 
+KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
+
 ifeq ("$(origin W)", "command line")
   export KBUILD_ENABLE_EXTRA_GCC_CHECKS := $(W)
 endif
@@ -26,6 +28,7 @@ warning-1 += -Wold-style-definition
 warning-1 += $(call cc-option, -Wmissing-include-dirs)
 warning-1 += $(call cc-option, -Wunused-but-set-variable)
 warning-1 += $(call cc-option, -Wunused-const-variable)
+warning-1 += $(call cc-option, -Wpacked-not-aligned)
 warning-1 += $(call cc-disable-warning, missing-field-initializers)
 warning-1 += $(call cc-disable-warning, sign-compare)
 


