Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB6C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4AA205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4AA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeKASQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:16:00 -0400
Received: from foss.arm.com ([217.140.101.70]:53502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeKASQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:16:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB81C341;
        Thu,  1 Nov 2018 02:13:51 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 662423F557;
        Thu,  1 Nov 2018 02:13:50 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:13:43 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: arm64 tools build failure wrt smp_load_{acquire,release}
 expansion on gcc version 5.4.0 20160609 (Ubuntu/Linaro
 5.4.0-6ubuntu1~16.04.9)
Message-ID: <20181101091343.GA1565@brain-police>
References: <20181031154550.GA28340@kernel.org>
 <20181031174408.GA27871@arm.com>
 <50dc7bfe-47de-6837-30e0-4d31dabacd31@iogearbox.net>
 <20181031211456.GE28340@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031211456.GE28340@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[apologies if you get this twice -- my GPU hung (!) whilst sending my
 previous response]

On Wed, Oct 31, 2018 at 06:14:56PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 31, 2018 at 07:08:29PM +0100, Daniel Borkmann escreveu:
> > On 10/31/2018 06:44 PM, Will Deacon wrote:
> > > Diff below...
>  
> > I just gave this a spin on 16.04 and it resolves the build issue, thanks
> > for the quick fix, Will!
>  
> > Tested-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> It buildz, ship it:
> 
> # time dm android-ndk:r12b-arm \
> 	  android-ndk:r15c-arm \
> 	  debian:experimental-x-arm64 \
> 	  ubuntu:14.04.4-x-linaro-arm64 \
> 	  ubuntu:16.04-x-arm \
> 	  ubuntu:16.04-x-arm64 \
> 	  ubuntu:18.04-x-arm \
> 	  ubuntu:18.04-x-arm64
>    1 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>    2 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>    3 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-7) 8.2.0
>    4 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
>    5 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    6 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    7 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
>    8 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
> #
> 
> So I've added it to my tree as below, can I keep it like that?

Yup, thanks for turning it into a proper patch. Just to be explicit, here's
my s-o-b:

Signed-off-by: Will Deacon <will.deacon@arm.com>

Will
