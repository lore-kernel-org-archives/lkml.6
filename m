Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF951C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EEE2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/krtLzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EEE2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbeKGBKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:10:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388760AbeKGBKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AbfHk1xjSkV+08tMGRcAsH709qMoOdW+0t6p1e6IYpA=; b=I/krtLzhOSB8c1mD1nOa7TOIy
        UajzeReN1hWcUEezFBOeQTYvOmjl8FCArnwmI7znnEemUMjjn6i/OCbsveHtBWwMoG4oKt/lvrI31
        rUONMrEcCjTfqJOqzGQxZgDUz8vN4iUDr3t03IzagSktsDiLfrHGWXN8BQGQEbVZ2KLIQzVnMAlbL
        UMG9WPsNUHgtiFmKfYXzXpLZ90O7eZwRICgbFFotgRjwZdJF9ya5py9UKrEIELFviKBfgQpnVqzee
        IPSa+Duhy1V6hN1kLZaUmz0RJySHsEfPANnywZ2oN+AtS1yCi12ZAzISGKJPNwGkYfKg8F4mDGq4e
        Wsa0Aw3iA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK3Wv-0005E3-Il; Tue, 06 Nov 2018 15:44:37 +0000
Date:   Tue, 6 Nov 2018 07:44:37 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arch@vger.kernel.org
Subject: Re: + fls-change-parameter-to-unsigned-int.patch added to -mm tree
Message-ID: <20181106154437.GF3074@bombadil.infradead.org>
References: <20181105233301.KlgdF%akpm@linux-foundation.org>
 <20181106151444.GA11221@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106151444.GA11221@avx2>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 06:14:44PM +0300, Alexey Dobriyan wrote:
> On Mon, Nov 05, 2018 at 03:33:01PM -0800, akpm@linux-foundation.org wrote:
> 
> > -static inline int fls(int x)
> > +static inline int fls(unsigned int x)
> >  {
> > -	return fls64((unsigned int) x);
> > +	return fls64(x);
> >  }
> 
> Should it return "unsigned"? Logically it should.
> I remember doing this and there was some code size increase :-(

Yes, it returns a number in the range [0-32], so it can absolutely
be unsigned.  I'm kind of surprised it made any difference.

When you say "doing this", what did you try?  unsigned fls(unsigned),
int fls(unsigned) or unsigned fls(int) ?
