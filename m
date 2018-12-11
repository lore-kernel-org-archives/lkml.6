Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A900C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD14620851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545077;
	bh=80CZw+1+OuPoiSH/PQW9R9H5kv9UF4hVtOQ2EY+3NFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q0tvH3z5btznsaNLb5RVa9/8WSccoO3tK5aHSj5RC8nAIWdi206jdiNLXY9uZqSvR
	 oSA+rfMAEIvqbVWNxCxmOiKaQPZcydPhPqU9J06JFpEm8TMi0Y+jqVBRrHdNd+6mDe
	 EPrK8zvc5oVlwPDDFCZFPM8PYpkjOwllLNumUkMo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD14620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeLKQRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbeLKPqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91D1208E7;
        Tue, 11 Dec 2018 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543209;
        bh=80CZw+1+OuPoiSH/PQW9R9H5kv9UF4hVtOQ2EY+3NFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmAuW7iof9E4fa1yTxLRL/ffZfvtLyJfdUTxgaWQl2V36l3vA3dLQlwg0Nza2wl7R
         TW4KHMzzpJZGvm5RHhOtu/svvXsCBGMwOfjsFQ3moHByAuG2oumP/J13G9IjIQenaX
         LD4ratvjWViqhX1Er6un/bJUArEIWLHVztwT9Uqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.4 21/91] Kbuild: suppress packed-not-aligned warning for default setting only
Date:   Tue, 11 Dec 2018 16:40:40 +0100
Message-Id: <20181211151607.518914047@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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
 
 warning-2 := -Waggregate-return


