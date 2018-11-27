Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ABC20663
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s9fhQcrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ABC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeK1GVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:21:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeK1GVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=24wB8o9yeOrlXfiLJvH4k2tbDIfY5VU2bEKRSqp25ew=; b=s9fhQcrG0zzOc5AJVBlXRFQRlq
        Xzrh4d4AfAD07j7rCT+S+yyhF2AEAg/b1zMyIFlg8Sd8Jqsrlqgcjwv+TSV7+RlankzN5ZiUmFMIj
        Qxxm3cgcrvUNJTu/cKYve9upcj7kayKvuV3xRsYd3ieULNSuWAuG+sbKnUzq+AKaqinuUGv0eQtSA
        Cm9rd8ZKFo2FV7CMFDzlwsQcK/iydp7H+zub1f4hJ3qg8fc1xWwpwfAMW4yIsTcTsWDaJisAalNYV
        7r7n83xWYTBoJAvtzCg7B91LQhcXdbYvNcy0W3G20q2bR7ZNwGtwBMfal/CnZUELF6oX/MIiK6tvG
        V+xhMSTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRiwM-000712-NA; Tue, 27 Nov 2018 19:22:34 +0000
Date:   Tue, 27 Nov 2018 11:22:34 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] docs/memory-barriers.txt: Enforce heavy ordering for
 port I/O accesses
Message-ID: <20181127192234.GF10377@bombadil.infradead.org>
References: <1543251134-29867-1-git-send-email-will.deacon@arm.com>
 <20181126193349.GA3509@andrea>
 <20181127184021.GS4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127184021.GS4170@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:40:21AM -0800, Paul E. McKenney wrote:
> On Mon, Nov 26, 2018 at 08:33:49PM +0100, Andrea Parri wrote:
> > On Mon, Nov 26, 2018 at 04:52:14PM +0000, Will Deacon wrote:
> > > David Laight explains:
> > > 
> > >   | A long time ago there was a document from Intel that said that
> > >   | inb/outb weren't necessarily synchronised wrt memory accesses.
> > >   | (Might be P-pro era). However no processors actually behaved that
> > >   | way and more recent docs say that inb/outb are fully ordered.
> > 
> > No intention to diminish David Laight's authority of course, but I would
> > have really appreciated a reference to these "recent docs" (section, pg.
> > or the like, especially if a reference manual...) here...
> 
> I would be inclined to cut Will a break given the research for his
> recent talk on this topic, but it would be good to get an ack from
> someone from Intel.  And memory-model patches require an ack or better
> in any case.  ;-)

Here's a quote from Section 18.6 of volume 1 of the Software Developer
Manual, November 2018 edition:

When the I/O address space is used instead of memory-mapped I/O, the
situation is different in two respects:
• The processor never buffers I/O writes. Therefore, strict ordering of
I/O operations is enforced by the processor. (As with memory-mapped I/O,
it is possible for a chip set to post writes in certain I/O ranges.)
• The processor synchronizes I/O instruction execution with external
bus activity (see Table 18-1).

Table 18-1 says that in* delays execution of the current instruction until
completion of pending stores, and out* delays execution of the _next_
instruction until completion of both pending stores and the current store.
