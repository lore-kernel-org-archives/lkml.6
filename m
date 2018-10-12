Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245FFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84DD20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84DD20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeJLQ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:27:31 -0400
Received: from foss.arm.com ([217.140.101.70]:48060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeJLQ1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:27:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D46F6F;
        Fri, 12 Oct 2018 01:56:05 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A42C13F5D3;
        Fri, 12 Oct 2018 01:56:05 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 07B251AE2DA4; Fri, 12 Oct 2018 09:56:05 +0100 (BST)
Date:   Fri, 12 Oct 2018 09:56:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/17] arm64: add pointer authentication register bits
Message-ID: <20181012085605.GB11847@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-2-kristina.martsenko@arm.com>
 <20181011162814.GC17000@arm.com>
 <20181012085352.xi6rkcpm62iqd6ru@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012085352.xi6rkcpm62iqd6ru@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:53:54AM +0100, Mark Rutland wrote:
> On Thu, Oct 11, 2018 at 05:28:14PM +0100, Will Deacon wrote:
> > On Fri, Oct 05, 2018 at 09:47:38AM +0100, Kristina Martsenko wrote:
> 
> > > +#define ESR_ELx_EC_PAC		(0x09)
> > 
> > Really minor nit: but shouldn't this be ESR_EL2_EC_PAC, since this trap
> > can't occur at EL1 afaict?
> 
> It can also be taken to EL3 dependent on SCR_EL3.API.
> 
> We use ESR_ELx_EC_<foo> for other exceptions that can't be taken to EL1
> (e.g. ESR_ELx_EC_SMC{32,64}), so I think it would be more consistent to
> leave this as ESR_ELx_EC_PAC rather than ESR_EL2_EC_PAC.

Fair enough, but if we grow a different EC for ESR_EL1 that uses encoding
0x09, this all falls apart. At the very list, maybe we should comment those
that are EL2 or higher with /* EL2 and above */ or just fix the misnomer and
drop the useless _ELx_ part of the names completely.

Will
