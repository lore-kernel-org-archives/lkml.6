Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09478C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1156222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfBPOZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:25:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:44288 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfBPOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:25:45 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1GEMUfJ030078;
        Sat, 16 Feb 2019 08:22:30 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x1GEMCDe030050;
        Sat, 16 Feb 2019 08:22:12 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 16 Feb 2019 08:22:12 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        jack@suse.cz, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
Message-ID: <20190216142206.GE14180@gate.crashing.org>
References: <20190214062339.7139-1-mpe@ellerman.id.au> <20190216105511.GA31125@350D>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216105511.GA31125@350D>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
> On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
> > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
> > rather than just checking that the value is non-zero, e.g.:
> > 
> >   static inline int pgd_present(pgd_t pgd)
> >   {
> >  -       return !pgd_none(pgd);
> >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> >   }
> > 
> > Unfortunately this is broken on big endian, as the result of the
> > bitwise && is truncated to int, which is always zero because

(Bitwise "&" of course).

> Not sure why that should happen, why is the result an int? What
> causes the casting of pgd_t & be64 to be truncated to an int.

Yes, it's not obvious as written...  It's simply that the return type of
pgd_present is int.  So it is truncated _after_ the bitwise and.


Segher
