Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A50C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11042089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11042089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeJFVpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 17:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeJFVpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 17:45:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 636073086262;
        Sat,  6 Oct 2018 14:41:58 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A5AA608F6;
        Sat,  6 Oct 2018 14:41:56 +0000 (UTC)
Date:   Sat, 6 Oct 2018 22:41:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/3] x86/mm/doc: Enhance the x86-64 virtual memory layout
 descriptions
Message-ID: <20181006144153.GE5140@MiWiFi-R3L-srv>
References: <20181006084327.27467-1-bhe@redhat.com>
 <20181006122259.GB418@gmail.com>
 <20181006123322.GA60572@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006123322.GA60572@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sat, 06 Oct 2018 14:41:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/18 at 02:33pm, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > +========================================================
> > +| Complete virtual memory map with 4-level page tables |
> > +========================================================
> 
> > +--------------------------------------------------------------------------------
> > +start addr       | offset     | end addr         |  size   | VM area description
> > +-----------------|------------|------------------|---------|--------------------
> 
> > +
> > +# Identical layout to the 56-bit one from here on:
> > +
> > +ffffff8000000000 | -512    GB | fffffffeefffffff | ~507 GB | ... unused hole
> > +ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
> 
> > +========================================================
> > +| Complete virtual memory map with 5-level page tables |
> > +========================================================
> 
> > +ffffff8000000000 |   -0.5  TB | ffffffeeffffffff |  444 GB | ... unused hole
> > +
> > +# Identical layout to the 47-bit one from here on:
> > +
> > +ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
> 
> So patch #2 appears to have introduced an error/typo in the 47-bit table. Note the weird size 
> and discontinuity of the 'unused hole' in the 47-bit table, and compare it with 56-bit table:
> 
>   fffffffeefffffff
>   ffffffeeffffffff
> 
> (Note how the incorrect end address was cargo-cult-copied into the 'size' field of ~507 GB...)
> 
> The correct number is the 56-bit one, and both tables should show the following identical 
> layout:
> 
>   ffffff8000000000 | -512    GB | fffffffeefffffff |  444 GB | ... unused hole
>   ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
> 
> Agreed?

Yes, you are right. I wondered why the size is a weird unaligned value.
Sorry about that.

Thanks
Baoquan
