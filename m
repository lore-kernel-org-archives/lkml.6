Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FFB20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FFB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeGRPDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:03:15 -0400
Received: from mail.us.es ([193.147.175.20]:45958 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730238AbeGRPDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:03:14 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0ED4BC22E3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:23:09 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F1FDBDA84D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:23:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E6933DA814; Wed, 18 Jul 2018 16:23:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E95C1DA737;
        Wed, 18 Jul 2018 16:23:06 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 18 Jul 2018 16:23:06 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C33DB4265A4E;
        Wed, 18 Jul 2018 16:23:06 +0200 (CEST)
Date:   Wed, 18 Jul 2018 16:25:00 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Varsha Rao <rvarsha016@gmail.com>
Subject: Re: linux-next: build failure after merge of the ida tree
Message-ID: <20180718142500.5ltqff7ajwmwidhp@salvia>
References: <20180718165406.6f262266@canb.auug.org.au>
 <20180718092426.mxdti3jes5jsssta@salvia>
 <20180718131446.GC4949@bombadil.infradead.org>
 <20180718132746.txspsjvw3xxlqtey@salvia>
 <20180718133126.GD4949@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718133126.GD4949@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:31:26AM -0700, Matthew Wilcox wrote:
> On Wed, Jul 18, 2018 at 03:27:46PM +0200, Pablo Neira Ayuso wrote:
> > On Wed, Jul 18, 2018 at 06:14:46AM -0700, Matthew Wilcox wrote:
> > > So Varsha, if you would like to take a look at transforming table->sets
> > > from a LIST_HEAD to an IDR, I think that would be a great use of your
> > > time.
> > 
> > Please, don't do so, we don't need a radix tree datastructure, it's
> > just more complexity.
> 
> It's no more complex to use than the list_* macros.

Problem is that some of the sets that we place in that list may have
no ID.

We basically have two type of sets:

* Sets with names, they have no IDs as the user provides a meaningful
  name from the control plane that can be used to add/delete elements,
  eg. IP addresses.

* Anonymous sets, these are built-in into rules, eg.

  ip saddr { 1.1.1.1, 2.2.2.2 }

  so we generate an ID that we can use to refer to the set.

For our usecase, I'm thinking, if we don't have a simple way to
allocate IDs through this API, we could just simplify our existing
codebase by using an u64 and use incremental id, we don't need to
recycle IDs, so that's one posibility I stop bothering you ;-)

BTW, the anti-pattern we have in our codebase is the same logic that we
have to allocate identifiers with netdevice name, see __dev_alloc_name()
in net/core/dev.c. *Someone* copied + pasted + mangled that original code
to make it fit into netfilter. I guess that code may benefit from a
simple way to allocate IDs without locking dependencies. Just an idea,
not that this is a priority.

Thanks!
