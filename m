Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A543C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13C7208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oc50Gom+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13C7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbeKOXzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:55:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbeKOXzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cYH4gsxFtygX1XaLn8nsv5VJETRhq30/Kt8o2YsCl2Y=; b=Oc50Gom+FpYiygi1yXbj+RV03
        2KvZUnhVqMq35wHYbouitnM2yPBuYAT5uhyTW2JHu8oo1q5reisaLGU/TEmpMZU8qSI5YJ4Z4LzbA
        hrlcRJuCqe/XVVIqqa/JpDqMCRY+JTpl75Pvahko3wYRsn3Jw+lTBroN3Q4MeureB3h6WdkkOevCK
        bp/riLaZ0v5A9gZBzceq5AKx9/R3BK7qvblhJTJCuX0xcHncnljhXzu1RD3dYFBBabIWh+j2kkGV1
        IbMwIlVhU8Hr+Rn+H018Pd0jEAtkiHD8t7Y62D244g37oxlOZyXcFKqMWE/y0lRtkc9HsbS0U2q+q
        NeqQhiecw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNHz8-0000ta-Cr; Thu, 15 Nov 2018 13:47:06 +0000
Date:   Thu, 15 Nov 2018 05:47:06 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/1] vmalloc: add test driver to analyse vmalloc
 allocator
Message-ID: <20181115134706.GC19286@bombadil.infradead.org>
References: <20181113151629.14826-1-urezki@gmail.com>
 <20181113151629.14826-2-urezki@gmail.com>
 <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
 <20181114151737.GA23419@dhcp22.suse.cz>
 <20181114150053.c3fe42507923322a0a10ae1c@linux-foundation.org>
 <20181115083957.GE23831@dhcp22.suse.cz>
 <20181115084642.GB19286@bombadil.infradead.org>
 <20181115125750.GS23831@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115125750.GS23831@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 01:57:50PM +0100, Michal Hocko wrote:
> On Thu 15-11-18 00:46:42, Matthew Wilcox wrote:
> > How about adding
> > 
> > #ifdef CONFIG_VMALLOC_TEST
> > int run_internal_vmalloc_tests(void)
> > {
> > ...
> > }
> > EXPORT_SYMBOL_GPL(run_internal_vmalloc_tests);
> > #endif
> > 
> > to vmalloc.c?  That would also allow calling functions which are marked
> > as static, not just functions which aren't exported to modules.
> 
> Yes that would be easier but do we want to pollute the normal code with
> testing? This looks messy to me.

I don't think it's necessarily the worst thing in the world if random
people browsing the file are forced to read test-cases ;-)

There's certainly a spectrum of possibilities here, one end being to
basically just re-export static functions, and the other end putting
every vmalloc test into vmalloc.c.  vmalloc.c is pretty big at 70kB, but
on the other hand, it's the 18th largest file in mm/ (can you believe
page_alloc.c is 230kB?!)
