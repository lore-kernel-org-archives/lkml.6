Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA425ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AA6214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YXuyrQHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AA6214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbeISOzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:55:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CPiSAyjpLKLvbxDMWSmiLwt9Aqv24WsOPZ4mNRHz7O8=; b=YXuyrQHhbDDXAufRolije9mFl
        yeOLWS1x80zLjpcotvboug5uGPx8TBQSJJaZBt60WEcasVGtWYb4DPvVZN85I9wUUWIWmpnDgfkz2
        VLHmc6IbxzuGcgbJZ8zWfkeMgXrpIu/1Hv1HgQHI8kQ6lkBU6fYUL993zkGTMhl2hg8wzarqiacR1
        NASQ6FR62pBT/InCV7TZs3K4pYp/7BHpndzknLymISjmme4UJMl+l6IJfUPk9M3fvhu1mOBBYD6/R
        vH+JgBr4dV4pmkE5iaRtuqNKlW98jb3LoQnY6x2ZED9Ug2m9Fr5TXwe4axyueUOfJ4Sho8aENj41y
        CS8K2iKlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YcT-0005Qd-2P; Wed, 19 Sep 2018 09:18:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99835202C1A33; Wed, 19 Sep 2018 11:17:59 +0200 (CEST)
Date:   Wed, 19 Sep 2018 11:17:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/6] perf/core: Add helper to obtain performance
 counter index
Message-ID: <20180919091759.GZ24124@hirez.programming.kicks-ass.net>
References: <cover.1536685533.git.reinette.chatre@intel.com>
 <6f93048a74c66a275f8eb6e1298f10552d1e5d95.1536685533.git.reinette.chatre@intel.com>
 <20180917082336.GP24124@hirez.programming.kicks-ass.net>
 <fdb736aa-3c2a-67d3-473f-b5a2a7d2c0e5@intel.com>
 <20180917230758.GA3117@worktop.programming.kicks-ass.net>
 <07d81d39-6f78-7a07-099c-883c65b540e6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d81d39-6f78-7a07-099c-883c65b540e6@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 10:54:28AM -0700, Reinette Chatre wrote:
> It works, but checkpatch.pl does not like it very much:
> > CHECK: extern prototypes should be avoided in .h files
> > #66: FILE: arch/x86/include/asm/perf_event.h:273:
> > +extern int x86_perf_rdpmc_index(struct perf_event *event);

Checkpatch is wrong. Ignore it.
