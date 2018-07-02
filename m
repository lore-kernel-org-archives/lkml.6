Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C3B24980
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UTk+TTV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C3B24980
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeGBUu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:50:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeGBUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dzHWSirdhjaVou+XhDBieBh2mLdaXme8EDgluBGNq+g=; b=UTk+TTV8CjQ5dsMfDvpzgshGN
        QAjQ5nY4k1kar36X009kg8UA+u/PA0iblkJHuL6WVcpLBJ3IVU38G2YEDbSE3h1YzMfVkJd55OySK
        67LQb9TaA8ZbNxXttwJUvmirxxEJdcd+DemEIPC/hyr0kF41HJm3abm4J9+0akoMMnhYAyvg6E5Kc
        iROHhPk1yip9Q7Sg04p/1eqouzGGeK2kqHLSpdAr0hPqSu8cS5IlGPoz3aowWpgK4vb3NsvwyAZJB
        WAK1NlbbuOVFgEWZ9nvEu8C43veap9XlwcAIHUXkU8ASqAkLaWLGHVmGmgVxKk8ixr0XM0fQXZgU/
        eUuaUwsYQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa5mC-0002Ol-3p; Mon, 02 Jul 2018 20:50:24 +0000
Subject: Re: [PATCH 1/5] kconfig: include common Kconfig files from top-level
 Kconfig
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
 <20180702144711.22111-2-hch@lst.de>
 <43b9a29d-27fc-1b6e-6f90-9187749bf338@infradead.org>
Message-ID: <7f7dfd3d-6d4b-fc64-956b-1defc5c5a7c3@infradead.org>
Date:   Mon, 2 Jul 2018 13:50:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <43b9a29d-27fc-1b6e-6f90-9187749bf338@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 13:41, Randy Dunlap wrote:

> --- linux-next-20180702.orig/init/Kconfig
> +++ linux-next-20180702/init/Kconfig
> @@ -1717,6 +1717,12 @@ config PROFILING
>  config TRACEPOINTS
>  	bool
>  
> +# Note:  arch/$(SRCARCH)/Kconfig needs to be before arch/Kconfig
> +# so that each $ARCH can specify its values for CONFIG_PGTABLE_LEVELS
> +# before the default value is found in arch/Kconfig.
> +
> +source "arch/$(SRCARCH)/Kconfig"
> +
>  source "arch/Kconfig"
>  
>  endmenu		# General setup
> 

except that the endmenu should be moved up a few lines so that the
Processor type and features menu is not part of the General setup menu.

v2 patch is below.

---
From: Randy Dunlap <rdunlap@infradead.org>

Present "General setup" before "Processor type and features".
This is done by sourcing arch/$(SRCARCH)/Kconfig before arch/Kconfig
inside init/Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: move General setup's endmenu before the $ARCH Kconfigs.

 Kconfig      |    2 --
 init/Kconfig |   10 ++++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

--- linux-next-20180702.orig/Kconfig
+++ linux-next-20180702/Kconfig
@@ -9,8 +9,6 @@ comment "Compiler: $(CC_VERSION_TEXT)"
 
 source "scripts/Kconfig.include"
 
-source "arch/$(SRCARCH)/Kconfig"
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
--- linux-next-20180702.orig/init/Kconfig
+++ linux-next-20180702/init/Kconfig
@@ -1717,10 +1717,16 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
-source "arch/Kconfig"
-
 endmenu		# General setup
 
+# Note:  arch/$(SRCARCH)/Kconfig needs to be before arch/Kconfig
+# so that each $ARCH can specify its values for CONFIG_PGTABLE_LEVELS
+# before the default value is found in arch/Kconfig.
+
+source "arch/$(SRCARCH)/Kconfig"
+
+source "arch/Kconfig"
+
 config RT_MUTEXES
 	bool
 


