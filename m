Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0C4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037452089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037452089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJCPd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:33:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbeJCPd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:33:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12BD030001E2;
        Wed,  3 Oct 2018 08:46:02 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D520662F2;
        Wed,  3 Oct 2018 08:46:01 +0000 (UTC)
Date:   Wed, 3 Oct 2018 16:45:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, thgarnie@google.com,
        corbet@lwn.net
Subject: Re: [PATCH v2 2/3] x86/mm/doc: Clean up the memory region layout
 descriptions
Message-ID: <20181003084557.GB5140@MiWiFi-R3L-srv>
References: <20180926235823.3567-1-bhe@redhat.com>
 <20180926235823.3567-3-bhe@redhat.com>
 <20181002091412.GE116695@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002091412.GE116695@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 03 Oct 2018 08:46:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/18 at 11:14am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> > -ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
> > -ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
> > +fffffe0000000000 - fffffe7fffffffff (=39 bits, 512 GB) cpu_entry_area mapping
> > +fffffe8000000000 - fffffeffffffffff (=39 bits, 512 GB) LDT remap for PTI
> > +ffffff0000000000 - ffffff7fffffffff (=39 bits, 512 GB) %esp fixup stacks
> > +ffffff8000000000 - fffffffeefffffff (~39 bits, ~507 GB) unused hole
> > +ffffffef00000000 - fffffffeffffffff (=36 bits, 64 GB) EFI region mapping space
> > +ffffffff00000000 - ffffffff7fffffff (=31 bits, 2 GB) unused hole
> > +ffffffff80000000 - ffffffff9fffffff (=29 bits, 512 MB)  kernel text mapping, from phys 0
> > +ffffffffa0000000 - fffffffffeffffff (~31 bits, 1520 MB) module mapping space
> >  [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
> >  ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
> >  ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
> 
> Looks mostly good now, but could you please make the right side align vertically as well, like 
> I did in the examples I provided previously?
> 
> There's zero reason for it to look this disorganized:
> 
> > +ffffff8000000000 - fffffffeefffffff (~39 bits, ~507 GB) unused hole
> > +ffffffef00000000 - fffffffeffffffff (=36 bits, 64 GB) EFI region mapping space
> > +ffffffff00000000 - ffffffff7fffffff (=31 bits, 2 GB) unused hole
> > +ffffffff80000000 - ffffffff9fffffff (=29 bits, 512 MB)  kernel text mapping, from phys 0
> 
> I.e. can we do something like:
> 
> > +ffffff8000000000 - fffffffeefffffff (~39 bits, ~507 GB) unused hole
> > +ffffffef00000000 - fffffffeffffffff (=36 bits,   64 GB) EFI region mapping space
> > +ffffffff00000000 - ffffffff7fffffff (=31 bits,    2 GB) unused hole
> > +ffffffff80000000 - ffffffff9fffffff (=29 bits,  512 MB) kernel text mapping, from phys 0

Sure, will change according to your suggestion. Thanks a lot!

> 
> ?
> 
> That not only makes it more readable, but makes typos like the whitespace noise double space in 
> the last line more obvious.
> 
> Thanks,
> 
> 	Ingo
