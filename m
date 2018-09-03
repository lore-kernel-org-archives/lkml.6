Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF85C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF3520856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF3520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeICNMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:12:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54585 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeICNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:12:41 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwkbv-0004PK-7z; Mon, 03 Sep 2018 10:53:27 +0200
Date:   Mon, 3 Sep 2018 10:53:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricardo.neri@intel.com, matt@codeblueprint.co.uk,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V2 5/6] x86/mm: If in_atomic(), allocate pages without
 sleeping
In-Reply-To: <20180903083459.GT24124@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809031048430.1349@nanos.tec.linutronix.de>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com> <1535881594-25469-6-git-send-email-sai.praneeth.prakhya@intel.com> <20180903083459.GT24124@hirez.programming.kicks-ass.net>
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

On Mon, 3 Sep 2018, Peter Zijlstra wrote:

Thanks for CC'ing me. I wonder why the world and some more is on CC, but
x86@kernel.org is NOT.

> On Sun, Sep 02, 2018 at 02:46:33AM -0700, Sai Praneeth Prakhya wrote:

> > @@ -926,7 +926,13 @@ static void unmap_pud_range(p4d_t *p4d, unsigned long start, unsigned long end)
> >  
> >  static int alloc_pte_page(pmd_t *pmd)
> >  {
> > -	pte_t *pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> > +	pte_t *pte;
> > +
> > +	if (in_atomic())
> > +		pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
> > +	else
> > +		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> > +
> >  	if (!pte)
> >  		return -1;
> >  
> 
> This looks like tinkering to me..

Yes it is and it's not going to happen.

Thanks,

	tglx
