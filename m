Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 270CBC07D22
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A4F208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uU5dPS1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A4F208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933866AbeFKQtD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:49:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933806AbeFKQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7kKDm54KD/HKt7qzH4v1ERV3Sljr4RD3bPuNaw5g7Is=; b=uU5dPS1IPO53IdR8WGVoknLbF
        W528fzEC9/f3KplybDQu8QDKtZn6UeBxugygp32IvnjVjDVuEZ3Bl25VdL33hdI1G7F2bidtc7M+U
        1ZGo56CS0ExASalIE6ERptBaix1MuVVucp7CfkgPqYQQC0ARWzEws/i/henY7pfYN650iosDhgueq
        fOBCFtZhN8+yLgJ3oIt18PlN+0ycztV2QZaqFV4DCOkbulIyBcrkDs0bzVpoz9g66jPftQi8N4AAK
        i2CQkFZ6nkVMahY7RLzQfQ9+FTKK1Li522V1XTp8rSTpCErhKuz2siVu/o1JlO+nBi7p3jxIfzryA
        DpRQX4DBw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSQ04-0006Zb-1S; Mon, 11 Jun 2018 16:49:00 +0000
Date:   Mon, 11 Jun 2018 09:48:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perfmon trouble
Message-ID: <20180611164859.GA28292@bombadil.infradead.org>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk>
 <20180609155107.GH30522@ZenIV.linux.org.uk>
 <20180611021028.GT30522@ZenIV.linux.org.uk>
 <20180611162313.GA6942@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611162313.GA6942@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:23:13AM -0700, Christoph Hellwig wrote:
> Is perfmon even in still in use?  If not it might be a good idea to
> drop it for good.

The problem is that even oprofile on ia64 depends on perfmon.

We have about four options, none of which are terribly appealing:

1. rm -rf arch/ia64.  Bit harsh to do this when hardware is still being
produced.

2. rm -rf arch/ia64's support for profiling completely.  Would anybody
complain?

3. Convert ia64 over to perf interface.  Who would do this work?

4. Fix the perfmon kernel and userspace to not assume this insane semantic.
Flag day, blah, blah.

Gentoo and Debian seem to be the only remaining living ports to Itanium
and at least the Debian one is very unofficial.
