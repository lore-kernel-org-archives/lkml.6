Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94007C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684F1218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfAXR2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:28:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33102 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbfAXR2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:28:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F2751596;
        Thu, 24 Jan 2019 09:28:44 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994253F6A8;
        Thu, 24 Jan 2019 09:28:42 -0800 (PST)
Date:   Thu, 24 Jan 2019 17:28:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v14 02/12] powerpc/irq: use memblock functions returning
 virtual address
Message-ID: <20190124172839.GB11163@lakrids.cambridge.arm.com>
References: <cover.1548346225.git.christophe.leroy@c-s.fr>
 <1c8e658c094022a15e4b9f5ef5c191caab3c0dff.1548346225.git.christophe.leroy@c-s.fr>
 <20190124165153.GB5531@lakrids.cambridge.arm.com>
 <20190124172553.GE13790@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124172553.GE13790@rapoport-lnx>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 07:25:53PM +0200, Mike Rapoport wrote:
> On Thu, Jan 24, 2019 at 04:51:53PM +0000, Mark Rutland wrote:
> > On Thu, Jan 24, 2019 at 04:19:33PM +0000, Christophe Leroy wrote:
> > > Since only the virtual address of allocated blocks is used,
> > > lets use functions returning directly virtual address.
> > > 
> > > Those functions have the advantage of also zeroing the block.
> > > 
> > > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > > Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > 
> > [...]
> > 
> > > +static void *__init alloc_stack(void)
> > > +{
> > > +	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
> > > +
> > > +	if (!ptr)
> > > +		panic("cannot allocate stacks");
> > > +
> > > +	return ptr;
> > > +}
> > 
> > I believe memblock_alloc() will panic() if it cannot allocate memory,
> > since that goes:
> > 
> >  memblock_alloc()
> >  -> memblock_alloc_try_nid()
> >     -> panic()
> > 
> > So you can get rid of the panic() here, or if you want a custom panic
> > message, you can use memblock_alloc_nopanic().
> 
> As we've already discussed it in [1], I'm working on removing the
> _nopanic() versions and dropping the panic() calls from memblock_alloc()
> and friends.
> 
> I've posted v2 of the patches earlier this week [2].
>  
> > [...]
> 
> [1] https://lore.kernel.org/lkml/20190108143428.GB14063@rapoport-lnx/ 
> [2] https://lore.kernel.org/lkml/1548057848-15136-1-git-send-email-rppt@linux.ibm.com/

Fair enough.

Feel free to take the ack regardless, then!

Thanks,
Mark.
