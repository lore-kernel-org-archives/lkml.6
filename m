Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E6E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E6E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeKIXds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:33:48 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:59531 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKIXds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:33:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 2EBFD185B0;
        Fri,  9 Nov 2018 14:53:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id S1q5t2goXaH4; Fri,  9 Nov 2018 14:53:01 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 59D001818A;
        Fri,  9 Nov 2018 14:53:01 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A7331E07D;
        Fri,  9 Nov 2018 14:53:01 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E5881E07C;
        Fri,  9 Nov 2018 14:53:01 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri,  9 Nov 2018 14:53:01 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 211E92EA5;
        Fri,  9 Nov 2018 14:53:01 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 1CCA580C23; Fri,  9 Nov 2018 14:53:01 +0100 (CET)
Date:   Fri, 9 Nov 2018 14:53:01 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181109135300.3tyord6amvd7wy54@axis.com>
References: <20181031084253.9650-1-vincent.whitchurch@axis.com>
 <20181031155341.GA27878@linux-8ccs>
 <20181101152913.r2isskngiahi6o2u@axis.com>
 <20181102135322.GA5289@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102135322.GA5289@linux-8ccs>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 02:53:22PM +0100, Jessica Yu wrote:
> +++ Vincent Whitchurch [01/11/18 16:29 +0100]:
> > On Wed, Oct 31, 2018 at 04:53:41PM +0100, Jessica Yu wrote:
> > > Could this be done in modpost? I'm guessing the answer is no as some
> > > relocations may rely on that bit being set in st_value, right?
> > > Therefore we can only clear the bit _after_ relocations to the module
> > > are applied at runtime, correct?
> > 
> > Yes, that's correct, it needs to be done after the relocations.
> > 
> > > I'm not against having an arch-specific kallsyms fixup function, my
> > > only concern would be if this would interfere with the delayed
> > > relocations livepatching does, if there are plans in the future to
> > > have livepatching on arm (IIRC there was an attempt at a port in
> > > 2016). If there exists some Thumb-2 relocation types that rely on that
> > > lowest bit in st_value being set in order to be applied, and we clear
> > > it permanently from the symtab, then livepatching wouldn't be able to
> > > apply those types of relocations anymore. If this is a legitimate
> > > concern, then perhaps an alternative solution would be to have an
> > > arch-specific kallsyms symbol-value-fixup function for accesses to
> > > sym.st_value, without modifying the module symtab.
> > 
> > I'm not familiar with livepatching, but yes, if it needs to do
> > relocations later I guess we should preserve the original value.
> 
> Yeah, I think the symtab needs to remain unmodified for livepatch to
> be able to do delayed relocations after module load.
> 
> > I gave the alternative solution a go and it seems to work.
> > add_kallsyms() currently overwrites st_info so I had to move the
> > elf_type to the unused st_other field instead to preserve st_info:
> 
> I think that's fine, I think the only usages of st_other I've found
> are during relocations, and the field is big enough for a char, so it
> should be fine to reuse it afterwards.

If livepatch can do relocations later, doesn't that mean that we _can't_
reuse st_other for storing the elf_type?  OTOH, the current code
overwrites st_info, and I see that used from various archs' relocation
functions too, so perhaps I'm missing something.
