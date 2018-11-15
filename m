Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A706C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DDC223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DDC223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbeKOWSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:18:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:51172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729115AbeKOWSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:18:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 123F9B014;
        Thu, 15 Nov 2018 12:11:05 +0000 (UTC)
Date:   Thu, 15 Nov 2018 13:11:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 3/6] kexec: export PG_offline to VMCOREINFO
Message-ID: <20181115121102.GP23831@dhcp22.suse.cz>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-4-david@redhat.com>
 <20181115061923.GA3971@dhcp-128-65.nay.redhat.com>
 <20181115111023.GC26448@zn.tnic>
 <4aa5d39d-a923-87de-d646-70b9cbfe62f0@redhat.com>
 <20181115115213.GE26448@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115115213.GE26448@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 12:52:13, Borislav Petkov wrote:
> On Thu, Nov 15, 2018 at 12:20:40PM +0100, David Hildenbrand wrote:
> > Sorry to say, but that is the current practice without which
> > makedumpfile would not be able to work at all. (exclude user pages,
> > exclude page cache, exclude buddy pages). Let's not reinvent the wheel
> > here. This is how dumping works forever.
> 
> Sorry, but "we've always done this in the past" doesn't make it better.
> 
> > I don't see how there should be "set of pages which do not have
> > PG_offline".
> 
> It doesn't have to be a set of pages. Think a (mmconfig perhaps) region
> which the kdump kernel should completely skip because poking in it in
> the kdump kernel, causes all kinds of havoc like machine checks. etc.
> We've had and still have one issue like that.
> 
> But let me clarify my note: I don't want to be discussing with you the
> design of makedumpfile and how it should or should not work - that ship
> has already sailed. Apparently there are valid reasons to do it this
> way.
> 
> I was *simply* stating that it feels wrong to export mm flags like that.
> 
> But as I said already, that is mm guys' call and looking at how we're
> already exporting a bunch of stuff in the vmcoreinfo - including other
> mm flags - I guess one more flag doesn't matter anymore.

I am not familiar with kexec to judge this particular patch but we
cannot simply define any range for these pages (same as for hwpoison
ones) because they can be almost anywhere in the available memory range.
Then there can be countless of them. There is no other way to rule them
out but to check the page state.

I am not really sure what is the concern here exactly. Kdump is so
closly tight to the specific kernel version that the api exported
specifically for its purpose cannot be seriously considered an ABI.
Kdump has to adopt all the time.
-- 
Michal Hocko
SUSE Labs
