Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A5C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F3F206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RTS6mqsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F3F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJEHOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:14:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeJEHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J1XtDIL3kBelGBNUkkDCrZazDGKBjJVyr73m5/HV1tQ=; b=RTS6mqsN4ys9mvLAflgaTs/QV
        lJYTxvfRtD2gC/G/vOzcqwVFUV9GeoM8Tw4NUbXkYLBMQQg6CH/SPeW5w38CiRQHqzeHNDdCSRCI1
        p0vMuj73Z8ydGkd1X1z/xjsEebSPM+0qI1g+oi165TntIG1BzOETT+cxIm+7w/AUxiAI0G9Wb1IC5
        kO4Jo+XSf7NkCpwLYkkLdwwUh0XbUJUlRs3906R5VGlWWqHr/IxVt1+zTbdPcgmwhUjrCrj+2J1qL
        WKPYDkhqmShimKED1eLho4Z5qxW/qCEe/fYjUNypXWxCsLlVujllYSQxcYgocvXUbMeHM6n0ScKvX
        awcL/ObNA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8Doo-0004Rs-RL; Fri, 05 Oct 2018 00:18:10 +0000
Subject: Re: [ANN] init-kconfig - easy way to embrace Linux's kconfig
To:     Luis Chamberlain <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Petr Vorel <pvorel@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Felix Fietkau <nbd@nbd.name>, kconfig-sat@googlegroups.com,
        Ulf Magnusson <ulfalizer@gmail.com>
References: <20181004200249.GL5238@garbanzo.do-not-panic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8487f1e3-248f-8736-90fb-5bbd87b35a44@infradead.org>
Date:   Thu, 4 Oct 2018 17:18:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181004200249.GL5238@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/18 1:02 PM, Luis Chamberlain wrote:
> Every now and then a project is born, and they decide to use Linux's
> kconfig to enable configuration of their project. As it stands we *know*
> kconfig is now used in at least over 12 different projects [0]. I myself
> added kconfig to one as well years ago. Even research reveals that
> kconfig has become one of the leading industrial variability modeling
> languages [1] [2].
> 
> What is often difficult to do though is to start off using kconfig and
> integrating it into a project. Or updating / syncing to the latest
> kconfig from upstream Linux.
> 
> I had yet another need to use kconfig for another small project so
> decided to make a clean template others can use and help keep it in sync.
> This is a passive fork which aims to keep in sync with the Linux
> kernel's latest kconfig to make it easier to keep up to date and to
> enable new projects to use and embrace kconfig on their own.  The goal
> is *not* to fork kconfig and evolve it separately, but rather keep in
> sync with the evolution of kconfig on Linux to make it easier for
> projects to use kconfig and also update their own kconfig when needed.
> 
> This may also be useful if folks want to test R&D code on a smaller
> compartamentalized codebase.
> 
> If you find this useful and you'd like to help keep it in sync, send
> patches my way as the kernel's kconfig evolves. The code is up on
> gitlab [3].
> 
> Do we want to document this option on Linux in case folks want to try
> and embrace kconfig on their own for other projects?
>   
> [0] http://www.eng.uwaterloo.ca/~shshe/kconfig_semantics.pdf
> [1] http://gsd.uwaterloo.ca/sites/default/files/vm-2013-berger.pdf
> [2] http://gsd.uwaterloo.ca/sites/default/files/ase241-berger_0.pdf
> [3] https://gitlab.com/mcgrof/init-kconfig
> 
>   Luis
> 

Hi Luis,

Any crossover with Ulf's recent announcement?

https://lore.kernel.org/lkml/CAFkk2KQ-sC=bAd9fCkOVPNmZn8m+EZfpZtirE+J5VpvW120sxQ@mail.gmail.com/


thanx,
-- 
~Randy
