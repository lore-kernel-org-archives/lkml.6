Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA6CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAB12075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAB12075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbeGROFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:05:47 -0400
Received: from mail.us.es ([193.147.175.20]:59326 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730882AbeGROFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:05:46 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DE24EC3491
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:25:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BEEAFDA4CC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:25:54 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B314FDA4C2; Wed, 18 Jul 2018 15:25:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C2C00DA57E;
        Wed, 18 Jul 2018 15:25:52 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 18 Jul 2018 15:25:52 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9FC204265A4E;
        Wed, 18 Jul 2018 15:25:52 +0200 (CEST)
Date:   Wed, 18 Jul 2018 15:27:46 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Varsha Rao <rvarsha016@gmail.com>
Subject: Re: linux-next: build failure after merge of the ida tree
Message-ID: <20180718132746.txspsjvw3xxlqtey@salvia>
References: <20180718165406.6f262266@canb.auug.org.au>
 <20180718092426.mxdti3jes5jsssta@salvia>
 <20180718131446.GC4949@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718131446.GC4949@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:14:46AM -0700, Matthew Wilcox wrote:
> On Wed, Jul 18, 2018 at 11:24:26AM +0200, Pablo Neira Ayuso wrote:
> > > interacting with commit
> > > 
> > >   9679150a0bd5 ("netfilter: nf_tables: Use id allocation")
> > > 
> > > from the netfilter-next tree.
> > 
> > @Varsha, I'm very sorry, but I guess I have to toss your patch, I
> > would prefer avoid dependencies with the IDA API by now.
> 
> I've had a chance to read this patch a bit more carefully.  It transforms
> one anti-pattern into another, so I can't say I'm a fan.
> 
> The first is specific to the networking code; having a list of things
> with IDs, and constructing a bitmap when we need to allocate a new ID.
> 
> The second is having both an IDA and a list of things.
> 
> The more effective way to do all of this is to use an IDR.  You can get
> rid of the linked list *and* the IDA, and it's faster to iterate over.
> The root of the IDR is the same size as the list_head, and then you need
> only store the 4-byte ID in each element instead of the 16-byte list_head.
> 
> So Varsha, if you would like to take a look at transforming table->sets
> from a LIST_HEAD to an IDR, I think that would be a great use of your
> time.

Please, don't do so, we don't need a radix tree datastructure, it's
just more complexity.

We just wanted to have a simple way to allocate IDs using a bitmap
structure in the background without reinventing the wheel.
