Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03709C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8F22147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Nn22gchn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8F22147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJDPfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:35:30 -0400
Received: from 8bytes.org ([81.169.241.247]:33924 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeJDPfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:35:30 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B2E1E345; Thu,  4 Oct 2018 10:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1538642598; bh=Dzfuf26mksisVVIFmA4NBA/y4HXmc3fmhZ+czV6QpNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nn22gchnUhc8lyRznvtNoXj5vHJAQFJ6YZ2kUmA09ht8JFV/ySM83GgvPiXvZcM5b
         5OQ5g+rpSIY0snAeyRaaDTNtIPx7wmmUjLCg/003rEgINDoKkJOcUOooz0cb3dIdas
         s+6hRQzASnOl1654km8RRxQaZmAPs62jM2SeXUkAp/j0MnhGatu/5tq8JM9u5M3FBg
         ZRnVc2s6lo9yXcUKq7JOWAjjCIod0uJJ/N6jVYCFUBgW3iFasrdoRmRTnO+MzFRdHH
         toT9MPwSyp6Zafr7ZzqYZElfEoa0eVIhWFKAE9nxw3Ns6fWgH337YKq0qH0euWf59H
         ch/ZFmHOLOzbA==
Date:   Thu, 4 Oct 2018 10:43:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>, linux-mm@kvack.org,
        x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: x86/mm: Found insecure W+X mapping at address (ptrval)/0xc00a0000
Message-ID: <20181004084318.GB3630@8bytes.org>
References: <e75fa739-4bcc-dc30-2606-25d2539d2653@molgen.mpg.de>
 <alpine.DEB.2.21.1809191004580.1468@nanos.tec.linutronix.de>
 <0922cc1b-ed51-06e9-df81-57fd5aa8e7de@molgen.mpg.de>
 <alpine.DEB.2.21.1809210045220.1434@nanos.tec.linutronix.de>
 <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de>
 <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
 <20181003212255.GB28361@zn.tnic>
 <20181004080321.GA3630@8bytes.org>
 <20181004081429.GB1864@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004081429.GB1864@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:14:38AM +0200, Borislav Petkov wrote:
> So looking at this, BIOS_BEGIN and BIOS_END is the same range as the ISA
> range:
> 
> #define ISA_START_ADDRESS       0x000a0000
> #define ISA_END_ADDRESS         0x00100000
> 
> #define BIOS_BEGIN              0x000a0000
> #define BIOS_END                0x00100000
> 
> 
> and I did try marking the ISA range RO in mark_rodata_ro() but the
> machine wouldn't boot after. So I'm guessing BIOS needs to write there
> some crap.

Yeah, that's what I also found out back then, the region needs to be WX.
So we can either leave with the warning, as we know it is harmless and
where it comes from or implement an exception in the checking code for
that region.

Regards,

	Joerg
