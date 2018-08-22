Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7951EC04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328912098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eLhkV6tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328912098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeHWDA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:00:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeHWDA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=54RKpTM/o2H3Dw0PmdZEWwFlQyynkdHa9plc9Y07t9s=; b=eLhkV6tAbSMg1qCeYNvBIU+0O
        tMmtXGFgMNKWWO86TLMzb3/bUSx2P7WDqWbYqrHHt3GVA7Svpm3itr23KvidnOL0N3SvGLV1X8xFK
        R3uk8YfaePhgQQAvN+fq/Fku4DjFvtLX3R6C4hRslRpsqpyttYEvb7J01ZkBVPiKnRBEybm+qT0Bd
        KSXQXp6HOMWufkpZGlpJgLfmapU41hIi12dvktRNXrX8ShrZIUKurrF1gM9c1j038aHP1Z0+Un49I
        V8oyA0jNOh4vixZBRgQJ+pRR5854Mk6/rhoNi7fi6GIJmv3ci0QuEZQNoY/RAy/R5yLOIYkvOIDvb
        PSyZAdQCA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fscd2-0000eG-O6; Wed, 22 Aug 2018 23:33:33 +0000
Subject: Re: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is
 installed" introduced in v4.18.4.
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
Date:   Wed, 22 Aug 2018 16:33:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/2018 11:53 AM, H. Nikolaus Schaller wrote:
> This patch requires that /sbin/depmod is installed and installable on
> the build host.
> 
> But not all build hosts for cross compiling Linux are Linux systems
> and are able to provide a working port of depmod, especially at the
> file patch /sbin/depmod.
> 
> I use, for example, a Darwin system to cross compile Linux and I run
> depmod -a on the embedded system once, after installing a new Linux
> kernel there.
> 
> I have no problem with seeing a warning, but aborting the build process
> is IMHO a bad idea since the previous behaviour didn't harm many people
> as far as I see. Probably 99% of people compiling Linux kernels do that
> on Linux and 99% of those have depmod installed for optimal operation of
> their build host. So IMHO printing the warning is good enough.

Thanks for the report and sorry about the problem.

I'm OK with changing the error to a warning.
Does the patch below work for you?

thanks.
---
From: Randy Dunlap <rdunlap@infradead.org>

When $DEPMOD is not found, only print a warning instead of exiting
with an error message and error status.

E.g.:
Warning: 'make modules_install' requires /sbin/depmod. Please install it.
This is probably in the kmod package.
../scripts/depmod.sh: line 44: /sbin/depmod: No such file or directory
make[1]: *** [/home/rdunlap/lnx/lnx-418/Makefile:1244: _modinst_post] Error 127
make: *** [Makefile:146: sub-make] Error 2

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 scripts/depmod.sh |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- lnx-418.orig/scripts/depmod.sh
+++ lnx-418/scripts/depmod.sh
@@ -15,9 +15,8 @@ if ! test -r System.map ; then
 fi
 
 if [ -z $(command -v $DEPMOD) ]; then
-	echo "'make modules_install' requires $DEPMOD. Please install it." >&2
+	echo "Warning: 'make modules_install' requires $DEPMOD. Please install it." >&2
 	echo "This is probably in the kmod package." >&2
-	exit 1
 fi
 
 # older versions of depmod require the version string to start with three


