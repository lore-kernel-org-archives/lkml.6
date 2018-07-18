Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4149AECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A112084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A112084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbeGRKBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:01:30 -0400
Received: from mail.us.es ([193.147.175.20]:49698 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbeGRKBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:01:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 65C4CD25FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:22:35 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 557F2DA861
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:22:35 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4AF73DA81D; Wed, 18 Jul 2018 11:22:35 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5238DDA7B9;
        Wed, 18 Jul 2018 11:22:33 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 18 Jul 2018 11:22:33 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2D3AC4265A4E;
        Wed, 18 Jul 2018 11:22:33 +0200 (CEST)
Date:   Wed, 18 Jul 2018 11:24:26 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Varsha Rao <rvarsha016@gmail.com>
Subject: Re: linux-next: build failure after merge of the ida tree
Message-ID: <20180718092426.mxdti3jes5jsssta@salvia>
References: <20180718165406.6f262266@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718165406.6f262266@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew, Stephen,

On Wed, Jul 18, 2018 at 04:54:06PM +1000, Stephen Rothwell wrote:
> Hi Matthew,
> 
> After merging the ida tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> net/netfilter/nf_tables_api.c: In function 'nf_tables_set_alloc_name':
> net/netfilter/nf_tables_api.c:3014:8: error: implicit declaration of function 'ida_get_new_above'; did you mean 'idr_get_next_ul'? [-Werror=implicit-function-declaration]
>     n = ida_get_new_above(&inuse, tmp, &id);
>         ^~~~~~~~~~~~~~~~~
>         idr_get_next_ul
> 
> Caused by commit
> 
>   3f2668c1e101 ("ida: Remove old API")

I see, we have no more lockless API for IDA anymore :-(. In our case,
we were already protected by the the nfnl_lock mutex, which it was
sufficient to ensure non-concurrent access to IDA structures.

Unless I'm missing anything, the new API forces use to the spinlock
call with disabled irq for each time we update something from the
netfilter netlink interface, so that's a no-go for us.

> interacting with commit
> 
>   9679150a0bd5 ("netfilter: nf_tables: Use id allocation")
> 
> from the netfilter-next tree.

@Varsha, I'm very sorry, but I guess I have to toss your patch, I
would prefer avoid dependencies with the IDA API by now.
