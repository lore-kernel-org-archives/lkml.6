Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C2C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A372075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SbQ0z9k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A372075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeJaAd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:33:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeJaAd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=55ckWGvPLucEZ6A7S9A1AJ7MTVz42QBk9yQvmKgwzxc=; b=SbQ0z9k3KbFUKKpXmkp3dFQik
        4OZFN88GKQBN/8UmraKtjJXUOGI5UuDIhdrVo/KinNraL716rtrSYQ/oDeW7KkvYGIwALAw02ugs8
        9vn88o5gjdxpqBKCYByD3fw65nt+cZIb/UDGKILl8VYp90g4gIjWLYCeZHdiOzGcMDaGi1V8VbeRd
        ufLaV3Z99BwOMrBgZKLnQMPvJtDJnmDjSF8HkWXy3nAanT/GJv7Q9NotvCDnbpLgn4QTFUAANe/Uq
        VTtWoPmO0epxhJ+DeC4MSyTeSoXUTEjCTK2C1cs3CRstLrDGtvDGBeyroHJlqHZRWed0Z6bgkKVlK
        wyRTlOdKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHW7O-0005ed-GQ; Tue, 30 Oct 2018 15:39:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFADE2029FA14; Tue, 30 Oct 2018 16:39:44 +0100 (CET)
Date:   Tue, 30 Oct 2018 16:39:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Lihao Liang <lianglihao@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] prmem: linked list: disable layout randomization
Message-ID: <20181030153944.GB13436@hirez.programming.kicks-ass.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-14-igor.stoppa@huawei.com>
 <20181026093205.GD3159@worktop.c.hoisthospitality.com>
 <20181026101707.GO25444@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026101707.GO25444@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 03:17:07AM -0700, Matthew Wilcox wrote:
> On Fri, Oct 26, 2018 at 11:32:05AM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 24, 2018 at 12:35:00AM +0300, Igor Stoppa wrote:
> > > Some of the data structures used in list management are composed by two
> > > pointers. Since the kernel is now configured by default to randomize the
> > > layout of data structures soleley composed by pointers, this might
> > > prevent correct type punning between these structures and their write
> > > rare counterpart.
> > 
> > 'might' doesn't really work for me. Either it does or it does not.
> 
> He means "Depending on the random number generator, the two pointers
> might be AB or BA.  If they're of opposite polarity (50% of the time),
> it _will_ break, and 50% of the time it _won't_ break."

So don't do that then. If he were to include struct list_head inside his
prlist_head, then there is only the one randomization and things will
just work.

Also, I really don't see why he needs that second type and all that type
punning crap in the first place.


