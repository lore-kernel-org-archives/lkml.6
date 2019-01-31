Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86449C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF8220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfAaJ1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:27:09 -0500
Received: from foss.arm.com ([217.140.101.70]:40136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfAaJ1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:27:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 952BFA78;
        Thu, 31 Jan 2019 01:27:08 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05DE23F71E;
        Thu, 31 Jan 2019 01:27:07 -0800 (PST)
Date:   Thu, 31 Jan 2019 10:27:06 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
Message-ID: <20190131092706.GN13482@e113682-lin.lund.arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
 <8e8c4f5b-5b83-7bbc-1b84-36d68e210968@arm.com>
 <847c54ef-ea41-eea5-8aff-72e0cea465f8@arm.com>
 <20190131081900.GM13482@e113682-lin.lund.arm.com>
 <32af4a5c-7aeb-0171-1b4a-2cbee5f78bca@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32af4a5c-7aeb-0171-1b4a-2cbee5f78bca@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 08:56:04AM +0000, Julien Thierry wrote:
> 
> 
> On 31/01/2019 08:19, Christoffer Dall wrote:
> > On Mon, Jan 28, 2019 at 03:42:42PM +0000, Julien Thierry wrote:
> >> Hi James,
> >>
> >> On 28/01/2019 11:48, James Morse wrote:
> >>> Hi Julien,
> >>>
> >>> On 21/01/2019 15:33, Julien Thierry wrote:
> >>>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
> >>>> to interract with guest TLBs, switching from EL2&0 translation regime
> >>>
> >>> (interact)
> >>>
> >>>
> >>>> to EL1&0.
> >>>>
> >>>> However, some non-maskable asynchronous event could happen while TGE is
> >>>> cleared like SDEI. Because of this address translation operations
> >>>> relying on EL2&0 translation regime could fail (tlb invalidation,
> >>>> userspace access, ...).
> >>>>
> >>>> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
> >>>> clear it if necessary when returning to the interrupted context.
> >>>
> >>> Yes please. This would not have been fun to debug!
> >>>
> >>> Reviewed-by: James Morse <james.morse@arm.com>
> >>>
> >>>
> >>
> >> Thanks.
> >>
> >>>
> >>> I was looking for why we need core code to do this, instead of updating the
> >>> arch's call sites. Your 'irqdesc: Add domain handlers for NMIs' patch (pointed
> >>> to from the cover letter) is the reason: core-code calls nmi_enter()/nmi_exit()
> >>> itself.
> >>>
> >>
> >> Yes, that's the main reason.
> >>
> > I wondered the same thing, but I don't understand the explanation :(
> > 
> > Why can't we do a local_daif_mask() around the (very small) calls that
> > clear TGE instead?
> > 
> 
> That would protect against the pseudo-NMIs, but you can still get an
> SDEI at that point even with all daif bits set. Or did I misunderstand
> how SDEI works?
> 

I don't know the details of SDEI.  From looking at this patch, the
logical conclusion would be that SDEIs can then only be delivered once
we've called nmi_enter, but since we don't call this directly from the
code that clears TGE for doing guest TLB invalidation (or do we?) then
masking interrupts at the PSTATE level should be sufficient.

Surely I'm missing some part of the bigger picture here.

Thanks,

    Christoffer
