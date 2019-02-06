Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC0DC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EF12184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfBFCwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 21:52:22 -0500
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:42008 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbfBFCwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 21:52:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1C230181D3368;
        Wed,  6 Feb 2019 02:52:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bee42_4e95c9dd94358
X-Filterd-Recvd-Size: 2859
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Feb 2019 02:52:19 +0000 (UTC)
Message-ID: <9e4332bf41d5d58a4fa6cf138fc9ea3b2f9a488f.camel@perches.com>
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
From:   Joe Perches <joe@perches.com>
To:     Paul Zimmerman <pauldzim@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Feb 2019 18:52:18 -0800
In-Reply-To: <20190205192733.b4bd98988d1e4695f740d445@gmail.com>
References: <20190205192733.b4bd98988d1e4695f740d445@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 19:27 -0700, Paul Zimmerman wrote:
> On Tue, 2019-02-05, Joe Perches wrote:
> > On Tue, 2019-02-05 at 12:04 -0800, Eric Dumazet wrote:
> > > On 02/05/2019 10:42 AM, Joe Perches wrote:
> > > > It's declared after a pointer so it is already is 2 byte aligned.
> > > > 
> > > > A lot of drivers wouldn't work otherwise.
> > > 
> > > Maybe these drivers are only used on arches where this does not matter.
> > 
> > Possible.
> > 
> > I had only grepped through the sources looking for
> > declarations using:
> > 
> > $ git grep -B1 '\[ETH_ALEN\];' -- '*.c' | grep -A1 '\*'
> > 
> > It's quite a few files in net/ too btw.
> > 
> > I still think adding __align(<even#>) is unnecessary here unless
> > it follows something like a bool or a u8.
> 
> Um, guys, this is practically C-101.
> 
> From C99, 6.7.2.1:
> 
> > 13/ Within a structure object, the non-bit-field members and the units in
> > which bit-fields reside have addresses that increase in the order in which
> > they are declared. A pointer to a structure object, suitably converted,
> > points to its initial member (or if that member is a bit-field, then to the
> > unit in which it resides), and vice versa. There may be unnamed padding
> > within a structure object, but not at its beginning.
> 
> AFAIK there is no such language in the spec regarding variable layout on
> the stack. So Joe, you are totally off-base here.

We're not talking about the spec, see the void * arithmetic
bit, we're talking about what gcc and clang actually do.

This spec regarding variable layout structure members could
also apply to any of the unpacked protocol headers like in
include/uapi/linux/ip.h (struct iphdr for instance)

So, it's not me that's off here.
I do understand the c90 spec pretty well.

Eric's comment about stack layout randomization certainly applies.

Perhaps it's reasonable to add some __aligned(<even#>) to the
appropriate [ETH_ALEN] declarations.


