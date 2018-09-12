Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20030C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6692088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KsXuAy7a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nPHP/nmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6692088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeILTrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:47:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeILTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:47:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F90B609A1; Wed, 12 Sep 2018 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536763351;
        bh=mMNCRBxP2jb4BjZi+5VDn0hkkpfgPYK5eSngb/Klr5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KsXuAy7aIb4xNZpORV+918QaBmGzsYDjxYUnaCJ/Ev2grgGIOOPwkfauxMWNi9+fe
         HdHn1z4LJBObUB1Nwn7s2qM5KroBrhDuip1ggq6GUvNS49NB92/+0JWpOGve8ErseF
         5BUtwbm4PMsQOUBrFHJ8MBP2UsVS435aG4oHmLv8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 38E696053B;
        Wed, 12 Sep 2018 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536763350;
        bh=mMNCRBxP2jb4BjZi+5VDn0hkkpfgPYK5eSngb/Klr5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nPHP/nmxkxVmLk+nqzwwBfnad3P2ptdcAAbXovpWesjYA6c4bE03GKNOH+2SfI3TY
         Qwxf8bV7coIrM36W7/IQklgv1RmEGwHxkBndiLPLlD26FweiW5DzkFeXWjwF6NUU5t
         sM3y2Z7+9SVG2IYP1XiR73McS6spdJPvBGn65Wmk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Sep 2018 20:12:30 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Balbir Singh <bsingharora@gmail.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, vbabka@suse.cz,
        pasha.tatashin@oracle.com, iamjoonsoo.kim@lge.com,
        osalvador@suse.de, malat@debian.org, gregkh@linuxfoundation.org,
        yasu.isimatu@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arunks.linux@gmail.com,
        vinmenon@codeaurora.org
Subject: Re: [RFC] memory_hotplug: Free pages as pageblock_order
In-Reply-To: <20180912131724.GH10951@dhcp22.suse.cz>
References: <1536744405-16752-1-git-send-email-arunks@codeaurora.org>
 <20180912103853.GC10951@dhcp22.suse.cz> <20180912125743.GB8537@350D>
 <20180912131724.GH10951@dhcp22.suse.cz>
Message-ID: <9d8dfd50046036a7b4e730738940014d@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-12 18:47, Michal Hocko wrote:
> On Wed 12-09-18 22:57:43, Balbir Singh wrote:
>> On Wed, Sep 12, 2018 at 12:38:53PM +0200, Michal Hocko wrote:
>> > On Wed 12-09-18 14:56:45, Arun KS wrote:
>> > > When free pages are done with pageblock_order, time spend on
>> > > coalescing pages by buddy allocator can be reduced. With
>> > > section size of 256MB, hot add latency of a single section
>> > > shows improvement from 50-60 ms to less than 1 ms, hence
>> > > improving the hot add latency by 60%.
>> >
>> > Where does the improvement come from? You are still doing the same
>> > amount of work except that the number of callbacks is lower. Is this the
>> > real source of 60% improvement?
>> >
>> 
>> It looks like only the first page of the pageblock is initialized, is
>> some of the cost amortized in terms of doing one initialization for
>> the page with order (order) and then relying on split_page and helpers
>> to do the rest? Of course the number of callbacks reduce by a 
>> significant
>> number as well.
> 
> Ohh, I have missed that part. Now when re-reading I can see the reason
> for the perf improvement. It is most likely the higher order free which
> ends up being much cheaper. This part makes some sense.
> 
> How much is this feasible is another question. Do not forget we have
> those external providers of the online callback and those would need to
> be updated as well.
Sure Michal, I ll look into this.

> 
> Btw. the normal memmap init code path does the same per-page free as
> well. If we really want to speed the hotplug path then I guess the init
> one would see a bigger improvement and those two should be in sync.
Thanks for pointers, Will look further.

> 
>> > >
>> > > If this looks okey, I'll modify users of set_online_page_callback
>> > > and resend clean patch.
>> >
>> > [...]
>> >
>> > > +static int generic_online_pages(struct page *page, unsigned int order);
>> > > +static online_pages_callback_t online_pages_callback = generic_online_pages;
>> > > +
>> > > +static int generic_online_pages(struct page *page, unsigned int order)
>> > > +{
>> > > +	unsigned long nr_pages = 1 << order;
>> > > +	struct page *p = page;
>> > > +	unsigned int loop;
>> > > +
>> > > +	for (loop = 0 ; loop < nr_pages ; loop++, p++) {
>> > > +		__ClearPageReserved(p);
>> > > +		set_page_count(p, 0);
> 
> btw. you want init_page_count here.
Do you mean replace set_page_count(p, 0) with init_page_count(page)?
Because init_page_count is setting the page _refcount to 1

static inline void init_page_count(struct page *page)
{
         set_page_count(page, 1);
}

I thought in case of higher order pages only the first struct page 
should have _refcount to 1 before calling __free_pages(). Please correct 
me if wrong.

Regards,
Arun


