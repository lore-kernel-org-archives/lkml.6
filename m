Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF548C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CA924079
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPDpjGWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CA924079
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeGEWvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:51:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeGEWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q7VaJiWgdb0a6EpA5yExE5KB45B5ojlH2oJR6Zhf1D0=; b=gPDpjGWafzq/wx75O6GGeoD3n
        Q8GeqGxpkJ2WYyLiQySezqvGfMOQ3KW2aKV41bUQ/FvhR1HEF8MX0lAouDBTSosTcRtrksM1/5Cyw
        9GfymHwpSTNHj7qKticYLmeVDFY7MzTne6oLg2dFvcrq+510SDLVCFEfc6c94Tu7Mh2VwcHPU5IEF
        bM5HeG/XDtHfS32eY4AEZ7/FOOKFhD/jZGO9IV18Xq6yJf9AgeHm7cEt1maiLcPPz8Lue1GI4QBjl
        4rLr00JnMjzZCBkA1ET/0qYdD+9GG20F8N4KaMQqfo1ljWdbmuOTItwyU84bhJ15XP72adLBhb0CV
        WbnEC172Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbD4e-0003EI-AF; Thu, 05 Jul 2018 22:50:04 +0000
Date:   Thu, 5 Jul 2018 15:50:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, vdavydov.dev@gmail.com,
        shakeelb@google.com, viro@zeniv.linux.org.uk, hannes@cmpxchg.org,
        mhocko@kernel.org, tglx@linutronix.de, pombredanne@nexb.com,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v8 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180705225004.GA26479@bombadil.infradead.org>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063056619.1818.12550500883688681076.stgit@localhost.localdomain>
 <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:50:00PM -0700, Andrew Morton wrote:
>   It should be possible to find the highest ID in an IDR tree with a
>   straightforward descent of the underlying radix tree, but I doubt if
>   that has been wired up.  Otherwise a simple loop in
>   unregister_memcg_shrinker() would be needed.

Feature request received.  I've actually implemented it for the XArray
already, but it should be easy to do for the IDR too.

