Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D6ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F38B214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PHOrclnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F38B214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeIQSzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:55:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeIQSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SW9YAoP65XhPCyQZsJpY8neHMxKuHkh97mAgsBt8Z4k=; b=PHOrclntcl9yJ4ik844Hald6c
        nKsW/KX0/Ok2Vzgry96NrbOlNAIJLrPwzFUtBD5pnsNuOdm8+hk3BFRrEJyxKRzpiIIti8IZXrGYg
        nG/MRQ/X6Rql3JhH+2FhWXKTpzO8iWDtKeQgccqM7Y7ZpCRLj7rQR+nBlERQuuoeLrAAZy3Vr4Jq4
        boMHj3/2YpzaHAUxXBinWWSFWfixbziuShr6ae6FWcD/rcF2NPVBQi5/fYYMzKTwX9BcwkmWOCWJq
        QzeTFQfbCfEr9idODtOoLMiDF420nl67I5cIWGy/SO9w0nNosa6rutprmb24J1qNb/mQLWft2CEFm
        T3pKufmgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1tYj-0003vE-J8; Mon, 17 Sep 2018 13:27:25 +0000
Date:   Mon, 17 Sep 2018 06:27:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     Juerg Haefliger <juergh@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        deepa.srinivasan@oracle.com, Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20180917132725.GA3633@infradead.org>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
 <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CADLDEKsxx=MSFu=4_4JLX1afUMr3GVjNxSQ-726NrbLn8KQaQg@mail.gmail.com>
 <ciirm8r2hs30kh.fsf@u54ee758033e858cfa736.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ciirm8r2hs30kh.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:01:02PM +0200, Julian Stecklina wrote:
> Juerg Haefliger <juergh@gmail.com> writes:
> 
> >> I've updated my XPFO branch[1] to make some of the debugging optional
> >> and also integrated the XPFO bookkeeping with struct page, instead of
> >> requiring CONFIG_PAGE_EXTENSION, which removes some checks in the hot
> >> path.
> >
> > FWIW, that was my original design but there was some resistance to
> > adding more to the page struct and page extension was suggested
> > instead.
> 
> >From looking at both versions, I have to say that having the metadata in
> struct page makes the code easier to understand and removes some special
> cases and bookkeeping.

Btw, can xpfo_lock be replaced with a bit spinlock in the page?
Growing struct page too much might cause performance issues.  Then again
going beyong the 64 byte cache line might already cause that, and even
then it propbably is still way better than the page extensions.

OTOH if you keep the spinlock it might be worth to use
atomic_dec_and_lock on the count.  Maybe the answer is an hash of
spinlock, as we obviously can't take all that many of them at the same
time anyway.

Also for your trasitions froms zero it might be worth at looking at
atomic_inc_unless_zero.
