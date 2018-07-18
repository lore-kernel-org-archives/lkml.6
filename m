Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3083EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96512075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ny5j1gzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96512075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbeGRMg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:36:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeGRMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GEaKs+/CqQZZetCX9ZFZioSChqDGf4b3uWl+vKwIlvM=; b=ny5j1gznjyx8LcEak7SHg9PKL
        qbKLqibpnpLV7o0S9Uw3Y8WvRS+8NO/cN8tKzgwAsZVrWOz3mEnoRaZLi2KxuVCvDWtUT+UFYk091
        GrmSzitLmGCEbrRthS3SRULzFr9PE/VwoTMKXUh3LjObbPlRPVzxHA3agWuCMpyGncpZ+paW2E9yn
        ECH5AE53fzSP4pPj4rz06HHndJcQxXRgl0BR5i6At6XjdmdkBuwgPiVnEWXVF8gEIC6ukcgUYhD23
        htyhZGCT0yxJ2Y96KPl3MkNoCRbBBS84HMwIkvfZ/X4KlwUFcJZioMF1HM8RFHizt4mIHClVPqhh8
        fuw6w6OYg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffl71-00069j-MI; Wed, 18 Jul 2018 11:59:19 +0000
Date:   Wed, 18 Jul 2018 04:59:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Varsha Rao <rvarsha016@gmail.com>
Subject: Re: linux-next: build failure after merge of the ida tree
Message-ID: <20180718115919.GB4949@bombadil.infradead.org>
References: <20180718165406.6f262266@canb.auug.org.au>
 <20180718092426.mxdti3jes5jsssta@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718092426.mxdti3jes5jsssta@salvia>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:24:26AM +0200, Pablo Neira Ayuso wrote:
> I see, we have no more lockless API for IDA anymore :-(. In our case,
> we were already protected by the the nfnl_lock mutex, which it was
> sufficient to ensure non-concurrent access to IDA structures.

You're actually the first user for whom this is true.  For every other
user, the requirement to manage their own spinlock was a pain.

> Unless I'm missing anything, the new API forces use to the spinlock
> call with disabled irq for each time we update something from the
> netfilter netlink interface, so that's a no-go for us.

I can't believe that's a serious problem for you, though.  You're calling
sscanf(), this can't possibly be a performance path.
