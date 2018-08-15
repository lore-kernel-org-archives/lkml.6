Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC3AC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4953921721
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JrU2cT8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4953921721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeHOD0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:26:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeHOD0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WbXiojAcYHcwBfBc5z1U42Z5iTTFVhLL88thTrgsEnc=; b=JrU2cT8QvBKGHthr8FJ6/3rY46
        xYXY6lh7L2gdQQ5l8ECg9NsmN1W0rMXMyb9t+rrEB9MraXoMU08LHoj7Knwg3eMZnjDVSxOQ1m5XQ
        WBTTyxV1qEM0JblMMGMHAJAf+HjfIAUYMiz+arvY6SNDb8P0ykLVDgGsfEqPU/eEFvn0SnaVuXg4l
        JUwUQLv/B2z0dam1KqjtyXh+f3JHZ4BwJC2sY2H5f8oli39YcWtLwG9Ln164MIp3DEtU70arkF0Zq
        vZPwtCB8DfQG9cZaRO/c2OuMnyBT2NUFqjrV91J5HxFjZJOZHGRKHzLlYtcv7JCJOB1Zh5xiYsJwb
        yD+dGWrA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpjny-00087x-2B; Wed, 15 Aug 2018 00:36:54 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kconfig: add build-only configurator targets
Message-ID: <abba6b9a-597b-a3eb-6d91-8a7261492c78@infradead.org>
Date:   Tue, 14 Aug 2018 17:36:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add build-only targets for build_menuconfig, build_nconfig,
build_xconfig, and build_gconfig.
(targets must end in "config" to qualify in top-level Makefile)

This allows these target to be built without execution (e.g., to
look for errors or warnings) and/or to be built and checked by sparse.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 scripts/kconfig/Makefile |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-next-20180814.orig/scripts/kconfig/Makefile
+++ linux-next-20180814/scripts/kconfig/Makefile
@@ -33,6 +33,14 @@ config: $(obj)/conf
 nconfig: $(obj)/nconf
 	$< $(silent) $(Kconfig)
 
+build_menuconfig: $(obj)/mconf
+
+build_nconfig: $(obj)/nconf
+
+build_gconfig: $(obj)/gconf
+
+build_xconfig: $(obj)/qconf
+
 localyesconfig localmodconfig: $(obj)/conf
 	$(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
 	$(Q)if [ -f .config ]; then 					\

