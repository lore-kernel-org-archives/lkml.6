Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFA6C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 01:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4908F215E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 01:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1LA7Bny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4908F215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbeHSEqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 00:46:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeHSEqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 00:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zs6HyhtowJQsKLuztdZKvugDV9VjghuA1Z+W4YacEr4=; b=B1LA7BnyESEHWgsuNUf31kWKI
        a4Z2AjtH+DXv0HtS5CawhXywrq/yuyKpK4iht6VS+6MDoCQZuRR3gz38Al9r+kqQcPWDLXhwlVubA
        hTKQDzLAoj+l4WL2OGIFqNPbj7FR7gcFvXmMKS0jqQ0cGANcl3tVJfdk3xWje7Z9NpT0VG3YmhWG5
        X2TPyZvlKIdnL/6PGQ/+yNq8ow9SXLRpAFn9foBbJpT1ZydUgDtICEXbMc0uB9FqGcaMl4DvYiApz
        QA8HSq2dOkawYYT9elN/7i71dM+/h5hOYVpPcx8Ep3Wn/qPv9Lbt7x6OH7jLIoPSR5wy2TqhDcJlP
        pOnuCRt8w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frCdj-0000jc-Ox; Sun, 19 Aug 2018 01:36:24 +0000
Subject: Re: problem in building 4.8.0: references to non-existent util CLANG
To:     Linda Walsh <lkml@tlinx.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <5B78BE6E.3080107@tlinx.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <631cc19b-f8c0-7e07-a60f-fcd52e8a8564@infradead.org>
Date:   Sat, 18 Aug 2018 18:36:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B78BE6E.3080107@tlinx.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/2018 05:48 PM, Linda Walsh wrote:
> Is CLANG required for building now?
> 
> when I did a "make xconfig" (or any make, for that matter), I get:
> 
>>  make xconfig
> scripts/kconfig/qconf  Kconfig
> invocation line: ./scripts/clang-version.sh gcc     ## debug line I added
> ./scripts/clang-version.sh: line 15: ./COPYING: Permission denied
> ./scripts/clang-version.sh: line 23: printf: __clang_major__: invalid number
> ./scripts/clang-version.sh: line 23: printf: __clang_minor__: invalid number
> ./scripts/clang-version.sh: line 23: printf: __clang_patchlevel__: invalid number
> init/Kconfig:24:warning: 'CLANG_VERSION': number is invalid
> .config:50:warning: symbol value '00000' invalid for CLANG_VERSION
> 
> The reference to COPYING comes from me running make in the
> top dir, where there is a text file named COPYING, however it is
> not executable.
> 
> I put in an echo to see what command line the script was being passed,
> "gcc"?
> 
> I'm guessing but I don't think the clang script should be getting
> called at all.  I installed the sources by patching 4.17.0 (done via a
> script).
> 
> Are there instructions somewhere for what command(s) to run for patching?
> It seems to have changed from using the standard patch program to using
> a git version that isn't compatible w/the gnu version.  I adapted the
> script to the git version and that's seemed to work since I did
> the change.  But with 4.18.0, I am uncertain if it is working correctly.
> 
> If the above was the only problem, I'd be less concerned, but
> scripts run after the main build to build external modules failed.
> It seems unlikely the two problems are related, but I wanted to fix
> this first before going on to the compile-fails.
> 
> Please Cc me, as I'm not currently on the list.
> 
> Thanks,
> Linda W.
> 

Looks like this patch should fix it:
https://marc.info/?l=linux-kbuild&m=153447099313149&w=2



-- 
~Randy
