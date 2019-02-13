Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B31222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbfBMNTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:19:12 -0500
Received: from foss.arm.com ([217.140.101.70]:53430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbfBMNTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:19:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A24F680D;
        Wed, 13 Feb 2019 05:19:11 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEE393F557;
        Wed, 13 Feb 2019 05:19:09 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:19:06 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     'Mark Rutland' <mark.rutland@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'James Morse' <james.morse@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Message-ID: <20190213131906.GB5875@brain-police>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
 <20190201105144.GA27140@fuggles.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A30C3CB@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A30C3CB@G01JPEXMBKW03>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:32:07PM +0000, Zhang, Lei wrote:
> > -----Original Message-----
> > From: linux-arm-kernel
> > [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> > Will Deacon
> > Sent: Friday, February 01, 2019 7:52 PM
> > To: Zhang, Lei 
> > Cc: 'Mark Rutland'; 'Catalin Marinas'; 'James Morse';
> > 'linux-kernel@vger.kernel.org';
> > 'linux-arm-kernel@lists.infradead.org'
> > Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX
> > erratum 010001
> 
> > So I guess we should boot with NFD1 clear, and then set it only when we
> > realise we're not on an A64FX?
> 
> In my patch, I do similar things at __cpu_setup which we 
> set NFD1=1 on all processors except A64FX.
> 
> Do you mean we would better to change the place where we 
> set/clear NFD1?

Yes, I think we should keep the code as simple as we can:

  - Don't set NFDx=1 in proc.S for any CPU
  - Later, in C code, we can set the bit for any CPU that is not an affected
    A64FX (this can be a simple MIDR check).

Does that work?

Will
