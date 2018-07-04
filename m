Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E6FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6791823CE4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6791823CE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeGDQIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:08:31 -0400
Received: from foss.arm.com ([217.140.101.70]:40036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbeGDQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:08:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD247A9;
        Wed,  4 Jul 2018 09:08:30 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F32F43F5AD;
        Wed,  4 Jul 2018 09:08:29 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id ECEA31AE180C; Wed,  4 Jul 2018 17:09:09 +0100 (BST)
Date:   Wed, 4 Jul 2018 17:09:09 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com,
        christoffer.dall@arm.com, drjones@redhat.com, marc.zyngier@arm.com,
        ramana.radhakrishnan@arm.com, awallis@codeaurora.org
Subject: Re: [PATCHv4 05/10] arm64/cpufeature: detect pointer authentication
Message-ID: <20180704160909.GR4828@arm.com>
References: <20180503132031.25705-1-mark.rutland@arm.com>
 <20180503132031.25705-6-mark.rutland@arm.com>
 <4c057e99-61a9-7f75-664d-1f16f2631766@arm.com>
 <20180525100137.mte5z2sonob3vffq@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525100137.mte5z2sonob3vffq@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 11:01:37AM +0100, Mark Rutland wrote:
> On Wed, May 23, 2018 at 09:48:28AM +0100, Suzuki K Poulose wrote:
> > On 03/05/18 14:20, Mark Rutland wrote:
> > > diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> > > index bc51b72fafd4..9dcb4d1b14f5 100644
> > > --- a/arch/arm64/include/asm/cpucaps.h
> > > +++ b/arch/arm64/include/asm/cpucaps.h
> > > @@ -48,7 +48,10 @@
> > >   #define ARM64_HAS_CACHE_IDC			27
> > >   #define ARM64_HAS_CACHE_DIC			28
> > >   #define ARM64_HW_DBM				29
> > > +#define ARM64_HAS_ADDRESS_AUTH_ARCH		30
> > > +#define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		31
> > 
> > Where are these caps used ? I couldn't find anything in the series
> > that uses them. Otherwise looks good to me.
> 
> Those were consumed by KVM support, which needed to detect if CPUs had
> mismatched support. Currently they're just placeholders as I need a
> cpucap value for the separate IMP-DEF / architected probing cases.
> 
> I *could* get rid of those and just have the ARM64_HAS_ADDRESS_AUTH case
> log "Address authentication", but I wanted to have separate messages for
> IMP-DEF vs architected.

Why? Surely it only matters if we find a mixture, and then you'll shout
loudly. I'd certainly be in favour of reducing the number of caps you're
adding here, particularly if they're just there for a line in dmesg.

Will
