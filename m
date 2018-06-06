Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0OkCNdNaGFvtGgAAmS7hNA
	; Wed, 06 Jun 2018 22:06:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2A2A860861; Wed,  6 Jun 2018 22:06:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 54101607E4;
	Wed,  6 Jun 2018 22:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54101607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeFFWGK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:06:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39563 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbeFFWGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:06:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D0773ABEF;
        Wed,  6 Jun 2018 22:06:06 +0000 (UTC)
Date: Thu, 7 Jun 2018 00:06:05 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [RFC PATCH v4 7/8] ima: based on policy prevent loading firmware
 (pre-allocated buffer)
Message-ID: <20180606220605.GJ4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-8-git-send-email-zohar@linux.vnet.ibm.com>
 <20180601191545.GP4511@wotan.suse.de>
 <20180601192545.GR4511@wotan.suse.de>
 <CAGXu5jKkg_=iHGgrED4qB4TCFJaWgLkLp61RHgJ6UEhAj89GwQ@mail.gmail.com>
 <CAKv+Gu9=8s2b-W6a4hHwxhJfFPGuBm5kwsxE_hx98fDUfMUkvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9=8s2b-W6a4hHwxhJfFPGuBm5kwsxE_hx98fDUfMUkvQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 08:20:17AM +0200, Ard Biesheuvel wrote:
> On 6 June 2018 at 00:37, Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Jun 1, 2018 at 12:25 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >> On Fri, Jun 01, 2018 at 09:15:45PM +0200, Luis R. Rodriguez wrote:
> >>> On Tue, May 29, 2018 at 02:01:59PM -0400, Mimi Zohar wrote:
> >>> > Some systems are memory constrained but they need to load very large
> >>> > firmwares.  The firmware subsystem allows drivers to request this
> >>> > firmware be loaded from the filesystem, but this requires that the
> >>> > entire firmware be loaded into kernel memory first before it's provided
> >>> > to the driver.  This can lead to a situation where we map the firmware
> >>> > twice, once to load the firmware into kernel memory and once to copy the
> >>> > firmware into the final resting place.
> >>> >
> >>> > To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
> >>> > into a pre-allocated buffer") introduced request_firmware_into_buf() API
> >>> > that allows drivers to request firmware be loaded directly into a
> >>> > pre-allocated buffer.  The QCOM_MDT_LOADER calls dma_alloc_coherent() to
> >>> > allocate this buffer.  According to Documentation/DMA-API.txt,
> >>> >
> >>> >      Consistent memory is memory for which a write by either the
> >>> >      device or the processor can immediately be read by the processor
> >>> >      or device without having to worry about caching effects.  (You
> >>> >      may however need to make sure to flush the processor's write
> >>> >      buffers before telling devices to read that memory.)
> >>> >
> >>> > Devices using pre-allocated DMA memory run the risk of the firmware
> >>> > being accessible by the device prior to the kernel's firmware signature
> >>> > verification has completed.
> >>>
> >>> Indeed. And since its DMA memory we have *no idea* what can happen in
> >>> terms of consumption of this firmware from hardware, when it would start
> >>> consuming it in particular.
> >>>
> >>> If the device has its own hardware firmware verification mechanism this is
> >>> completely obscure to us, but it may however suffice certain security policies.
> >>>
> >>> The problem here lies in the conflicting security policies of the kernel wanting
> >>> to not give away firmware until its complete and the current inability to enable
> >>> us to have platforms suggest they trust hardware won't do something stupid.
> >>> This becomes an issue since the semantics of the firmware API preallocated
> >>> buffer do not require currently allow the kernel to inform LSMs of the fact
> >>> that a buffer is DMA memory or not, and a way for certain platforms then
> >>> to say that such use is fine for specific devices.
> >>>
> >>> Given a pointer can we determine if a piece of memory is DMA or not?
> >>
> >> FWIW
> >>
> >> Vlastimil suggests page_zone() or virt_to_page() may be able to.
> >
> > I don't see a PAGEFLAG for DMA, but I do see ZONE_DMA for
> > page_zone()... So maybe something like
> >
> > struct page *page;
> >
> > page = virt_to_page(address);
> > if (!page)
> >    fail closed...
> > if (page_zone(page) == ZONE_DMA)
> >     handle dma case...
> > else
> >     non-dma
> >
> > But I've CCed Laura and Rik, who I always lean on when I have these
> > kinds of page questions...
> >
> 
> That is not going to help. In general, DMA can access any memory in
> the system (unless a IOMMU is actively preventing that).
> 
> The streaming DMA API allows you to map()/unmap() arbitrary pieces of
> memory for DMA, regardless of how they were allocated. (Some drivers
> were even doing DMA from the stack at some point, but this broke
> vmapped stacks so most of these cases have been fixed) Uploading
> firmware to a device does not require a coherent (as opposed to
> streaming) mapping for DMA, and so it is perfectly reasonable for a
> driver to use the streaming API to map the firmware image (wherever it
> is in memory) and map it.

This is useful thanks!

But let's keep in mind that this isn't about whether or not this should be
done. This is about informing security layers to make a choice to decide
whether or not what a solution is doing is banana crazy or not.

> However, the DMA API does impose some ordering. Mapping memory for DMA
> gives you a DMA address (which may be different from the physical
> address [depending on the platform]), and this DMA address is what
> gets programmed into the device, not the virtual or physical address.
> That means you can be reasonably confident that the device will not be
> able to consume what is in this memory before it has been mapped for
> DMA.

Again, not for coherent DMA. By *definition* the device *and* processor has
immediate access to data written *immediately* when dma_alloc_coherent() is
used. And that is what was used on the qcom drivers last we checked. The call
sequence is:

qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent()

> Also, the DMA api explicitly forbids touching memory mapped for
> streaming DMA: the device owns it at this point, and so the CPU should
> refrain from accessing it.

Wonderful. I note you said *should*. And again, its up to LSMs to decide
if that is not good enough.

> So the question is, why is QCOM_MDT_LOADER using a coherent DMA
> mapping?

Right and the qcom driver makes it very difficult to decipher and verify.
*And* when folks were poked about this during patch review it was clearly
stated that the READING ID should annotate DMA if it was DMA so LSMs
could be informed.

> That does not make any sense purely for moving firmware into
> the device, and it is indeed a security hazard if we are trying to
> perform a signature check before the device is cleared for reading it.

:)

> Note that qcom_scm_pas_init_image() is documented as
> 
>         /*
>          * During the scm call memory protection will be enabled for the meta
>          * data blob, so make sure it's physically contiguous, 4K aligned and
>          * non-cachable to avoid XPU violations.
>          */
> 
> and dma_alloc_coherent() happens to give them that. Whether the DMA
> mapping is actually used is a different matter: the code is a bit
> complex, but it calls into the secure world to set up the region.

Again, it doesn't matter whether they think its OK, that's fine, it is just
up to the LSMs to then decide on their own if this is pure crap.

> If this is the only counterexample,

The problem is this is the *only* user of request_firmware_into_buf()!

> I wouldn't worry about it too much
> (QCOM have elaborate SoC management layers in the secure world), and
> simply mandate that only streaming DMA be used for firmware loading,
> and that the firmware signature verification is performed before the
> memory is mapped for DMA.

Again, it doesn't matter what they *think*. LSMs want the ability to
decide as well and its fair for them to want to differentiate coherent
DMA and say this is not reasonably trustworthy.

  Luis

-- 
Do not panic
