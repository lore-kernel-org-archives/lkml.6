Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB22DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A158621901
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eeP0JHlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeL2By7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:54:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeL2By7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nTTS0Oxnwwq7zyBs96gq67nFjAvmBAPzbWc9nnfvnC4=; b=eeP0JHlNVWPxJCgyT0Z7ODkiU
        gyJyv6qzAjCPY0oAzkQJd9ySgdGDSVNsNVY0eA+Qjg6Bt6S0s/6pynnOz7j95/4qZbYKNwptrRDHp
        YMTqdbtDpogacU/Craod/g4wf2Ue6e+JqIXmI+OwaLHwaDBHrDzajoyE7H7K6qsTF9S/Il9CZI+Gc
        JWPeaoHtITwpDZZWqs8CMs3tSlkXFM4GQmTcABLHct3WS9Tvd5PRjL+TrGjkB+w/XrqdLmufkoK8K
        8RzucHQuFNK32RR0aebK4fgtzED5VXLeVOGoUEa7u28psKlYFq+dM7fL0sC/4dyZtAbcudaoxLWpT
        kMeNpJxDA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gd3q2-0004CV-9V; Sat, 29 Dec 2018 01:54:54 +0000
Date:   Fri, 28 Dec 2018 17:54:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>, libc-alpha@sourceware.org,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Van Hensbergen <ericvh@gmail.com>, hpa@zytor.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
Message-ID: <20181229015453.GA6310@bombadil.infradead.org>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
 <CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
 <9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
 <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
 <1EF1B31A-83D8-4642-BEBF-F56E45485223@dilger.ca>
 <CAFEAcA8Yq=CEyAUer1TcaSzuzcdNi3OUi4c67B6e+OkhmcKvbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Yq=CEyAUer1TcaSzuzcdNi3OUi4c67B6e+OkhmcKvbg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 12:12:27AM +0000, Peter Maydell wrote:
> On Fri, 28 Dec 2018 at 23:16, Andreas Dilger <adilger@dilger.ca> wrot
> > On Dec 28, 2018, at 4:18 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > The problem is that there is no 32-bit API in some cases
> > > (unless I have misunderstood the kernel code) -- not all
> > > host architectures implement compat syscalls or allow them
> > > to be called from 64-bit processes or implement all the older
> > > syscall variants that had smaller offets. If there was a guaranteed
> > > "this syscall always exists and always gives me 32-bit offsets"
> > > we could use it.
> >
> > The "32bitapi" mount option would use 32-bit hash for seekdir
> > and telldir, regardless of what kernel API was used.  That would
> > just set the FMODE_32BITHASH flag in the file->f_mode for all files.
> 
> A mount option wouldn't be much use to QEMU -- we can't tell
> our users how to mount their filesystems, which they're
> often doing lots of other things with besides running QEMU.
> (Otherwise we could just tell them "don't use ext4", which
> would also solve the problem :-)) We need something we can
> use at the individual-syscall level.

Could you use a prctl to set whether you were running in 32 or 64 bit
mode?  Or do you change which kind of task you're emulating too often
to make this a good idea?
