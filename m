Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C8FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6A220652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pHqdw9gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6A220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeJWUsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:48:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbeJWUsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d0SR6uAd9+fp4gIT+veEgCDquPv2pU5w5Fjybo4wDvQ=; b=pHqdw9gE8MuWLYrOasOTitl2f
        r7+jSP56/BqiHWaRC80aiq8e4HH3dWP9SVQaRkjsV1j1sxFDmK5M4KM8MrwvFTTcAYask2d/G8rz3
        20qOh8tZjbR+OAYRz5BGxDgRsWmbehukRhVsC6kHwQH2UaiC44Bv5Ti2AAlc5cJaQpJndLn/k8PtS
        7QOpn4yER0zSuIHSM+OqBT8Gevyre3eFf7bx3LerBc9z8PWDdT44vw/igRWlWu+JRMA3peFHMbk+Y
        NLIV0ibjgfc01ApQHV0IGm51Dwpcys/+x31qtCRjY6ecODej+4YKbkOg4J0baEszn8xO3FiyPA7+i
        NjXKZBQbw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEvjg-0007u7-4V; Tue, 23 Oct 2018 12:24:36 +0000
Date:   Tue, 23 Oct 2018 05:24:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin@protonic.nl, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kees Cook <keescook@chromium.org>, treding@nvidia.com,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, aryabinin@virtuozzo.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, tchibo@google.com,
        riel@redhat.com, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, ak@linux.intel.com,
        rppt@linux.vnet.ibm.com, linux@dominikbrodowski.net,
        Arnd Bergmann <arnd@arndb.de>, cpandya@codeaurora.org,
        hannes@cmpxchg.org, Joe Perches <joe@perches.com>,
        mcgrof@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
Message-ID: <20181023122435.GB20085@bombadil.infradead.org>
References: <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
 <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
 <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
 <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
 <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
 <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
 <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
 <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com>
 <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
 <CAFqt6zZ2yHkVcbYtK1dxr9B3K5WVYGboavjP1ibmYei0u4zFbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZ2yHkVcbYtK1dxr9B3K5WVYGboavjP1ibmYei0u4zFbQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 05:44:32PM +0530, Souptick Joarder wrote:
> On Sat, Oct 6, 2018 at 4:19 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Sat, Oct 6, 2018 at 7:11 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > On Fri, Oct 5, 2018 at 11:39 PM Miguel Ojeda
> > > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > > They are not supposed to be "steps". You did it with 70+ commits (!!)
> > > > over the course of several months. Why a tree wasn't created, stuff
> > > > developed there, and when done, submitted it for review?
> > >
> > > Because we already have a plan for entire vm_fault_t migration and
> > > the * instruction * was to send one patch per driver.
> >
> > The instruction?
> 
> Sorry for the delayed response.
> Instruction from Matthew  Wilcox who is supervising the entire vm_fault_t
> migration work :-)

Hang on.  That was for the initial vm_fault_t conversion in which each
step was clearly an improvement.  What you're looking at now is far
from that.

