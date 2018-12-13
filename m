Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64643C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5B920851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b92DYGuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5B920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeLMQpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:45:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeLMQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HpvIkCUTKhZ8m/AlJ/HXRZvHU6C6ni1ztgdy9Zt70jE=; b=b92DYGuEO/DmBSpkCTADkfuw+
        J79eVDtiNChrLLCSDHZ0wMaZ6WmwvqUmiLCMGS/Y3uZ7y1QlX3FjBDFbu4FMwAm0KqmJDws91QrWG
        fh4eSHqOVShzJgF9AYmxD6KtNjFX1eAzc5hTqftiS18R5+LC1QUIas92GqhEJdC9UCm0rnGjJBwRX
        mVOjusqcNfx22TcfF8APIPYADjS0BfB4F4/H4Grg+wjuFV4IMJ2cpZipn8NJLBJKSuuu6hlMYAZBW
        TPujHhRazf3HiQr0P3siq3+yN4eKqsNgUN+OiMFaO9jfKAG67Or2aIf6oLaTQisFJU+3lXBXa71/o
        uYeERygHA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXU7B-0002eg-DH; Thu, 13 Dec 2018 16:45:33 +0000
Date:   Thu, 13 Dec 2018 08:45:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Xin Long <lucien.xin@gmail.com>, kent.overstreet@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, dave.hansen@intel.com,
        davem <davem@davemloft.net>, Oleg Babin <obabin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 6/6] Drop flex_arrays
Message-ID: <20181213164533.GQ6830@bombadil.infradead.org>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-7-kent.overstreet@gmail.com>
 <CADvbK_ccPYY5jGRV+cLNc5Nzcfv0mq0eNMeU-ALvepax0ZSizQ@mail.gmail.com>
 <20181213144111.GO6830@bombadil.infradead.org>
 <20181213155149.GA4127@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213155149.GA4127@hmswarspite.think-freely.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:51:49AM -0500, Neil Horman wrote:
> On Thu, Dec 13, 2018 at 06:41:11AM -0800, Matthew Wilcox wrote:
> > On Thu, Dec 13, 2018 at 09:30:47PM +0900, Xin Long wrote:
> > > On Sat, Sep 8, 2018 at 1:57 AM Kent Overstreet
> > > <kent.overstreet@gmail.com> wrote:
> > > >
> > > > All existing users have been converted to generic radix trees
> > > NAK, SCTP is still using flex_arrays,
> > > # grep flex_array net/sctp/*
> > > 
> > > This patch will break the build.
> > 
> > sctp added that user after this patch was sent.  Please stop adding
> > flexarray users!
> > 
> > This particular user should probably have just used kvmalloc.
> > 
> 
> No, I don't think thats right.
> 
> This appears to have been sent on September 7th.  Commit
> 0d493b4d0be352b5e361e4fa0bc3efe952d8b10e, which added the use of flex_arrays to
> sctp, seems to have been merged on August 10th, a month prior.

Are you seriously suggesting anybody sending cleanups needs to be
monitoring every single email list to see if anybody has added a new user?
Removing the flexarray has been advertised since May.
https://lkml.org/lkml/2018/5/22/1142

> regardless, however, sctp has a current in-tree use of flex_arrays, and merging
> this patch will break the build without a respin.

Great.  I await your patch to replace the flexarray usage.
