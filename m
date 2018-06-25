Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79094C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F042560F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F042560F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeFYIlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:41:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754563AbeFYIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:40:58 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXN1x-0004hD-Uw; Mon, 25 Jun 2018 10:39:26 +0200
Date:   Mon, 25 Jun 2018 10:39:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
In-Reply-To: <20180625081429.GS2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-2-pasha.tatashin@oracle.com> <20180625081429.GS2494@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Peter Zijlstra wrote:
> On Thu, Jun 21, 2018 at 05:25:08PM -0400, Pavel Tatashin wrote:
> > -void *text_poke(void *addr, const void *opcode, size_t len)
> > +void __ref *text_poke(void *addr, const void *opcode, size_t len)
> >  {
> >  	unsigned long flags;
> >  	char *vaddr;
> >  	struct page *pages[2];
> >  	int i;
> >  
> > +	/* While boot memory allocator is runnig we cannot use struct
> 
> Broken comment style..
> 
> > +	 * pages as they are not yet initialized. However, we also know
> > +	 * that this is early in boot, and it is safe to fallback to
> > +	 * text_poke_early.
> > +	 */
> > +	if (unlikely(!after_bootmem))
> > +		return text_poke_early(addr, opcode, len);
> 
> I'm not entirely sure this is right.. Because not only do we need the
> whole fixmap stuff working, we also need #DB and the IPI handlers set-up
> and working.

IPI? That's early UP boot why would you need an IPI?

Thanks,

	tglx
