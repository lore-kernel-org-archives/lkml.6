Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC86C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F37F21567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F37F21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeHXQei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:34:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbeHXQei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:34:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0779840241C6;
        Fri, 24 Aug 2018 13:00:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4743F10073AD;
        Fri, 24 Aug 2018 13:00:01 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w7OD01Pk016215;
        Fri, 24 Aug 2018 09:00:01 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w7OD00nh016211;
        Fri, 24 Aug 2018 09:00:01 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 24 Aug 2018 09:00:00 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Herbert Xu <herbert@gondor.apana.org.au>
cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Mike Snitzer <msnitzer@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Deadlock when using crypto API for block devices
In-Reply-To: <alpine.LRH.2.02.1808240837120.11243@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.1808240854010.15479@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808231621220.8560@file01.intranet.prod.int.rdu2.redhat.com> <20180824021010.hfar7gasp34ddrib@gondor.apana.org.au> <alpine.LRH.2.02.1808240659320.27014@file01.intranet.prod.int.rdu2.redhat.com> <20180824112435.ggizlqrymuibm6oo@gondor.apana.org.au>
 <alpine.LRH.2.02.1808240837120.11243@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 24 Aug 2018 13:00:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 24 Aug 2018 13:00:04 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2018, Mikulas Patocka wrote:

> 
> 
> On Fri, 24 Aug 2018, Herbert Xu wrote:
> 
> > On Fri, Aug 24, 2018 at 07:06:32AM -0400, Mikulas Patocka wrote:
> > >
> > > A quick search through the crypto code shows that ahash_save_req and 
> > > seqiv_aead_encrypt return -ENOMEM.
> > > 
> > > Will you fix them?
> > 
> > These only trigger for unaligned buffers.  It would be much better
> > if dm-crypt can ensure that the input/output is properly unaligned
> > and if otherwise do the allocation in dm-crypt.
> 
> But we are relying here on an implementation detail and not on contract.
> 
> Mikulas

BTW. gcmaes_crypt_by_sg also contains GFP_ATOMIC and -ENOMEM, behind a 
pretty complex condition. Do you mean that this condition is part of the 
contract that the crypto API provides?

Should "req->src->offset + req->src->length < PAGE_SIZE" use "<=" instead? 
Because if the data ends up at page boundary, it will use the atomic 
allocation that can fail.

Mikulas
